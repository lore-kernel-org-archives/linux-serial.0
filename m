From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Fri, 6 Jul 2018 15:22:20 -0600
Message-ID: <20180706212220.GC3583@cisco.lan>
References: <20180706143919.GA2344@kroah.com>
 <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
 <20180706183928.GA3583@cisco.lan>
 <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 06, 2018 at 11:48:58PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 6, 2018 at 9:39 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
> >> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> >  but without the initialization I get,
> >
> >   CC      drivers/tty/serial/serial_core.o
> > In file included from ./include/linux/seqlock.h:36:0,
> >                  from ./include/linux/time.h:6,
> >                  from ./include/linux/stat.h:19,
> >                  from ./include/linux/module.h:10,
> >                  from drivers/tty/serial/serial_core.c:10:
> > drivers/tty/serial/serial_core.c: In function ‘uart_startup.part.20’:
> > ./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
> >    _raw_spin_unlock_irqrestore(lock, flags); \
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/serial_core.c:184:22: note: ‘flags’ was declared here
> >   unsigned long page, flags;
> >                       ^~~~~
> 
> Hmm... I didn't see such warning. How you run make?

Just with `make`, although using the specific object file works too.
Perhaps it's gcc versions?

~/packages/linux uart-fix-v4 make drivers/tty/serial/serial_core.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      drivers/tty/serial/serial_core.o
In file included from ./include/linux/seqlock.h:36:0,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/tty/serial/serial_core.c:10:
drivers/tty/serial/serial_core.c: In function ‘uart_startup.part.20’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/serial_core.c:184:22: note: ‘flags’ was declared here
  unsigned long page, flags;
                      ^~~~~
In file included from ./include/linux/seqlock.h:36:0,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/tty/serial/serial_core.c:10:
drivers/tty/serial/serial_core.c: In function ‘uart_shutdown’:
./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function  -Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/serial_core.c:269:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~
~/packages/linux uart-fix-v4 gcc --version
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

> Btw, you adding the only places with such assignments in this file.
> So, I would not do in your case, until entire file would be fixed.
> 
> (But warning looks bogus, or you have some patches on top of current
> vanilla / next)

I don't have any patches, but I do admit to not thinking about it very hard and
adding initializations. I'll see if I can figure out what's going on.

Thanks,

Tycho
