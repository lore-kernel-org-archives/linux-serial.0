From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 62/75] tty: Drop the lock_kernel in the private ioctl hook
Date: Fri, 02 Jan 2009 13:48:56 +0000
Message-ID: <20090102134852.13472.99774.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37665 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755428AbZABNsm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:42 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

We don't need the BKL here any more so it can go. In a couple of spots the
driver requirements are not clear so push the lock down into the driver.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/usb/serial/ftdi_sio.c   |    9 ++++++++-
 drivers/usb/serial/kl5kusb105.c |    1 +
 drivers/usb/serial/mct_u232.c   |    2 +-
 drivers/usb/serial/mos7840.c    |    3 +++
 drivers/usb/serial/usb-serial.c |    7 +------
 5 files changed, 14 insertions(+), 8 deletions(-)


diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index fb6f293..ef6cfa5 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1054,6 +1054,8 @@ static int set_serial_info(struct tty_struct *tty,
 
 	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
 		return -EFAULT;
+
+	lock_kernel();
 	old_priv = *priv;
 
 	/* Do error checking and permission checking */
@@ -1069,8 +1071,10 @@ static int set_serial_info(struct tty_struct *tty,
 	}
 
 	if ((new_serial.baud_base != priv->baud_base) &&
-	    (new_serial.baud_base < 9600))
+	    (new_serial.baud_base < 9600)) {
+	    	unlock_kernel();
 		return -EINVAL;
+	}
 
 	/* Make the changes - these are privileged changes! */
 
@@ -1098,8 +1102,11 @@ check_and_exit:
 	     (priv->flags & ASYNC_SPD_MASK)) ||
 	    (((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
 	     (old_priv.custom_divisor != priv->custom_divisor))) {
+		unlock_kernel();
 		change_speed(tty, port);
 	}
+	else
+		unlock_kernel();
 	return 0;
 
 } /* set_serial_info */
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index dc36a05..fcd9082 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -878,6 +878,7 @@ static void mct_u232_break_ctl(struct tty_struct *tty, int break_state)
 
 	dbg("%sstate=%d", __func__, break_state);
 
+	/* LOCKING */
 	if (break_state)
 		lcr |= MCT_U232_SET_BREAK;
 
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 07710cf..82930a7 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -721,10 +721,10 @@ static void mct_u232_break_ctl(struct tty_struct *tty, int break_state)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	lcr = priv->last_lcr;
-	spin_unlock_irqrestore(&priv->lock, flags);
 
 	if (break_state)
 		lcr |= MCT_U232_SET_BREAK;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	mct_u232_set_line_ctrl(serial, lcr);
 } /* mct_u232_break_ctl */
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index fda4a64..96a8c77 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1343,6 +1343,7 @@ static void mos7840_break(struct tty_struct *tty, int break_state)
 	else
 		data = mos7840_port->shadowLCR & ~LCR_SET_BREAK;
 
+	/* FIXME: no locking on shadowLCR anywhere in driver */
 	mos7840_port->shadowLCR = data;
 	dbg("mcs7840_break mos7840_port->shadowLCR is %x\n",
 	    mos7840_port->shadowLCR);
@@ -2214,10 +2215,12 @@ static int mos7840_set_modem_info(struct moschip_port *mos7840_port,
 		break;
 	}
 
+	lock_kernel();
 	mos7840_port->shadowMCR = mcr;
 
 	Data = mos7840_port->shadowMCR;
 	status = mos7840_set_uart_reg(port, MODEM_CONTROL_REGISTER, Data);
+	unlock_kernel();
 	if (status < 0) {
 		dbg("setting MODEM_CONTROL_REGISTER Failed\n");
 		return -1;
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 8d51890..080ade2 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -382,9 +382,7 @@ static int serial_ioctl(struct tty_struct *tty, struct file *file,
 	/* pass on to the driver specific version of this function
 	   if it is available */
 	if (port->serial->type->ioctl) {
-		lock_kernel();
 		retval = port->serial->type->ioctl(tty, file, cmd, arg);
-		unlock_kernel();
 	} else
 		retval = -ENOIOCTLCMD;
 	return retval;
@@ -413,11 +411,8 @@ static int serial_break(struct tty_struct *tty, int break_state)
 	WARN_ON(!port->port.count);
 	/* pass on to the driver specific version of this function
 	   if it is available */
-	if (port->serial->type->break_ctl) {
-		lock_kernel();
+	if (port->serial->type->break_ctl)
 		port->serial->type->break_ctl(tty, break_state);
-		unlock_kernel();
-	}
 	return 0;
 }
 

