Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9127C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 23:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1374206C3
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 23:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFkzTwNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLX7t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLX7s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 19:59:48 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1CAC061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 16:59:48 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id e20so1135552uav.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkhzGPTFs+cac0M1GsyIfO4qoWfrJUKbKZsDfMHWaAg=;
        b=HFkzTwNacjMvOvgx22Z3SG8a6pDXPQ+p9Z6vB8BMDuAuTtWaCiM8aYdJxMIuZeRmbO
         45cxZTBoq3sVtBgHK8iPHQYje/WU0QiZt/AseLymk+FGgtaJFeJMA/jXvbUVcH4VnaAI
         9x5KXG/OaT2CkwffRwz7Xb5RmKH+Bk1BlH9R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkhzGPTFs+cac0M1GsyIfO4qoWfrJUKbKZsDfMHWaAg=;
        b=lWS7idaaanEFvcH0GF7QOXx1Bodi7w4Eg7N0WjKDcNn+R9NfwraDQBmTthxcuQ5DYs
         UVzkNY0GGN5b1vIRjgN4xtv+fwrPVgOiWSfuqEqIxC20Aa6/uQd8Mq5KW/GxiYyBtDLl
         SWfumoZi82H2173B+qyAM0QISQ8xhBaLUV4LyKgE2ODPdwledeEuFtTo2JzLiRoEde6E
         0wJzHP5ib7muBocSjpUgrpbvZUjnQ+AhmuCPZKw8aWuzjT/hB0I+MNcsze08nXVSgpem
         A+r0J2raGp8i5S5Lu6Wcqbib4uIz6GhUf8NNlkkfzIvx/mmDHpgn12jj7m08dMBtGSeu
         DsiQ==
X-Gm-Message-State: AOAM533QGpWQLx13NssITZDefaInJxEa6Wnvf/78aurzZAz4UuUoI5yA
        jPf6ulk7bl6/bXAst9fEyQAgI8HcsG4=
X-Google-Smtp-Source: ABdhPJxZNYRfUhnMeZn1YsRaio58r/bCEIlJPlNeWHwvJGNHGNjzRSbzEsMffgs49fC62PetIbqCmA==
X-Received: by 2002:a9f:2966:: with SMTP id t93mr1484702uat.90.1597276787539;
        Wed, 12 Aug 2020 16:59:47 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id l11sm574437vka.24.2020.08.12.16.59.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 16:59:46 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id r197so888058vkf.13
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 16:59:46 -0700 (PDT)
X-Received: by 2002:a1f:ae42:: with SMTP id x63mr1608058vke.100.1597276786166;
 Wed, 12 Aug 2020 16:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org> <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1595333413-30052-3-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Aug 2020 16:59:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
Message-ID: <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Jul 21, 2020 at 5:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add NMI framework APIs in serial core which can be leveraged by serial
> drivers to have NMI driven serial transfers. These APIs are kept under
> CONFIG_CONSOLE_POLL as currently kgdb initializing uart in polling mode
> is the only known user to enable NMI driven serial port.
>
> The general idea is to intercept RX characters in NMI context, if those
> are specific to magic sysrq then allow corresponding handler to run in
> NMI context. Otherwise defer all other RX and TX operations to IRQ work
> queue in order to run those in normal interrupt context.
>
> Also, since magic sysrq entry APIs will need to be invoked from NMI
> context, so make those APIs NMI safe via deferring NMI unsafe work to
> IRQ work queue.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/serial_core.c | 120 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/serial_core.h      |  67 ++++++++++++++++++++++
>  2 files changed, 185 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57840cf..6342e90 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3181,8 +3181,14 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>                 return true;
>         }
>
> +#ifdef CONFIG_CONSOLE_POLL
> +       if (in_nmi())
> +               irq_work_queue(&port->nmi_state.sysrq_toggle_work);
> +       else
> +               schedule_work(&sysrq_enable_work);
> +#else
>         schedule_work(&sysrq_enable_work);
> -
> +#endif

It should be a very high bar to have #ifdefs inside functions.  I
don't think this meets it.  Instead maybe something like this
(untested and maybe slightly wrong syntax, but hopefully makes
sense?):

Outside the function:

#ifdef CONFIG_CONSOLE_POLL
#define queue_port_nmi_work(port, work_type)
irq_work_queue(&port->nmi_state.work_type)
#else
#define queue_port_nmi_work(port, work_type)
#endif

...and then:

if (IS_ENABLED(CONFIG_CONSOLE_POLL) && in_nmi())
  queue_port_nmi_work(port, sysrq_toggle_work);
else
  schedule_work(&sysrq_enable_work);

---

The whole double-hopping is really quite annoying.  I guess
schedule_work() can't be called from NMI context but can be called
from IRQ context?  So you need to first transition from NMI context to
IRQ context and then go and schedule the work?  Almost feels like we
should just fix schedule_work() to do this double-hop for you if
called from NMI context.  Seems like you could even re-use the list
pointers in the work_struct to keep the queue of people who need to be
scheduled from the next irq_work?  Worst case it seems like you could
add a schedule_work_nmi() that would do all the hoops for you.  ...but
I also know very little about NMI so maybe I'm being naive.


>         port->sysrq = 0;
>         return true;
>  }
> @@ -3273,12 +3279,122 @@ int uart_handle_break(struct uart_port *port)
>                 port->sysrq = 0;
>         }
>
> -       if (port->flags & UPF_SAK)
> +       if (port->flags & UPF_SAK) {
> +#ifdef CONFIG_CONSOLE_POLL
> +               if (in_nmi())
> +                       irq_work_queue(&port->nmi_state.sysrq_sak_work);
> +               else
> +                       do_SAK(state->port.tty);
> +#else
>                 do_SAK(state->port.tty);
> +#endif
> +       }

Similar comment as above about avoiding #ifdef in functions.  NOTE: if
you have something like schedule_work_nmi() I think you could just
modify the do_SAK() function to call it and consider do_SAK() to be
NMI safe.


>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(uart_handle_break);
>
> +#ifdef CONFIG_CONSOLE_POLL
> +int uart_nmi_handle_char(struct uart_port *port, unsigned int status,
> +                        unsigned int overrun, unsigned int ch,
> +                        unsigned int flag)
> +{
> +       struct uart_nmi_rx_data rx_data;
> +
> +       if (!in_nmi())
> +               return 0;
> +
> +       rx_data.status = status;
> +       rx_data.overrun = overrun;
> +       rx_data.ch = ch;
> +       rx_data.flag = flag;
> +
> +       if (!kfifo_in(&port->nmi_state.rx_fifo, &rx_data, 1))
> +               ++port->icount.buf_overrun;
> +
> +       return 1;
> +}
> +EXPORT_SYMBOL_GPL(uart_nmi_handle_char);
> +
> +static void uart_nmi_rx_work(struct irq_work *rx_work)
> +{
> +       struct uart_nmi_state *nmi_state =
> +           container_of(rx_work, struct uart_nmi_state, rx_work);
> +       struct uart_port *port =
> +           container_of(nmi_state, struct uart_port, nmi_state);
> +       struct uart_nmi_rx_data rx_data;
> +
> +       /*
> +        * In polling mode, serial device is initialized much prior to
> +        * TTY port becoming active. This scenario is especially useful
> +        * from debugging perspective such that magic sysrq or debugger
> +        * entry would still be possible even when TTY port isn't
> +        * active (consider a boot hang case or if a user hasn't opened
> +        * the serial port). So we discard any other RX data apart from
> +        * magic sysrq commands in case TTY port isn't active.
> +        */
> +       if (!port->state || !tty_port_active(&port->state->port)) {
> +               kfifo_reset(&nmi_state->rx_fifo);
> +               return;
> +       }
> +
> +       spin_lock(&port->lock);
> +       while (kfifo_out(&nmi_state->rx_fifo, &rx_data, 1))
> +               uart_insert_char(port, rx_data.status, rx_data.overrun,
> +                                rx_data.ch, rx_data.flag);
> +       spin_unlock(&port->lock);
> +
> +       tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static void uart_nmi_tx_work(struct irq_work *tx_work)
> +{
> +       struct uart_nmi_state *nmi_state =
> +           container_of(tx_work, struct uart_nmi_state, tx_work);
> +       struct uart_port *port =
> +           container_of(nmi_state, struct uart_port, nmi_state);
> +
> +       spin_lock(&port->lock);
> +       if (nmi_state->tx_irq_callback)
> +               nmi_state->tx_irq_callback(port);
> +       spin_unlock(&port->lock);
> +}
> +
> +static void uart_nmi_sak_work(struct irq_work *work)
> +{
> +       struct uart_nmi_state *nmi_state =
> +           container_of(work, struct uart_nmi_state, sysrq_sak_work);
> +       struct uart_port *port =
> +           container_of(nmi_state, struct uart_port, nmi_state);
> +
> +       do_SAK(port->state->port.tty);
> +}
> +
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +static void uart_nmi_toggle_work(struct irq_work *work)
> +{
> +       schedule_work(&sysrq_enable_work);
> +}

Nit: weird that it's called "toggle" work but just wrapps "enable" work.



> +#endif
> +
> +int uart_nmi_state_init(struct uart_port *port)
> +{
> +       int ret;
> +
> +       ret = kfifo_alloc(&port->nmi_state.rx_fifo, 256, GFP_KERNEL);
> +       if (ret)
> +               return ret;
> +
> +       init_irq_work(&port->nmi_state.rx_work, uart_nmi_rx_work);
> +       init_irq_work(&port->nmi_state.tx_work, uart_nmi_tx_work);
> +       init_irq_work(&port->nmi_state.sysrq_sak_work, uart_nmi_sak_work);
> +#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
> +       init_irq_work(&port->nmi_state.sysrq_toggle_work, uart_nmi_toggle_work);
> +#endif
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(uart_nmi_state_init);
> +#endif
> +
>  EXPORT_SYMBOL(uart_write_wakeup);
>  EXPORT_SYMBOL(uart_register_driver);
>  EXPORT_SYMBOL(uart_unregister_driver);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 9fd550e..84487a9 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -18,6 +18,8 @@
>  #include <linux/tty.h>
>  #include <linux/mutex.h>
>  #include <linux/sysrq.h>
> +#include <linux/irq_work.h>
> +#include <linux/kfifo.h>
>  #include <uapi/linux/serial_core.h>
>
>  #ifdef CONFIG_SERIAL_CORE_CONSOLE
> @@ -103,6 +105,28 @@ struct uart_icount {
>  typedef unsigned int __bitwise upf_t;
>  typedef unsigned int __bitwise upstat_t;
>
> +#ifdef CONFIG_CONSOLE_POLL
> +struct uart_nmi_rx_data {
> +       unsigned int            status;
> +       unsigned int            overrun;
> +       unsigned int            ch;
> +       unsigned int            flag;
> +};
> +
> +struct uart_nmi_state {
> +       bool                    active;
> +
> +       struct irq_work         tx_work;
> +       void                    (*tx_irq_callback)(struct uart_port *port);
> +
> +       struct irq_work         rx_work;
> +       DECLARE_KFIFO_PTR(rx_fifo, struct uart_nmi_rx_data);
> +
> +       struct irq_work         sysrq_sak_work;
> +       struct irq_work         sysrq_toggle_work;
> +};
> +#endif
> +
>  struct uart_port {
>         spinlock_t              lock;                   /* port lock */
>         unsigned long           iobase;                 /* in/out[bwl] */
> @@ -255,6 +279,9 @@ struct uart_port {
>         struct gpio_desc        *rs485_term_gpio;       /* enable RS485 bus termination */
>         struct serial_iso7816   iso7816;
>         void                    *private_data;          /* generic platform data pointer */
> +#ifdef CONFIG_CONSOLE_POLL
> +       struct uart_nmi_state   nmi_state;
> +#endif
>  };
>
>  static inline int serial_port_in(struct uart_port *up, int offset)
> @@ -475,4 +502,44 @@ extern int uart_handle_break(struct uart_port *port);
>                                          !((cflag) & CLOCAL))
>
>  int uart_get_rs485_mode(struct uart_port *port);
> +
> +/*
> + * The following are helper functions for the NMI aware serial drivers.
> + * Currently NMI support is only enabled under polling mode.
> + */
> +
> +#ifdef CONFIG_CONSOLE_POLL
> +int uart_nmi_state_init(struct uart_port *port);
> +int uart_nmi_handle_char(struct uart_port *port, unsigned int status,
> +                        unsigned int overrun, unsigned int ch,
> +                        unsigned int flag);
> +
> +static inline bool uart_nmi_active(struct uart_port *port)
> +{
> +       return port->nmi_state.active;
> +}
> +
> +static inline void uart_set_nmi_active(struct uart_port *port, bool val)
> +{
> +       port->nmi_state.active = val;
> +}
> +#else
> +static inline int uart_nmi_handle_char(struct uart_port *port,
> +                                      unsigned int status,
> +                                      unsigned int overrun,
> +                                      unsigned int ch, unsigned int flag)
> +{
> +       return 0;
> +}
> +
> +static inline bool uart_nmi_active(struct uart_port *port)
> +{
> +       return false;
> +}
> +
> +static inline void uart_set_nmi_active(struct uart_port *port, bool val)
> +{
> +}
> +#endif
> +
>  #endif /* LINUX_SERIAL_CORE_H */
> --
> 2.7.4
>
