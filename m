Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E422C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3013860F25
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhINJTU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:19:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40700
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhINJTT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:19:19 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 217483FDC7
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631611082;
        bh=aRxLbL6hEiGe6xganEKR1lyiW6DB54cMIWpJYFs9yww=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=rxHl1wUOx9nBhchTjahMS7oehPqJ2Ahnm1yu3xry/v/r0tfu/EUY49q1IGvXg3eFC
         9ADDdt6dJcOKyUF9bRw/bDXHBK5Udy6LiHW6VNef4sSPEOEvXP/zgsPl2CecruQmr+
         ZXO46Jdzw2viy4KADDXpSl+SIer6bi4WaKHRtYu+zaLFEL7MVHIWkLKDdns7b7aUtP
         2Ep4jkGuNxFUBhlxBGV9vJSikXbv8V0OWLTC/n5BbV40uM/5hS+mDMr9/Q+bFOqw+D
         JglaoEZnzQqt9q1oo8m2DsF8Ov8THYuq8ZvIdqLX/m/nB99CSabkR2mfF688/K8++6
         GzjllO1OVcM9A==
Received: by mail-wr1-f70.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso1509583wrw.22
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 02:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRxLbL6hEiGe6xganEKR1lyiW6DB54cMIWpJYFs9yww=;
        b=lQmmoXDNpKgJFzRTVOONAkXQxq41F9ZLhYfBw845E+e82h6siINsfptxT7NWKdnKaE
         ReBGO7tVfGDYUYdpn7uSyIQk0Rrb/X8yIxr9Qwgvvbw6j+1+0l2MRwBJAwrwiPU0N0w6
         TkVZ/yOC1o/73ObXlBOMDlsD7trcmcmjOc2tK1KYA8u3APDWFg/yN8aLngB3FrNIV0lE
         Y3N1vGnfeA9MAyeDgCKJE+WcTEJYcNMkoLXZqSRF7Le/wYxB7lJLeQWQ+mUtmMblb2Wi
         +fz9Vo0/P4+ZzXkqoYIAp+iB2Sjz8YIeF8riUzZ9nxFr+yGDpLlX3iI5lEwSxmeLjlDT
         QZgg==
X-Gm-Message-State: AOAM5325ZOj0Xxbq1qUjHlG87NgR3DKogbYT+0iDa0CRjNXrFaGgoxjH
        a4oBFk4fUdhRb9IGrr0NLUnerdzImeJ7EdRSiomwnzBEW8wv5VVQEJhdjfyLfoLRGQS8UBKYBkO
        AVlBoMHC7Rtn9t7hhyEGtMcvSDJmHUUlFeS3/l8+gDQ==
X-Received: by 2002:adf:9f0d:: with SMTP id l13mr17852470wrf.328.1631611081603;
        Tue, 14 Sep 2021 02:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyzQztBzbBrYTaOhN+AokKj5GVs0m53CtmIkzfLqV3EcR+H0RZPuNBjuVmjpdyhO8bDxCc7A==
X-Received: by 2002:adf:9f0d:: with SMTP id l13mr17852425wrf.328.1631611081418;
        Tue, 14 Sep 2021 02:18:01 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n17sm2747552wrp.17.2021.09.14.02.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:18:00 -0700 (PDT)
Subject: Re: [PATCH 08/16] tty: drivers/tty/serial/, stop using
 tty_flip_buffer_push
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Al Cooper <alcooperx@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <3551622b-31a5-d349-5785-a07fc1241958@canonical.com>
Date:   Tue, 14 Sep 2021 11:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/09/2021 11:14, Jiri Slaby wrote:
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in
> drivers/tty/serial/.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/tty/serial/21285.c                  |  2 +-
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  2 +-
>  drivers/tty/serial/8250/8250_bcm7271.c      |  2 +-
>  drivers/tty/serial/8250/8250_dma.c          |  2 +-
>  drivers/tty/serial/8250/8250_mtk.c          |  2 +-
>  drivers/tty/serial/8250/8250_omap.c         |  2 +-
>  drivers/tty/serial/8250/8250_port.c         |  2 +-
>  drivers/tty/serial/altera_jtaguart.c        |  2 +-
>  drivers/tty/serial/altera_uart.c            |  2 +-
>  drivers/tty/serial/amba-pl010.c             |  2 +-
>  drivers/tty/serial/amba-pl011.c             |  6 +++---
>  drivers/tty/serial/apbuart.c                |  2 +-
>  drivers/tty/serial/ar933x_uart.c            |  2 +-
>  drivers/tty/serial/arc_uart.c               |  2 +-
>  drivers/tty/serial/atmel_serial.c           |  6 +++---
>  drivers/tty/serial/bcm63xx_uart.c           |  2 +-
>  drivers/tty/serial/clps711x.c               |  2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
>  drivers/tty/serial/digicolor-usart.c        |  2 +-
>  drivers/tty/serial/dz.c                     |  2 +-
>  drivers/tty/serial/fsl_linflexuart.c        |  2 +-
>  drivers/tty/serial/fsl_lpuart.c             |  6 +++---
>  drivers/tty/serial/icom.c                   |  2 +-
>  drivers/tty/serial/imx.c                    |  6 +++---
>  drivers/tty/serial/ip22zilog.c              |  4 ++--
>  drivers/tty/serial/jsm/jsm_tty.c            |  2 +-
>  drivers/tty/serial/kgdb_nmi.c               |  2 +-
>  drivers/tty/serial/lantiq.c                 |  4 ++--
>  drivers/tty/serial/liteuart.c               |  2 +-
>  drivers/tty/serial/lpc32xx_hs.c             |  2 +-
>  drivers/tty/serial/max3100.c                |  4 ++--
>  drivers/tty/serial/max310x.c                |  2 +-
>  drivers/tty/serial/mcf.c                    |  2 +-
>  drivers/tty/serial/men_z135_uart.c          |  2 +-
>  drivers/tty/serial/meson_uart.c             |  2 +-
>  drivers/tty/serial/milbeaut_usio.c          |  2 +-
>  drivers/tty/serial/mpc52xx_uart.c           |  2 +-
>  drivers/tty/serial/mps2-uart.c              |  4 ++--
>  drivers/tty/serial/msm_serial.c             |  6 +++---
>  drivers/tty/serial/mux.c                    |  2 +-
>  drivers/tty/serial/mvebu-uart.c             |  2 +-
>  drivers/tty/serial/mxs-auart.c              |  4 ++--
>  drivers/tty/serial/omap-serial.c            |  2 +-
>  drivers/tty/serial/owl-uart.c               |  2 +-
>  drivers/tty/serial/pch_uart.c               |  4 ++--
>  drivers/tty/serial/pic32_uart.c             |  2 +-
>  drivers/tty/serial/pmac_zilog.c             |  4 ++--
>  drivers/tty/serial/pxa.c                    |  2 +-
>  drivers/tty/serial/qcom_geni_serial.c       |  4 ++--
>  drivers/tty/serial/rda-uart.c               |  2 +-
>  drivers/tty/serial/rp2.c                    |  2 +-
>  drivers/tty/serial/sa1100.c                 |  2 +-
>  drivers/tty/serial/samsung_tty.c            |  6 +++---

For Samsung:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

BR,
Krzysztof
