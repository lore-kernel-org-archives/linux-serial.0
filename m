Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239EC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 11:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384763AbiEBLrd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355474AbiEBLrc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 07:47:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B935B7D1;
        Mon,  2 May 2022 04:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A5B5B8167C;
        Mon,  2 May 2022 11:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8066C385AC;
        Mon,  2 May 2022 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651491841;
        bh=oqdtyd9avy7ZtJQj+1RRxZjZ3hJSVX+nXxcXiTILq2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCGDjWs/gOH4rtObicyVK5bBYA27MmBVVkw7Rzo0Icy4igGxXwXSguT/NTopoD51V
         wMDfUWzNOWtcDDAh+WMDtebNq/+knKmZThw6OI6N9jWtL490nszOTrjS++4sGhX2wR
         hjCJoQdno3t6/4Dx29Ybn8SsihJD8gobBrJkjOAE=
Date:   Mon, 2 May 2022 13:44:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: Fix suspend/resume on S5L
Message-ID: <Ym/EAGq3IzW5rYwr@kroah.com>
References: <20220502092505.30934-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502092505.30934-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 02, 2022 at 06:25:05PM +0900, Hector Martin wrote:
> We were restoring the IRQ masks then clearing them again, because
> ucon_mask wasn't set properly. Adding that makes suspend/resume
> work as intended.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 1 +
>  include/linux/serial_s3c.h       | 3 +++
>  2 files changed, 4 insertions(+)

Does this fix a specific older commit?

And should it be backported to older stable kernels?

thanks,

greg k-h
