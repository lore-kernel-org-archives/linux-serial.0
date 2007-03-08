From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 8 Mar 2007 15:25:52 +0100
Message-ID: <57354eff0703080625r783f6e39k5d6b2fe4d335a518@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <200703071019.55896.rgetz@blackfin.uclinux.org>
	 <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com>
	 <200703080844.32157.rgetz@blackfin.uclinux.org>
	 <20070308134800.GA30023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:26430 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbXCHOZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2007 09:25:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so652810nfa
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2007 06:25:53 -0800 (PST)
In-Reply-To: <20070308134800.GA30023@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>, Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

2007/3/8, Russell King <rmk+lkml@arm.linux.org.uk>:
> On Thu, Mar 08, 2007 at 08:44:31AM -0500, Robin Getz wrote:
> > On Wed 7 Mar 2007 16:30, Oleksiy Kebkal pondered:
> > > 2007/3/7, Robin Getz <rgetz@blackfin.uclinux.org>:
> > > > Right - so the question is where to manage the default state? I=
 was
> > > > thinking in the resource might be a good idea, but there isn't =
really a
> > > > good place for it. (You could re-use some bits if flags, but I =
think that
> > > > would not be a good idea).
> > >
> > > /proc/tty/driver/uartN/settings?
> > >
> >
> > That would let you change things are run time, but the problem is a=
t boot
> > time. A default setting needs to be set, so when things initialize,=
 and proc
> > does not exist yet, it is still set properly...
>
> I disagree.  "proc does not exist yet" - the only time that applies i=
s
> long before userspace as active.
>
> As I've said already, having a console on the same port as your appli=
cation
> program is just asking for trouble.  All bets are off - the kernel _w=
ill_
> corrupt your data stream in random places.
>
> Don't do it - it will _NEVER_ be reliable.
>
> Never, ever, mix kernel consoles with application serial ports.
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
>


--=20
EvoLogics GmbH
Blumenstra=DFe 49, 10243 Berlin

=46&E Labor Bionik
Ackerstra=DFe 76, 13355 Berlin

Tel.: + 49- (0) 30- 46 06 82 26
=46ax:  + 49- (0) 30- 46 06 82 15

lesha@evologics.de
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
