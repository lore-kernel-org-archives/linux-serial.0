From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 54/62] TTY: irq: Remove IRQF_DISABLED
Date: Thu, 22 Sep 2011 16:08:44 -0700
Message-ID: <20110922230844.GA17025@kroah.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
 <1315383059-3673-55-git-send-email-yong.zhang0@gmail.com>
 <20110922230420.GA11264@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110922230420.GA11264@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tobias Klauser <tklauser@distanz.ch>, Sonic Zhang <sonic.zhang@analog.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Jesper Juhl <jj@chaosbits.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 22, 2011 at 04:04:20PM -0700, Greg KH wrote:
> On Wed, Sep 07, 2011 at 04:10:51PM +0800, Yong Zhang wrote:
> > This flag is a NOOP and can be removed now.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  drivers/tty/amiserial.c              |    2 +-
> >  drivers/tty/cyclades.c               |    2 +-
> >  drivers/tty/hvc/hvc_irq.c            |    2 +-
> >  drivers/tty/hvc/hvcs.c               |    2 +-
> >  drivers/tty/hvc/hvsi.c               |    2 +-
> >  drivers/tty/isicom.c                 |    2 +-
> >  drivers/tty/serial/68328serial.c     |    2 +-
> >  drivers/tty/serial/altera_jtaguart.c |    2 +-
> >  drivers/tty/serial/altera_uart.c     |    2 +-
> >  drivers/tty/serial/bfin_5xx.c        |    8 ++++----
> 
> This file isn't in my tree anymore, so I can't apply this :(
> 

Oh nevermind, I see your newer patch, I'll take that one, sorry.

greg k-h
