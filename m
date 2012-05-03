From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/06] serial8250-em: Add Emma Mobile UART driver
Date: Thu, 3 May 2012 08:46:54 +0000
Message-ID: <201205030846.55250.arnd@arndb.de>
References: <20120502124642.30480.41373.sendpatchset@w520> <4FA14788.6090000@windriver.com> <20120502212205.GA12212@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120502212205.GA12212@kroah.com>
Sender: linux-sh-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, horms@verge.net.au, linux-sh@vger.kernel.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Wednesday 02 May 2012, Greg KH wrote:
> > > +
> > > +config SERIAL_8250_EM
> > > +   tristate "Support for Emma Mobile intergrated serial port"
> > > +   depends on SERIAL_8250
> > 
> > Should we depend on arch=ARM or something similar?  Even if the
> > driver is written to be arch independent, if the Emma itself is
> > physically tied to ARM platforms, we probably don't need to be
> > building it for sparc allyesconfig etc.
> 
> Yeah, it doesn't build on x86-64, I get the following build problems:
>         ERROR: "clk_get_rate" [drivers/tty/serial/8250/8250_em.ko] undefined!
>         ERROR: "clk_enable" [drivers/tty/serial/8250/8250_em.ko] undefined!
>         ERROR: "clk_get" [drivers/tty/serial/8250/8250_em.ko] undefined!
>         ERROR: "clk_put" [drivers/tty/serial/8250/8250_em.ko] undefined!
>         ERROR: "clk_disable" [drivers/tty/serial/8250/8250_em.ko] undefined!
> 
> So it should depend on some arch that has clk at the least.
> 
> Magnus, care to redo just this one patch that fixes this up?  I've
> applied the first 5 already.

I think it's best to make it depend on HAVE_CLK, but depending on
ARM && HAVE_CLK is also fine with me. I would not like to have it depend
on EMMA specifically though because I want to increase built coverage.

	Arnd

