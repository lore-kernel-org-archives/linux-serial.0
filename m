From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] allow alternative name for PXA serial console
Date: Tue, 12 Mar 2013 16:39:51 -0700
Message-ID: <20130312233951.GA32737@kroah.com>
References: <1363129342-24310-1-git-send-email-ynvich@gmail.com>
 <20130312231054.GA6379@kroah.com>
 <CAL0eWdGYvdun=ChQ5gra67cBEgLFrzQ9dBGHL3ubAHOdww4FrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:40533 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab3CLXjy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Mar 2013 19:39:54 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so409692iag.31
        for <linux-serial@vger.kernel.org>; Tue, 12 Mar 2013 16:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL0eWdGYvdun=ChQ5gra67cBEgLFrzQ9dBGHL3ubAHOdww4FrQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?utf-8?B?0KHQtdGA0LPQtdC5INCv0L3QvtCy0LjRhw==?= <ynvich@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 13, 2013 at 03:34:59AM +0400, =D0=A1=D0=B5=D1=80=D0=B3=D0=B5=
=D0=B9 =D0=AF=D0=BD=D0=BE=D0=B2=D0=B8=D1=87 wrote:
> On 13 March 2013 03:10, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
> > On Wed, Mar 13, 2013 at 03:02:22AM +0400, Sergey Yanovich wrote:
> >> +config SERIAL_PXA_TTYSA_NAME
> >> +     bool "as /dev/ttySA[0-3]"
> >
> > Does that config text really make sense?  What does it look like wh=
en
> > you run "make oldconfig"?
>=20
> --------------------
> * Non-8250 serial port support
> *
> PXA serial port support (SERIAL_PXA) [Y/n/?] y
>   Console on PXA serial port (SERIAL_PXA_CONSOLE) [Y/n/?] y
>   as /dev/ttySA[0-3] (SERIAL_PXA_TTYSA_NAME) [N/y/?] (NEW)

Please make it sane for the single line it is on.

> So the kernel will have PXA serial port, a console on it, and it will
> have a name (and numbers) /dev/ttySA0 to /dev/ttySA3.
>=20
> >> ICP DAS LP-8x4x is an industrial data acquision device. It is base=
d
> >> on PXA270 CPU. The board containsi a lot of (up to 36) standard UA=
RTi
> >> 8250i serial ports. System console on the board is provided with
> >> an on-chip PXA serial port. Both modules use /dev/ttyS0 by default=
=2E
> >>
> >> To solve the collision, PXA ports could be configured with differe=
nt
> >> name and device numbers.
>=20
> > Ugh, why does it matter what it is named?
> >
> > Use udev, or a tool like it, to rename serial ports if you really n=
eed
> > it, don't do this in the kernel please.
>=20
> It doesn't matter what it is named. It matters that both drivers try
> to use the same major device number. I have to change major device
> number for PXA tty, as a result I need a different name in /dev
>=20
> Maybe I am missing something obvious, but it seems that such a
> collision is a kernel bug. Someone assumed that PXA cannot have a 825=
0
> tty device and used 8250's parameters in PXA tty driver.

Yes, someone must have messed up, so care to find the root problem here=
?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
