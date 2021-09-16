Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBC1611C6
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhIPHeP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPHeM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 03:34:12 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6DC061574;
        Thu, 16 Sep 2021 00:32:52 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso1789561ooq.8;
        Thu, 16 Sep 2021 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PPKEeXIy+YAqD7CDz6P2iHKAUbIobz6bTFOKIsZPo9w=;
        b=SpVH81Iv2iXIug1AXKuyzs7DZfHHFu2BGOhDUJ7Z2eOzIiCo9V3OAhssSktvn805dr
         oLpVq4gXaGlDSCijpQBD16X893ThNudKK7wThGWyfxkpk8kyR6sK070GV2WdHvcR40mM
         eOsCRrzmPEl2NCnI/vzSOwpoeJzmgUxk5bYDZOVdsDT3RmQ1Irdz8tShjK1EPr3tXgs3
         3JXh55pXyE3waE/2mKgNb8PdfEoMvFM3GNA8qcCcMgHN4zWWp5GF6VDBXTNKh19m016e
         SXROLVYMyMBHFEbhZlbuFQ7kPMhX+i2m+JcOMz3GBLtiglErw0DoY48sljDqNriYaUM9
         r4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PPKEeXIy+YAqD7CDz6P2iHKAUbIobz6bTFOKIsZPo9w=;
        b=uyFEzktj/l3VuyICmbCssuJndMNfR+pt7L+NaP+IxR0sxQ1c07YKHJef5JhGod06rR
         ecdPhXxnRaStaZsOzGEorsQ88opFUgukK1xeFnLNEpFW7r+G55Z7G01S38udiDlOxy3o
         vXmO5RVE0NVYRIt5ZK1+6xmQs/cbvlj+Ye+wcczal+CbhfwPk//K1mBJEqyZdoH1br5t
         2g9dqaIRXYpFwJPY7rhnPfPINwtjk+VP401foikegx9iKtZAlU6qRnoCQb7Ip2dt2nzG
         jlGFFKhoVc0qbtVgQgrSpIh1vxeIQpkkGiDiYJY+WEJfPEq3oW337vaAT2cbkUeyYgFz
         tmsA==
X-Gm-Message-State: AOAM531jVFDqF0gNZdU1ZvOYF7zn+5ljrvmza4CU1xVklStofA/MWzYE
        1kZKbqwAn6pglTj+24PEzV5LMwGYo9Xz19twNGY=
X-Google-Smtp-Source: ABdhPJwM1Nx+6Vb3ATZlqP1Dckj7VkHHB2eyXzuRsBPY2n9OCwHHZwHsk0x9ZjaFQpSyXlwB+nEE1bAyeNBGjw+TAmo=
X-Received: by 2002:a4a:ba0f:: with SMTP id b15mr3169729oop.31.1631777571643;
 Thu, 16 Sep 2021 00:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210914091134.17426-1-jslaby@suse.cz> <20210914091415.17918-1-jslaby@suse.cz>
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 16 Sep 2021 15:32:15 +0800
Message-ID: <CAAfSe-tUM_SBZ=MnDTNFU-JJJPkWsn-0RPVfNx7OOw_Odz5TMA@mail.gmail.com>
Subject: Re: [PATCH 08/16] tty: drivers/tty/serial/, stop using tty_flip_buffer_push
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 14 Sept 2021 at 17:14, Jiri Slaby <jslaby@suse.cz> wrote:
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

[snip]

For:

>  drivers/tty/serial/sprd_serial.c            |  4 ++--

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
