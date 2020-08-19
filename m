Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4E1C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E063620772
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 05:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597816012;
	bh=Reby7qH/4xzkhdOcZj+ZaIMIIOdxohp746qpjKaPSwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qq+n4VNa3Xz+DGaamHPEDq6zuDM+uJ1sAbhs98Hc8/egNUIKXeggE0RLsxhF2YgKs
	 Gj9eu5WpVzqr94hGAb5XHt9WYl0In4hLhpxsFMKRzwbuJ6uzYu2XaburvTLB554wGv
	 CNOnsZZl6b8+E4FFOePOP6Vy8kfigWUg90h5dUWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgHSFqw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgHSFqw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 01:46:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD6720738;
        Wed, 19 Aug 2020 05:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597816011;
        bh=Reby7qH/4xzkhdOcZj+ZaIMIIOdxohp746qpjKaPSwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgbbMlw10i4pVlb5KZjScbZ7GdX4LXMjaEvGked69Dj2zvA7txtxhkrHzP6qzudiG
         JroN++uMXBWHJ2x8Pwnr3ybKNobiO6WHx/eWhXnzp8zESO2X7Jk0OT3MvzgGTFWlxG
         cg3H6K2/tt+OkG8YankE/OLr4Tk0Z+XbhOiltApQ=
Date:   Wed, 19 Aug 2020 07:47:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Seiya Wang <seiya.wang@mediatek.com>, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 30/32]
 arch/arm64/boot/dts/mediatek/mt8192.dtsi:8:10: fatal error:
 dt-bindings/clock/mt8192-clk.h: No such file or directory
Message-ID: <20200819054714.GA846914@kroah.com>
References: <202008191002.dncQiI7M%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008191002.dncQiI7M%lkp@intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 19, 2020 at 10:49:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   831b6a948800e27475276c331624defb6b084545
> commit: 546947e5d94e1b24768736fffbf832c29ce3f495 [30/32] arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile
> config: arm64-randconfig-s031-20200818 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-183-gaa6ede3b-dirty
>         git checkout 546947e5d94e1b24768736fffbf832c29ce3f495
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/boot/dts/mediatek/mt8192-evb.dts:7:
> >> arch/arm64/boot/dts/mediatek/mt8192.dtsi:8:10: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
>     #include <dt-bindings/clock/mt8192-clk.h>
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

I've dropped this patch from my tree now, thanks for the report.

greg k-h
