From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and uart_shutdown()
Date: Thu, 12 Jul 2018 12:03:08 +0300
Message-ID: <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
References: <20180706212220.GC3583@cisco.lan> <20180711160744.32074-1-tycho@tycho.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711160744.32074-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 11, 2018 at 7:07 PM, Tycho Andersen <tycho@tycho.ws> wrote:

> Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> last chunk of that function may release state->xmit.buf before its assigned
> to null, and cause the race above.
>
> To fix it, let's lock uport->lock when allocating/deallocating
> state->xmit.buf in addition to the per-port mutex.

>     * use the result of uart_port_lock() in uart_shutdown() to avoid
>       uninitialized warning
>     * don't use the uart_port_lock/unlock macros in uart_port_startup,
>       instead test against uport directly; the compiler can't seem to "see"
>       through the macros/ref/unref calls to not warn about uninitialized
>       flags. We don't need to do a ref here since we hold the per-port
>       mutex anyway.

> +       if (uport)
> +               spin_lock_irqsave(&uport->lock, flags);

> +       if (uport)
> +               spin_unlock_irqrestore(&uport->lock, flags);

At some point it It was uart_port_lock()/uart_port_unlock(), and you
changed to simple spin lock. The macro also take reference to the
port. Do we aware about that here?

-- 
With Best Regards,
Andy Shevchenko
