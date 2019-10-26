Return-Path: <SRS0=cigD=YT=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7298ACA9EBE
	for <linux-serial@archiver.kernel.org>; Sat, 26 Oct 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486DE21897
	for <linux-serial@archiver.kernel.org>; Sat, 26 Oct 2019 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096444;
	bh=xWOCyH4LpE2A2ZS3DvRRqKw8BvJSQw43usiPJKaUMvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IscQexKzmEUR6hLVvnAasQRI4jZmjSw3rTn1sJDCnE1Uu1jlLTqwRcwHR+0wsx6+8
	 luXM/LXalI9DazPIoIEYX3VGK8gcpNUZ9qBdTSKZ2CMVePxFTOl5I8H34n/grplBPl
	 TZzrvTwtKfMYR9fMq/qhQkHlQ6Mr84V2p7yx8QLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfJZN1S (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfJZN1S (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Oct 2019 09:27:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066BF20867;
        Sat, 26 Oct 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096436;
        bh=xWOCyH4LpE2A2ZS3DvRRqKw8BvJSQw43usiPJKaUMvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yON2IQoQY/Zk1ndYAF3l8modBN8uczhSPyVFlAsxCQszQq7en5ohxiJRiCx27vIbx
         Yz4Nv1Fh3Oe+nVr0tn7wux/YNYTR/d6tpU/WhhjLd4T9aKSue6CflWKxTAxYO56ztE
         vUMOSltQ4ZhKbP3sestArcFAw40ddVAAff7iRj6k=
Date:   Sat, 26 Oct 2019 21:26:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/5] Add initial support for S32V234-EVB
Message-ID: <20191026132657.GO14401@dragon>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <20191016131728.GA56859@kroah.com>
 <VI1PR0402MB28630943CC0820644D26919CDF920@VI1PR0402MB2863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB28630943CC0820644D26919CDF920@VI1PR0402MB2863.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 16, 2019 at 04:54:58PM +0000, Stefan-gabriel Mirea wrote:
> On 10/16/2019 4:17 PM, Greg KH wrote:
> > 
> > I've taken patch 3 in my tty-next tree.  The others should probably go
> > through an arm-specific tree, right?
> 
> Thank you very much, Greg! That was all for the tty tree.
> 
> I think that the other patches should go to the following trees:
> * git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git:
>     patches #1 and possibly #4 (as it covers arch/*/boot/dts/);
> * git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git:
>     patches #2, #5 and possibly #4 (as it covers arch/arm64/boot/dts/)
> * git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>     possibly patch #4 (as it covers arch/arm64/boot/dts/freescale/fsl-*)
> 
> As a general question, would it be any chance to have the device tree
> included in v5.4 (along with its compatible documentation and config
> definition, without enablement)? That is, only the patches #1, #2 and
> #4, because #3 is a cosmetic change and #5 enables the new configs by
> default. That would complete a minimal support for S32V234-EVB, together
> with the LINFlexD UART driver which was accepted.
> 
> From the development process documentation[1]: "An occasional exception
> is made for drivers for previously-unsupported hardware; if they touch
> no in-tree code, they cannot cause regressions and should be safe to add
> at any time".
> 
> I know that it mentions only drivers and not device trees, but from the
> history is seems that there have also been dts/dtsi files added outside
> of merge windows, such as:
> * arch/riscv/boot/dts/sifive/fu540-c000.dtsi;
> * arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts;
> * arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts;
> * arch/xtensa/boot/dts/lx200mx.dts;
> * arch/xtensa/boot/dts/kc705.dts;
> * arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi;
> * arch/arm/boot/dts/omap3-beagle-xm-ab.dts;
> * arch/arm/boot/dts/at91-sama5d3_xplained.dts;
> * arch/arm/boot/dts/am335x-boneblack.dts;
> * arch/powerpc/boot/dts/charon.dts.
> 
> I am sorry if my question is inopportune, I am definitely not trying to
> rush anyone. I just ask because this has been under review for some
> time and all the feedback has been addressed. We would really appreciate
> to have this SoC and board supported in the following LTS release if
> there are no other issues.

Sorry, no.  It happens occasionally that non-fixing patches are merged
during -rc time, mostly because they are supposed to land mainline
during merge window, but missed the window for some reason, like
subsystem maintainers did not send pull request to Linus in time.
Also the patches are only taken in early -rc like rc2.

Shawn
