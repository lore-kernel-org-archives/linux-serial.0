Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27D5C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 28 Nov 2022 11:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiK1LDi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiK1LDi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Nov 2022 06:03:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394D1900D
        for <linux-serial@vger.kernel.org>; Mon, 28 Nov 2022 03:03:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j196so12816508ybj.2
        for <linux-serial@vger.kernel.org>; Mon, 28 Nov 2022 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5DiE42j4ubNltbzQXZx/+NLMNVDEzOQxUmz6VQnWto=;
        b=D5NNHT4MhK4wc86HfMm5GxaECZHfNSKuBKcMMet2X9Y+fRHZ+R1W2GHvU0KYVO3b2W
         DTsj2yRiaJql2ktYDWE/E2pthWdMlABuBlRpsZAyxZ87K28c90+MjABfCW6hAGelY1ar
         UGpdT4Uh+Sz2fC9QdhsVwSb9dIVwderMPUUVUfwNnNAC69+jdjllEM39SQacyqG81Gg0
         0Dh6qiwrPoDKKYEXQTLml2sOTRMimetlQfwO5JftnL0F4kp5ae3NE8aZZCAEvNO7VrcO
         B+ncMWHyvz1pyAQR/Q0lrxbSnEYACaqft2J1r66Mikwfmd7dqUWRMInYv9Tbw7SDd0H5
         1lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5DiE42j4ubNltbzQXZx/+NLMNVDEzOQxUmz6VQnWto=;
        b=ZiaHPxUGCsd3+KTHmut3nyFndImAOh4jGDw8yrh0OoXCk4EFlNtiitF24N/AwpTWIO
         6Fz63P7ND5yNENp78wRalBcBm47lLK9y4450AqgMyZhrhW4VbaGGRM3Crv6Hf4g9s6OO
         zQOq6fU876PnUliWFCUfkCh7ObxdKe4OEWfvezSKfE5V4M618wHXryLD9bDzSTOTZGqf
         ks3xNARKEtRH2aJ/0VJCnmx5yn4YWqW8RI99rGB7abcEjxH511OSuc8E9Govxb0GKoJC
         f/4ig5bW3mQ6tmMlb4pivrHHxWN0AXAU0oVTZgf2ozO0DoeVSL4ApLGIHX88YvoRC0th
         Sbwg==
X-Gm-Message-State: ANoB5pkfWEUcRsrkTUD+BDz7UVFKgwj9/UEB5C7O6YDvco9coUAOp2Nl
        GG+zwLmbFzw+NU/Bg9eirwbzt5ho1d6j5agUj1C66w==
X-Google-Smtp-Source: AA0mqf694kce0vLz91QS01OVFP9K/SDuWK+OmZ9OuEbaXo5uULcHI9tfdh5WllBxb0ilG+y6HbtFNHjijrPWL/Kbbio=
X-Received: by 2002:a05:6902:534:b0:6d5:4f72:e6c1 with SMTP id
 y20-20020a056902053400b006d54f72e6c1mr30176111ybs.122.1669633415572; Mon, 28
 Nov 2022 03:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20221123110759.1836666-1-brgl@bgdev.pl> <20221123110759.1836666-14-brgl@bgdev.pl>
 <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
In-Reply-To: <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 28 Nov 2022 12:03:24 +0100
Message-ID: <CACMJSet4WZj3qNCDGUkcg6NPS0aO10L5jq=rETvLFTg78iULtA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] tty: serial: qcom-geni-serial: add support for
 serial engine DMA
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 25 Nov 2022 at 15:37, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>

<snip>

> >
> > @@ -552,18 +558,11 @@ static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> >
> >   static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
> >   {
> > -     struct tty_port *tport;
> >       struct qcom_geni_serial_port *port = to_dev_port(uport);
> > -     u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
> > -     u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
> > +     struct tty_port *tport = &uport->state->port;
> >       int ret;
> >
> > -     tport = &uport->state->port;
> > -     ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
> > -     if (drop)
> > -             return;
> > -
>
> Are we removing FIFO support for uart?
>
> It it not a overhead to use dma for small transfers that are less than
> fifo size?
>

You made me think about it but no - while I haven't measured it yet, I
don't think it's worth the code complexity behind it. The i2c driver
doesn't do it this way for short transfers either. If you insist I can
test it and come forward with numbers but unless we encounter a
real-life example of the need for lots of very short reads/writes in
short succession, I don't think we should overcomplicate this.

>
> > -     ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
> > +     ret = tty_insert_flip_string(tport, port->rx_buf, bytes);
> >       if (ret != bytes) {
> >               dev_err(uport->dev, "%s:Unable to push data ret %d_bytes %d\n",
> >                               __func__, ret, bytes);
> > @@ -578,7 +577,70 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
> >       return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
> >   }
> >
> > -static void qcom_geni_serial_start_tx(struct uart_port *uport)
> > +static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port = to_dev_port(uport);
> > +     bool done;
>
> -->
> > +     u32 status;
> ...
> > +
> > +     status = readl(uport->membase + SE_GENI_STATUS);
> > +     if (!(status & M_GENI_CMD_ACTIVE))
> > +             return;
> <---
>
> this code snippet is repeating more than few times in the patches, looks
> like it could be made to a inline helper.
>

Makes sense.

>
> > +
> > +     if (port->rx_dma_addr) {
> > +             geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
> > +                                   port->tx_remaining);
> > +             port->tx_dma_addr = (dma_addr_t)NULL;
> > +             port->tx_remaining = 0;
> > +     }
> > +
> > +     m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> > +     writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> > +     geni_se_cancel_m_cmd(&port->se);
> > +
> > +     done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
> > +                                      S_CMD_CANCEL_EN, true);
> > +     if (!done) {
> > +             geni_se_abort_m_cmd(&port->se);
> > +             qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                       M_CMD_ABORT_EN, true);
>
> return is not checked, there are few more such instances in the patch.
>

Yes, but this is an error path. What would I do if the cancel failed
to go through and then the abort failed as well? I can at best emit an
error message.

> > +             writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> > +     }
> > +
> > +     writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> > +}
> > +
> > +static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port = to_dev_port(uport);
> > +     struct circ_buf *xmit = &uport->state->xmit;
> > +     unsigned int xmit_size;
> > +     int ret;
> > +
> > +     if (port->tx_dma_addr)
> > +             return;
> Is this condition actually possible?
>

It should never happen but I wanted to be sure. Maybe a BUG_ON() or
WARN_ON() would be better?

>
> > +
> > +     xmit_size = uart_circ_chars_pending(xmit);
> > +     if (xmit_size < WAKEUP_CHARS)
> > +             uart_write_wakeup(uport);
> > +
> > +     xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> > +
> > +     qcom_geni_serial_setup_tx(uport, xmit_size);
> > +
> > +     ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
> > +                               xmit_size, &port->tx_dma_addr);
> > +     if (ret) {
> > +             dev_err(uport->dev, "unable to start TX SE DMA: %d\n", ret);
> > +             qcom_geni_serial_stop_tx_dma(uport);
> > +             return;
> > +     }
> > +
> > +     port->tx_remaining = xmit_size;
> > +}
> > +
>
> ...

Bart
