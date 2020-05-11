Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE4C54E4B
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05AF208DB
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589191722;
	bh=WtEq/1kpgVLewTDkwfFKbHjTtwrkAeHhRFFbWBnnn6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bpg+W+uiFF1Ps+yfFBHBtXYlsChD2lv3URtftJwV+TLQ/g0AAvXTRD93yh/DAV2dw
	 eknr9eAa1J6QwqTZOP+A2casP2SeGLtCRtsXzI8RGwpflGH2LfDFPQVjEhgYMU3F1N
	 y/g01LeLOYlcT4Q1INW1LcdgrrJD4i/mokqRhYjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgEKKIm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 06:08:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgEKKIm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 06:08:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10so7421038edy.9;
        Mon, 11 May 2020 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADM8r+B0dzyP5A/vqyNmonnjvaPcrODBmZPyMqMMxIs=;
        b=qwcJ/U4lMnxfhStkH1TeBu1nnGL/VamUIPI6uUaTqGgUn0w7hZ4ovPOHFR7Ee0GRqh
         8aum25vzSOgS6GWJhlNKm7Orn2BdSq7VcGYZJw0xddzStZylWAMXIjLcpa+Rykkf3lJq
         z378MI3yjLb4rzqfQNtW4GcfjS/8giGCHfFfvtNCW+66oQ3y6ZRx18DR3MVHQBqiqask
         Y2+c5G3KLnKqmkHlsSzjEl3GCCp6VPSZ1DIv0xSRvch+u5g0vneXHBWYsAxZGxSV1Ig2
         zNST5BafTWPyc8Poy3r8rmc13QG5JpajmW8QOMz+s1ZVyxarri0pJxLzXL4ofao7mwZa
         aP+w==
X-Gm-Message-State: AGi0PuYSNg2M7CI1jFMj9Mwzy3wA7he6JUv1S+XD17eDhY8JNVMshxdO
        7+D/kh9NsTDziCPzYuhLNUF8aXvK
X-Google-Smtp-Source: APiQypIIjKKjypDAYbOFH4MiQWndpu/est9zg63nnHoe6ueUE/9p66tdn9yO2ilqbrvMJLoHMfCWHw==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr12321849edv.184.1589191719680;
        Mon, 11 May 2020 03:08:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id ga1sm1242231ejb.65.2020.05.11.03.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 03:08:39 -0700 (PDT)
Date:   Mon, 11 May 2020 12:08:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung: Correct clock selection logic
Message-ID: <20200511100836.GA16828@kozik-lap>
References: <BN6PR04MB06604E63833EA41837EBF77BA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06604E63833EA41837EBF77BA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 08, 2020 at 06:34:33PM -0700, Jonathan Bakker wrote:
> Some variants of the samsung tty driver can pick which clock
> to use for their baud rate generation.  In the DT conversion,
> a default clock was selected to be used if a specific one wasn't
> assigned and then a comparison of which clock rate worked better
> was done.  Unfortunately, the comparison was implemented in such
> a way that only the default clock was ever actually compared.
> Fix this by iterating through all possible clocks, except when a
> specific clock has already been picked via clk_sel (which is
> only possible via board files).
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/tty/serial/samsung_tty.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 73f951d65b93..9d2b4be44209 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1281,14 +1281,14 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>  	struct s3c24xx_uart_info *info = ourport->info;
>  	struct clk *clk;
>  	unsigned long rate;
> -	unsigned int cnt, baud, quot, clk_sel, best_quot = 0;
> +	unsigned int cnt, baud, quot, best_quot = 0;
>  	char clkname[MAX_CLK_NAME_LENGTH];
>  	int calc_deviation, deviation = (1 << 30) - 1;
>  
> -	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
> -			ourport->info->def_clk_sel;
>  	for (cnt = 0; cnt < info->num_clks; cnt++) {
> -		if (!(clk_sel & (1 << cnt)))
> +		/* Keep selected clock if provided */

Makes sense and good catch.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

I wonder about the s3c24xx_serial_enable_baudclk() which has similar
pattern - is there
testing only def_clk_sel on purpose?

Best regards,
Krzysztof

> +		if (ourport->cfg->clk_sel &&
> +			!(ourport->cfg->clk_sel & (1 << cnt)))
>  			continue;
>  
>  		sprintf(clkname, "clk_uart_baud%d", cnt);
> -- 
> 2.20.1
> 
