Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA9DC6FD1B
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 18:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjCGSyd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCGSyH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 13:54:07 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2785C223B
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 10:42:03 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x10so8913726ill.12
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678214519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIBoIM/MahzmKHcLNphJUdBT59zK6GNgrma5w7fsSlM=;
        b=RSDaAUvJWdX/pgYCQD9V62BikNMQtSk4X+T8iCz13FrSmzG8etaoNw+evqN5EpGvwq
         A3kS3pRnZHrG0Y5rgBHrGQqy9s7dpWwDTXU3PJjJkoZrMlhYEeLVn1ZCJxuBMW0Ct4Uu
         3ojVYRwF9Q5Lf4yMbgwCqvKRi+0J2C4+iPcIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIBoIM/MahzmKHcLNphJUdBT59zK6GNgrma5w7fsSlM=;
        b=AbyfTaE/FqFhCyhxw+TeXzfxXW/EdhMGNdHRHvmlHxZ0e3Wyds1JGPdaNQBeP6s2vv
         eelHYJj1+X6BVwziImb1fD7Z1y+PW3q8vg6ZFiH06iXkGyYZ0jegGGKIwFX2mUtJGBiZ
         I/Jz7657RAvvzpdbH8g1PNbxJQxFlWeTB+3mv3xSp8/UYRgZEVAZFq7C2jDuMwttZt0E
         c5LK+eaDyjCKrvVYllyesPYO4w8L02eiiZP2TBfQYsaVj5LPdJq4dG3zxGG9fbpyKKQe
         FncFTPBxtvrkHpyvm8kBpi2rQ+yD0mL8UAa220Xg4DowWrP7TlLDEzz7JsfnRBXWar/G
         l3Kw==
X-Gm-Message-State: AO0yUKXm+VUoJe5xdC9H30bfWPpfrfqR1F3BDRxAh3ZItCmddFkDzWaf
        g+OKPKYGCWts0ouO8RLpv77L0WENhQCML5/nKbI=
X-Google-Smtp-Source: AK7set+Saei/mN1QAa8NHW0N2L6Ak+MzWb6DDRcsKe8sax0RrePCEFvlCTncntA9bwKY9Dx1Le2Myg==
X-Received: by 2002:a05:6e02:8ae:b0:31f:9b6e:2f49 with SMTP id a14-20020a056e0208ae00b0031f9b6e2f49mr5926626ilt.10.1678214519240;
        Tue, 07 Mar 2023 10:41:59 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id t16-20020a02ab90000000b00375783003fcsm4131848jan.136.2023.03.07.10.41.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 10:41:58 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id i19so413126ila.10
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 10:41:58 -0800 (PST)
X-Received: by 2002:a05:6e02:928:b0:317:fc57:d2f7 with SMTP id
 o8-20020a056e02092800b00317fc57d2f7mr7437142ilt.6.1678214517983; Tue, 07 Mar
 2023 10:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <20230307164405.14218-4-johan+linaro@kernel.org>
In-Reply-To: <20230307164405.14218-4-johan+linaro@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 10:41:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
Message-ID: <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: qcom-geni: fix mapping of empty DMA buffer
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 8:43=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Make sure that there is data in the ring buffer before trying to set up
> a zero-length DMA transfer.
>
> This specifically fixes the following warning when unmapping the empty
> buffer on the sc8280xp-crd:
>
>    WARNING: CPU: 0 PID: 138 at drivers/iommu/dma-iommu.c:1046 iommu_dma_u=
nmap_page+0xbc/0xd8
>    ...
>    Call trace:
>     iommu_dma_unmap_page+0xbc/0xd8
>     dma_unmap_page_attrs+0x30/0x1c8
>     geni_se_tx_dma_unprep+0x28/0x38
>     qcom_geni_serial_isr+0x358/0x75c
>
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 2aa3872e6283..9871225b2f9b 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -631,6 +631,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart=
_port *uport)
>         if (port->tx_dma_addr)
>                 return;
>
> +       if (uart_circ_empty(xmit))
> +               return;

I guess you could remove the uart_circ_empty() test in
qcom_geni_serial_handle_tx_dma() now? In any case, with or without
that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
