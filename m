Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D82C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645DC60F51
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhIPHOl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:14:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45412 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhIPHOk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 03:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631776401; x=1663312401;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S9xwUs0E3cYgoZ5/WPnXwXWHbUY3eB8DgTjEUCZc+pc=;
  b=c1bGAYIp1GMVd3J2bnKi1kMtOTKls2D1+nZUnBCio7HxUjrEGWyNsr1t
   Kg4qGFWp7ofsATP2VqDif0PrGCgwNbgti9YB4AeUgAHIqAQgKZbRIQlvA
   JnhoSyi4FXxmr6qfpHb0Hy6G9pPwfyXNlYlhHmvW1LgIck/7pVshNcpGW
   tzRqnCIUSE66mfLsdMqjV05n7IHSfr/i5oDpgnf2vBykBCIdGNxzQTvnY
   8HCAdAvWk6pNXLNbblALsDieGOOnvvUXiecoTbM59qkzwB/eYiO/s0oJ/
   kiWpfgb7lJ73+S38x8ZwI1f598EU9kauh8EAM834QfXBToaihsuq0CN9T
   g==;
IronPort-SDR: WDxWUPiA9x1TXSKHajXCBvyei74iFfdPWJ/1G5MKfz1jj5vqpVavib9YvSUG8tlGnTTc5AOmCy
 ATe7r5F3LgnrHBeR/WBKHF+UtZtlTFXBd00MfHTGc1A3k0AKGV1B/T4iHyL0hs3G/6qIA969+N
 UL232BjHu91Hgb6RlYxGR89dea6Tff9D3YpJdO1Oe/0usBM315c6ybQMSGB3SJ5st6/AVjedis
 cqZsM75ZJfZchUI0t7WbiM+8BmsAeTRyOI8IJN4QqaJPuIzzc/Gdp7DFog7xZ8fRPfjnmYyicz
 NA1BfgnV8pVwFWtF2///hXqZ
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="136166781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 00:13:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 00:13:12 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 00:13:02 -0700
Subject: Re: [PATCH 08/16] tty: drivers/tty/serial/, stop using
 tty_flip_buffer_push
To:     Jiri Slaby <jslaby@suse.cz>, <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Al Cooper <alcooperx@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tobias Klauser" <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        "Vineet Gupta" <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
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
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <f2f2b42b-6bd2-c5de-0f69-590d4f216586@microchip.com>
Date:   Thu, 16 Sep 2021 09:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/09/2021 at 11:14, Jiri Slaby wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
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

[..]

For:

>   drivers/tty/serial/atmel_serial.c           |  6 +++---

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
-- 
Nicolas Ferre
