Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EDBC4727F
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16903206E5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2c/K5nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgI1URP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgI1URP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 16:17:15 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FCC0613CE
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 13:17:14 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id h15so2644194uab.3
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ac5Zwjpr9AVZ3pSe9QkEO8EPUo8M1+nPVhneyJIUqAY=;
        b=Y2c/K5nnzDh4DbGtuNoYr0jfKdm1Uz0zud9DFXef5BKN0+Diio5gLKL7SPt1yvIYMN
         foB/5kWx9nsm5FhESFZj7pBVElk0RVu5g5SnFGTvnYXUB0C7ECVHnkEHVdxE9YPRr8pf
         3nB78wVzrQr9ikiMJLgJ7MibqaDa/0CfYjnKMwK7oYZYje96/cQ7oPt29le/L6hPlYjM
         8fcNFVR/03B/I5Cfxk/rO802OztXOo8rGW7VSYNOUsw1wFGH8R8h5WO1s5v/5fEuDwtC
         0g07k4zsR6CtpRHzHM+MoyuyoW+zwdTwImtkAphHlfSRZ+f5iyhLlHnYyc283Fgil0z3
         ianA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac5Zwjpr9AVZ3pSe9QkEO8EPUo8M1+nPVhneyJIUqAY=;
        b=WMTDL51X9XOR2fyuwRNdjI/4upJU3rKu9lxvrSSsKB6JzcUje5hx5xY9CfU6GXLPfs
         ONGCKD/uwJAd6btM+ghOINodXh018JFRD/Z+nPbcLNsgbCN6DdBOGgNYMGKrpgcSVY2W
         L/Ph+xhH1gdz1eHU60BO87wusvC4iELbgC4hXIffgR0bg0bucrOWeWCoEGz/0VbH6aJD
         w2iUyJQnsPHT98X5uM3WMU7AbIVzGxA1hbaVKykFSgC6NOEOuXmG13cNdc4Ldv0QJJt2
         4xYJR2PCNo9k/dLaYGG0itIuvHgHHwE22qHR8FY2eWp7/zgQEpjk1Mgl/nkD4g6t9I04
         iwgw==
X-Gm-Message-State: AOAM531PeGBf2imhzN+Nk8zNd+YvIwRY6Wq3zai4pPK17B/gk7yxof00
        BNX323/Xa75ZCZ2gbrvY+pU8Gky73iPXkOCwbD4epg==
X-Google-Smtp-Source: ABdhPJzh3dTo9bSOoZb9Ltse/GAJmwvQOfeeE5WIGyrBY1gm09Sbs9aqNce9ZQU/RHtkreHhQ0Mf7DK8/2n7uFsu/mY=
X-Received: by 2002:ab0:2c1a:: with SMTP id l26mr2148024uar.6.1601324233960;
 Mon, 28 Sep 2020 13:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200918021643.2067895-1-sashal@kernel.org> <20200918021643.2067895-42-sashal@kernel.org>
In-Reply-To: <20200918021643.2067895-42-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Sep 2020 01:46:59 +0530
Message-ID: <CA+G9fYsi87yT-bEdpQ+7ca5gH_QcWHmticMSxKuCSt+SLrWj-A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.4 42/64] serial: uartps: Wait for tx_empty in
 console setup
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 18 Sep 2020 at 07:51, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
>
> [ Upstream commit 42e11948ddf68b9f799cad8c0ddeab0a39da33e8 ]
>
> On some platforms, the log is corrupted while console is being
> registered. It is observed that when set_termios is called, there
> are still some bytes in the FIFO to be transmitted.
>
> So, wait for tx_empty inside cdns_uart_console_setup before calling
> set_termios.
>
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Link: https://lore.kernel.org/r/1586413563-29125-2-git-send-email-ravitej=
a.narayanam@xilinx.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

stable rc branch 4.4 arm64 build broken.

../drivers/tty/serial/xilinx_uartps.c: In function =E2=80=98cdns_uart_conso=
le_setup=E2=80=99:
../drivers/tty/serial/xilinx_uartps.c:1170:40: error: =E2=80=98TX_TIMEOUT=
=E2=80=99
undeclared (first use in this function)
 1170 |  time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
                                                                      ^~~~~=
~~~~~
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
>  drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xili=
nx_uartps.c
> index 06efcef1b4953..5b4469098888a 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1152,6 +1152,7 @@ static int cdns_uart_console_setup(struct console *=
co, char *options)
>         int bits =3D 8;
>         int parity =3D 'n';
>         int flow =3D 'n';
> +       unsigned long time_out;
>
>         if (co->index < 0 || co->index >=3D CDNS_UART_NR_PORTS)
>                 return -EINVAL;
> @@ -1165,6 +1166,13 @@ static int cdns_uart_console_setup(struct console =
*co, char *options)
>         if (options)
>                 uart_parse_options(options, &baud, &parity, &bits, &flow)=
;
>
> +       /* Wait for tx_empty before setting up the console */
> +       time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +
> +       while (time_before(jiffies, time_out) &&
> +              cdns_uart_tx_empty(port) !=3D TIOCSER_TEMT)
> +               cpu_relax();
> +
>         return uart_set_options(port, co, baud, parity, bits, flow);
>  }
>
> --
> 2.25.1
>

--=20
Linaro LKFT
https://lkft.linaro.org
