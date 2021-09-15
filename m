Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775DC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 23:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B0160F8F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 23:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhIOXo6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:44:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49411 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232740AbhIOXo6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 19:44:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 51A855C0152;
        Wed, 15 Sep 2021 19:43:38 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Wed, 15 Sep 2021 19:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=65EmZ
        L0LbwiB8lQFRNIghM/u70CDsGRCVD3XuySJaeI=; b=l9xR4zfF4wiqamyyU31nR
        F7DPlejLec1ro8igl3/ITiXG1uM4iSxcUTQ7o1LK69+AIqqxJpQDMZZ3aepzF/BG
        IEWHhlmPKo9BUyKxgVADnAu7z2DMCSQ6JxUZT4DolHqS2Bu0Ef7IrUswS6mici1A
        CSBMyaFUAIpu0y3mqWpd+vFBX9MqRTufXKFKlNDjnDBj/zJUerxUZEE4saT/wCCU
        jBHWIawIT4MmrKd+xjEf7N3+Q0hEES6bm4XQg99MuxlqMABBP5cpsHEk2BV9IAVC
        l+DARsUB9MAPuJKP/efxVIOnzs/etFy0pwPvNZeTscWQqZaAgXG/xohFTzevC0cl
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=65EmZL0LbwiB8lQFRNIghM/u70CDsGRCVD3XuySJa
        eI=; b=CzfV1+QK+9dTkwhngYWlKamtMF6ziKrhznHBercJ4GNdLFEaojaBbTsDz
        aOwNx7otyyhjb9fcACHUQcS8NCB2CPJvXCi/wmK5TsarRni/qgs+FfZwvotUae6T
        QkO7hJS4q/sHpEUdEUL4QZ0wvq0gitrMWHmaiSKHWY+w3wucGLLKl5B/z96aOSHh
        vVc5B/COOtKoCMSO5heuqHCVKrshLqnYq3v53uRNy+QYN/wwbcIL1kaeLbHM02Lj
        iOS1XgxwWrCDutqalGwQ5OFJwjw4AB4jn00RuMmP5P0EJjWZAnabjy1aJdhIVNUI
        uDdJb3SqzsvJuPlt+Vr6xgzv+ztBw==
X-ME-Sender: <xms:KYVCYfGKFVxQlm1R4lkH67gqZGSnxYW9kz19WY_TDvRWTjwCPVeYpw>
    <xme:KYVCYcXKIuzN4rVidcWlqyWoZQDsnMPmahxrX_yk0TdBij3P0ohlUFdVKPjqxDqPm
    XXcRurPW5fmYWrXQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
    kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:KYVCYRKs-YffzSB_tk-0mmUW9Derm3Q0Z4XVSuT5z-h271JrynQjvw>
    <xmx:KYVCYdHbYbdVViKbtKewspu3hoQDlsDzH5UnKuhE13nn6Jxu27MSEA>
    <xmx:KYVCYVUiGB9c1F2TgTPuEoCmcXsObzXAi-o4hYAJ2wP7Ghl-g5U5OQ>
    <xmx:KoVCYTdUpGOY_eKcLmMs4zsQb2D8iZc-udpo12fuZU8q_3aWefRNIQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAF10AC04C2; Wed, 15 Sep 2021 19:43:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <4c4bee50-41f7-4ec2-80f9-b8f38c3ef99d@www.fastmail.com>
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
Date:   Thu, 16 Sep 2021 09:13:16 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Jiri Slaby" <jslaby@suse.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>, "Al Cooper" <alcooperx@gmail.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Tobias Klauser" <tklauser@distanz.ch>,
        "Russell King" <linux@armlinux.org.uk>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Richard Genoud" <richard.genoud@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Alexander Shiyan" <shc_work@mail.ru>,
        "Baruch Siach" <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Karol Gugala" <kgugala@antmicro.com>,
        "Mateusz Holenko" <mholenko@antmicro.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang7@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "David Miller" <davem@davemloft.net>,
        "Peter Korsgaard" <jacmet@sunsite.dk>,
        "Timur Tabi" <timur@kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>
Subject: =?UTF-8?Q?Re:_[PATCH_08/16]_tty:_drivers/tty/serial/,_stop_using_tty=5Ff?=
 =?UTF-8?Q?lip=5Fbuffer=5Fpush?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Tue, 14 Sep 2021, at 18:44, Jiri Slaby wrote:
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in
> drivers/tty/serial/.
>=20
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
> Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
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

For the Aspeed change:

Acked-by: Andrew Jeffery <andrew@aj.id.au>
