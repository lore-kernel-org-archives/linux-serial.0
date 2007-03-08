From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 8 Mar 2007 15:23:49 +0100
Message-ID: <57354eff0703080623r2f7f88c3r7ddf6381061cbd73@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <200703071019.55896.rgetz@blackfin.uclinux.org>
	 <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com>
	 <200703080844.32157.rgetz@blackfin.uclinux.org>
	 <20070308134800.GA30023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:24224 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbXCHOXv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2007 09:23:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so652079nfa
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2007 06:23:50 -0800 (PST)
In-Reply-To: <20070308134800.GA30023@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>, Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

2007/3/8, Russell King <rmk+lkml@arm.linux.org.uk>:
> On Thu, Mar 08, 2007 at 08:44:31AM -0500, Robin Getz wrote:
> > On Wed 7 Mar 2007 16:30, Oleksiy Kebkal pondered:
> > > 2007/3/7, Robin Getz <rgetz@blackfin.uclinux.org>:
> > > > Right - so the question is where to manage the default state? I was
> > > > thinking in the resource might be a good idea, but there isn't really a
> > > > good place for it. (You could re-use some bits if flags, but I think that
> > > > would not be a good idea).
> > >
> > > /proc/tty/driver/uartN/settings?
> > >
> >
> > That would let you change things are run time, but the problem is at boot
> > time. A default setting needs to be set, so when things initialize, and proc
> > does not exist yet, it is still set properly...
>
> I disagree.  "proc does not exist yet" - the only time that applies is
> long before userspace as active.
>
> As I've said already, having a console on the same port as your application
> program is just asking for trouble.  All bets are off - the kernel _will_
> corrupt your data stream in random places.
>
> Don't do it - it will _NEVER_ be reliable.
>
> Never, ever, mix kernel consoles with application serial ports.

Ok. I understand now one of the sources of misunderstanding. I don't
want to mix console and application serial port. It was a question,
Myke Frisinger initially asked. I would switch on/off console
depending on some external control action if possible...

The other problem is how to open serial port with correct settings
_after_ booting. In this case /proc could be applicable, isn't it?

-Oleksiy
