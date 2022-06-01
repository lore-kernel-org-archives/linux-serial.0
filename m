Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81085C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 15:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiFAPh4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355677AbiFAPhx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 11:37:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE22B1AE
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654097867; x=1685633867;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fhclYYO2TKhArGtsWs2l3T3omUSPUU+8y4xUw63O01Q=;
  b=EWgVLPgLJAsJ8RUzwkm0MwfJGgbQoLmuWwES5+wGPrgQ69sTTNNe0SoA
   4URXBgsl4PFdw4WZ5UgnH/mssmS/9PqG5EhryvxMtA2doxkRKcDolD3j3
   WW5GdmzaM+GFqr8nA5byN6CvD8plawuzmrpjr2uKVQfZG8ysq5bi5/1RR
   9icWuYi6Na5hih0tIc+Z8ld+iN4rpxG5akJBrC7txOoFnhT+3Ts7M9B+q
   PW4RUn+yHO9FhG+hsvgca8dZgUgXcBHsPruINj0eQml6lOhW/URAAvI8+
   6Ob/dg8+52mzO6xPqpSl3dXdbRnr+NkHvJFnwuoZXcFoqcvWozTknRD6p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274432053"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="274432053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:37:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="606328164"
Received: from ksulliv1-mobl.ger.corp.intel.com ([10.251.214.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:37:44 -0700
Date:   Wed, 1 Jun 2022 18:37:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Frank Wunderlich <frank-w@public-files.de>
cc:     angelogioacchino.delregno@collabora.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [BUG] mtk serial broken on mt7622 with 5.18.0
In-Reply-To: <23accb82-8f75-4773-4fad-b6218930da62@public-files.de>
Message-ID: <8e98f469-c495-88a1-258e-33178e453a17@linux.intel.com>
References: <CAGXv+5Hx7cRwNzLWrExcFGy=MMOc3-0EbqCanv2E0G_DKXLCgg@mail.gmail.com> <23accb82-8f75-4773-4fad-b6218930da62@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 1 Jun 2022, Frank Wunderlich wrote:

> Hi,
> 
> i get a serial console hang on booting my mt7622 bananapi r64 with 5.18.0
> 
> [    0.591802] Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
> [    0.599915] printk: console [ttyS0] disabled
> [    0.624563] 11002000.serial: ttyS0 at MMIO 0x11002000 (irq = 126,
> base_baud = 1562500) is a 16550A
> 
> git bisect points to this commit (cannot revert it alone)
> 
> 6f81fdded0d024c7d4084d434764f30bca1cd6b1 is the first bad commit
> commit 6f81fdded0d024c7d4084d434764f30bca1cd6b1
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Date:   Wed Apr 27 15:23:27 2022 +0200
> 
>     serial: 8250_mtk: Make sure to select the right FEATURE_SEL
> 
>     Set the FEATURE_SEL at probe time to make sure that BIT(0) is enabled:
>     this guarantees that when the port is configured as AP UART, the
>     right register layout is interpreted by the UART IP.
> 
>     Signed-off-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
>     Cc: stable <stable@vger.kernel.org>
>     Link:
> https://lore.kernel.org/r/20220427132328.228297-3-angelogioacchino.delregno@collabora.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  drivers/tty/serial/8250/8250_mtk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> merged by 6811a466d27b "Merge tag 'tty-5.18-rc7'"
> 
> reverted these 2 commits works for me
> e1bfdbc7daca 2022-04-27 serial: 8250_mtk: Fix register address for
> XON/XOFF character
> 6f81fdded0d0 2022-04-27 serial: 8250_mtk: Make sure to select the right
> FEATURE_SEL
> 
> have see this discussion [1], but can't manage to import mbox file to
> thunderbird yet
> 
> regards Frank
> 
> [1]
> https://lore.kernel.org/linux-arm-kernel/CAGXv+5Hx7cRwNzLWrExcFGy=MMOc3-0EbqCanv2E0G_DKXLCgg@mail.gmail.com/#t

The FEATURE_SEL change is already reverted to fix the problem but it 
didn't make into 5.18:

https://lore.kernel.org/linux-arm-kernel/Yot+xTBus04O9TUu@kroah.com/T/

-- 
 i.

