Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DB9C43334
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jul 2022 07:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiGDHkU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiGDHkT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jul 2022 03:40:19 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594DF43;
        Mon,  4 Jul 2022 00:40:17 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id sb34so15136976ejc.11;
        Mon, 04 Jul 2022 00:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=laOin+H9K41T+vz55kKfEFBIeZyyDRm/w+NPo83UhHI=;
        b=B6mPRY6laAzqiUBQ8xQdagAmB+MS25wzTMZ7SQ2dBAA+E/kmPq5OowT/BoTXjs2ZQW
         ovjPHnAOyrk6SVbfHX2e/8I5aNajnUBHz7aaJM9QSv+oRRxCDVRcpgLB/D+6lo+i3P3G
         KCvclZD75vrpd4KDcJ1/cbV0s7hl7xwuXJPGTECv6bGjHRe+IX7J2YgkgRT+nddvxmo5
         xoTdLBhxOwboCqvtbgplNpZxmAeFB+RWm5Vkx8IGF1N8E4LgwONjwa3dYMpGOjaQtfmW
         3JJDLtr8nNATTbG2Iml+QHYsnetcfVl+nYaQHg7BBmnF9pTP6GmmNurJqRVNiQNvh5+S
         yhwg==
X-Gm-Message-State: AJIora9GNOdvUgeH+1+Gf2raLvvX2qQdQnumGFkb+qX7Tb0BQP/Qvca3
        PjuMwIWXWv6TRScbYz46rE0=
X-Google-Smtp-Source: AGRyM1sP7KkmyoVD9abyysFJbyvfe+5dz5vuF7MygN+RTkBwuZ5LMR7scjJPqQSF5H5KzdClTNWx/g==
X-Received: by 2002:a17:907:2d2a:b0:726:3527:60ac with SMTP id gs42-20020a1709072d2a00b00726352760acmr26561592ejc.661.1656920416237;
        Mon, 04 Jul 2022 00:40:16 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090666cc00b007041e969a8asm13916243ejp.97.2022.07.04.00.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:40:15 -0700 (PDT)
Message-ID: <c7157f50-4739-2365-f394-826ff91637ed@kernel.org>
Date:   Mon, 4 Jul 2022 09:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] tty: serial: samsung_tty: support more than 4 uart
 ports
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17@epcas2p4.samsung.com>
 <20220629005538.60132-1-chanho61.park@samsung.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220629005538.60132-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29. 06. 22, 2:55, Chanho Park wrote:
> Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
> maximum number of the ports has been derived from
> CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> limitation, this changes the usage of the definition to UART_NR which is
> widely used from other serial drivers. This also defines the value to 12
> only for ARM64 SoCs to not affect the change to previous arm32 SoCs.
> 
> Instead of enumerating all the ports as predefined arrays, this
> introduces s3c24xx_serial_init_port_default that is initializing the
> structure as the default value.
...
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
...
> @@ -1810,67 +1816,27 @@ static const struct uart_ops apple_s5l_serial_ops = {
...
> +static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
> +
> +static void s3c24xx_serial_init_port_default(int index) {

The opening brace should be on a separate line.

> +	struct uart_port *port = &s3c24xx_serial_ports[index].port;
> +
> +	spin_lock_init(&port->lock);
> +
> +	port->iotype = UPIO_MEM;
> +	port->uartclk = 0;
> +	port->fifosize = 16;
> +	port->ops = &s3c24xx_serial_ops;
> +	port->flags = UPF_BOOT_AUTOCONF;
> +	port->line = index;
> +}
>   
>   /* s3c24xx_serial_resetport
>    *
> @@ -2186,6 +2152,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	}
>   	ourport = &s3c24xx_serial_ports[index];
>   
> +	s3c24xx_serial_init_port_default(index);

Perhaps pass &ourport->port to the function too -- you'd save the 
refetch there.

thanks,
-- 
js
suse labs
