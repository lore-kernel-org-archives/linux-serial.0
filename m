Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ABEC433E6
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BB92086A
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf4uaxGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgH1Mvh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgH1Mvf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 08:51:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E939C06121B
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 05:51:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so1153744ljk.9
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSrvv0FJmitf6q9JxmYipGO4Y6PZy6cFkX1VzqR3xEU=;
        b=Pf4uaxGE3D9QkcwZ3m7v40UpPYGsLMXlPXzxXdofFxgCOrudLrDJjKqDtapXdZT1me
         U/qpgdyHur4b2ylpfOmLYfGRbbgioYR4DE8hUX9n3OD1PsJjx4bY6DfOPPLZ+nR7uoPR
         t2fPwIQzvGmoNipg0tib+zvmAuyzH0asX7NHoXYzOS+c1S9GjWZHK3ZfK4tTEAShELZn
         UQgYkmIIjXX9+QwSVHsgwAXyE2t1Y98bukfmK6CGzaKFvQbixk0LvK3eWs+XS6UxLeZr
         H6WwkkQfXpaJarmhsieD/FOJieotOGDuhvpWyJnLOHQ5bvJH2PkEoyOghCRX7loqwBdo
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSrvv0FJmitf6q9JxmYipGO4Y6PZy6cFkX1VzqR3xEU=;
        b=SIX24LYvtHushvK/2qiTh2lcckNBDR0zyJ/1Br0kt45RoiTd9+XzhryvKUUd3SKBnP
         7EomTJdkJ3euu5thYJqrUcFV2aEHNveXmtQjAHw8WSZMz/+RO2F0uEubb45kdaWwgp//
         MJUgB/dlqvVuGAWqABDK4GYf0bv2sRZqawz+vl9nKhJJ6Fjoxda1t3fnol2l8uKvfM2p
         Ui7JzoKfMRiooCbI0OaQ9PH7JbcZ0t5Ytoe+JjdDyAXvyhoUk9cpDL0PIQkB9VZkuReR
         vDjhVZ2KpjtHhSwLGn4y470GmQtC+kee0cxYDoB70FEZfiXls+YPkSHEi49VgTvQ0onr
         +Fdw==
X-Gm-Message-State: AOAM5317QZu8PigeVp925DYPCcn1c7xIXfHHeSlXeJt3gWDLvQ/6PYyi
        +B7eL09dJsKmkilsO94XflqF7N1euGQvXFblE6MYvA==
X-Google-Smtp-Source: ABdhPJzTyH+jeLvxiBsauaVxTH5hij7/x8BNA+Ly/857QQXdScYFOsf9kjoayIwSsdP0TIKRwlItOzGM4zkgBEGoiX8=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr872506ljo.286.1598619091424;
 Fri, 28 Aug 2020 05:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org>
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 14:51:20 +0200
Message-ID: <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 25, 2020 at 9:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> This is a v3 of cleanup of i.XM 8 bindings and DTSes.

If you are going to be working a lot on Freescale SoC code going forward
I wouldn't mind if you could add yourself as maintainer for the
Freescale pin controller and GPIO at least, I already have high trust
in you in general so if the Freescale maintainers also have that I think you
should just sign up as maintainer. This makes it easier to do pull requests
and things like that.

Yours,
Linus Walleij
