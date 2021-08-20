Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A83C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 20 Aug 2021 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F0661101
	for <linux-serial@archiver.kernel.org>; Fri, 20 Aug 2021 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhHTRXT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhHTRXT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5341D61154;
        Fri, 20 Aug 2021 17:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629480161;
        bh=NtBbpRqS1/eYwYOxSrX1KDFfMTuxY8jViL2MBLXG2Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIh2j4rnKv4rLSL2S/xW+E95f5meZHEUMlJhw7ffG+4wWQjELyVecEyBc7fr0PeHD
         1jwPDMM01WLqV2cUQgupVegZwFv622VKVHqnfWImWZlXCtvIkGky388p5sKRqY4w8g
         6wL8mKaTox1a0v7Lv3CRgXSKM9E+gArd9XG7Dg7MFVJ5zR5L1Ec85tL221/y1adKDc
         jvwZW6gwD71iJK4Z5nRas07sD/hhBdv0vMjssStMB2lFJXAp+WzIe+KV8bsOwpmLFz
         FQB3CO/gs0hJAX+vuzzWH7PFqp9PrMu9ftVvhO8MiTxiac+edyy1hkq+4bTjOVTI8b
         7lrzKaS25px/Q==
Received: by pali.im (Postfix)
        id 22CDAB8A; Fri, 20 Aug 2021 19:22:39 +0200 (CEST)
Date:   Fri, 20 Aug 2021 19:22:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20210820172238.ekvo42s7oqxkeomt@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Monday 09 August 2021 16:53:23 Pali Rohár wrote:
> This patch series add support for baudrates higher than 230400 on
> Marvell Armada 37xx boards.
> 
> Please review these patches as they touch both Device Tree bindings and
> mvebu-uart.c driver.

Stephen, is this patch series OK now? Or is there any other issue?

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
>  .../bindings/clock/armada3700-uart-clock.yaml |  57 ++
>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
>  .../arm64/boot/dts/marvell/armada-3720-db.dts |   4 +
>  .../dts/marvell/armada-3720-espressobin.dtsi  |   4 +
>  .../dts/marvell/armada-3720-turris-mox.dts    |   4 +
>  .../boot/dts/marvell/armada-3720-uDPU.dts     |   4 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  15 +-
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
>  include/linux/math64.h                        |  13 +
>  10 files changed, 682 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> 
> -- 
> 2.20.1
> 
