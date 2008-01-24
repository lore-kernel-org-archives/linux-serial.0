From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: Handling RTS
Date: Thu, 24 Jan 2008 14:42:14 +0100
Message-ID: <014501c85e8e$edfc21b0$2e01a8c0@acksys.local>
References: <OF09424E34.A1A575E5-ONC12573D7.00406A86-C12573D7.0041A4D2@cemitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp02.msg.oleane.net ([62.161.4.2]:58707 "EHLO
	smtp02.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYAXOEm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jan 2008 09:04:42 -0500
In-Reply-To: <OF09424E34.A1A575E5-ONC12573D7.00406A86-C12573D7.0041A4D2@cemitec.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: JZabalza@cemitec.com, 'linux-serial' <linux-serial@vger.kernel.org>, linux-serial-owner@vger.kernel.org

It has been known since long ago that this behaviour (which is required=
 to
properly handle many RS485 devices) is not implemented by the serial dr=
iver.

So yes, you will have to implement it.
There are several ways to do it, by creating a new line discipline as
suggested by Russell King, or a new termios behaviour, or a new serial
ioctl.

In any case you will also need to add support for this in the 8250 driv=
er
itself. You can do this
 - by using special features of 82950 uarts (I did this once),
 - or by implementing RTS toggleing in software, which
    (1) is more difficult because there is no UART interrupt
        at the end of the byte serialization process,
    (2) is more flexible because you may want to handle a
        configurable delay between RTS rise/data/RTS fall,
    (3) is the only way with the 16C550 and earlier devices.

Jean-Pierre Tosoni

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of
> JZabalza@cemitec.com
> Sent: Monday, January 21, 2008 12:57 PM
> To: linux-serial; linux-serial-owner@vger.kernel.org
> Subject: RE: Handling RTS
>
>
> linux-serial-owner@vger.kernel.org escribi=F3 el 14/01/2008 16:05:03:
>
> > > From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> > > owner@vger.kernel.org] On Behalf Of JZabalza@cemitec.com
> > > Sent: January 10, 2008 3:27 AM
> > > To: linux-serial
> > > Subject: RE: Handling RTS
> > >
> > >         Thanks for your response. I have a PC, so dmesg said
> > >
> > >                 serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4)
> is a 16550A
> > >
> > >         How I said, I just handle RTS but from userland.
> This means a
> big
> > > latency between RTS activation and begin out data. I want
> only reduce
> this
> > > latency activating RTS on driver. My question is, is this
> *protocol*
> > > implemented actually or I must implement them.
> >
> > I'm not an expert on the current 8250 driver, but I believe
> you will
> have to
> > implement your 485 control.
> >
>
>         I'm not an expert too, but my question is, if is
> posible and good
> idea modify common layer of serial linux driver (serial_core.c) to
> implement a **walky-talky** protocol with RTS line, this is,
> activate RTS
> when there are chars to transmit and deactivate when there is not any
> character.
>
> Thanks.
>
>
> Jos=E9 Luis Zabalza
>
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
