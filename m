From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [RFC PATCH] cdc-acm: do not drop data from fast devices
Date: Mon,  5 Mar 2018 10:55:39 +0100
Message-ID: <20180305095539.13698-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

There are some devices using their USB CDC-ACM interfaces as a debug port
that are able to send data at a very high speed, but with the current
driver implementation it is not possible to receive it when using a
relatively slow embedded system without dropping an important part of the
data.

The existing driver uses the throttling mechanism of the TTY line
discipline to regulate the speed of the data transmitted from the port to
the upper layers. This throttling prevents URBs from being resubmitted,
slowing down the transfer on the USB line. But the existing code does not
work correctly when the internal bufferring gets filled.

The TTY buffer is 4096 bytes large, throttling when there are only 128
free bytes left, and unthrottling when there are only 128 bytes available.
But the TTY buffer is filled from an intermediate flip buffer that
contains up to 64 KiB of data, and each time unthrottle() is called 16
URBs are scheduled by the driver, sending up to 16 KiB to the flip buffer.
As the result of tty_insert_flip_string() is not checked in the URB
reception callback, data can be lost when the flip buffer is filled faster
than the TTY is emptied.

Moreover, as the URB callbacks are called from a tasklet context, whereas
throttling is called from the system workqueue, it is possible for the
throttling to be delayed by high traffic in the tasklet. As a result,
completed URBs can be resubmitted even if the flip buffer is full, and we
request more data from the device only to drop it immediately.

To prevent this problem, the URBs whose data did not reach the flip buffer
are placed in a waiting list, which is only processed when the serial port
is unthrottled.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

--

This is working when using the normal line discipline on ttyACM. But
there is a big hole in this: other line disciplines do not use throttling
and thus unthrottle is never called. The URBs will never get resubmitted,
and the port is dead. Unfortunately, there is no notification when the
flip buffer is ready to receive new data, so the only alternative would
be to schedule a timer polling the flip buffer. But with an additional
asynchronous process in the mix, the code starts to be very brittle.

I believe this issue is not limited to ttyACM. As the TTY layer is not
performance-oriented, it can be easy to overwhelm devices with a low
available processing power. In my case, a modem sending a sustained 2 MB/s
on a debug port (exported as a CDC-ACM port) was enough to trigger the
issue. The code handling the CDC-ACM class and the generic USB serial port
is very similar when it comes to URB handling, so all drivers that rely on
that code have the same issue.

But in general, it seems to me that there is no code in the kernel that
checks the return value of tty_insert_flip_string(). This means that we
are working with the assumption that the kernel will consume the data
faster than the source can send it, or that the upper layer will be
able or willing to throttle it fast enough to avoid losing data.


---
 drivers/usb/class/cdc-acm.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/usb/class/cdc-acm.h |  4 +++
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7b366a6c0b49..833fa0a43ddd 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -150,12 +150,18 @@ static inline int acm_set_control(struct acm *acm, int control)
 static void acm_kill_urbs(struct acm *acm)
 {
 	int i;
+	struct acm_rb *rb, *t;
 
 	usb_kill_urb(acm->ctrlurb);
 	for (i = 0; i < ACM_NW; i++)
 		usb_kill_urb(acm->wb[i].urb);
 	for (i = 0; i < acm->rx_buflimit; i++)
 		usb_kill_urb(acm->read_urbs[i]);
+	list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+		set_bit(rb->index, &acm->read_urbs_free);
+		rb->offset = 0;
+		list_del_init(&rb->node);
+	}
 }
 
 /*
@@ -454,14 +460,27 @@ static int acm_submit_read_urbs(struct acm *acm, gfp_t mem_flags)
 	return 0;
 }
 
-static void acm_process_read_urb(struct acm *acm, struct urb *urb)
+static int acm_process_read_urb(struct acm *acm, struct urb *urb)
 {
+	int flipped, remainder;
+	struct acm_rb *rb = urb->context;
 	if (!urb->actual_length)
-		return;
+		return 0;
+	flipped = tty_insert_flip_string(&acm->port,
+			urb->transfer_buffer + rb->offset,
+			urb->actual_length - rb->offset);
+	rb->offset += flipped;
+	remainder = urb->actual_length - rb->offset;
+	if (remainder != 0)
+		dev_dbg(&acm->data->dev,
+			"remaining data: usb %d len %d offset %d flipped %d\n",
+			rb->index, urb->actual_length, rb->offset, flipped);
+	else
+		rb->offset = 0;
 
-	tty_insert_flip_string(&acm->port, urb->transfer_buffer,
-			urb->actual_length);
 	tty_flip_buffer_push(&acm->port);
+
+	return remainder;
 }
 
 static void acm_read_bulk_callback(struct urb *urb)
@@ -474,17 +493,29 @@ static void acm_read_bulk_callback(struct urb *urb)
 	dev_vdbg(&acm->data->dev, "got urb %d, len %d, status %d\n",
 		rb->index, urb->actual_length, status);
 
-	set_bit(rb->index, &acm->read_urbs_free);
-
 	if (!acm->dev) {
 		dev_dbg(&acm->data->dev, "%s - disconnected\n", __func__);
+		set_bit(rb->index, &acm->read_urbs_free);
 		return;
 	}
 
+	if (status == 0) {
+		int rem = urb->actual_length;
+
+		usb_mark_last_busy(acm->dev);
+		if (list_empty_careful(&acm->wait_list))
+			rem = acm_process_read_urb(acm, urb);
+		if (rem) {
+			dev_vdbg(&acm->data->dev,
+				"queuing urb %d\n", rb->index);
+			list_add_tail(&rb->node, &acm->wait_list);
+			return;
+		}
+	}
+	set_bit(rb->index, &acm->read_urbs_free);
+
 	switch (status) {
 	case 0:
-		usb_mark_last_busy(acm->dev);
-		acm_process_read_urb(acm, urb);
 		break;
 	case -EPIPE:
 		set_bit(EVENT_RX_STALL, &acm->flags);
@@ -518,6 +549,8 @@ static void acm_read_bulk_callback(struct urb *urb)
 		acm_submit_read_urb(acm, rb->index, GFP_ATOMIC);
 	} else {
 		spin_unlock_irqrestore(&acm->read_lock, flags);
+		dev_vdbg(&acm->data->dev,
+			"urb %d is suspended by throttling\n", rb->index);
 	}
 }
 
@@ -549,8 +582,14 @@ static void acm_softint(struct work_struct *work)
 
 	if (test_bit(EVENT_RX_STALL, &acm->flags)) {
 		if (!(usb_autopm_get_interface(acm->data))) {
+			struct acm_rb *rb, *t;
 			for (i = 0; i < acm->rx_buflimit; i++)
 				usb_kill_urb(acm->read_urbs[i]);
+			list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+				set_bit(rb->index, &acm->read_urbs_free);
+				rb->offset = 0;
+				list_del_init(&rb->node);
+			}
 			usb_clear_halt(acm->dev, acm->in);
 			acm_submit_read_urbs(acm, GFP_KERNEL);
 			usb_autopm_put_interface(acm->data);
@@ -901,14 +940,32 @@ static void acm_tty_unthrottle(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
 	unsigned int was_throttled;
+	struct acm_rb *rb, *t;
+	bool processed = false;
+	int rem = 0;
 
 	spin_lock_irq(&acm->read_lock);
+
+	list_for_each_entry_safe(rb, t, &acm->wait_list, node) {
+		dev_vdbg(&acm->data->dev, "processing urb %d: %d/%d\n",
+			rb->index, rb->offset, rb->urb->actual_length);
+		rem = acm_process_read_urb(acm, rb->urb);
+		if (rem) {
+			spin_unlock_irq(&acm->read_lock);
+			return;
+		}
+		processed = true;
+		set_bit(rb->index, &acm->read_urbs_free);
+		rb->offset = 0;
+		list_del_init(&rb->node);
+	}
+
 	was_throttled = acm->throttled;
 	acm->throttled = 0;
 	acm->throttle_req = 0;
 	spin_unlock_irq(&acm->read_lock);
 
-	if (was_throttled)
+	if (was_throttled || processed)
 		acm_submit_read_urbs(acm, GFP_KERNEL);
 }
 
@@ -1430,6 +1487,8 @@ static int acm_probe(struct usb_interface *intf,
 	if (!acm->ctrlurb)
 		goto alloc_fail5;
 
+	INIT_LIST_HEAD(&acm->wait_list);
+
 	for (i = 0; i < num_rx_buf; i++) {
 		struct acm_rb *rb = &(acm->read_buffers[i]);
 		struct urb *urb;
@@ -1445,6 +1504,9 @@ static int acm_probe(struct usb_interface *intf,
 		if (!urb)
 			goto alloc_fail6;
 
+		rb->offset = 0;
+		rb->urb = urb;
+		INIT_LIST_HEAD(&rb->node);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = rb->dma;
 		if (usb_endpoint_xfer_int(epread))
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index eacc116e83da..cee849a79371 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -77,7 +77,10 @@ struct acm_rb {
 	unsigned char		*base;
 	dma_addr_t		dma;
 	int			index;
+	struct urb		*urb;
 	struct acm		*instance;
+	unsigned int		offset;
+	struct list_head	node;
 };
 
 struct acm {
@@ -96,6 +99,7 @@ struct acm {
 	unsigned long read_urbs_free;
 	struct urb *read_urbs[ACM_NR];
 	struct acm_rb read_buffers[ACM_NR];
+	struct list_head wait_list;
 	struct acm_wb *putbuffer;			/* for acm_tty_put_char() */
 	int rx_buflimit;
 	spinlock_t read_lock;
-- 
2.14.1
