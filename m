Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB8C43214
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940AE60FE7
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhG3PW5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:22:57 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47268
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239674AbhG3PWz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 11:22:55 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 9A1513F243
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627658569;
        bh=ZB8kRJjvGWoqH+/4j72g+qbwLJfHVt3xG+HcUqPQc2Y=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hsSJUIQWF+A54wirnqBUwl9XJEi3X2Y4Lu8vHQOR73gbMhpTzIIBXNkR+RBcW2OPW
         YAxzffQyaRvwfvb0PlaJNx/+rCRQum4GDJaljsxNSQsFM7UYRcbzeJk0vtyzTmEMLY
         ojxlWPlARYQA/HS964ZAstMrKXoLjVVx+eYdAGeA7TqTKQ+Jw3D45wiC12WuUtOVf0
         MGpg/z00VCJ1SXsH999lmI6+yG8vsHIVKcGQzhfavPws8wnVRgBp510N8nfwwcE7SO
         Xtl0yM9B0q6xUe2wlcHoe4lf14zDEQC1Kwct6r17bjDTEX/x5ZtEmosw/U1ESfsOVm
         2hZ+8LTWnO1YA==
Received: by mail-ed1-f71.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so4776567edt.9
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 08:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZB8kRJjvGWoqH+/4j72g+qbwLJfHVt3xG+HcUqPQc2Y=;
        b=nXJArBTYeH6jaFOl6Aw2lvN5dqRNy3mdNR59kVztHo5cmphhQwoRHKlrWK+yWDp1Ry
         Gl8zmW+VX6Nm50zfZqQ9dU4skwsWWhUzqG12HQ6Yt8wbwkqfr/qg+NSAC3bFv7faPAva
         be2cN2pw9tTbykfpwT8FAXuuDlCWw4acYEVbBRbh5/dCff45/iRQH2d+zmdEhp2sxtTG
         Uc3wXfUTmt7PWKWXaCGomUkLCH8u57egMGMM6gQNmWBmfrq5fuZzur1+w/yjcMJBeIpD
         zNepZqpQwWEoq/inLuYH2LbDoozCJBzQwjXRq1zoxPAunYKntlzrzgmbhcuxFJk4hO2Q
         AZNA==
X-Gm-Message-State: AOAM531PkYNugdV3TaYTkrUTWeZFLAIj8j9zfQJlf2dld1hF8EpruKth
        QxaXtG5SxutaykCcsyJX7dRceViwVvyialCJuLKyC+X/TjoRflq7ngdJ3ICyFaFQdUYSa1hTfjd
        ZEz7n3/xkUPeLirFSJeCVuvlA9IEPcy/SiqNDY8OSkg==
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr3086295ejb.190.1627658568547;
        Fri, 30 Jul 2021 08:22:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJmE2LbHYPFXopTp4l0M6WlVDaj/oAMIqaQivR3KofKuI0KNALJNNHvO7iO6MY00bQnFdV9w==
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr3086285ejb.190.1627658568399;
        Fri, 30 Jul 2021 08:22:48 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id k21sm816287edo.41.2021.07.30.08.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:22:47 -0700 (PDT)
Subject: Re: [PATCH 02/12] pinctrl: samsung: Add Exynos850 SoC specific data
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a2b6b868-e984-440c-75b1-599680537cc9@canonical.com>
Date:   Fri, 30 Jul 2021 17:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Add Samsung Exynos850 SoC specific data to enable pinctrl support for
> all platforms based on Exynos850.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 129 ++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-exynos.h      |  29 ++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
>  4 files changed, 161 insertions(+)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> index b6e56422a700..9c71ff84ba7e 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> @@ -40,6 +40,24 @@ static const struct samsung_pin_bank_type exynos5433_bank_type_alive = {
>  	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
>  };
>  
> +/*
> + * Bank type for non-alive type. Bit fields:
> + * CON: 4, DAT: 1, PUD: 4, DRV: 4, CONPDN: 2, PUDPDN: 4
> + */
> +static struct samsung_pin_bank_type exynos850_bank_type_off  = {
> +	.fld_width = { 4, 1, 4, 4, 2, 4, },
> +	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
> +};
> +
> +/*
> + * Bank type for alive type. Bit fields:
> + * CON: 4, DAT: 1, PUD: 4, DRV: 4
> + */
> +static struct samsung_pin_bank_type exynos850_bank_type_alive = {
> +	.fld_width = { 4, 1, 4, 4, },
> +	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
> +};
> +
>  /* Pad retention control code for accessing PMU regmap */
>  static atomic_t exynos_shared_retention_refcnt;
>  
> @@ -422,3 +440,114 @@ const struct samsung_pinctrl_of_match_data exynos7_of_data __initconst = {
>  	.ctrl		= exynos7_pin_ctrl,
>  	.num_ctrl	= ARRAY_SIZE(exynos7_pin_ctrl),
>  };
> +
> +/* pin banks of exynos850 pin-controller 0 (ALIVE) */
> +static struct samsung_pin_bank_data exynos850_pin_banks0[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),

Why EXYNOS9 not EXYNOS850? Is it really shared with 96xx, 98xx and 9x0
series?

> +	EXYNOS9_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
> +	EXYNOS9_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
> +	EXYNOS9_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
> +	EXYNOS9_PIN_BANK_EINTW(4, 0x080, "gpa4", 0x10),
> +	EXYNOS9_PIN_BANK_EINTN(3, 0x0A0, "gpq0"),
> +};
> +
> +/* pin banks of exynos850 pin-controller 1 (CMGP) */
> +static struct samsung_pin_bank_data exynos850_pin_banks1[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x000, "gpm0", 0x00),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x020, "gpm1", 0x04),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x040, "gpm2", 0x08),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x060, "gpm3", 0x0C),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x080, "gpm4", 0x10),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x0A0, "gpm5", 0x14),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x0C0, "gpm6", 0x18),
> +	EXYNOS9_PIN_BANK_EINTW(1, 0x0E0, "gpm7", 0x1C),
> +};
> +
> +/* pin banks of exynos850 pin-controller 2 (AUD) */
> +static struct samsung_pin_bank_data exynos850_pin_banks2[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x00),
> +	EXYNOS9_PIN_BANK_EINTG(5, 0x020, "gpb1", 0x04),
> +};
> +
> +/* pin banks of exynos850 pin-controller 3 (HSI) */
> +static struct samsung_pin_bank_data exynos850_pin_banks3[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTG(6, 0x000, "gpf2", 0x00),
> +};
> +
> +/* pin banks of exynos850 pin-controller 4 (CORE) */
> +static struct samsung_pin_bank_data exynos850_pin_banks4[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTG(4, 0x000, "gpf0", 0x00),
> +	EXYNOS9_PIN_BANK_EINTG(8, 0x020, "gpf1", 0x04),
> +};
> +
> +/* pin banks of exynos850 pin-controller 5 (PERI) */
> +static struct samsung_pin_bank_data exynos850_pin_banks5[] = {
> +	/* Must start with EINTG banks, ordered by EINT group number. */
> +	EXYNOS9_PIN_BANK_EINTG(2, 0x000, "gpg0", 0x00),
> +	EXYNOS9_PIN_BANK_EINTG(6, 0x020, "gpp0", 0x04),
> +	EXYNOS9_PIN_BANK_EINTG(4, 0x040, "gpp1", 0x08),
> +	EXYNOS9_PIN_BANK_EINTG(4, 0x060, "gpp2", 0x0C),
> +	EXYNOS9_PIN_BANK_EINTG(8, 0x080, "gpg1", 0x10),
> +	EXYNOS9_PIN_BANK_EINTG(8, 0x0A0, "gpg2", 0x14),
> +	EXYNOS9_PIN_BANK_EINTG(1, 0x0C0, "gpg3", 0x18),
> +	EXYNOS9_PIN_BANK_EINTG(3, 0x0E0, "gpc0", 0x1C),
> +	EXYNOS9_PIN_BANK_EINTG(6, 0x100, "gpc1", 0x20),
> +};
> +
> +static const struct samsung_pin_ctrl exynos850_pin_ctrl[] __initconst = {
> +	{
> +		/* pin-controller instance 0 ALIVE data */
> +		.pin_banks	= exynos850_pin_banks0,
> +		.nr_banks	= ARRAY_SIZE(exynos850_pin_banks0),
> +		.eint_gpio_init = exynos_eint_gpio_init,
> +		.eint_wkup_init = exynos_eint_wkup_init,
> +		.suspend	= exynos_pinctrl_suspend,
> +		.resume		= exynos_pinctrl_resume,

I guess retention registers will follow sometime later.

Best regards,
Krzysztof
