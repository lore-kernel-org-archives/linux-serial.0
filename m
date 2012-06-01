From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid recursive spinlocks
Date: Fri, 1 Jun 2012 17:30:25 +0900
Message-ID: <CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59889 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758929Ab2FAIaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Jun 2012 04:30:25 -0400
In-Reply-To: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Thu, May 31, 2012 at 5:54 PM, Darren Hart <dvhart@linux.intel.com> w=
rote:
> @@ -1376,7 +1379,8 @@ static void pch_uart_set_termios(struct uart_po=
rt *port,
>
> =A0 =A0 =A0 =A0baud =3D uart_get_baud_rate(port, termios, old, 0, por=
t->uartclk / 16);
>
> - =A0 =A0 =A0 spin_lock_irqsave(&port->lock, flags);
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> + =A0 =A0 =A0 spin_lock(&port->lock);
>
> =A0 =A0 =A0 =A0uart_update_timeout(port, termios->c_cflag, baud);
> =A0 =A0 =A0 =A0rtn =3D pch_uart_hal_set_line(priv, baud, parity, bits=
, stb);
> @@ -1389,7 +1393,8 @@ static void pch_uart_set_termios(struct uart_po=
rt *port,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tty_termios_encode_baud_rate(termios, =
baud, baud);
>
> =A0out:
> - =A0 =A0 =A0 spin_unlock_irqrestore(&port->lock, flags);
> + =A0 =A0 =A0 spin_unlock(&port->lock);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> =A0}

Are both port->lock and priv->lock really necessary ?


> @@ -1572,7 +1578,9 @@ pch_console_write(struct console *co, const cha=
r *s, unsigned int count)
>
> =A0 =A0 =A0 =A0if (locked)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&priv->port.lock);
> + =A0 =A0 =A0 spin_unlock(&priv->lock);
> =A0 =A0 =A0 =A0local_irq_restore(flags);
> +
> =A0}

Looks spare blank line.

thanks.
--=20
ROHM Co., Ltd.
tomoya
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
