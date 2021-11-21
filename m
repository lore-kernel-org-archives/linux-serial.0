Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC47C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 21 Nov 2021 23:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhKUXio (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Nov 2021 18:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhKUXio (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Nov 2021 18:38:44 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813EC061714
        for <linux-serial@vger.kernel.org>; Sun, 21 Nov 2021 15:35:38 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso26151372otf.12
        for <linux-serial@vger.kernel.org>; Sun, 21 Nov 2021 15:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaBwOZhHd4DxX6OyrXmhy1nl2ZJax3QUSfV+91vGF7M=;
        b=K+j7e9qBhUAibBOZEuR3+OvgRRz5+9kXuJpfy7hOrCUUI5mVAVvfPjVaSaQWagEtmD
         VaQjSDZvZCKKfl/PaO0UdwCeIlqMJ7eJooO6eT7GjoXW1uvDDryVqntBnxqhbhpAdjE3
         CmxKLcWB9dGg5+uW12IGRoofHXHVRV9TegwAW6qUaX/HiDYCvGQYSP2/TGLWo1eJk41q
         HLONx6bHVQumcQ5Vy4Z+6fD/ZgNYF7VwvELj9YticGsmN4Q2lcnFiWT5fPI5W1ugXnAY
         wRaew207TxZ9kuepimcJjzsp7th6vntEkiki7IDzihCyEVwhCSWDlcpKyzXN5bcdu5J+
         tDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaBwOZhHd4DxX6OyrXmhy1nl2ZJax3QUSfV+91vGF7M=;
        b=leYTPJru7g/G751eNTlak8MKtZmP7Gjw91GVpm2izRJcGmUBKw+cFlySpto+w5gERM
         SU3r+Z9hKZstxjyyQCL/ca6NLCbtClkzA3WKGgaMzSpAmVPQS5EFnROH+zC8Tu4KyoVt
         yDw1iyAwdbej4thqh7pmaTCBrv7fY7ile6yzFBvOSMWtNNjOdZCR9tPAvdfy7lpD0CTQ
         2Vbu7jPcjjSbaZ++TsA+ioW7t/oXokd+NBk06tlvyWPXfF04/8sBqzaRvZIblEA/gdjH
         /eZqdOTR+rSan8dN1UBIr/DFrpqRPhqt4R+JmzO874PS0UqLBjb0sYNCxTS53QkLz5sE
         H7Uw==
X-Gm-Message-State: AOAM531+HgajnAiGFbVKv3296U0Gn+mx6ZB8rd4H74pTzfsJVB3q1Szn
        wtoyar3dGV8rxlX6VYK+ZaMtVw2xKoBcPbTELbbszQ==
X-Google-Smtp-Source: ABdhPJxP1hm4dAk3hP5iwxGTmVS5kCY5d1BVX1iWfJPo1f0KYbx3q9C2qhLGJ7JQjety/S6BZHEqWcsnr8krInQwy+4=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr21475101otg.179.1637537737964;
 Sun, 21 Nov 2021 15:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20211116150119.2171-1-kernel@esmil.dk> <20211116150119.2171-13-kernel@esmil.dk>
In-Reply-To: <20211116150119.2171-13-kernel@esmil.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 00:35:26 +0100
Message-ID: <CACRpkdbsRg3KB=xvhUPF3gVjE92pTwsbV+1SOJ=DXSE7c9VNHw@mail.gmail.com>
Subject: Re: [PATCH v4 12/16] pinctrl: starfive: Add pinctrl driver for
 StarFive SoCs
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Huan Feng <huan.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 16, 2021 at 4:02 PM Emil Renner Berthing <kernel@esmil.dk> wrote:

> Add a combined pinctrl and GPIO driver for the JH7100 RISC-V SoC by
> StarFive Ltd. This is a test chip for their upcoming JH7110 SoC, which
> is said to feature only minor changes to these pinctrl/GPIO parts.
>
> For each "GPIO" there are two registers for configuring the output and
> output enable signals which may come from other peripherals. Among these
> are two special signals that are constant 0 and constant 1 respectively.
> Controlling the GPIOs from software is done by choosing one of these
> signals. In other words the same registers are used for both pin muxing
> and controlling the GPIOs, which makes it easier to combine the pinctrl
> and GPIO driver in one.
>
> I wrote the pinconf and pinmux parts, but the GPIO part of the code is
> based on the GPIO driver in the vendor tree written by Huan Feng with
> cleanups and fixes by Drew and me.
>
> Datasheet: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Data%20Sheet%20V01.01.04-EN%20(4-21-2021).pdf
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Drew Fustini <drew@beagleboard.org>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Overall there is nothing wrong with this, and it is in nice shape.
Let's merge it:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
