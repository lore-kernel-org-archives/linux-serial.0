From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] USB: console: fix potential use after free
Date: Sat,  3 Jan 2015 17:28:27 +0100
Message-ID: <1420302507-18167-2-git-send-email-johan@kernel.org>
References: <20150103162642.GC12203@localhost>
 <1420302507-18167-1-git-send-email-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1420302507-18167-1-git-send-email-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Use tty kref to release the fake tty in usb_console_setup to avoid use
after free if the underlying serial driver has acquired a reference.

Fixes: 4a90f09b20f4 ("tty: usb-serial krefs")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/console.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index e56f394b58d8..4fbf7fe64860 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -47,6 +47,13 @@ static struct console usbcons;
  */
 
 
+static void usb_console_release_fake_tty(struct kref *kref)
+{
+	struct tty_struct *tty = container_of(kref, struct tty_struct, kref);
+
+	kfree(tty);
+}
+
 /*
  * The parsing of the command line works exactly like the
  * serial.c code, except that the specifier is "ttyUSB" instead
@@ -137,7 +144,6 @@ static int usb_console_setup(struct console *co, char *options)
 				goto reset_open_count;
 			}
 			kref_init(&tty->kref);
-			tty_port_tty_set(&port->port, tty);
 			tty->driver = usb_serial_tty_driver;
 			tty->index = co->index;
 			init_ldsem(&tty->ldisc_sem);
@@ -145,6 +151,7 @@ static int usb_console_setup(struct console *co, char *options)
 				retval = -ENOMEM;
 				goto free_tty;
 			}
+			tty_port_tty_set(&port->port, tty);
 		}
 
 		/* only call the device specific open if this
@@ -162,7 +169,7 @@ static int usb_console_setup(struct console *co, char *options)
 			serial->type->set_termios(tty, port, &dummy);
 
 			tty_port_tty_set(&port->port, NULL);
-			kfree(tty);
+			kref_put(&tty->kref, usb_console_release_fake_tty);
 		}
 		set_bit(ASYNCB_INITIALIZED, &port->port.flags);
 	}
@@ -179,7 +186,7 @@ static int usb_console_setup(struct console *co, char *options)
  fail:
 	tty_port_tty_set(&port->port, NULL);
  free_tty:
-	kfree(tty);
+	kref_put(&tty->kref, usb_console_release_fake_tty);
  reset_open_count:
 	port->port.count = 0;
 	usb_autopm_put_interface(serial->interface);
-- 
2.0.5
