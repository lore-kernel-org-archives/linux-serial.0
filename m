From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Tue, 6 Mar 2007 18:24:08 -0500
Message-ID: <200703061824.08834.rgetz@blackfin.uclinux.org>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <m3bqj6jebt.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:31413 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030701AbXCFXXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Mar 2007 18:23:18 -0500
In-Reply-To: <m3bqj6jebt.fsf@maximus.localdomain>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Tue 6 Mar 2007 15:40, Krzysztof Halasa pondered:
> "Mike Frysinger" <vapier.adi@gmail.com> writes:
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/*
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Setup the RTS and DTR signals once the
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * port is open and ready to respond.
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (info->tty->termios->c_cflag & CBAUD)
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
>  > ...
>  >
>  > shouldnt TIOCM_RTS be passed down only when the 'r' is appended to=
 the
>  > boot cmdline ?
>
>  How would it be useful?

It is useful on (broken) legacy serial equipment, where RTS should be=20
completely under the applications control.

Glitches on RTS aren't acceptable, and confuse some devices.

>  CRTSCTS is for CTS only (i.e., the transmission is paused when CTS i=
s
>  inactive), not for RTS. DTR and RTS should be active when the port i=
s
>  open even without CRTSCTS (=3D without handshaking),

That depends on the equipment that you are attached to. Some very early=
=20
(broken) systems actually invert the meaning of RTS, so while the kerne=
l=20
thinks it is "opening" the port, it actually closes it...

>  it's used for=20
>  various purposes such as providing +12V to the device (and two pins
>  can supply more power than one - sure, it isn't the best idea).

I understand - the request wasn't to change the default operation - jus=
t add a=20
method of controlling things, so those minority of people who want the=20
control can have it.

-Robin
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
