Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE9C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 18:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiFFS3Z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiFFS3Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 14:29:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A21AF6EB
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 11:29:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l18so9354048lje.13
        for <linux-serial@vger.kernel.org>; Mon, 06 Jun 2022 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rsv2N92+ZqJEH9bTxNPmExrepo9exn8lWuSrT2tKiOI=;
        b=CDRN5wvevDSX4L6VqzDHsCD/eYaYFxLIjrjvDqvfUY+zAZ8soBwmK9oZR2d906uKTM
         DeeQR42u/Z70lsKCub+iMsXnU0YBa9nSvQ8N3RIatmDxUX0k66bbt78vQrErqH824Vk2
         nTrB/ubSBF25YQ/ORyc1m07tu1dLOF3LVUokOXM3uYi5fbYULpQI0pBr53SHJ6Y9ECWm
         tiOKhcVGEqPtEho6uQFRF8gZr027NjFevnNZBQrUP6W4fu8tXmq9IPNstzR/CcxweYSf
         lYBFCLBLmyQx8WeETP7/wuI18EDZPM8K+62AOGQpOndlQj0/Y4wM5Ls/7BCOBDuj8/WL
         5GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rsv2N92+ZqJEH9bTxNPmExrepo9exn8lWuSrT2tKiOI=;
        b=B5bBD5RWwNX0MzpYUb/HqYfANVnmgC5XnkTv5Ek0VboatAKLA2KUYEKcg7nRImVANd
         XMpgLb8EFyb1OFs0mrsocfXay1XYd3DPZhHS9+fEL8JC0fJBnYUFs92gpkajSc52ZUZi
         +i0oleopqRsiUtMlVGkNAOPbAoyA0eCh3JA9HZ7makbyl4u6KvrAYY1pGJfqSZxWjcwV
         BSbtKdH45YDf0YG/t/8NPMNvYBB/3i+sWTTKdLgatVGcVthiCJ5sVqSpW+nAPYV1lE0Q
         DnIoFBiMSQYUXisJs24s2O4bchAb9aB8HZQ8rCHBz6jNWkzX0T8h1Kbl+SxJlqg1Fib7
         2AGA==
X-Gm-Message-State: AOAM530HSpuGWOY0ka9Nn6vbnW1GM7wLkJQsotJoX9fRTrFVe2Gi/vN7
        jj4dkM844MUrjceLAiZRjjJ7v154vvw+GcC0DB/qAsC9oJE=
X-Google-Smtp-Source: ABdhPJz9WBVfjcWsnEhD1m8xEt5J4gYwmCxK9iWJrGTUUViNn3ZQW/arYk5oezL4vGONjYr05Zn9cp/XNsth6qnJcTA=
X-Received: by 2002:a2e:a90a:0:b0:253:de3f:812b with SMTP id
 j10-20020a2ea90a000000b00253de3f812bmr48330959ljq.400.1654540159081; Mon, 06
 Jun 2022 11:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220529134605.12881-1-trix@redhat.com>
In-Reply-To: <20220529134605.12881-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Jun 2022 11:29:07 -0700
Message-ID: <CAKwvOdnvcP4m_+4gjhmjX+xmmU2um6_HGVqQa0euFCkwog6i1A@mail.gmail.com>
Subject: Re: [PATCH] serial: core: check if uart_get_info succeeds before using
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nathan@kernel.org, peter@hurleysoftware.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 29, 2022 at 6:46 AM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports this representative issue
> drivers/tty/serial/serial_core.c:2818:9: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
>         return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> uart_get_info() is used the *show() functions.  When uart_get_info() fails, what is reported
> is garbage.  So check if uart_get_info() succeeded.

Hi Tom,
Thanks for the patch. What do you think about throwing __must_check on
the definition of uart_get_info with a comment that members of the
retinfo param will not be initialized if the return value is not zero?

Otherwise, patch LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 4047b37122d1 ("serial: core: Prevent unsafe uart port access, part 1")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9a85b41caa0a..4160f6711c5d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2690,7 +2690,9 @@ static ssize_t uartclk_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.baud_base * 16);
>  }
>
> @@ -2700,7 +2702,9 @@ static ssize_t type_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.type);
>  }
>
> @@ -2710,7 +2714,9 @@ static ssize_t line_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.line);
>  }
>
> @@ -2721,7 +2727,9 @@ static ssize_t port_show(struct device *dev,
>         struct tty_port *port = dev_get_drvdata(dev);
>         unsigned long ioaddr;
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         ioaddr = tmp.port;
>         if (HIGH_BITS_OFFSET)
>                 ioaddr |= (unsigned long)tmp.port_high << HIGH_BITS_OFFSET;
> @@ -2734,7 +2742,9 @@ static ssize_t irq_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.irq);
>  }
>
> @@ -2744,7 +2754,9 @@ static ssize_t flags_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "0x%X\n", tmp.flags);
>  }
>
> @@ -2754,7 +2766,9 @@ static ssize_t xmit_fifo_size_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.xmit_fifo_size);
>  }
>
> @@ -2764,7 +2778,9 @@ static ssize_t close_delay_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.close_delay);
>  }
>
> @@ -2774,7 +2790,9 @@ static ssize_t closing_wait_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.closing_wait);
>  }
>
> @@ -2784,7 +2802,9 @@ static ssize_t custom_divisor_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.custom_divisor);
>  }
>
> @@ -2794,7 +2814,9 @@ static ssize_t io_type_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.io_type);
>  }
>
> @@ -2804,7 +2826,9 @@ static ssize_t iomem_base_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "0x%lX\n", (unsigned long)tmp.iomem_base);
>  }
>
> @@ -2814,7 +2838,9 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
>         struct serial_struct tmp;
>         struct tty_port *port = dev_get_drvdata(dev);
>
> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;
> +
>         return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
>  }
>
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
