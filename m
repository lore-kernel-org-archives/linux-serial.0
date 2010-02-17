From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/5] tty: sort out the request_room handling for whiteheat
Date: Wed, 17 Feb 2010 13:06:57 +0000
Message-ID: <20100217130653.16008.3889.stgit@localhost.localdomain>
References: <20100217130604.16008.86393.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100217130604.16008.86393.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This driver has its own (surplus) backup queue system which wants removing
from the receive overflow logic.

Do this at the same time as removing the request_room logic

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/whiteheat.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)


diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index e89e0d5..12ed820 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -1492,21 +1492,9 @@ static void rx_data_softint(struct work_struct *work)
 		wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 		urb = wrap->urb;
 
-		if (tty && urb->actual_length) {
-			int len = tty_buffer_request_room(tty,
-							urb->actual_length);
-			/* This stuff can go away now I suspect */
-			if (unlikely(len < urb->actual_length)) {
-				spin_lock_irqsave(&info->lock, flags);
-				list_add(tmp, &info->rx_urb_q);
-				spin_unlock_irqrestore(&info->lock, flags);
-				tty_flip_buffer_push(tty);
-				schedule_work(&info->rx_work);
-				goto out;
-			}
-			tty_insert_flip_string(tty, urb->transfer_buffer, len);
-			sent += len;
-		}
+		if (tty && urb->actual_length)
+			sent += tty_insert_flip_string(tty,
+				urb->transfer_buffer, urb->actual_length);
 
 		urb->dev = port->serial->dev;
 		result = usb_submit_urb(urb, GFP_ATOMIC);
