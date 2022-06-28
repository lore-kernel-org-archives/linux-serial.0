Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiF1QZ0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiF1QYs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 12:24:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA63914C
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 09:17:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v38so12342982ybi.3
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+P6wSeN2x0ZvD2/JjzHKyqS9/n/5A6tY5jiA6Lhnb8=;
        b=svPPiUXmjLu4A2+b3rJgoCqrzxWVmAH7KXTvVP4AwaLTDrIN9AN3BtNG2XiV2ycJ8x
         6Y9oMX5BQlCl6K+KL9J1KxqNRcb1MdTb/c18nJgwvmc5rVyOe8EKUyj+KrCbNC70iJoL
         OlJOsi9x5Scvw9W8cP8d/OYBAk6luTiA/PE8w/jzj7tOJ+ICpHFzyCnfh2xqrRn3YVLo
         nvgpT4pJzONw4hikJOgq/y8DRHjrG2lOfrc2hEWRc02ovhuxlfgkK9/gOnTwVGME5DOU
         4AXMX65QfUYiz76GEkrT/465op3M51kj45IkhJmeQobRe1+J32FVHZumFFaJBd9Gan88
         /wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+P6wSeN2x0ZvD2/JjzHKyqS9/n/5A6tY5jiA6Lhnb8=;
        b=pjN/wL/nKSaXXklkNsbYkbaz8AeRZsP0D9MlxsfG7FTF6LVRxCAOJccZ/YcmnfW0w7
         NwVSIEbPjBs8aLowVrtXMjtv3BDK5ZRwig0Nf0ePnjT76yqI7huMgA8akgWIEum/k1hp
         SjnvO2ADbewfhr5Ysjf6Im+LfWf7dLUXHMNCscCV7DbjFcgPRlHSGFuZpiS0Xgx5+0m5
         WkJweV5+dI7vPz6WvZOV2izDPNZyPPfwmnRRIkcsuUveHoK7YtzuaM/zDEDxARAvFoOG
         7NDf24oJbX9iJqntsnAQaxiKemOLXojCbXtS+Le/u1s84oAmCfXbK1ohPfz6BVZGhh/V
         4K9Q==
X-Gm-Message-State: AJIora/f9Uvt37SsW6aLJ6ObIn7IPnTAquCIk9frZxiwoC3yYqPFxxvc
        H4xDx6MecLwYl/Bl08XsQnqHwxfxDkU4DwQs4nm19A==
X-Google-Smtp-Source: AGRyM1vHa4WRnJlk4sln0xuJGdVhcpu8QS15R2N9PrbVvkglI7Nzwr0PBFdp1lTun6HJ/nUSS1O/TmeoEjFZPidRK0U=
X-Received: by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr20258885ybb.447.1656433020483; Tue, 28
 Jun 2022 09:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628020110.1601693-1-saravanak@google.com>
 <20220628020110.1601693-3-saravanak@google.com> <20220628140025.qpom64ptru4ub6fu@distanz.ch>
In-Reply-To: <20220628140025.qpom64ptru4ub6fu@distanz.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Jun 2022 09:16:24 -0700
Message-ID: <CAGETcx_7jS3H2cphiXdk=NBfmuPzsusEwPBx75n3PrP6YTnjnA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] serial: Set probe_no_timeout for all DT based drivers
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pali Rohar <pali@kernel.org>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>,
        sascha hauer <sha@pengutronix.de>, peng fan <peng.fan@nxp.com>,
        kevin hilman <khilman@kernel.org>,
        ulf hansson <ulf.hansson@linaro.org>,
        len brown <len.brown@intel.com>, pavel machek <pavel@ucw.cz>,
        joerg roedel <joro@8bytes.org>, will deacon <will@kernel.org>,
        andrew lunn <andrew@lunn.ch>,
        heiner kallweit <hkallweit1@gmail.com>,
        eric dumazet <edumazet@google.com>,
        jakub kicinski <kuba@kernel.org>,
        paolo abeni <pabeni@redhat.com>,
        linus walleij <linus.walleij@linaro.org>,
        hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
        david ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-unisoc@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        sparclinux@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 28, 2022 at 7:00 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2022-06-28 at 04:01:03 +0200, Saravana Kannan <saravanak@google.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
> > index 758c4aa203ab..5a6f2f67de4f 100644
> > --- a/drivers/tty/serial/8250/8250_acorn.c
> > +++ b/drivers/tty/serial/8250/8250_acorn.c
> > @@ -114,7 +114,6 @@ static const struct ecard_id serial_cids[] = {
> >  static struct ecard_driver serial_card_driver = {
> >       .probe          = serial_card_probe,
> >       .remove         = serial_card_remove,
> > -     .id_table       = serial_cids,
>
> Is this change intentional? All other drivers are only changed to set
> .probe_no_time and I don't see anything mentioned in the commit message
> re. this driver's change.

No, that's a mistake. Thanks for catching it! I'll check this patch again.

-Saravana
