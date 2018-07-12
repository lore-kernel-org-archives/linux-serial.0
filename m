From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Date: Thu, 12 Jul 2018 08:13:14 -0600
Message-ID: <20180712141314.GB13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Thu, Jul 12, 2018 at 12:03:08PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 11, 2018 at 7:07 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> > last chunk of that function may release state->xmit.buf before its assigned
> > to null, and cause the race above.
> >
> > To fix it, let's lock uport->lock when allocating/deallocating
> > state->xmit.buf in addition to the per-port mutex.
> 
> >     * use the result of uart_port_lock() in uart_shutdown() to avoid
> >       uninitialized warning
> >     * don't use the uart_port_lock/unlock macros in uart_port_startup,
> >       instead test against uport directly; the compiler can't seem to "see"
> >       through the macros/ref/unref calls to not warn about uninitialized
> >       flags. We don't need to do a ref here since we hold the per-port
> >       mutex anyway.
> 
> > +       if (uport)
> > +               spin_lock_irqsave(&uport->lock, flags);
> 
> > +       if (uport)
> > +               spin_unlock_irqrestore(&uport->lock, flags);
> 
> At some point it It was uart_port_lock()/uart_port_unlock(), and you
> changed to simple spin lock. The macro also take reference to the
> port. Do we aware about that here?

I don't think so, the commit message you quoted above says,

> We don't need to do a ref here since we hold the per-port mutex
> anyway.

Cheers,

Tycho
