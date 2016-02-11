From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v1] tty: serial: 8250: Fix possible race in serial8250_em485_destroy()
Date: Thu, 11 Feb 2016 23:05:45 +0300
Message-ID: <CAJs94EbLv0=5BOVLrk1muEWkge251Xhh4bQXe7dW-K7bL96qvw@mail.gmail.com>
References: <1455219152-10254-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455219152-10254-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I am sorry, please ignore it. There is no issue actually. The timer
handlers and rs485_config callbacks are protected by the same
spinlock, so they are never run in parallel.

2016-02-11 22:32 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
> Fix possbile race in serial8250_em485_destroy() when timer handlers can
> dereference p->em485 which is alread destroyed but not yet NULLed.
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
> I've found that Greg applied initial patchset, so this erratum goes as separate patch.
>
>  drivers/tty/serial/8250/8250_port.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c908b77..d962de2 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -617,14 +617,16 @@ EXPORT_SYMBOL_GPL(serial8250_em485_init);
>   */
>  void serial8250_em485_destroy(struct uart_8250_port *p)
>  {
> -       if (p->em485 == NULL)
> +       struct uart_8250_em485 *em485 = p->em485;
> +
> +       if (!em485)
>                 return;
>
> -       del_timer(&p->em485->start_tx_timer);
> -       del_timer(&p->em485->stop_tx_timer);
> +       del_timer(&em485->start_tx_timer);
> +       del_timer(&em485->stop_tx_timer);
>
> -       kfree(p->em485);
>         p->em485 = NULL;
> +       kfree(em485);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
>
> --
> 2.7.0
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
