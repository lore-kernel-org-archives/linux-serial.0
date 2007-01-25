From: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Subject: New IOCTL for Modem Control Lines monitoring
Date: Thu, 25 Jan 2007 18:09:33 +0100
Message-ID: <45B8E44D.5050005@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailironport.loria.fr ([152.81.144.100]:31983 "EHLO
	mailironport.loria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030470AbXAYRTb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Jan 2007 12:19:31 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

In kernel 2.6 (file drivers/serial/serial_core.c), there exists 2 IOCTL
for receiving signals over the modem control lines

TIOCMIWAIT  (function uart_wait_modem_status) for waiting for a change
             on the modem status lines.

TIOCGICOUNT (uart_get_count) to get the current state of the modem
              status lines.

While these IOCTL may be helpful to use the serial port as a general
serial communication device over modem control lines like in
the following (and quite old) discussion

http://www.mail-archive.com/linux-serial@vger.rutgers.edu/msg00407.html

I find a kind of "design" flaw with the 2 IOCTL for such a goal.

Indeed, it is possible that a modem status change occurs in between
ioctl(TIOCGICOUNT) and ioctl(TIOCMIWAIT) possibly locking a
communication because the last call would miss the status change
necessary to trigger a response. Indeed ioctl(TIOCMIWAIT) cannot
detect a change occurring before its call.

Even tough such an event would have a low probability to occur
if the 2 ioctl are close enough, it is still possible. This is
a race condition (outside the kernel but possibly locking some
process).

I propose the introduction of a new ioctl to solve this race,
implemented through the NEW function uart_wait_new_status associated
to a NEW ioctl.

The idea is that this new call would detect a change not compared
to the status at the beginning of the call but compared to some
previously recorded state. This way, the new ioctl would not
miss a status change, even if it occurs before the call to the
ioctl.

Could it be considered for inclusion in the kernel ?
It does not change any existing behavior. However it
does need a new ioctl name/number.

Thanks in advance for any comment

Dominique Larchey-Wendling
CNRS, France

-------------------------------------------------
Code to include in drivers/serial/serial_core.c
-------------------------------------------------

/*
  * Wait until any NEW signal is received on some selected
  * modem inputs lines (DCD,RI,DSR,CTS), compared to some
  * previously considered state.
  * If asked to wait on none, simply returns the current
  * status
  */

static int
uart_wait_new_status(struct uart_state *state, struct 
serial_icounter_struct __user *icnt)
{
	struct uart_port *port = state->port;
	DECLARE_WAITQUEUE(wait, current);
         struct serial_icounter_struct icount;
	struct uart_icount cstart, cnow;
         unsigned int mask, mctrl;
	int ret;

         if (copy_from_user(&icount, icnt, sizeof(icount)))
                 return -EFAULT;

         cstart.cts         = icount.cts;
         cstart.dsr         = icount.dsr;
         cstart.rng         = icount.rng;
         cstart.dcd         = icount.dcd;
         cstart.rx          = icount.rx;
         cstart.tx          = icount.tx;
         cstart.frame       = icount.frame;
         cstart.overrun     = icount.overrun;
         cstart.parity      = icount.parity;
         cstart.buf_overrun = icount.buf_overrun;

         /* if mask == 0 just simulate behavior of TIOCGICOUNT
          */

         mask = (unsigned) icount.reserved[0];

         /* enable Modem Status Interrupts in case not already done
          */

	spin_lock_irq(&port->lock);
	port->ops->enable_ms(port);
	spin_unlock_irq(&port->lock);

	add_wait_queue(&state->info->delta_msr_wait, &wait);

	for (;;) {
		spin_lock_irq(&port->lock);
                 mctrl = port->ops->get_mctrl(port);
		memcpy(&cnow, &port->icount, sizeof(struct uart_icount));
		spin_unlock_irq(&port->lock);

		set_current_state(TASK_INTERRUPTIBLE);

		if (((mask & TIOCM_RNG) && (cnow.rng != cstart.rng)) ||
		    ((mask & TIOCM_DSR) && (cnow.dsr != cstart.dsr)) ||
		    ((mask & TIOCM_CAR) && (cnow.dcd != cstart.dcd)) ||
		    ((mask & TIOCM_CTS) && (cnow.cts != cstart.cts)) ||
                      (mask == 0))
                 {
		    	ret = 0;
		    	break;
		}

		schedule();

		/* see if a signal did it */
		if (signal_pending(current)) {
			ret = -ERESTARTSYS;
			break;
		}

	}

	current->state = TASK_RUNNING;
	remove_wait_queue(&state->info->delta_msr_wait, &wait);

         if (ret < 0) return ret;

         /* we got our (new) state, transfer to user space
          */

         icount.cts         = cnow.cts;
	icount.dsr         = cnow.dsr;
	icount.rng         = cnow.rng;
	icount.dcd         = cnow.dcd;
	icount.rx          = cnow.rx;
	icount.tx          = cnow.tx;
	icount.frame       = cnow.frame;
	icount.overrun     = cnow.overrun;
	icount.parity      = cnow.parity;
	icount.brk         = cnow.brk;
	icount.buf_overrun = cnow.buf_overrun;
         icount.reserved[0] = mctrl;

         return copy_to_user(icnt, &icount, sizeof(icount)) ? -EFAULT : 0;
}
