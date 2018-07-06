From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Fri, 6 Jul 2018 12:39:28 -0600
Message-ID: <20180706183928.GA3583@cisco.lan>
References: <20180706143919.GA2344@kroah.com>
 <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
> > protected by the "per-port mutex", which based on uart_port_check() is
> > state->port.mutex. Indeed, the lock acquired in uart_put_char() is
> > uport->lock, i.e. not the same lock.
> >
> > Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> > last chunk of that function may release state->xmit.buf before its assigned
> > to null, and cause the race above.
> >
> > To fix it, let's lock uport->lock when allocating/deallocating
> > state->xmit.buf in addition to the per-port mutex.
> 
> Thanks for fixing this!
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Some nitpicks though.
> 
> > +       unsigned long page, flags = 0;
> 
> I would rather put on separate lines and btw assignment is not needed.
> It all goes through macros.

Sure, I can split it up, but without the initialization I get,

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

> > -       if (!state->xmit.buf) {
> > -               /* This is protected by the per port mutex */
> > -               page = get_zeroed_page(GFP_KERNEL);
> > -               if (!page)
> > -                       return -ENOMEM;
> > +       page = get_zeroed_page(GFP_KERNEL);
> > +       if (!page)
> > +               return -ENOMEM;
> > +       if (!state->xmit.buf) {
> >                 state->xmit.buf = (unsigned char *) page;
> >                 uart_circ_clear(&state->xmit);
> > +       } else {
> > +               free_page(page);
> >         }
> 
> I see original code, but since you are adding else, does it make sense
> to switch to positive condition?

Sure, I'll switch it.

> > +       unsigned long flags = 0;
> 
> Ditto about assignment.

And in this case too,

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

Tycho
