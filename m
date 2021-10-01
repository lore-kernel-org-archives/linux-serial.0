Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5AC433FE
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843E661A8B
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 12:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354334AbhJAMNi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354324AbhJAMNi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 08:13:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9AE561A56;
        Fri,  1 Oct 2021 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633090313;
        bh=Bvy+7X1IcIDRcHyDyMAbTvUl3nHvygA3YktJ+oiCrcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7U9VDDpYX0ZUwtPnEO56MFcniGYqvbSsSx9pflxdaVOgSJUyodGnMeiqQ6CTaByk
         G3H6vIMgHU8TuTqQMmE/rlpvdQgNwvmhm2cHD49GxeT8dtoLPu2Ez0GaERSW8lzftu
         P1xZ1daUu/9RAi0dJdvXzfIvZWDInO2F6GRneepwoUqL0RMrHCe07heU8kCu8fSdvC
         JQbsqGvVhfzlHS08xTAPyshoZTnNJxmkqHtBHlV4cXQIScgolopdLNhsRpe3OkHrMi
         BGQ1gN/Upw0B8nWWw8Ogih/EQCQHUzh3lM9F1F03UdO44bcvOsRe4ST9ol3aApAR2C
         RYuHokUNuAGjw==
Received: by pali.im (Postfix)
        id 6F5A2821; Fri,  1 Oct 2021 14:11:51 +0200 (CEST)
Date:   Fri, 1 Oct 2021 14:11:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
Message-ID: <20211001121151.ofydfrf55hmh6gro@pali>
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

Gregory, could you please review this patch series?

On Thursday 30 September 2021 11:58:32 Pali Rohár wrote:
> This patch series add support for baudrates higher than 230400 on
> Marvell Armada 37xx boards.
> 
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
