Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F9C4320A
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 08:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146B361075
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 08:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhHIIHN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhHIIHM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 04:07:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4152A61055;
        Mon,  9 Aug 2021 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496412;
        bh=Ikg3meFEMeJ+TjtVqcKRIE45ORfSRMuo9yhavDrGMbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7W3xIRaRXC+bQGotOsAaPGnHZK3XsgxMJKc0jAvWVbK8WfMFJ6cfTtuoXiZdax4u
         4yfA3QPBz5LYGywvyjSFcxM340PAbSqLVQZz7FqNQdTy9sCw5dseLsn6DhVlI2QyYY
         5rfSfBB9e9j16s5eNX5QmW/NkjNIzeaPOb4Wm2ZoFGN0D5uOi61kJQXg+Rx/mV6wik
         VgJ6FY4vlwAEBCclm5EQnPHe1dAvhLM1It3Yd9ByzkGeWRQ7ZwcTZPcfLewlGVBQVq
         bi5ZAYY8cJ9AKlX/dJhXc78sp/m3K5AzMfvCI7EMBYphwcVL7SHLTgmXlMBnycHu+8
         OCd+ykIriSTzQ==
Date:   Mon, 9 Aug 2021 16:06:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s32@nxp.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 0/8] arm64: dts: initial NXP S32G2 support
Message-ID: <20210809080642.GP30984@dragon>
References: <20210805065429.27485-1-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 05, 2021 at 02:54:21PM +0800, Chester Lin wrote:
> Hello,
> 
> Here I'd like to propose a patchset, which is initial upstream support for NXP
> S32G2. S32G is a processor family developed by NXP for automotive solutions,
> such as vehicle networking and automotive high-performance processing. This
> series focuses on S32G2, which is the latest generation we can find at the
> moment. As the first round to support S32G2, this patchset only enables basic
> components and interfaces the SoC must have while kernel booting, which aims
> to have minimum hardware enablement for these two boards, S32G-VNP-EVB and
> S32G-VNP-RDB2. The concepts of how these boards work are originated from the
> downstream kernel tree[1] developed by NXP, which provides lots of details
> about the SoC S32G274A and its integrated boards. This series has been
> verified with downstream ATF[2] & U-Boot[3] based on the ATF boot flow.
> 
> Thanks,
> Chester
> 
> [1] https://source.codeaurora.org/external/autobsps32/linux/
> [2] https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/
> [3] https://source.codeaurora.org/external/autobsps32/u-boot/
> 
> Chester Lin (8):
>   dt-bindings: arm: fsl: add NXP S32G2 boards
>   dt-bindings: serial: fsl-linflexuart: convert to json-schema format
>   dt-bindings: serial: fsl-linflexuart: Add compatible for S32G2
>   arm64: dts: add NXP S32G2 support
>   arm64: dts: s32g2: add serial/uart support
>   arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
>   arm64: dts: s32g2: add memory nodes for evb and rdb2

The dts changes look good to me.  I will pick up the series once
bindings gets acked by Rob.

Shawn

>   MAINTAINERS: Add an entry for NXP S32G2 boards
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   7 +
>  .../bindings/serial/fsl,s32-linflexuart.txt   |  22 ---
>  .../bindings/serial/fsl,s32-linflexuart.yaml  |  66 +++++++++
>  MAINTAINERS                                   |   6 +
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 129 ++++++++++++++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  29 ++++
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |  33 +++++
>  8 files changed, 272 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> 
> -- 
> 2.30.0
> 
