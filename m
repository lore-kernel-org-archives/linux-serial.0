Return-Path: <SRS0=jZzm=CJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E17AC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 03:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D882100A
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598844299;
	bh=F8SGH7dboaPQz17xUfKd3KTHNfAbnW1y3V3zbE7JbIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DW2qMUtREHSEFVKk3lk5uZZnEiqKJWmj0XQfAl/RCikOC1DjVXWkn+Woet7kviYm9
	 6XSUpHPurLM9Y3PKsvwUNPG2BojcJofz2SbGDqe4LrGhewO8ryDm3Lc4boiWxsl4LE
	 KyHsXb13sF1gQYQOOjd9Qv3EYCUUegX4tFDtsECM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHaDYv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgHaDYr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 30 Aug 2020 23:24:47 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E072920E65;
        Mon, 31 Aug 2020 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598844286;
        bh=F8SGH7dboaPQz17xUfKd3KTHNfAbnW1y3V3zbE7JbIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gv/l+LgWt4CYKE0uf2j1yLMnDp4c01Jmy98F14D0dFwXTuUCBqRaklh1YL/8h9Krx
         4EZLCF45EDzHmlytvCraViLBHGfcJLoV6hXH8voWS2ph5uQZZ14zWPOaoh23gPXZ7M
         dXLytT9F8UB21s71Mmvto6H5U5+M38sXnBHG7Rnw=
Date:   Mon, 31 Aug 2020 11:24:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 18/19] arm64: dts: imx8mq-evk: Add hog suffix to
 wl-reg-on
Message-ID: <20200831032438.GH4488@dragon>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-19-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-19-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 25, 2020 at 09:35:35PM +0200, Krzysztof Kozlowski wrote:
> According to device tree specification, device node names should be
> somewhat generic and reflecting the function of the device so add the
> "hog" suffix to wl-reg-on GPIO hog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
