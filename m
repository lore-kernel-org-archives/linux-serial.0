Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F5C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838F261130
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhINNy4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhINNyn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 09:54:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1CC061764;
        Tue, 14 Sep 2021 06:53:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g16so20403050wrb.3;
        Tue, 14 Sep 2021 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R5Ll91GiIKwpebUxcKaoRvdeNSdIOg5l+lemZ4KefSc=;
        b=ZLNVFXPBj8feUKVClnB4owuugv1a86o9TIKQsUKIon3bWAyun2uNCG/XUrXPcfZx/Y
         ndkQstXdtlpLnoFeORAUzZ6ThLQiKY1bDPoLCps2Wr9jSEE28vUnFCg3IjWI9gd9xykc
         LQwkqjpSisybWOc2DDHpoVQQ8s2bJg7ANh+AxLyLpkfh66tRQA1WqDjcjnXfXDKvBbPo
         WTnj8W+w0nD/r0eAS6k5CEl2zUu2THKDDn6n66DisgAv9LEhj6EcTlqXk2cKLoa5xwug
         Ldv+E3VE+obBlfO40m2lEAL1NX77kJbn9SeoiR4PPKl7rdpLQ/mMs19gpXrfKAgQsD7Z
         zbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5Ll91GiIKwpebUxcKaoRvdeNSdIOg5l+lemZ4KefSc=;
        b=ZeTBCd9WSaOi44io0r8ke6nQxo34OG1G4EW1qktLNJgANrt822gBzCHkNFZX18Zu43
         NRSVctIAxzTUsRfjpwFeQcHXlkglf0J/GItlDSqqCbmYo2/eXbXKlqvJDabQ13+yUMgE
         XGBy/nIV51gDbNDF6dUwLQTij7HS4oBj9ZD42+HXxvS6BlL1JKWQBxkuTNBL88FFkofj
         7/YLNikkw8WA/IFCvapI5jYzd1qe3n/mksmMVlW8c8PnOwYXS0udidRC5YfBnFKNvM/t
         G/lXH8o/VN87sgsivz6Gq4bnq4t+IQoZKvxgesRjP8EnSD2t7MmjSgaz0bufjnOIhh2F
         yESw==
X-Gm-Message-State: AOAM530/OVgHnSkFzkwXOlhvUMqlcmDr73e9ZuhRKT44m8Hf7ATtcu/h
        +FevEXGg4rp5vKxfU009auE=
X-Google-Smtp-Source: ABdhPJy3X2Pnc+BXXTdj4AXvyDGV7Z3RE/epMkOU2lYGUjHAdEmUlD4FksFl2tTXfSR+vW1ttdmdGg==
X-Received: by 2002:a05:6000:374:: with SMTP id f20mr19103683wrf.129.1631627604005;
        Tue, 14 Sep 2021 06:53:24 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id f3sm1201844wmj.28.2021.09.14.06.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 06:53:23 -0700 (PDT)
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
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <9be03e0b-8255-9306-0041-0ed3228709e2@gmail.com>
Date:   Tue, 14 Sep 2021 15:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 14/09/2021 à 11:14, Jiri Slaby a écrit :
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in
> drivers/tty/serial/.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

For Atmel:
Acked-by: Richard Genoud <richard.genoud@gmail.com>
