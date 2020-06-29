Return-Path: <SRS0=FCDA=AK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B63AC433E1
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D9C206F1
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458006;
	bh=i9ZfBpzxB3oPpousxT2bRt0NotTChvxCXKkleB811bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cFkB8PM1BXnPQd74Kd8RX6gWCZ3W+wDH20pYnDXcxz8DSY7Zt33Dp9ONa7QnC31M8
	 cMmexc3Nqi5m31NY/2vCscNEMQuqwMoFbT8yfV/3LZQtBprUKSrTuzrTLiWil2y8QW
	 EyAkR1+InjfqxjeX5rL2/P1TOWYzki53BmaQUt+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgF2TNZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgF2TNU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B91C008751;
        Mon, 29 Jun 2020 01:35:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i14so15694087ejr.9;
        Mon, 29 Jun 2020 01:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/lWBTxJeT64MmPuE+Y53vSa9wNIb6a3JKrDaGJpzms=;
        b=tCNf8B6YWMeZ7MhUEoFAMQQAPNwFYbsz8eq/qIeXIgJQ6vdkn0041EqqTNOsLS+Ait
         7avI8YxjJj1tMA/EiLLMs3kgCxbshsE+tLXz1Zkr/SQZY78jFK2GDRipp7jWGmZScS1m
         x0YWXskl11/zTACK5IRnOR5tCmC5WpBc1ZRDVWTcj5RK5B2ZK2TB6YSmWsVCouXkc9fH
         m3LrT8ZGR4If4XF5Ru3zfQMz5xoTV5WWhsbTlYl9M7mxn+MGHY4/MM234iegMFhaWdsp
         uhOC0QCCdFbme+VmxGNE4aqPWc/SeAOABmuCY5wbNX3szwexaajOfxaWr/jw8Q8AH78H
         wrqg==
X-Gm-Message-State: AOAM533VCO9psoKWQ3lh3cxY3vt8aw0C/h3kyeoM21T5JpLGZtQXoefc
        /JH67q0msfWvT/9U+Fkm30zhyXT3
X-Google-Smtp-Source: ABdhPJwSpDThVjcEd0PgJHWyDlPf/nuRiq+gnvJcGaWZixD0/guW/6gO2OZBM23kPBf0l0OLqzgoxQ==
X-Received: by 2002:a17:906:a1cc:: with SMTP id bx12mr12520655ejb.461.1593419756288;
        Mon, 29 Jun 2020 01:35:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id c4sm24101091ejb.17.2020.06.29.01.35.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 01:35:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:35:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [PATCH v2] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Message-ID: <20200629083553.GA14028@kozik-lap>
References: <CGME20200628071932epcas5p175059c085421a95de76202767bd132cf@epcas5p1.samsung.com>
 <20200628070007.36222-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200628070007.36222-1-m.shams@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jun 28, 2020 at 12:30:07PM +0530, Tamseel Shams wrote:
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
> Removed the RFC tag and using 'platform_get_irq_optional'
> instead of 'platform_get_irq' as per comment received from
> Robin Murphy.
> 
>  drivers/tty/serial/samsung_tty.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 6ef614d8648c..60554f42e208 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -60,6 +60,7 @@ struct s3c24xx_uart_info {
>  	char			*name;
>  	unsigned int		type;
>  	unsigned int		fifosize;
> +	unsigned int		irq_cnt;

No, it's duplicating the logic.

The driver already checks whether SoC has two or one interrupt line with
s3c24xx_serial_has_interrupt_mask() so there is no point to have two of
such methods.

Instead unify it please. Probably entire
s3c24xx_serial_has_interrupt_mask() and s3c24xx_serial_type() should be
removed and switched into *serial_drv_data.

Best regards,
Krzysztof
