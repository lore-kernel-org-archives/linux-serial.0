From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] USB: console: fix potential use after free
Date: Mon,  5 Jan 2015 16:04:13 +0100
Message-ID: <1420470253-8141-2-git-send-email-johan@kernel.org>
References: <20150103162642.GC12203@localhost>
 <1420470253-8141-1-git-send-email-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1420470253-8141-1-git-send-email-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Use tty kref to release the fake tty in usb_console_setup to avoid use
after free if the underlying serial driver has acquired a reference.

Note that using the tty destructor release_one_tty requires some more
state to be initialised.

Fixes: 4a90f09b20f4 ("tty: usb-serial krefs")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes since v1:

 - Use tty_kref_put to release tty also in setup()
 - Some more state must be initialised to avoid NULL derefs when the tty
   destructor is run after the underlying driver puts its reference.


 drivers/usb/serial/console.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index e56f394b58d8..29fa1c3d0089 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -46,6 +46,8 @@ static struct console usbcons;
  * ------------------------------------------------------------
  */
 
+static const struct tty_operations usb_console_fake_tty_ops = {
+};
 
 /*
  * The parsing of the command line works exactly like the
@@ -137,14 +139,17 @@ static int usb_console_setup(struct console *co, char *options)
 				goto reset_open_count;
 			}
 			kref_init(&tty->kref);
-			tty_port_tty_set(&port->port, tty);
 			tty->driver = usb_serial_tty_driver;
 			tty->index = co->index;
 			init_ldsem(&tty->ldisc_sem);
+			INIT_LIST_HEAD(&tty->tty_files);
+			kref_get(&tty->driver->kref);
+			tty->ops = &usb_console_fake_tty_ops;
 			if (tty_init_termios(tty)) {
 				retval = -ENOMEM;
-				goto free_tty;
+				goto put_tty;
 			}
+			tty_port_tty_set(&port->port, tty);
 		}
 
 		/* only call the device specific open if this
@@ -162,7 +167,7 @@ static int usb_console_setup(struct console *co, char *options)
 			serial->type->set_termios(tty, port, &dummy);
 
 			tty_port_tty_set(&port->port, NULL);
-			kfree(tty);
+			tty_kref_put(tty);
 		}
 		set_bit(ASYNCB_INITIALIZED, &port->port.flags);
 	}
@@ -178,8 +183,8 @@ static int usb_console_setup(struct console *co, char *options)
 
  fail:
 	tty_port_tty_set(&port->port, NULL);
- free_tty:
-	kfree(tty);
+ put_tty:
+	tty_kref_put(tty);
  reset_open_count:
 	port->port.count = 0;
 	usb_autopm_put_interface(serial->interface);
-- 
2.0.5
