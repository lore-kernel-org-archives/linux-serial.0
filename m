From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Sun, 4 Mar 2007 15:42:25 -0500
Message-ID: <200703041542.25633.rgetz@blackfin.uclinux.org>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <20070304194632.GC30345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:16399 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbXCDUlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2007 15:41:32 -0500
In-Reply-To: <20070304194632.GC30345@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Sun 4 Mar 2007 14:46, Russell King pondered:
> On Thu, Mar 01, 2007 at 07:03:02PM -0500, Mike Frysinger wrote:
>  > the console=3D bootcmd allows for controlling of the initial state=
 of
>  > flow control by adding/omitting the 'r' suffix ...
>
>  The console command *only* sets the state for the kernel's use of on=
e
>  serial port.=C2=A0 It does not affect any other serial port, so tyin=
g
>  random RTS behaviours into that command line option is absolutely
>  silly.

I have one serial port in the system, it shares console, and the=20
communications port for the application. (But I guess that is besides t=
he=20
point).

When the common serial core initialises the UART, and sees that it has =
the=20
capability to do HW flow control - it enables it, asserting the pin, ev=
en if=20
I don't want it at that moment in time.

The real issue is that there is some legacy equipment, which gets confu=
sed if=20
it sees glitches on RTS (which happens today, when serial core init ass=
erts=20
RTS, and then the the main application turns it off)...

How do I set the set up the UART, so RTS is avaliable, but not enabled?

Thanks
-Robin
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
