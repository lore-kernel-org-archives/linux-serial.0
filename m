Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1000EC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68C861207
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhIPHt7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhIPHt6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 03:49:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A9C061574
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 00:48:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso6682544wmb.2
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=836pQNEOAKs5EjUipaYr5iTmWSGcl9uSpxBTxlPDNwg=;
        b=Vc4NxgDeb0/J8lHl8oOnMqlN5Jy1ogBUkUF54zM6lb5a7hvUtkGJEmc+HeNZLIjEri
         IJrMYLP7RuOAYLgsCGhcG/gl5mGL6JJ/VqdMCFomG73uCCLVaFZyhOTzk20t3WqQWIGi
         PgcQMwSKmUwIRd0RXchHMHAqL2GL7EPpfOdtFYKcrcXQiLHyn2A1BnnnWJRrGVTHBTPC
         Mgx2ZzcHcYBH4z2IAue2Zwzsrk1/3km74E6dNEnfdYH6wMLI5EgGeS7eSVC+PE+pHPwJ
         dKpwLquo+/CPwel76EsFxgERIXW6m+qvJF5bnbUT8oq6CjlaW/1fGLwXB+u6gNkUoMBQ
         JJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=836pQNEOAKs5EjUipaYr5iTmWSGcl9uSpxBTxlPDNwg=;
        b=lICDnOwgEjvAQW6SdKJqhknWvc7UMptYh9gE+CeCULNdZojTuNrOmspybCsmY9OBtG
         ufwTwc7dc06eOSjU2eAEnf/Ej6n75HTLekMxJGONnN3vjOqeD8/K1YdByaUIS8Osx0WU
         frYrzULHw9heTQLk3VckhXykpMq3AR2JjDRCLDTxP1Ibo97Kixji6sdrXtw/0z2XKY3e
         3i0pAZ/Dk1/FYxShE1jO3YyjZGuYcDaNd8M9Tglk1/IM6g4H179+wdRxOx/2HKPKcoB0
         GaOastajUBOId+71bw3LrtujkKD1vhXvtn0Ph6+9eOGOoDAnesVeT1x6FGUk+Uwh8fSR
         uNtQ==
X-Gm-Message-State: AOAM530Mrq7wbdExiagjXNl9Mx+jHJ7GXszHgufSl/1Exj5fhtlvEugy
        NhoJlxiK77Vubp1hfhLAA58sng==
X-Google-Smtp-Source: ABdhPJw2KytWoJGk8kUldFaBNIU3o57ulqI57sR8NeimQGmqAg+hDLglDQ/tA3JvLXNoX5X131ax4Q==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr8649130wme.51.1631778516430;
        Thu, 16 Sep 2021 00:48:36 -0700 (PDT)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h18sm2375509wrb.33.2021.09.16.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 00:48:35 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ba18bc51-6d4a-bc3b-5e4b-55a7315a2ed2@baylibre.com>
Date:   Thu, 16 Sep 2021 09:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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
>  drivers/tty/serial/sb1250-duart.c           |  2 +-
>  drivers/tty/serial/sc16is7xx.c              |  2 +-
>  drivers/tty/serial/sccnxp.c                 |  2 +-
>  drivers/tty/serial/serial-tegra.c           |  2 +-
>  drivers/tty/serial/serial_core.c            |  2 +-
>  drivers/tty/serial/serial_txx9.c            |  2 +-
>  drivers/tty/serial/sh-sci.c                 | 12 ++++++------
>  drivers/tty/serial/sifive.c                 |  2 +-
>  drivers/tty/serial/sprd_serial.c            |  4 ++--
>  drivers/tty/serial/st-asc.c                 |  2 +-
>  drivers/tty/serial/stm32-usart.c            |  2 +-
>  drivers/tty/serial/sunhv.c                  |  2 +-
>  drivers/tty/serial/sunsab.c                 |  2 +-
>  drivers/tty/serial/sunsu.c                  |  2 +-
>  drivers/tty/serial/sunzilog.c               |  4 ++--
>  drivers/tty/serial/tegra-tcu.c              |  2 +-
>  drivers/tty/serial/timbuart.c               |  2 +-
>  drivers/tty/serial/uartlite.c               |  2 +-
>  drivers/tty/serial/ucc_uart.c               |  2 +-
>  drivers/tty/serial/vr41xx_siu.c             |  2 +-
>  drivers/tty/serial/vt8500_serial.c          |  2 +-
>  drivers/tty/serial/xilinx_uartps.c          |  2 +-
>  drivers/tty/serial/zs.c                     |  2 +-
>  76 files changed, 103 insertions(+), 103 deletions(-)

For meson_uart:

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
