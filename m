Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF30DC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E9C61108
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 21:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKCVou (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Nov 2021 17:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKCVot (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Nov 2021 17:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8393A610E7;
        Wed,  3 Nov 2021 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635975732;
        bh=dXG7SJaQ86pYqJemvGzySTPjN5HOWyXBZ8H3AZzV0mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDQvJJmqgrYtDTkFGpnKklT993BQjy5VMDYDDmPrbFmh2RiyVLdnOe/+edUVPy3LU
         WYMzlPDCnRmpJyg6xuKz6tWbaIm8M3pBUwD2I4BBKotHWXH4eviCrKe4thQTmj+/lh
         Vi3+Nvq0HvDovb94YsdTyUXcWj15fbzbq1kOOOLPcVNiSh2evrDvlC5yiPBoat1dqJ
         b/9cBsZCykHL84fliTZ/QNO4BnC59EnxpojW/fk4nQuOr+HZajtvhIKu+ucyF1dwgQ
         XKCZCNPI5rKQDvYMOoB/b3cPgF6nJfaZ5+J1Qno38WGRaxYzjQVh9zXnA05uXL4DcJ
         gw6jpeNfeOhfQ==
Received: by pali.im (Postfix)
        id 0FB206FC; Wed,  3 Nov 2021 22:42:09 +0100 (CET)
Date:   Wed, 3 Nov 2021 22:42:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20211103214209.azo2z3z4gy7aj5hu@pali>
References: <20210930095838.28145-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210930095838.28145-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thursday 30 September 2021 11:58:32 Pali Rohár wrote:
> This patch series add support for baudrates higher than 230400 on
> Marvell Armada 37xx boards.

Stephen, Gregory, are there any issues with this patch series?
If not, could you take them?

> Changes in v7:
> * fixed lint errors in yaml binding file
> 
> Changes in v6:
> * fixed yaml binding file and dts files
> 
> Changes in v5:
> * fixed yaml binding file
> 
> Changes in v4:
> * converted armada3700-uart-clock documentation to YAML
> * split documentation changes into two commits:
>   - first which adds clock documentation
>   - second which updates UART documentation
> 
> Changes in v3:
> v3 is rebased on top of Linus master branch and all already applied patches
> were dropped. There are no changes in patches itself since v2.
> 
> Pali Rohár (6):
>   math64: New DIV_U64_ROUND_CLOSEST helper
>   serial: mvebu-uart: implement UART clock driver for configuring UART
>     base clock
>   dt-bindings: mvebu-uart: document DT bindings for
>     marvell,armada-3700-uart-clock
>   dt-bindings: mvebu-uart: update information about UART clock
>   arm64: dts: marvell: armada-37xx: add device node for UART clock and
>     use it
>   serial: mvebu-uart: implement support for baudrates higher than 230400
> 
>  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
>  include/linux/math64.h                        |  13 +
>  6 files changed, 667 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> 
> -- 
> 2.20.1
> 
