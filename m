From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Remove schedule_work in sci_dma_rx_complete
Date: Mon, 18 May 2015 00:15:21 +0900
Message-ID: <CAH1o70LUUC7teuzLqM-8SsindwSaYP9LtsT2vLmwv6EGHcDygg@mail.gmail.com>
References: <1430327256-8545-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdWZj3tzwfFhjrTAB4cO0ZAKNJu+G_jBuNyfi46g1fQrYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWZj3tzwfFhjrTAB4cO0ZAKNJu+G_jBuNyfi46g1fQrYQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert-san,

2015-04-30 3:21 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san, Mizuguchi-san,
>
> On Wed, Apr 29, 2015 at 7:07 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index e7d6566..664ae78 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -126,6 +126,9 @@ struct sci_port {
>>  static void sci_start_tx(struct uart_port *port);
>>  static void sci_stop_tx(struct uart_port *port);
>>  static void sci_start_rx(struct uart_port *port);
>> +#ifdef CONFIG_SERIAL_SH_SCI_DMA
>> +static void work_fn_rx(struct work_struct *work);
>> +#endif
>
> While it would generate a larger patch, I think it's worthwhile moving
> work_fn_rx() up, so you don't need the #ifdef and the forward declaration.

Thanks for your review.
I'll send patch v2.

Regards,
Kaneko

>
>>  #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
>>
>> @@ -1341,7 +1344,7 @@ static void sci_dma_rx_complete(void *arg)
>>         if (count)
>>                 tty_flip_buffer_push(&port->state->port);
>>
>> -       schedule_work(&s->work_rx);
>> +       work_fn_rx(&s->work_rx);
>>  }
>>
>>  static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
