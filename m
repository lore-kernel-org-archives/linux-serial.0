Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29CEC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EF5613A2
	for <linux-serial@archiver.kernel.org>; Mon,  4 Oct 2021 08:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJDINf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Oct 2021 04:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhJDINd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Oct 2021 04:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43AF061130;
        Mon,  4 Oct 2021 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633335104;
        bh=X+/eVDLqQ/v8O30Qd97NCA1wWkaSu4VjEg4Oj5YU8LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzZYTXA6E88DJoc1kd+I4DOQAsX5k8SpwmTG/Y8JBFs78Sw2vvSxCtY79anw4e/7J
         YjbO68kAz7c56uSWrR7A8IrN5kOgFA60522coZNWbJC/iWokliNK1QjWDkTGP8iMIy
         fN67nzZG65FutzFcf4Z19rvLc3iFHv4rvdiuAbzVRzfKumIowKQ30oBsktDLjPT/HZ
         EHr77Ez9myBlhqZmH+wREImUsj3NYYtkUTQqEDyh1AqAgphfPZiD7IsYkMChtMwDW9
         t9hS0A5U2XbBLCOCORyN0E+r14UvRU0IjWcHo11MSaIl/KvQViicuh4cy6XZo93r8w
         MoWkzK1mP3KSw==
Date:   Mon, 4 Oct 2021 16:11:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s32@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH v2 0/8] arm64: dts: initial NXP S32G2 support
Message-ID: <20211004081136.GF15650@dragon>
References: <20210908064528.922-1-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908064528.922-1-clin@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 08, 2021 at 02:45:20PM +0800, Chester Lin wrote:
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
> Changes in v2:
> - dt-bindings:
>   - Rename the compatible vendor string to "nxp," for s32g2.
>   - Drop the specific description "S32V234 SoC".
>   - Fill my name in the maintainer field. I tried to contact the authors
>     of fsl,s32-linflexuart.txt but got no response.
>   - Remove redundant minItems/maxItems from compatible properties.
>   - Remove the redundant example from fsl,s32-linflexuart.yaml.
> - dtsi/dts:
>   - Add a SoC description in s32g2.dtsi.
>   - Add an interrupt-affinity to the pmu node.
>   - Move the psci node into the "/firmware" node.
>   - Remove the redundant properties and white lines in DT.
>   - Remove the wrong interrupt specifier from the gic node.
>   - Specify the range and cell-size of /soc [0 - 4 GiB].
>   - Correct the reserved size of GICR to 512Kbytes [0x80000].
>   - Add new Signed-off-by to the DT uart patch.
>   - Fix copyright strings.
>   - Revise reg properties based on new cell-size.
>   - Move the serial/uart aliases from the SoC .dtsi to board .dts files.
>   - Correct the model string of RDB2.
>   - Add comments for the uart markings on PCB.
>   - Adjust RAM size comments of memory nodes.
>   - Convert reg addresses of memory nodes into hex format.
> - MAINTAINERS
>   - Add information of reviewers.
> 
> Chester Lin (8):
>   dt-bindings: arm: fsl: add NXP S32G2 boards
>   dt-bindings: serial: fsl-linflexuart: convert to json-schema format
>   dt-bindings: serial: fsl-linflexuart: add compatible for S32G2
>   arm64: dts: add NXP S32G2 support
>   arm64: dts: s32g2: add serial/uart support
>   arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
>   arm64: dts: s32g2: add memory nodes for evb and rdb2
>   MAINTAINERS: add an entry for NXP S32G boards

Applied all, thanks!
