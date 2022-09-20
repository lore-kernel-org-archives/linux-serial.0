Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7FC6FA82
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiITUh3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiITUh2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 16:37:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E870E47
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 13:37:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so3589618plv.5
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=V/X2NQANvTDmkPd1F0YWtdFn++b8aCyFunzORsYrONQ=;
        b=TCs7kqkPQVrLQkRrAFwXm+g+FHBRWFoV2esGT6hmslFrkA05qpUHyeFUnJDyZ8ulQr
         I4Amixm2yJcjeuv90ODZ6IhHDPAJzeuzYkzc7zYTE1QIa8e5V/hPHIDbS5i6nOokcfr9
         cqTJAihIHVduLLHltI6VpNfxj96TgvybwBWvZKOaOI2jrMZv/U4vfBhHbr9MJYzXU839
         AqHOKNc90ry76qNuFowv999TixYYFmsATpgrYh2jV9fnUMdfFMOFi9KIVFjtEUqSJu6V
         MHzBlJB1f8iy1JgS2kMS7JK8WNIjtV1p+dvq1Z9q5xm1OfbrSw73pE/m1TpFIxsclOpR
         oh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V/X2NQANvTDmkPd1F0YWtdFn++b8aCyFunzORsYrONQ=;
        b=o5hL3dGHFY8KjJ2J2V2VYrDOv6Sm+TJlmJb6Zl3wNPE2mf9JmPS6Ajs+hLbfmhtA9B
         6lft8ESOsk6tMqiN1xuQ8zQWZHzbKh/J8ez/bHfbvgRvBx3R6o85NpL60R3jsepSlflm
         cLzVPBnctHzWJu+ETil4BiM4yfjvhsdnSvM9qOPQq7g6sGk6Cm1r6iGfUq3eiHu8bJHB
         XKNxgyPr+PH0vd32lQcBw/XF3xJyKTu/S8eZ6QdDnJz0PhCWzObZHm5ulv+aq4KU4QqT
         DsaJX91pP4851f5Gniy+xDJpyb/kfd64nZDxlOwBof0ndk5kOimDD+4rJUhX+BBclAoh
         GlMg==
X-Gm-Message-State: ACrzQf28DrT8PgvFw0SlpNxiwW3toY7kpiPrxnVyzljIy813mC8gKbCc
        ecl8izWLGhsYJQHgw0mastdp+Q==
X-Google-Smtp-Source: AMsMyM5sO4QMKnmIY21SZBsYUOz5HOAORsSvtVv/tBwcJEPQCvY+0Ll0j6T6ybkTXVyiPd865ztNaA==
X-Received: by 2002:a17:90a:4f4f:b0:202:7ab1:46ec with SMTP id w15-20020a17090a4f4f00b002027ab146ecmr5857272pjl.32.1663706247087;
        Tue, 20 Sep 2022 13:37:27 -0700 (PDT)
Received: from localhost (p57a238e9.dip0.t-ipconnect.de. [87.162.56.233])
        by smtp.gmail.com with ESMTPSA id x68-20020a623147000000b0053b850b17c8sm319621pfx.152.2022.09.20.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:37:26 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:37:26 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Sep 2022 13:37:20 PDT (-0700)
Subject:     Re: [PATCH v2] serial: sifive: enable clocks for UART when probed
In-Reply-To: <20220920160017.7315-1-olof@lixom.net>
CC:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Olof Johansson <olof@lixom.net>
Message-ID: <mhng-48b61fc8-ae88-4ebe-8d91-b49f13c5ba0f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 20 Sep 2022 09:00:18 PDT (-0700), Olof Johansson wrote:
> When the PWM driver was changed to disable clocks if no PWMs are enabled,
> it ended up also disabling the shared parent with the UART, since the
> UART doesn't do any clock enablement on its own.
>
> To avoid these surprises, switch to clk_get_enabled().
>
> Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly once per running PWM")
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> ---
>
> v2: Switch to devm_clk_enabled() per Uwe's suggestion.
>
> ---
>  drivers/tty/serial/sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 5c3a07546a58..4b1d4fe8458e 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -945,7 +945,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	}
>
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "unable to find controller clock\n");
>  		return PTR_ERR(clk);

I have one of these lying around somewhere if you need someone to test 
it, but sounds like you had from the v1 email.  Either way

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

as this seems better than what was there.

Thanks!
