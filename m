From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and uart_shutdown()
Date: Fri, 6 Jul 2018 19:49:09 +0300
Message-ID: <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com>
References: <20180706143919.GA2344@kroah.com> <20180706162457.20489-1-tycho@tycho.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706162457.20489-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:

> Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
> protected by the "per-port mutex", which based on uart_port_check() is
> state->port.mutex. Indeed, the lock acquired in uart_put_char() is
> uport->lock, i.e. not the same lock.
>
> Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> last chunk of that function may release state->xmit.buf before its assigned
> to null, and cause the race above.
>
> To fix it, let's lock uport->lock when allocating/deallocating
> state->xmit.buf in addition to the per-port mutex.

Thanks for fixing this!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Some nitpicks though.

> +       unsigned long page, flags = 0;

I would rather put on separate lines and btw assignment is not needed.
It all goes through macros.

> -       if (!state->xmit.buf) {
> -               /* This is protected by the per port mutex */
> -               page = get_zeroed_page(GFP_KERNEL);
> -               if (!page)
> -                       return -ENOMEM;
> +       page = get_zeroed_page(GFP_KERNEL);
> +       if (!page)
> +               return -ENOMEM;
> +       if (!state->xmit.buf) {
>                 state->xmit.buf = (unsigned char *) page;
>                 uart_circ_clear(&state->xmit);
> +       } else {
> +               free_page(page);
>         }

I see original code, but since you are adding else, does it make sense
to switch to positive condition?

> +       unsigned long flags = 0;

Ditto about assignment.

-- 
With Best Regards,
Andy Shevchenko
