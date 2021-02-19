Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D59C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597D864ECA
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 09:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBSJoI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:44:08 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45463 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSJoH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 04:44:07 -0500
Received: by mail-ed1-f46.google.com with SMTP id p2so8623115edm.12;
        Fri, 19 Feb 2021 01:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuBGqICC+95wAYpH1uDMaRfEyp5FKDDvT+kNTfJaJ7Q=;
        b=keVzVcVlWw43UX9iy9CKMUSXLQ/1BNT5uvVB8ucgQRSQzcMeBSBInD5zw06OyDXdQO
         TJAVmpFM8Vgg/+MjAJNwdMUqRtow2kOOV39Z0gk7C+h6+Px4qoTziGxo51g/3CD1j7+V
         iLVEbR/rsUPVPTMydvN5QQ6QKt8AmA814u9Dx95gI2bxmqwe2wO1rijtHpK54CgEWMZo
         TStpQ/Y/+TJexXK2Tk+cPWvP5jlvXgHrw5OuQ6vbtbDH/ErT88fOjYV1bCli4eVdGfOm
         iJ9K+uT9WmXIPFLYu52kpDU47jmQ24lREsP0BbbX72PJhWhakBh1PX2fIFIH+EhMm2rs
         autA==
X-Gm-Message-State: AOAM5338sOHtAIm2SEc11+dJrJJCSl11a+rb2IPQHfl1hh+lzQXgD93z
        3RUwZhx3aUfH86xb+PlqCZQ=
X-Google-Smtp-Source: ABdhPJxOSz36mtchaYVHlW+F54VkE7/jOJwnpqm26Nw9+JatNCFWQKysxYeEFMpNpc5IUOdjkZXF5Q==
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr8216082edb.283.1613727803314;
        Fri, 19 Feb 2021 01:43:23 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y11sm2071075edw.18.2021.02.19.01.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:43:22 -0800 (PST)
Subject: Re: [PATCH v3 2/2] serial: 8250: Add new 8250-core based Broadcom STB
 driver
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210212195736.45328-1-alcooperx@gmail.com>
 <20210212195736.45328-3-alcooperx@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <d891e5bf-4fd8-fc44-7256-35ffa9d0931a@kernel.org>
Date:   Fri, 19 Feb 2021 10:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212195736.45328-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 02. 21, 20:57, Al Cooper wrote:
> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> UART is backward compatible with the standard 8250, but has some
> additional features. The new features include a high accuracy baud
> rate clock system and DMA support.
> 
> The driver will use the new optional BAUD MUX clock to select the best
> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> the baud rate selection logic for any requested baud rate.  This allows
> for more accurate BAUD rates when high speed baud rates are selected.
...
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
...
> +static void brcmuart_rx_isr(struct uart_port *up, u32 rx_isr)
> +{
> +	struct brcmuart_priv *priv = up->private_data;
> +	struct device *dev = up->dev;
> +	u32 rx_done_isr;
> +	u32 check_isr;
> +	char seq_err[] = "RX buffer ready out of sequence, restarting RX DMA\n";

What's the purpose of this on-stack variable?

> +static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
> +{
> +	int x;
> +	int rc;
> +
> +	priv->default_mux_rate = clk_get_rate(priv->baud_mux_clk);
> +	dev_dbg(dev, "Default BAUD MUX Clock rate is %lu\n",
> +		priv->default_mux_rate);
> +
> +	for (x = 0; x < ARRAY_SIZE(priv->real_rates); x++) {
> +		if (priv->rate_table[x] == 0) {
> +			priv->real_rates[x] = 0;
> +			continue;
> +		}
> +		rc = clk_set_rate(priv->baud_mux_clk, priv->rate_table[x]);
> +		if (rc) {
> +			dev_err(dev, "Error selecting BAUD MUX clock for %u\n",
> +				priv->rate_table[x]);
> +			priv->real_rates[x] = priv->rate_table[x];
> +		} else {
> +			priv->real_rates[x] = clk_get_rate(priv->baud_mux_clk);
> +		}
> +	}
> +	 clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);

This is only weirdly indented.

> +}
> +
> +static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
> +			u32 baud)
> +{
> +	u32 percent;
> +	u32 best_percent = UINT_MAX;
> +	u32 quot;
> +	u32 best_quot = 1;
> +	u32 rate;
> +	int best_index = -1;
> +	u64 hires_rate;
> +	u64 hires_baud;
> +	u64 hires_err;
> +	int rc;
> +	int i;
> +	int real_baud;
> +
> +	/* If the Baud Mux Clock was not specified, just return */
> +	if (priv->baud_mux_clk == NULL)
> +		return;
> +
> +	/* Find the closest match for specified baud */
> +	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
> +		if (priv->real_rates[i] == 0)
> +			continue;
> +		rate = priv->real_rates[i] / 16;
> +		quot = DIV_ROUND_CLOSEST(rate, baud);
> +		if (!quot)
> +			continue;
> +
> +		/* increase resolution to get xx.xx percent */
> +		hires_rate = (u64)rate * 10000;
> +		hires_baud = (u64)baud * 10000;
> +
> +		hires_err = div_u64(hires_rate, (u64)quot);
> +
> +		/* get the delta */
> +		if (hires_err > hires_baud)
> +			hires_err = (hires_err - hires_baud);
> +		else
> +			hires_err = (hires_baud - hires_err);
> +
> +		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
> +		dev_dbg(up->dev,
> +			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
> +			baud, priv->real_rates[i], percent / 100,
> +			percent % 100);
> +		if (percent < best_percent) {
> +			best_percent = percent;
> +			best_index = i;
> +			best_quot = quot;
> +		}
> +	}
> +	if (best_index == -1) {
> +		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
> +		return;
> +	}
> +	rate = priv->real_rates[best_index];
> +	rc = clk_set_rate(priv->baud_mux_clk, rate);
> +	if (rc)
> +		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
> +
> +	/* Error over 3 percent will cause data errors */
> +	if (best_percent > 300)
> +		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
> +			baud, percent / 100, percent % 100);
> +
> +	real_baud = rate / 16 / best_quot;
> +	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
> +	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
> +		baud, real_baud);
> +
> +	/* calc nanoseconds for 1.5 characters time at the given baud rate */
> +	i = 1000000000 / real_baud / 10;

NSEC_PER_SEC here?

> +	i += (i / 2);
> +	priv->char_wait = ns_to_ktime(i);
> +
> +	up->uartclk = rate;
> +}

...

> +static int __maybe_unused brcmuart_resume(struct device *dev)
> +{
> +	struct brcmuart_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->baud_mux_clk);
> +	if (ret)
> +		dev_err(dev, "Error enabling BAUD MUX clock\n");
> +
> +	/*
> +	 * The hardware goes back to it's default after suspend
> +	 * so get the "clk" back in sync.
> +	 */
> +	ret = clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
> +	if (ret)
> +		dev_err(dev, "Error restoring default BAUD MUX clock\n");
> +	if (priv->dma_enabled) {
> +		brcmuart_arbitration(priv, 1);
> +		brcmuart_init_dma_hardware(priv);
> +		start_rx_dma(serial8250_get_port(priv->line));
> +	}
> +	serial8250_resume_port(priv->line);

All these cannot fail? Or the above can, so does proceeding further 
without an error make sense?

> +	return 0;
> +}
....
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -501,6 +501,7 @@ config SERIAL_8250_PXA
>   	  applicable to both devicetree and legacy boards, and early console is
>   	  part of its support.
>   
> +

Why adding a newline here?

>   config SERIAL_8250_TEGRA
>   	tristate "8250 support for Tegra serial ports"
>   	default SERIAL_8250

regards,
-- 
js
suse labs
