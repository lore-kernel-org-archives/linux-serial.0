From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 2/6] serio: serport: hacks to get DT probe to work
Date: Wed, 24 Aug 2016 18:24:33 -0500
Message-ID: <20160824232437.9446-4-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For DT matching, the serio->dev.parent is expected to be the UART device
which is the tty's parent device. Not sure if this change has any side
effects, but this is all just for testing.

The spinlock causes deadlocks if serio_write is called from interrupt
handler as write_wakeup gets called. This could be fixed by clearing
TTY_DO_WRITE_WAKEUP if the spinlock is locked, but just doing quick hack
for now.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/serport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 9c927d3..a938c2b 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -183,7 +183,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, u
 	serio->open = serport_serio_open;
 	serio->close = serport_serio_close;
 	serio->port_data = serport;
-	serio->dev.parent = tty->dev;
+	serio->dev.parent = tty->dev->parent;
 
 	serio_register_port(serport->serio);
 	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty));
@@ -253,10 +253,10 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 	struct serport *serport = (struct serport *) tty->disc_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&serport->lock, flags);
+//	spin_lock_irqsave(&serport->lock, flags);
 	if (test_bit(SERPORT_ACTIVE, &serport->flags))
 		serio_drv_write_wakeup(serport->serio);
-	spin_unlock_irqrestore(&serport->lock, flags);
+//	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
-- 
2.9.3
