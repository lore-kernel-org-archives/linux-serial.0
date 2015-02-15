From: "Li, Elvin" <elvin.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Usb serial driver change question in the linux kernel
Date: Sun, 15 Feb 2015 13:26:08 +0000
Message-ID: <85D5955FC01BBD45B061B0BD47E1291910F5198A@SHSMSX103.ccr.corp.intel.com>
References: <85D5955FC01BBD45B061B0BD47E1291910F50B6B@SHSMSX103.ccr.corp.intel.com>
 <85D5955FC01BBD45B061B0BD47E1291910F5140E@SHSMSX103.ccr.corp.intel.com>
 <20150215051542.GA2551@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150215051542.GA2551@localhost>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Tian, Feng" <feng.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Ni, Ruiyu" <ruiyu.ni-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Johan,
	Your patch fixed my issue. Thank you for support!

Regards
Elvin Li

-----Original Message-----
From: Johan Hovold [mailto:jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Johan Hovold
Sent: Sunday, February 15, 2015 1:16 PM
To: Li, Elvin
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tian, Feng; Ni, Ruiyu; greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org; jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: Usb serial driver change question in the linux kernel

On Sun, Feb 15, 2015 at 12:43:51AM +0000, Li, Elvin wrote:
> Hi All,
>                 I am using usb_debug driver in Linux kernel  to manage
>                 Ajays USB debug device (Vendor Id: 0525 Product Id:
>                 127a) which follows EHCI debug device specification.
>                 drivers\usb\serial\usb_debug.c was developed by Greg
>                 Kroah-Hartman, it worked very well with Ajays debug
>                 device until one change to usb-serial.c. I could see
>                 the Johan's change at
>                 https://github.com/torvalds/linux/commit/5083fd7bdfe6760577235a724cf6dccae13652c2.

> Does anyone has ideas how the issue could be resolved?

Thanks for the report. The commit mentioned above should simply be reverted; a bulk-out buffer size smaller than the end-point size is indeed valid.

Could you verify that the patch below fixes the issues you're seeing?

Thanks,
Johan


>From fffe54908863974c20adf1b1bf4e24e35a8d921b Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Sun, 15 Feb 2015 11:57:53 +0700
Subject: [PATCH] Revert "USB: serial: make bulk_out_size a lower limit"

This reverts commit 5083fd7bdfe6760577235a724cf6dccae13652c2.

A bulk-out size smaller than the end-point size is indeed valid. The offending commit broke the usb-debug driver for EHCI debug devices, which use 8-byte buffers.

Fixes: 5083fd7bdfe6 ("USB: serial: make bulk_out_size a lower limit")
Reported-by: "Li, Elvin" <elvin.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# v3.15
Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/usb/serial/usb-serial.c | 5 +++--
 include/linux/usb/serial.h      | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c index 475723c006f9..19842370a07f 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -940,8 +940,9 @@ static int usb_serial_probe(struct usb_interface *interface,
 		port = serial->port[i];
 		if (kfifo_alloc(&port->write_fifo, PAGE_SIZE, GFP_KERNEL))
 			goto probe_error;
-		buffer_size = max_t(int, serial->type->bulk_out_size,
-						usb_endpoint_maxp(endpoint));
+		buffer_size = serial->type->bulk_out_size;
+		if (!buffer_size)
+			buffer_size = usb_endpoint_maxp(endpoint);
 		port->bulk_out_size = buffer_size;
 		port->bulk_out_endpointAddress = endpoint->bEndpointAddress;
 
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h index 9bb547c7bce7..704a1ab8240c 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -190,8 +190,7 @@ static inline void usb_set_serial_data(struct usb_serial *serial, void *data)
  * @num_ports: the number of different ports this device will have.
  * @bulk_in_size: minimum number of bytes to allocate for bulk-in buffer
  *	(0 = end-point size)
- * @bulk_out_size: minimum number of bytes to allocate for bulk-out buffer
- *	(0 = end-point size)
+ * @bulk_out_size: bytes to allocate for bulk-out buffer (0 = end-point 
+ size)
  * @calc_num_ports: pointer to a function to determine how many ports this
  *	device has dynamically.  It will be called after the probe()
  *	callback is called, but before attach()
--
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
