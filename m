Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D5FC433E0
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107DF20760
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594023196;
	bh=+J43D10c1do+MqKRehDMJtCNekWCxU9ZJ7/Y3GE2T4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rxmvzaZ0Inse24IKc+eMWv06OM/xyVDrrhewmPj+qM6/IPy/tFlHTbwRs83OQmAqm
	 KVN4cpGjAFxhWBNYPD4NS77o+O/OSFdu6foD63blnpaBCdaGNSHvIG0yF+kcbTdtiM
	 kAJGSfQ0GTZqTpgPWpbRTxq2Rtvec4oOcVYYqyxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGFINN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:13:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgGFINM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 04:13:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so28501925wrl.8;
        Mon, 06 Jul 2020 01:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUKUTjO33DX82247t1T1Yew5fhk3nmz220YuXhRhADc=;
        b=O+fe/A3mpb7/lMfOJzovPrh19ECYGgB/aEMbGQnBoy182VY0hc1SmedElo+QxKi3fb
         dBzB7oinC7z/J1ErcUrvazxlszIBaN97Wx2TPhmxKsC5Un2XEJR9AiLlOtLYZpD1GNjy
         /B60pws2N/VXmTEWbTPmkLjaGp0wjhHN4jvHimy1lyFzk8ZeDB4uE71dNNgK4zqjb7oa
         3jHuJffwsJG0bCf1F6OtcDt6M3CpMsGy4h0YvHVdf4I51MjmuF686gFWcTQ9VZod2mnt
         fdC/JPG8xnUeDy6pQeRCRTmNbi+1OXTmHlgf4T4l4FsPf6FhQfcheVkRKA2u8NAmSQ4Y
         Kj5Q==
X-Gm-Message-State: AOAM533+F24McVPRrcgUGfHn27fHwq6NJRiYRJADHyDpsrNiuxVfg7+0
        +lLr5izk9qUsCYesPVKiYp0=
X-Google-Smtp-Source: ABdhPJzyJLT0CQOJhMf7/BN92VF7E6LpQaMaK9rgLW0mqz5ccWXizBMna/VaEldxg5y18H3HXfxLPA==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr46637840wrt.209.1594023190618;
        Mon, 06 Jul 2020 01:13:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id f12sm23767680wrj.48.2020.07.06.01.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 01:13:09 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:13:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [PATCH v3] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Message-ID: <20200706081307.GA13025@kozik-lap>
References: <CGME20200704142658epcas5p254ae909fedb07dda58cece5d6d5252b4@epcas5p2.samsung.com>
 <20200704140646.66528-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200704140646.66528-1-m.shams@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 04, 2020 at 07:36:46PM +0530, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following warning:
> "IRQ index 1 not found" on recent platforms.
> 
> This patch re-factors the IRQ resources handling for
> each platform and hence fixing the above warnings seen
> on some platforms.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> Removed the logic of irq_cnt and directly using
> s3c24xx_serial_has_interrupt_mask() to check for
> number of interrupt lines.
> 
>  drivers/tty/serial/samsung_tty.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 6ef614d8648c..8a955f3d8975 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1908,10 +1908,13 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  	else {
>  		port->irq = ret;
>  		ourport->rx_irq = ret;
> -		ourport->tx_irq = ret + 1;
> +		if (s3c24xx_serial_has_interrupt_mask(port))
> +			ourport->tx_irq = ret;

Hi,

I don't understand: Why do you assign here the same interrupt as RX?

Best regards,
Krzysztof

> +		else
> +			ourport->tx_irq = ret + 1;
>  	}
>  
> -	ret = platform_get_irq(platdev, 1);
> +	ret = platform_get_irq_optional(platdev, 1);
>  	if (ret > 0)
>  		ourport->tx_irq = ret;
>  	/*
> -- 
> 2.17.1
> 
