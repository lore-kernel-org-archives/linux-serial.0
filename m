Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B6C33CB1
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 07:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B0207FF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 07:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQtIs1Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgANHwg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:52:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41146 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANHwg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 02:52:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so11020118eds.8
        for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2020 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNSE1PFZJJft7ctjmJInclxLjnHHAsUSvvb0hQe0jR0=;
        b=sQtIs1WplcQOL39mv+L+1v2hnkUQMZ3wNksQFdduZbipL9LqhjR85m6xqZgMQoXCPI
         jTfLIQToOtNQnjFp+ru9SfyXcHq0PwHUOh8Vuz+8FCt1fMfBZdidn0sqoidli6b4dF0l
         F2mE2LBxe7++WTsu5GLzTWtKsrn9RGsjawY36lTPMuewuFoVmjsZZUm8Zijv3i3dZAIy
         7Q9qx7l/MN9Q1cwdyhfiGafI9BjVyiQlQs2zsc+YX+p1A+MsXXQ+lX+x6kv2OX9mkDLR
         gC9vjuueregFSOZz0pw8f0pvvBQvIAfjK5dokQnhAwgPZH4HJFFviNW8vVz8eRSX5G2u
         H6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNSE1PFZJJft7ctjmJInclxLjnHHAsUSvvb0hQe0jR0=;
        b=WOR+EA/cx4b7TU91NK47HjyTQ2VVv60veM4k+aTNwwU9RMMeWqKNZ6eOjBO63w2N05
         +NdUQwBZebIaP6PGgBs69SPlPsH6xCPVMnBwJ019og7yuqiLoYzlgrkXzIfev/HsAXrS
         /IR1FcbRexHj2Bi4LzjrIhEcP+ACRMc7/eIu6qv4jmzwlYFl1Vx1MqVyCEkcBegmOOzc
         kIUIk552VRhGdBc6P+dxe8HU8V5RXlDv7nId5ClsMYHAEqx8/5ECkbhIUvH2wXggChdJ
         aiQmabIubFDEQ5yJLr5abvoxbaTHxmF3xN+glgzEbwFkwr+ORpuyBgQGe00WPfBInPpA
         L3dg==
X-Gm-Message-State: APjAAAXVmcqu4uvBF0UAU9chArxr7fyNBXEBqJ+dTsNDOYnxd44OjiAR
        7VzJmwhtoaRtH8m45wgo0qo74HnqGc7vkn0BRhNzpQ==
X-Google-Smtp-Source: APXvYqymAZSlgEpVYFsdOdZckb4ehuHrVvBiGJjeVudApzthPcsPTNqp0UxnHqFBSQu22E44BtnMpES52qUmo3wJhNI=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr21785295edb.146.1578988354858;
 Mon, 13 Jan 2020 23:52:34 -0800 (PST)
MIME-Version: 1.0
References: <1578646684-17379-1-git-send-email-loic.poulain@linaro.org> <CAOCk7NrSkaY5xUdA+Q3tCoDv01fVDYpakWmk-RnOuuBKsNN8Jg@mail.gmail.com>
In-Reply-To: <CAOCk7NrSkaY5xUdA+Q3tCoDv01fVDYpakWmk-RnOuuBKsNN8Jg@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 14 Jan 2020 08:55:02 +0100
Message-ID: <CAMZdPi8ih2LukVsGvG_w2HOSZL9DSbYDmD_U=PTnk96vbE=u8g@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: msm_serial: RX SW/FIFO mode fallback
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 13 Jan 2020 at 20:53, Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> On Fri, Jan 10, 2020 at 1:55 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > During db410c stress test and when the system is low on memory,
> > the UART/console becomes unresponsive and never recover back.
> > This has been narrowed down to the msm_start_rx_dma which does
> > not manage error cases correctly (e.g. dma mapping failure),
> > indeed, when an error happens, dma transfer is simply discarded
> > and so never completed, leading to unconfigured RX path.
> >
> > This patch fixes this issue by switching to SW/FIFO mode in case
> > of DMA issue. This mainly consists in resetting the receiver to
> > apply RX BAM/DMA disabling change and re-enabling the RX level
> > and stale interrupts (previously disabled for DMA transfers).
> >
> > The DMA will be re-enabled once memory is available since the
> > SW/FIFO read function (msm_handle_rx_dm) retries to start dma
> > on completion.
>
> Is there a risk of the same thing occurring in the TX path?

Yes, but the TX case is already handled. If msm_handle_tx_dma fails,
msm_handle_tx_pio is used to directly write the FIFO.

>
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> >  drivers/tty/serial/msm_serial.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> > index 1cbae07..a63b703 100644
> > --- a/drivers/tty/serial/msm_serial.c
> > +++ b/drivers/tty/serial/msm_serial.c
> > @@ -610,7 +610,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
> >                                    UARTDM_RX_SIZE, dma->dir);
> >         ret = dma_mapping_error(uart->dev, dma->phys);
> >         if (ret)
> > -               return;
> > +               goto sw_mode;
> >
> >         dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
> >                                                 UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
> > @@ -661,6 +661,22 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
> >         return;
> >  unmap:
> >         dma_unmap_single(uart->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
> > +
> > +sw_mode:
> > +       /*
> > +        * Switch from DMA to SW/FIFO mode. After clearing Rx BAM (UARTDM_DMEN),
>
> Where does this clear of UARTDM_DMEN occur?

The DMEN clear occurs on DMA RX completion (msm_complete_tx_dma()) and
set on DMA
restart (msm_start_rx_dma). In our case, since DMA start fails, we
just reset the RX path to
effectively apply the SW/FIFO mode.

>
> > +        * receiver must be reset.
> > +        */
> > +       msm_write(uart, UART_CR_CMD_RESET_RX, UART_CR);
> > +       msm_write(uart, UART_CR_RX_ENABLE, UART_CR);
> > +
> > +       msm_write(uart, UART_CR_CMD_RESET_STALE_INT, UART_CR);
> > +       msm_write(uart, 0xFFFFFF, UARTDM_DMRX);
> > +       msm_write(uart, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
> > +
> > +       /* Re-enable RX interrupts */
> > +       msm_port->imr |= (UART_IMR_RXLEV | UART_IMR_RXSTALE);
> > +       msm_write(uart, msm_port->imr, UART_IMR);
> >  }
> >
> >  static void msm_stop_rx(struct uart_port *port)
> > --
> > 2.7.4
> >

Regards,
Loic
