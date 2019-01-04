From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH RFC 4/5] usb: cdc-acm: Enable serdev support
Date: Fri,  4 Jan 2019 12:21:30 +0100
Message-ID: <20190104112131.14451-5-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104112131.14451-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Switch from tty_port_register_device() to tty_port_register_device_serdev()
and from tty_unregister_device() to tty_port_unregister_device().

On removal of a serdev driver sometimes count mismatch warnings were seen:

  ttyACM ttyACM0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
  ttyACM ttyACM0: tty_port_close_start: tty->count = 1 port count = 0

Note: The serdev drivers appear to probe asynchronously as soon as they
are registered. Should the USB quirks in probe be moved before registration?
No noticeable difference for the devices at hand.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/usb/class/cdc-acm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index ed8c62b2d9d1..c225a586c524 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1460,7 +1460,7 @@ static int acm_probe(struct usb_interface *intf,
 	usb_set_intfdata(data_interface, acm);
 
 	usb_get_intf(control_interface);
-	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
+	tty_dev = tty_port_register_device_serdev(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
 		rv = PTR_ERR(tty_dev);
@@ -1534,7 +1534,7 @@ static void acm_disconnect(struct usb_interface *intf)
 	acm_kill_urbs(acm);
 	cancel_work_sync(&acm->work);
 
-	tty_unregister_device(acm_tty_driver, acm->minor);
+	tty_port_unregister_device(&acm->port, acm_tty_driver, acm->minor);
 
 	usb_free_urb(acm->ctrlurb);
 	for (i = 0; i < ACM_NW; i++)
-- 
2.16.4
