From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 8/9] tty: ircomm: remove dead and broken ioctl code
Date: Tue,  6 Jun 2017 12:54:40 +0200
Message-ID: <20170606105441.689-9-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Remove three ifdefed and broken implementations of TIOCSSERIAL and
TIOCGICOUNT, and parity handling in set_termios which had suffered
severe bit rot.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 net/irda/ircomm/ircomm_tty_ioctl.c | 107 +------------------------------------
 1 file changed, 1 insertion(+), 106 deletions(-)

diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index f18070118d05..171c3dee760e 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -97,33 +97,7 @@ static void ircomm_tty_change_speed(struct ircomm_tty_cb *self,
 		self->settings.flow_control &= ~IRCOMM_RTS_CTS_IN;
 	}
 	tty_port_set_check_carrier(&self->port, ~cflag & CLOCAL);
-#if 0
-	/*
-	 * Set up parity check flag
-	 */
-
-	if (I_INPCK(self->tty))
-		driver->read_status_mask |= LSR_FE | LSR_PE;
-	if (I_BRKINT(driver->tty) || I_PARMRK(driver->tty))
-		driver->read_status_mask |= LSR_BI;
-
-	/*
-	 * Characters to ignore
-	 */
-	driver->ignore_status_mask = 0;
-	if (I_IGNPAR(driver->tty))
-		driver->ignore_status_mask |= LSR_PE | LSR_FE;
-
-	if (I_IGNBRK(self->tty)) {
-		self->ignore_status_mask |= LSR_BI;
-		/*
-		 * If we're ignore parity and break indicators, ignore
-		 * overruns too. (For real raw support).
-		 */
-		if (I_IGNPAR(self->tty))
-			self->ignore_status_mask |= LSR_OE;
-	}
-#endif
+
 	self->settings.data_format = cval;
 
 	ircomm_param_request(self, IRCOMM_DATA_FORMAT, FALSE);
@@ -271,67 +245,6 @@ static int ircomm_tty_get_serial_info(struct ircomm_tty_cb *self,
 static int ircomm_tty_set_serial_info(struct ircomm_tty_cb *self,
 				      struct serial_struct __user *new_info)
 {
-#if 0
-	struct serial_struct new_serial;
-	struct ircomm_tty_cb old_state, *state;
-
-	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
-		return -EFAULT;
-
-
-	state = self
-	old_state = *self;
-
-	if (!capable(CAP_SYS_ADMIN)) {
-		if ((new_serial.baud_base != state->settings.data_rate) ||
-		    (new_serial.close_delay != state->close_delay) ||
-		    ((new_serial.flags & ~ASYNC_USR_MASK) !=
-		     (self->flags & ~ASYNC_USR_MASK)))
-			return -EPERM;
-		state->flags = ((state->flags & ~ASYNC_USR_MASK) |
-				 (new_serial.flags & ASYNC_USR_MASK));
-		self->flags = ((self->flags & ~ASYNC_USR_MASK) |
-			       (new_serial.flags & ASYNC_USR_MASK));
-		/* self->custom_divisor = new_serial.custom_divisor; */
-		goto check_and_exit;
-	}
-
-	/*
-	 * OK, past this point, all the error checking has been done.
-	 * At this point, we start making changes.....
-	 */
-
-	if (self->settings.data_rate != new_serial.baud_base) {
-		self->settings.data_rate = new_serial.baud_base;
-		ircomm_param_request(self, IRCOMM_DATA_RATE, TRUE);
-	}
-
-	self->close_delay = new_serial.close_delay * HZ/100;
-	self->closing_wait = new_serial.closing_wait * HZ/100;
-	/* self->custom_divisor = new_serial.custom_divisor; */
-
-	self->flags = ((self->flags & ~ASYNC_FLAGS) |
-		       (new_serial.flags & ASYNC_FLAGS));
-	self->tty->low_latency = (self->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-
- check_and_exit:
-
-	if (tty_port_initialized(self)) {
-		if (((old_state.flags & ASYNC_SPD_MASK) !=
-		     (self->flags & ASYNC_SPD_MASK)) ||
-		    (old_driver.custom_divisor != driver->custom_divisor)) {
-			if ((driver->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-				driver->tty->alt_speed = 57600;
-			if ((driver->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-				driver->tty->alt_speed = 115200;
-			if ((driver->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-				driver->tty->alt_speed = 230400;
-			if ((driver->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-				driver->tty->alt_speed = 460800;
-			ircomm_tty_change_speed(driver);
-		}
-	}
-#endif
 	return 0;
 }
 
@@ -367,24 +280,6 @@ int ircomm_tty_ioctl(struct tty_struct *tty,
 
 	case TIOCGICOUNT:
 		pr_debug("%s(), TIOCGICOUNT not impl!\n", __func__);
-#if 0
-		save_flags(flags); cli();
-		cnow = driver->icount;
-		restore_flags(flags);
-		p_cuser = (struct serial_icounter_struct __user *) arg;
-		if (put_user(cnow.cts, &p_cuser->cts) ||
-		    put_user(cnow.dsr, &p_cuser->dsr) ||
-		    put_user(cnow.rng, &p_cuser->rng) ||
-		    put_user(cnow.dcd, &p_cuser->dcd) ||
-		    put_user(cnow.rx, &p_cuser->rx) ||
-		    put_user(cnow.tx, &p_cuser->tx) ||
-		    put_user(cnow.frame, &p_cuser->frame) ||
-		    put_user(cnow.overrun, &p_cuser->overrun) ||
-		    put_user(cnow.parity, &p_cuser->parity) ||
-		    put_user(cnow.brk, &p_cuser->brk) ||
-		    put_user(cnow.buf_overrun, &p_cuser->buf_overrun))
-			return -EFAULT;
-#endif
 		return 0;
 	default:
 		ret = -ENOIOCTLCMD;  /* ioctls which we must ignore */
-- 
2.13.0
