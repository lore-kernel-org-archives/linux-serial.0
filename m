From: JZabalza@cemitec.com
Subject: RE: Handling RTS
Date: Fri, 25 Jan 2008 10:37:42 +0100
Message-ID: <OFB4416C24.6CC7E961-ONC12573DB.002E41AD-C12573DB.0034DD9C@cemitec.com>
References: <014501c85e8e$edfc21b0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cliente-24411.iberbanda.es ([83.230.159.89]:4126 "EHLO
	Morondo.cemitec.local" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754415AbYAYJgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2008 04:36:05 -0500
In-Reply-To: <014501c85e8e$edfc21b0$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'linux-serial' <linux-serial@vger.kernel.org>
Cc: Tosoni <jp.tosoni@acksys.fr>

linux-serial-owner@vger.kernel.org escribi=F3 el 24/01/2008 14:42:14:

Thank you very munch for your response Jean-Pierre. I think you underst=
and=20
me.

> It has been known since long ago that this behaviour (which is requir=
ed=20
to
> properly handle many RS485 devices) is not implemented by the serial=20
driver.
>=20
> So yes, you will have to implement it.
> There are several ways to do it, by creating a new line discipline as
> suggested by Russell King, or a new termios behaviour, or a new seria=
l
> ioctl.


Yes, but, I am confused.  A line discipline is oriented to translate da=
ta=20
not to handle flow control protocol , isn't It?=20


>=20
> In any case you will also need to add support for this in the 8250=20
driver
> itself. You can do this
>  - by using special features of 82950 uarts (I did this once),
>  - or by implementing RTS toggleing in software, which
>     (1) is more difficult because there is no UART interrupt
>         at the end of the byte serialization process,
>     (2) is more flexible because you may want to handle a
>         configurable delay between RTS rise/data/RTS fall,
>     (3) is the only way with the 16C550 and earlier devices.
>=20

Yes, but it's only for 8250 uart. I think that all uarts have RTS pin. =
I=20
know it's not true, but

=46or example this code snipet from serial_core.c

static void __uart_start(struct tty_struct *tty)
{
        struct uart_state *state =3D tty->driver_data;
        struct uart_port *port =3D state->port;

        if (!uart_circ_empty(&state->info->xmit) && state->info->xmit.b=
uf=20
&&
            !tty->stopped && !tty->hw_stopped)
                port->ops->start_tx(port);
}

is it posible activate RTS just before start_tx() call using=20
uart_update_mctrl() function?

This shall be used by all uarts, isn't it?

Is it posible implement RTS handling on serial_core.c module to be comm=
on=20
to all uarts?

Thanks in avance








Jos=E9 Luis Zabalza

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
