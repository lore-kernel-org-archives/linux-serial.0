Return-Path: <SRS0=jM0J=7V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF5C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 06:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976A02076A
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591598474;
	bh=BQCBgwFsMXSNTIHxvc5pCdzZe+VJ7aLilK0Z+i0lOhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TM79co/isxo0v8LQloKDSKbbPTde8K4No49PkaelHRJ3naVzUVZcQLhA6J7WnYFfj
	 hfQ7i1Cp3viushclIbPB+moKSczaEEUua87rvRypsFrODsqhVtyEmBESQahixR+wS0
	 9XZv5u8vnbLVvxRk885oE8KOFmY1nFS6rEZ5J00o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgFHGlO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:41:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45992 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFHGlN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Jun 2020 02:41:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id i27so8049651ljb.12;
        Sun, 07 Jun 2020 23:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4UQh0Us0hQtEs1TDFqY5o6aN1qVDkFutQCZsE8JqaU=;
        b=csQWcLndzxeF1KrldccUUCgN7uzZmNEptynzFIjfAjykqXPq0K25A1eJPkrBtnq2Xo
         8LuQ5cvNIrTsEFXj8mfV0PVlbYL8PM0bX/oQTKgDZfq7YgnyRmZjKQvNH0Qcl1iQyhrl
         XzifwteGq2Ukke6BV+PaPrECf+x9h0S+AVVGr0Wj3f1dfAzVqJ5dkhyN0it2VAsnLpM2
         sMhwrM/q3algyoJEwqmltogYOxkgy7EOLwe8SNhNYizjmtu0qRoth1lpV7c0HbKs3GRp
         YsZHRI5TyIAkr0Q1LRiZV0csdWn20+YZu0fsjXovAWb4T/oox0+6763EQdrQfxBtIOea
         lTmg==
X-Gm-Message-State: AOAM532DGYSVhK83OR1UL9HwTJ0z6cjd+60ljzawBnNMObWxCPswL3Aj
        ugDYlW/uAEhxT5DumuOit34=
X-Google-Smtp-Source: ABdhPJw7i0D0egd72cvg61t4dDEMZ5Zoy6Geiu+vS8eBA4Z7uYi/XVCKJRKsmx3xMFnlXhqh8YnFKw==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr10196151ljk.382.1591598471669;
        Sun, 07 Jun 2020 23:41:11 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t26sm4169562lfk.61.2020.06.07.23.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:41:11 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jiBSz-0003mQ-EB; Mon, 08 Jun 2020 08:41:05 +0200
Date:   Mon, 8 Jun 2020 08:41:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: cpm_uart: Fix behaviour for non existing
 GPIOs
Message-ID: <20200608064105.GL19480@localhost>
References: <bafd8df9e743c433196c727293c5015620fae2b8.1591428452.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafd8df9e743c433196c727293c5015620fae2b8.1591428452.git.christophe.leroy@csgroup.eu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 06, 2020 at 07:30:21AM +0000, Christophe Leroy wrote:
> devm_gpiod_get_index() doesn't return NULL but -ENOENT when the
> requested GPIO doesn't exist,  leading to the following messages:
> 
> [    2.742468] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.748147] can't set direction for gpio #2: -2
> [    2.753081] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.758724] can't set direction for gpio #3: -2
> [    2.763666] gpiod_direction_output: invalid GPIO (errorpointer)
> [    2.769394] can't set direction for gpio #4: -2
> [    2.774341] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.779981] can't set direction for gpio #5: -2
> [    2.784545] ff000a20.serial: ttyCPM1 at MMIO 0xfff00a20 (irq = 39, base_baud = 8250000) is a CPM UART
> 
> Use IS_ERR_OR_NULL() to properly check gpiod validity.

Why check for NULL at all?

> Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
> Cc: stable@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index a04f74d2e854..3cbe24802296 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1217,7 +1217,7 @@ static int cpm_uart_init_port(struct device_node *np,
>  
>  		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
>  
> -		if (gpiod) {
> +		if (!IS_ERR_OR_NULL(gpiod)) {
>  			if (i == GPIO_RTS || i == GPIO_DTR)
>  				ret = gpiod_direction_output(gpiod, 0);
>  			else

Johan
