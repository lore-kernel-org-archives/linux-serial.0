Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9517C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4F220771
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 07:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNdWSaFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHLHmD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHLHmC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 03:42:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD0C061787
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 00:42:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so693953pjb.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=5TtyJc5f+z90IMWpY4SLjVhTX8xv82FaqtlU9ijwJsU=;
        b=oNdWSaFHCLhqlFxLDcPMNRz7V6vdp40bk1vwxL3DK0HT819d/1HmzftJmzN4plgS+J
         ldfmIbC0Vl5h5BfPXF6zcAHNNtCwWnixJ8J4eDQhQyp4KFfaYDwEOd7M8KdeQKiT/6nH
         Dmy0KZt1/EgjsPx5kS3UK94wSEuUV3Ur8nPVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=5TtyJc5f+z90IMWpY4SLjVhTX8xv82FaqtlU9ijwJsU=;
        b=VnOnZfKhXv/TF2RCDB+K6aJPuJBemK6UkDBe5jutvncJvTZPzWO6sh39JOcowUiIJu
         z/yszmZR84HFe41WoQEP/LHw7f3nwNjaOGl3Hp+FG7yo/ElDKTK0BN5pOSRXHFvjePkW
         fciewd2UkMWWBQNYdWGnYNBGlm9CfQfMdIBWNaRwBRIZXJq8MmZYRGBSLSE0EBvvCkr5
         DVfLx+UAXNJjT6kFXStflDB72ZldYaB7gQRIwjnZ+OXbtExHMq6n0ZW2SnjTC3cYTPnn
         af/FUcluBk0VelicmnU1XnWyXR9UCQWtnWZILbKibOLmk/Lp7PgX1v3432iHgzF+icYc
         qcfA==
X-Gm-Message-State: AOAM533mZ4FMpQeUjV1nrdfHMTyZiLy3vpC91SggQmTeRi2FB/FL3MR1
        ky4DDumwktIwK7GewLOjIVlF9w==
X-Google-Smtp-Source: ABdhPJzN64xwwe+sitVOfTG/lg/D2FU1b3vkA7UXprF3CM4A6bpsaKkduGP7B4HwqstaEjcxRH81SQ==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr4674206pjb.151.1597218122210;
        Wed, 12 Aug 2020 00:42:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e9sm1421282pfh.151.2020.08.12.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:42:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1597211328-23500-1-git-send-email-skakit@codeaurora.org>
References: <1597211328-23500-1-git-send-email-skakit@codeaurora.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Remove the UART frequency table
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        satya priya <skakit@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        satya priya <skakit@codeaurora.org>
Date:   Wed, 12 Aug 2020 00:42:00 -0700
Message-ID: <159721812037.1360974.11604578290766022830@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting satya priya (2020-08-11 22:48:48)
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3aa29d2..312daa24 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -941,30 +935,22 @@ static int qcom_geni_serial_startup(struct uart_por=
t *uport)
>         return 0;
>  }
> =20
> -static unsigned long get_clk_cfg(unsigned long clk_freq)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(root_freq); i++) {
> -               if (!(root_freq[i] % clk_freq))
> -                       return root_freq[i];
> -       }
> -       return 0;
> -}
> -
> -static unsigned long get_clk_div_rate(unsigned int baud,
> -                       unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long get_clk_div_rate(const struct geni_se *se,
> +                       unsigned int baud, unsigned int sampling_rate,
> +                       unsigned int *clk_div)
>  {
>         unsigned long ser_clk;
>         unsigned long desired_clk;
> +       long actual_clk;
> =20
>         desired_clk =3D baud * sampling_rate;
> -       ser_clk =3D get_clk_cfg(desired_clk);
> -       if (!ser_clk) {
> +       actual_clk =3D clk_round_rate(se->clk, desired_clk);
> +       if (actual_clk % desired_clk !=3D 0) {

The logic isn't the same. Is that a concern? Before we would loop
through all the frequencies this driver knew about and try to find a
frequency that evenly divides by the 'desired_clk'. With this patch
we'll do that calculation exactly once, and ask the clk driver what rate
can be achieved if we call clk_set_rate() with 'desired_clk' as the
argument.

Maybe we need to loop and call clk_round_rate() with 'desired_clk <<=3D 1'
until it overflows or reaches some limit?

>                 pr_err("%s: Can't find matching DFS entry for baud %d\n",
>                                                                 __func__,=
 baud);
> -               return ser_clk;
> +               return 0;
>         }
> +       ser_clk =3D actual_clk;
> =20
>         *clk_div =3D ser_clk / desired_clk;
>         return ser_clk;
