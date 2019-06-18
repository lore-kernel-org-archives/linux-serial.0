From: Charles Oliveira <18oliveira.charles@gmail.com>
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
Date: Tue, 18 Jun 2019 16:35:30 -0300
Message-ID: <CAD17tR9-xss+AkeBMv6XLTxQ=Hx13wYuRYEmoRauNVxFLqh27A@mail.gmail.com>
References: <20190613180824.6ajwjelzr5fmjnie@debie> <20190618073853.GA25598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190618073853.GA25598@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 18, 2019 at 4:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 13, 2019 at 03:08:24PM -0300, Charles wrote:
> > Avoid following compiler warning on uninitialized variable
> >
> > In file included from ./include/linux/rwsem.h:16:0,
> >                  from ./include/linux/notifier.h:15,
> >                  from ./include/linux/clk.h:17,
> >                  from drivers/tty/serial/sh-sci.c:24:
> > drivers/tty/serial/sh-sci.c: In function =E2=80=98sci_dma_rx_submit=E2=
=80=99:
> > ./include/linux/spinlock.h:288:3: warning: =E2=80=98flags=E2=80=99 may =
be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >    _raw_spin_unlock_irqrestore(lock, flags); \
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/tty/serial/sh-sci.c:1353:16: note: =E2=80=98flags=E2=80=99 was =
declared here
> >   unsigned long flags;
> >                 ^~~~~
>
> What version of gcc is doing this?  It should be smarter than that,
> perhaps you should just upgrade.

Yep, worked like a charm. I was running gcc 6.3.0, just updated to 8.3.0
and got rid of that warning.

Thanks, Greg
>
> thanks,
>
> greg k-h



--=20
Charles
