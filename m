Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85CCC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 08:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9632E61353
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhEUI5l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 May 2021 04:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233621AbhEUI5k (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 May 2021 04:57:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10DB961363;
        Fri, 21 May 2021 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621587377;
        bh=YT+RhOJSsa1QTgVRdxAJ4vUT6y0Q6065b7jPuI/rx7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyF85jRAU7C7VbFuv1f2gyHORo3n6K40ZxO0Vqp1MbmMSZWeEbGj4FXumLnhegodV
         4ejOqnFx9J08fMWgEYcgnoPttAdNs8mptB3GhcaarTpxnIKSpiZFyQQZ99yFAupHre
         qrtEdPXBZaMYlr1nZ1XMwiXx0JQHv7hOzscRUuvL6O4YAjyUr38lN/Yp+FoPyZ0Gy9
         l31FuV2cztoqAL8vZAHRzPu8lkBVUB0ImYWVTKGmnNn9vKNfp2dFO2q4ZJe7NiZPmI
         gJlpDhpNEaOu9Sn1HUPKJKRM0RWtbbVr5L76H/TbCqxoqXS87aEu+CjFQOQiyyUwA6
         sIkLqTZL3JyLw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lk0x6-0005Du-B4; Fri, 21 May 2021 10:56:16 +0200
Date:   Fri, 21 May 2021 10:56:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linuxarm@huawei.com, huangdaode@huawei.com,
        tangzihao1@hisilicon.com
Subject: Re: [PATCH 00/11] tty: serial: Fix some coding style issues
Message-ID: <YKd1sJRRPpNQF+v+@hovoldconsulting.com>
References: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 18, 2021 at 09:57:07AM +0800, Jay Fang wrote:
> From: Zihao Tang <tangzihao1@hisilicon.com>
> 
> This patchset fixes some coding style issues reported by checkpatch.pl.

Please don't send (checkpatch) style cleanups for code outside of
staging unless you're also doing some real changes to the code in
question as this only makes it harder to do code forensics and backport
fixes for no good reason.

Some more discussion can be found here:

	https://lore.kernel.org/r/YKYcFfKiHT39Gyey@hovoldconsulting.com

> Zihao Tang (11):
>   tty: serial: 21285: Fix some coding sytle issues
>   tty: serial: amba-pl010: Fix 2 coding style issues
>   tty: serial: amba-pl011: Replace the unsuitable spaces with tabs
>   tty: serial: amba-pl011: Remove initialization of static variable
>   tty: serial: apbuart: Fix some coding sytle issues
>   tty: serial: atmel: Fix some coding style issues
>   tty: serial: bcm63xx_uart: Fix some coding style issues
>   tty: serial: clps711x: Fix some coding style issuses
>   tty: serial: digicolor: Use 'unsigned int' instead of 'unsigned'
>   tty: serial: dz: Use 'unsigned int' instead of 'unsigned'
>   tty: serial: earlycon-arm-semihost : Fix some coding style issuses

Johan
