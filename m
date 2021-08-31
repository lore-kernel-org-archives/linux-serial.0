Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE1C4320E
	for <linux-serial@archiver.kernel.org>; Tue, 31 Aug 2021 08:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B125C6103E
	for <linux-serial@archiver.kernel.org>; Tue, 31 Aug 2021 08:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhHaIgI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240347AbhHaIgH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Aug 2021 04:36:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B910E6101C;
        Tue, 31 Aug 2021 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630398912;
        bh=Pns88gfzitfY2T3bP8utOQi67YcxT/YNMT+cCdTj+TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB3pD9Lnv0T1SincG1NLxCNS8lz7IJ/72EAasUGcnD6pcZZ1uk9uXWxjj7I/3cig6
         v4yOmN96eaIwbgu8cyGbAPg22s0mAb4OM3lvOqGDyvyR2qKj2poc73gGXZiPbWO6j/
         SRoAoqYx05phY2s0iZFV96E2Uq8doKLCQtox0pWYFxHWWFSYwPkIxF92e/jhvDgAN1
         d4pVoGp2EKIt6Phgr6HHvsis7DYruqCjiWeskV/ndapZlYrAdqdBJBt/MJVAXw69/s
         bsFIfajQZE/MtWPyeAJAb+qQAkLXbKamDm1RSpYel5NuejxTMa13kL6J6oG+FKtxpI
         6ayyNnaZSckZg==
Received: by pali.im (Postfix)
        id 6B42EEF2; Tue, 31 Aug 2021 10:35:10 +0200 (CEST)
Date:   Tue, 31 Aug 2021 10:35:10 +0200
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
Message-ID: <20210831083510.iiapfla7iy76fs3w@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
 <20210820172238.ekvo42s7oqxkeomt@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820172238.ekvo42s7oqxkeomt@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Friday 20 August 2021 19:22:38 Pali Rohár wrote:
> On Monday 09 August 2021 16:53:23 Pali Rohár wrote:
> > This patch series add support for baudrates higher than 230400 on
> > Marvell Armada 37xx boards.
> > 
> > Please review these patches as they touch both Device Tree bindings and
> > mvebu-uart.c driver.
> 
> Stephen, is this patch series OK now? Or is there any other issue?

PING?

> > Changes in v5:
> > * fixed yaml binding file
> > 
> > Changes in v4:
> > * converted armada3700-uart-clock documentation to YAML
> > * split documentation changes into two commits:
> >   - first which adds clock documentation
> >   - second which updates UART documentation
> > 
> > Changes in v3:
> > v3 is rebased on top of Linus master branch and all already applied patches
> > were dropped. There are no changes in patches itself since v2.
> > 
> > Pali Rohár (6):
> >   math64: New DIV_U64_ROUND_CLOSEST helper
> >   serial: mvebu-uart: implement UART clock driver for configuring UART
> >     base clock
> >   dt-bindings: mvebu-uart: document DT bindings for
> >     marvell,armada-3700-uart-clock
> >   dt-bindings: mvebu-uart: update information about UART clock
> >   arm64: dts: marvell: armada-37xx: add device node for UART clock and
> >     use it
> >   serial: mvebu-uart: implement support for baudrates higher than 230400
> > 
> >  .../bindings/clock/armada3700-uart-clock.yaml |  57 ++
> >  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
> >  .../arm64/boot/dts/marvell/armada-3720-db.dts |   4 +
> >  .../dts/marvell/armada-3720-espressobin.dtsi  |   4 +
> >  .../dts/marvell/armada-3720-turris-mox.dts    |   4 +
> >  .../boot/dts/marvell/armada-3720-uDPU.dts     |   4 +
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  15 +-
> >  drivers/tty/serial/Kconfig                    |   1 +
> >  drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
> >  include/linux/math64.h                        |  13 +
> >  10 files changed, 682 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > 
> > -- 
> > 2.20.1
> > 
