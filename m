From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: New IOCTL for Modem Control Lines monitoring
Date: Thu, 25 Jan 2007 19:34:58 +0100
Message-ID: <000701c740af$852c83d0$2e01a8c0@acksys.local>
References: <45B8E44D.5050005@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp20.msg.oleane.net ([62.161.4.20]:52174 "EHLO
	smtp20.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965572AbXAYSz6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Jan 2007 13:55:58 -0500
In-Reply-To: <45B8E44D.5050005@loria.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Dominique Larchey-Wendling' <Dominique.Larchey-Wendling@loria.fr>, linux-serial@vger.kernel.org

Sounds like an equivalent to WaitCommEvent in Windows NT.

But there is a problem in Linux, which does not exist in Windows where =
the
serial port is locked by the requesting process: in Linux you would hav=
e to
associate your "recorded state" with the requesting process, because se=
veral
processes may use your new ioctl at the same time.

Or, you can say that it's a feature of your ioctl to handle only one pr=
ocess
:-)

Also, in Windows there is an extra feature, you can set a mask of which
signal changes you want to monitor, you might want this feature as well

Best regards
Tosoni, Acksys

> -----Message d'origine-----
> De : linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]De la part de Dominique
> Larchey-Wendling
> Envoy=E9 : jeudi 25 janvier 2007 18:10
> =C0 : linux-serial@vger.kernel.org
> Objet : New IOCTL for Modem Control Lines monitoring
>
>
> In kernel 2.6 (file drivers/serial/serial_core.c), there
> exists 2 IOCTL
> for receiving signals over the modem control lines
>
> TIOCMIWAIT  (function uart_wait_modem_status) for waiting for a chang=
e
>              on the modem status lines.
>
> TIOCGICOUNT (uart_get_count) to get the current state of the modem
>               status lines.
>
> While these IOCTL may be helpful to use the serial port as a general
> serial communication device over modem control lines like in
> the following (and quite old) discussion
>
> http://www.mail-archive.com/linux-serial@vger.rutgers.edu/msg0
> 0407.html
>
> I find a kind of "design" flaw with the 2 IOCTL for such a goal.
>
> Indeed, it is possible that a modem status change occurs in between
> ioctl(TIOCGICOUNT) and ioctl(TIOCMIWAIT) possibly locking a
> communication because the last call would miss the status change
> necessary to trigger a response. Indeed ioctl(TIOCMIWAIT) cannot
> detect a change occurring before its call.
>
> Even tough such an event would have a low probability to occur
> if the 2 ioctl are close enough, it is still possible. This is
> a race condition (outside the kernel but possibly locking some
> process).
>
> I propose the introduction of a new ioctl to solve this race,
> implemented through the NEW function uart_wait_new_status associated
> to a NEW ioctl.
>
> The idea is that this new call would detect a change not compared
> to the status at the beginning of the call but compared to some
> previously recorded state. This way, the new ioctl would not
> miss a status change, even if it occurs before the call to the
> ioctl.
>
> Could it be considered for inclusion in the kernel ?
> It does not change any existing behavior. However it
> does need a new ioctl name/number.
>
> Thanks in advance for any comment
>
> Dominique Larchey-Wendling
> CNRS, France
>
> -------------------------------------------------
> Code to include in drivers/serial/serial_core.c
> -------------------------------------------------
>
> /*
>   * Wait until any NEW signal is received on some selected
>   * modem inputs lines (DCD,RI,DSR,CTS), compared to some
>   * previously considered state.
>   * If asked to wait on none, simply returns the current
>   * status
>   */
>
> static int
> uart_wait_new_status(struct uart_state *state, struct
> serial_icounter_struct __user *icnt)
> {
> 	struct uart_port *port =3D state->port;
> 	DECLARE_WAITQUEUE(wait, current);
>          struct serial_icounter_struct icount;
> 	struct uart_icount cstart, cnow;
>          unsigned int mask, mctrl;
> 	int ret;
>
>          if (copy_from_user(&icount, icnt, sizeof(icount)))
>                  return -EFAULT;
>
>          cstart.cts         =3D icount.cts;
>          cstart.dsr         =3D icount.dsr;
>          cstart.rng         =3D icount.rng;
>          cstart.dcd         =3D icount.dcd;
>          cstart.rx          =3D icount.rx;
>          cstart.tx          =3D icount.tx;
>          cstart.frame       =3D icount.frame;
>          cstart.overrun     =3D icount.overrun;
>          cstart.parity      =3D icount.parity;
>          cstart.buf_overrun =3D icount.buf_overrun;
>
>          /* if mask =3D=3D 0 just simulate behavior of TIOCGICOUNT
>           */
>
>          mask =3D (unsigned) icount.reserved[0];
>
>          /* enable Modem Status Interrupts in case not already done
>           */
>
> 	spin_lock_irq(&port->lock);
> 	port->ops->enable_ms(port);
> 	spin_unlock_irq(&port->lock);
>
> 	add_wait_queue(&state->info->delta_msr_wait, &wait);
>
> 	for (;;) {
> 		spin_lock_irq(&port->lock);
>                  mctrl =3D port->ops->get_mctrl(port);
> 		memcpy(&cnow, &port->icount, sizeof(struct
> uart_icount));
> 		spin_unlock_irq(&port->lock);
>
> 		set_current_state(TASK_INTERRUPTIBLE);
>
> 		if (((mask & TIOCM_RNG) && (cnow.rng !=3D cstart.rng)) ||
> 		    ((mask & TIOCM_DSR) && (cnow.dsr !=3D cstart.dsr)) ||
> 		    ((mask & TIOCM_CAR) && (cnow.dcd !=3D cstart.dcd)) ||
> 		    ((mask & TIOCM_CTS) && (cnow.cts !=3D cstart.cts)) ||
>                       (mask =3D=3D 0))
>                  {
> 		    	ret =3D 0;
> 		    	break;
> 		}
>
> 		schedule();
>
> 		/* see if a signal did it */
> 		if (signal_pending(current)) {
> 			ret =3D -ERESTARTSYS;
> 			break;
> 		}
>
> 	}
>
> 	current->state =3D TASK_RUNNING;
> 	remove_wait_queue(&state->info->delta_msr_wait, &wait);
>
>          if (ret < 0) return ret;
>
>          /* we got our (new) state, transfer to user space
>           */
>
>          icount.cts         =3D cnow.cts;
> 	icount.dsr         =3D cnow.dsr;
> 	icount.rng         =3D cnow.rng;
> 	icount.dcd         =3D cnow.dcd;
> 	icount.rx          =3D cnow.rx;
> 	icount.tx          =3D cnow.tx;
> 	icount.frame       =3D cnow.frame;
> 	icount.overrun     =3D cnow.overrun;
> 	icount.parity      =3D cnow.parity;
> 	icount.brk         =3D cnow.brk;
> 	icount.buf_overrun =3D cnow.buf_overrun;
>          icount.reserved[0] =3D mctrl;
>
>          return copy_to_user(icnt, &icount, sizeof(icount)) ?
> -EFAULT : 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
