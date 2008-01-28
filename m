From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: Handling RTS
Date: Mon, 28 Jan 2008 10:27:05 +0100
Message-ID: <008601c8618f$f3643f30$2e01a8c0@acksys.local>
References: <OFB4416C24.6CC7E961-ONC12573DB.002E41AD-C12573DB.0034DD9C@cemitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp06.msg.oleane.net ([62.161.4.6]:52018 "EHLO
	smtp06.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226AbYA1J1Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Jan 2008 04:27:16 -0500
In-Reply-To: <OFB4416C24.6CC7E961-ONC12573DB.002E41AD-C12573DB.0034DD9C@cemitec.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: JZabalza@cemitec.com, 'linux-serial' <linux-serial@vger.kernel.org>
Cc: Jean-Pierre TOSONI <TOSONI@acksys.local>

Please note that the subject has been discussed in deep several times :
http://www.spinics.net/lists/linux-serial/msg00303.html
http://www.mail-archive.com/linux-serial@vger.rutgers.edu/msg00407.html
Also the driver CRISV10.C once had some provision for RTS toggle (at le=
ast
this was true three years ago).
I gave you some of my code below, which diverts from the CRISV10 ioctl =
in a
compatible way. I can send you all the code offline if you wish (not su=
re it
will help more although).

> Yes, but, I am confused.  A line discipline is oriented to translate =
data
> not to handle flow control protocol , isn't It?
>
- A line discipline defines a way to manage the transmission line, not
merely data translation but mainly the protocol. So it is a good place =
to
enforce half duplex for example.

> Is it posible implement RTS handling on serial_core.c module to be co=
mmon
to all uarts?
> This shall be used by all uarts, isn't it?
>
- Well, yes. But some people won't want the feature, so it must be
configurable in some way. hence the need for an ioctl (callable from us=
er
space or from a line discipline, whatever).

> is it posible activate RTS just before start_tx() call using
uart_update_mctrl() function?
>
- I am not familiar with this part of the driver, but there is a proble=
m
mainly with the RTS drop, because we don't know for sure when the UART
serializer is empty. So the implementation on the 8250 requires to star=
t a
timer when the driver's buffer becomes empty. It's no easy because some
uarts have fifo's of their own.

- Also, I have encountered cases where a parametrized delay was needed
between RTS and data, so it would be great if your new IOCTL has parame=
ters
to do this (even if you only implement the 'zero delay' case) just like=
 I
have done in my own implementation, and the CRISV10 driver does the ful=
l
implementation.

- Also, pay attention to this use of RTS that may go in the way of flow
control by RTS (CRTSCTS flag), you may want to disable flow control whe=
n you
activate RTS toggling.

Here is what I am using for a 82950 device. The ioctl can be used for a=
ny
UART but my implementation applies only to the 82950, so, I don't need =
to
change the RTS in the transmission data path:

///// in 8250.c: ////////////////////
added in uart_ops serial8250_pops:
	.ioctl		=3D serial8250_ioctl,
then:
static int
serial8250_ioctl(struct uart_port *port, unsigned int cmd, unsigned lon=
g
arg)
{
	struct uart_8250_port *up =3D (struct uart_8250_port *)port;
	int ret =3D -ENOIOCTLCMD;

	switch (cmd) {
	case TIOCSERSETRS485:
		if (up->port.type =3D=3D PORT_16C950) {
			// arg may be 1 or struct rs485_control *
			// in order to be crisv10 compatible

			/* HERE, STUFF to activate built-in 16C950 RTS toggle */
			...
			return 0;
		}
		// else, it may be the RTS-TOGGLE kind of RS485 device, needs
		// more work to support. See crisv10.c.
		break;

	default:
		break;
	}
	return ret;
}
///// misc defines which should be included in linux standard headers
////////

/* in asm-i386/ioctls.h */
#ifndef TIOCSERSETRS485
#define TIOCSERSETRS485 0x5461  /* enable rs-485 */
#define TIOCSERWRRS485  0x5462  /* write rs-485 */
#endif

///////////// sample use /////////////////////
#include <stdio.h>
//#include "ioctls.h"
#include <linux/termios.h>
//#include <sys/ioctl.h>
#ifndef TIOCSERSETRS485
#define TIOCSERSETRS485 0x5461  /* enable rs-485 */
#define TIOCSERWRRS485  0x5462  /* write rs-485 */
#endif
main(int c,char **v)
{
	int fd,i;
	char t[1000];

	if (c !=3D 3) {
		fprintf(stderr,"usage: %s /dev/ttySxxx 0-or-1\n",v[0]);
		exit(1);
	}
	fd =3D open(v[1],2);
	if(fd < 0) {
		perror(v[1]);
		exit(1);
	}
	i =3D ioctl(fd,TIOCSERSETRS485,atoi(v[2]));
	if(i < 0) {
		perror("TIOCRS485");
	}
	printf("%s set to %s\n",v[1],atoi(v[2])
			? "RS485 auto turnaround using DTR"
			: "normal full-duplex mode");
	close(fd);
}



> -----Original Message-----
> From: JZabalza@cemitec.com [mailto:JZabalza@cemitec.com]
> Sent: Friday, January 25, 2008 10:38 AM
> To: 'linux-serial'
> Cc: Tosoni
> Subject: RE: Handling RTS
>
>
> linux-serial-owner@vger.kernel.org escribi=F3 el 24/01/2008 14:42:14:
>
> Thank you very munch for your response Jean-Pierre. I think
> you understand
> me.
>
> > It has been known since long ago that this behaviour (which
> is required
> to
> > properly handle many RS485 devices) is not implemented by
> the serial
> driver.
> >
> > So yes, you will have to implement it.
> > There are several ways to do it, by creating a new line
> discipline as
> > suggested by Russell King, or a new termios behaviour, or a
> new serial
> > ioctl.
>
>
> Yes, but, I am confused.  A line discipline is oriented to
> translate data
> not to handle flow control protocol , isn't It?
>
>
> >
> > In any case you will also need to add support for this in the 8250
> driver
> > itself. You can do this
> >  - by using special features of 82950 uarts (I did this once),
> >  - or by implementing RTS toggleing in software, which
> >     (1) is more difficult because there is no UART interrupt
> >         at the end of the byte serialization process,
> >     (2) is more flexible because you may want to handle a
> >         configurable delay between RTS rise/data/RTS fall,
> >     (3) is the only way with the 16C550 and earlier devices.
> >
>
> Yes, but it's only for 8250 uart. I think that all uarts have
> RTS pin. I
> know it's not true, but
>
> For example this code snipet from serial_core.c
>
> static void __uart_start(struct tty_struct *tty)
> {
>         struct uart_state *state =3D tty->driver_data;
>         struct uart_port *port =3D state->port;
>
>         if (!uart_circ_empty(&state->info->xmit) &&
> state->info->xmit.buf
> &&
>             !tty->stopped && !tty->hw_stopped)
>                 port->ops->start_tx(port);
> }
>
> is it posible activate RTS just before start_tx() call using
> uart_update_mctrl() function?
>
> This shall be used by all uarts, isn't it?
>
> Is it posible implement RTS handling on serial_core.c module
> to be common
> to all uarts?
>
> Thanks in avance
>
>
>
>
>
>
>
>
> Jos=E9 Luis Zabalza
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
