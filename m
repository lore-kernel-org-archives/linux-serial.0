Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73699C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 00:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5410961355
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 00:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhESBAc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 21:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhESBAc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 21:00:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E4C06175F;
        Tue, 18 May 2021 17:59:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f8so8986730qth.6;
        Tue, 18 May 2021 17:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iA2EHGmILYF3Ml1IoKcFl7klA1jJMkJx+SQifRlFeBM=;
        b=jDbIwZK9bujZuoCmwjiZCtN3t0mgYNHbMStF+mg90h2xWnCH6z6HnUfyNuKPPsVDnb
         e1z3o3bUHhZT9BzFRs00wSV5QLLltabKEGKqIvrGBsoYzbgN0MojPWltj0DrF1KvMoGb
         YPrwqlbkl4q3mD42AKzyPDQhvTkPYhPielBj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iA2EHGmILYF3Ml1IoKcFl7klA1jJMkJx+SQifRlFeBM=;
        b=OPEtno6ujpVjGjQ35CU0srEG8hf7qbq2sSoA22+YGLZpo4/VlShKC9A51X8mrivFuF
         h41mNFMUIXiIygv3wkiKm/0AfV6MvGKPYAfmL5cfhOksl/mzn3WVaahkkcoY2oOCWzg6
         c5slbijf4rTooi3r9mrtMrqurAcuwTdI6rIsw0iv1wp6ime/JmIt/NbSTViU1GzGOR1j
         i+b2GSDv+Z5CMVDkcykWdr8eUer1+waNznrTYYq4WLCzWnmeYkS08MjgF81/d8vPWAh6
         CoEAqxX+FJeVShIqi2zMePP4OlvDpInHmOGiFq5osmiukjHs2zw2Pv95DQMQm/Vwwq6a
         iXLA==
X-Gm-Message-State: AOAM530EIUN+Of1RmjBl+oqa6ZsqlNCF+dbJJAcBCn2+7FgE5l0qcCNT
        K/cHPnBaSBcpS01uz3idUAO2noalw+JfnUZAdmg=
X-Google-Smtp-Source: ABdhPJxhcLKtuV5HoYZdC5QIYyfaUlbDWsTyG4InHF+kLqOE28o2g0f3FPeB2WalZeVgyPWCQKM+2IW+QfQ8WjUgOLY=
X-Received: by 2002:ac8:5459:: with SMTP id d25mr8202628qtq.385.1621385951143;
 Tue, 18 May 2021 17:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210519000704.3661773-1-andrew@aj.id.au> <20210519000704.3661773-2-andrew@aj.id.au>
In-Reply-To: <20210519000704.3661773-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 19 May 2021 00:58:57 +0000
Message-ID: <CACPK8XdqeS+rE0Jz9SF+sSMUaxmg7vFtghhiZNbDpKRNbBZK=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add UART_BUG_TXRACE workaround for
 Aspeed VUART
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jenmin Yuan <jenmin_yuan@aspeedtech.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Milton Miller II <miltonm@us.ibm.com>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 19 May 2021 at 00:07, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
> LPC bus to the UART interface on the BMC's internal APB. As such there's
> no RS-232 signalling involved - the UART interfaces on each bus are
> directly connected as the producers and consumers of the one set of
> FIFOs.
>
> The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
> at 33MHz. The difference in clock speeds exposes a race in the VUART
> design where a Tx data burst on the APB interface can result in a byte
> lost on the LPC interface. The symptom is LSR[DR] remains clear on the
> LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
> remains clear on the APB interface as the host has not consumed the data
> the BMC has transmitted. In this state, the UART has stalled and no
> further data can be transmitted without manual intervention (e.g.
> resetting the FIFOs, resulting in loss of data).
>
> The recommended work-around is to insert a read cycle on the APB
> interface between writes to THR.
>
> Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/tty/serial/8250/8250.h              |  1 +
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
>  drivers/tty/serial/8250/8250_port.c         | 10 ++++++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..34aa2714f3c9 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -88,6 +88,7 @@ struct serial8250_config {
>  #define UART_BUG_NOMSR (1 << 2)        /* UART has buggy MSR status bits (Au1x00) */
>  #define UART_BUG_THRE  (1 << 3)        /* UART has buggy THRE reassertion */
>  #define UART_BUG_PARITY        (1 << 4)        /* UART mishandles parity if FIFO enabled */
> +#define UART_BUG_TXRACE        (1 << 5)        /* UART Tx fails to set remote DR */
>
>
>  #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index a28a394ba32a..4caab8714e2c 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>         port.port.status = UPSTAT_SYNC_FIFO;
>         port.port.dev = &pdev->dev;
>         port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> +       port.bugs |= UART_BUG_TXRACE;

A future enhancement would be to have this depend on the ast2600
compatible string, so we don't enable the feature for ast2400/ast2500.

That would also mean adding a compatible string for the ast2600.

Cheers,

Joel
