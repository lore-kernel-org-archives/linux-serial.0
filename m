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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07BC43216
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BB360EE6
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhG3QcL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:32:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52284
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhG3QcG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 12:32:06 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 124BA3F243
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627662720;
        bh=cdkeBF7KTOrwZe4RSaJRZayxTRjOsHfP6nNB8Tio5O4=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=S3sQOFMWcpTO38J6XWn73hbTGH/lWIfJy1s1LYlwhy99eWXLP4H4cb+aJ3x11TiGO
         xuVB7w8Ef6c9Nq3vEVZIWfwcu1oSYBhJAbp68tUHP8mHgfgdavsnLVegENAELFuDPr
         gy/WC4EzN7kxW+RGYLw8IvJy/oTP9lOWHnzf7WzCCqph2t4AOo8aXVFK0PrvXOElIh
         G4c6/qEWGmQ3zcAW64j2ijbF6Td43vFZR8BwKNAnaBx15ebq1ZeH2lPNJQQF0goo2k
         coHda49noSF474ewBSOzYHBEtZVaZnHuJkedKqX1KEtfDi/jrey+RXxyMXqfoAnb3c
         cw92rHhUbOGzg==
Received: by mail-ej1-f71.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so2207826eje.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 09:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdkeBF7KTOrwZe4RSaJRZayxTRjOsHfP6nNB8Tio5O4=;
        b=keHuJJoA8E5uT1vEhKdoYwmZCLdJUuo/0+SMYK/467xc9LDsLm+vhp/tWjAjCdYTgA
         qSiPkcGrDgehiDhYXcotYLlIUn4slQFnCa+rLIx3ahK5J+563y9pxjNXmAMRQVBG+XtK
         uamU4lqtKyp8nxr431LtSa3/+64AwD0xVovGX61OF9t4ubfRZr0Ai9kYPcP1Z/eGhEIr
         WqLL5cNxbd3WfUF14nS1FZ3rwmdGMF17a7K7IG5YXhEZoL2IcVufr3xKYD+juV/q0DXd
         nEv43YsboHvwWCCkJuwy3gspjmhc/7n22zujokP39/wzqP6lGcfKS4cRHvUf+P3FGqW5
         vtZQ==
X-Gm-Message-State: AOAM533P/50XT5ecpXBBeCMirJwm93GaHiDyXU8syMetP56V6xUNFl9q
        1u5FJ7FdlJuhh0moOGE3L+qzb4JRfsL3CH/7dDBbBejY96ARw+XHYDj1bfOBad0sP5hp7lS5IsU
        Gnj9666ELVLQ9xQzOx0mcoG6efIuTQOhEWjc5ByAz5Q==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr3933027edq.225.1627662718833;
        Fri, 30 Jul 2021 09:31:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznpHPrHjFlOb+VuZi7FIsAImjbSiLLF3mhXsmZY17xgLFw6xzBdtYFFywclnCr3+C+w8ivdg==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr3933008edq.225.1627662718644;
        Fri, 30 Jul 2021 09:31:58 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id q8sm896087edv.95.2021.07.30.09.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:31:58 -0700 (PDT)
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
 <20210730144922.29111-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 04/12] tty: serial: samsung: Init USI to keep clocks
 running
Message-ID: <a1701931-136e-235c-8392-a3f64c050d74@canonical.com>
Date:   Fri, 30 Jul 2021 18:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> UART block is a part of USI (Universal Serial Interface) IP-core in
> Samsung SoCs since Exynos9810 (e.g. in Exynos850). USI allows one to
> enable one of three types of serial interface: UART, SPI or I2C. That's
> possible because USI shares almost all internal circuits within each
> protocol. USI also provides some additional registers so it's possible
> to configure it.
> 
> One USI register called USI_OPTION has reset value of 0x0. Because of
> this the clock gating behavior is controlled by hardware (HWACG =
> Hardware Auto Clock Gating), which simply means the serial won't work
> after reset as is. In order to make it work, USI_OPTION[2:1] bits must
> be set to 0b01, so that HWACG is controlled manually (by software).
> Bits meaning:
>   - CLKREQ_ON = 1: clock is continuously provided to IP
>   - CLKSTOP_ON = 0: drive IP_CLKREQ to High (needs to be set along with
>                     CLKREQ_ON = 1)
> 
> USI is not present on older chips, like s3c2410, s3c2412, s3c2440,
> s3c6400, s5pv210, exynos5433, exynos4210. So the new boolean field
> '.has_usi' was added to struct s3c24xx_uart_info. USI registers will be
> only actually accessed when '.has_usi' field is set to "1".
> 
> This feature is needed for further serial enablement on Exynos850, but
> some other new Exynos chips (like Exynos9810) may benefit from this
> feature as well.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 33 +++++++++++++++++++++++++++++++-
>  include/linux/serial_s3c.h       |  9 +++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..0f3cbd0b37e3 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -65,6 +65,7 @@ enum s3c24xx_port_type {
>  struct s3c24xx_uart_info {
>  	char			*name;
>  	enum s3c24xx_port_type	type;
> +	unsigned int		has_usi;
>  	unsigned int		port_type;
>  	unsigned int		fifosize;
>  	unsigned long		rx_fifomask;
> @@ -1352,6 +1353,29 @@ static int apple_s5l_serial_startup(struct uart_port *port)
>  	return ret;
>  }
>  
> +static void exynos_usi_init(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	struct s3c24xx_uart_info *info = ourport->info;
> +
> +	if (!info->has_usi)
> +		return;
> +
> +	/*
> +	 * USI_RESET is an active High signal. Reset value of USI_RESET is 0x1
> +	 * to drive stable value to PAD. Due to this feature, the USI_RESET must
> +	 * be cleared (set as 0x0) before starting a transaction.

"before starting a transaction" suggests it is related with transaction
or something before starting it. Don't you need it simply after reset or
resume?

> +	 */
> +	wr_regl(port, USI_CON, USI_RESET);

You are clearing entire register, not only USI_RESET bitfield. Is it
really what you want?

> +	udelay(1);
> +
> +	/*
> +	 * Set the HWACG option bit in case of UART Rx mode.
> +	 * CLKREQ_ON = 1, CLKSTOP_ON = 0 (set USI_OPTION[2:1] = 0x1).
> +	 */
> +	wr_regl(port, USI_OPTION, USI_HWACG_CLKREQ_ON);
> +}
> +
>  /* power power management control */
>  
>  static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> @@ -1379,6 +1403,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>  		if (!IS_ERR(ourport->baudclk))
>  			clk_prepare_enable(ourport->baudclk);
>  
> +		exynos_usi_init(port);
>  		break;
>  	default:
>  		dev_err(port->dev, "s3c24xx_serial: unknown pm %d\n", level);
> @@ -2102,6 +2127,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  	if (ret)
>  		pr_warn("uart: failed to enable baudclk\n");
>  
> +	exynos_usi_init(port);
> +
>  	/* Keep all interrupts masked and cleared */
>  	switch (ourport->info->type) {
>  	case TYPE_S3C6400:
> @@ -2750,10 +2777,11 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>  #endif
>  
>  #if defined(CONFIG_ARCH_EXYNOS)
> -#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
> +#define EXYNOS_COMMON_SERIAL_DRV_DATA_USI(_has_usi)		\
>  	.info = &(struct s3c24xx_uart_info) {			\
>  		.name		= "Samsung Exynos UART",	\
>  		.type		= TYPE_S3C6400,			\
> +		.has_usi	= _has_usi,			\
>  		.port_type	= PORT_S3C6400,			\
>  		.has_divslot	= 1,				\
>  		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
> @@ -2773,6 +2801,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>  		.has_fracval	= 1,				\
>  	}							\
>  
> +#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
> +	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(0)
> +
>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>  	EXYNOS_COMMON_SERIAL_DRV_DATA,
>  	.fifosize = { 256, 64, 16, 16 },
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index f6c3323fc4c5..013c2646863e 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -28,6 +28,15 @@
>  #define S3C2410_UFSTAT	  (0x18)
>  #define S3C2410_UMSTAT	  (0x1C)
>  
> +/* USI Control Register offset */
> +#define USI_CON			(0xC4)
> +/* USI Option Register offset */
> +#define USI_OPTION		(0xC8)
> +/* USI_CON[0] = 0b0: clear USI global software reset (Active High) */
> +#define USI_RESET		(0<<0)

Just 0x0. I understand you wanted to hint it is a bit field, but the
shift of 0 actually creates more questions.


Best regards,
Krzysztof
