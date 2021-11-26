Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE3C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 15:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353970AbhKZPlA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 10:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhKZPi7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 10:38:59 -0500
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 07:29:19 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4BC0613F4;
        Fri, 26 Nov 2021 07:29:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BF2622A6;
        Fri, 26 Nov 2021 15:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3743DC93056;
        Fri, 26 Nov 2021 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637940557;
        bh=tIcKsGkixjO2bAVBkpPEOSXSKG6bYATN9ROIsuTm8ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUohIP4xtZGwU92wBJBPFqGd15/YAX6U0lrrzpuHKTnyTH6r0A9GudAzgyci3LzQQ
         5hQAtQZba79Vl4Z8hyxiOrjJzGdgxyyGBqZ/DKodWmbhkKGtr0fuoCbU1DdcS0umru
         oqlua9GHiJt/+uyjAnZ/AWU2VTChfBJNbc1V0Brs=
Date:   Fri, 26 Nov 2021 16:28:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: do not request memory region twice
Message-ID: <YaD9JW8i9vxmWWhk@kroah.com>
References: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 26, 2021 at 03:39:25PM +0100, Lino Sanfilippo wrote:
> The driver attempts to request and release the IO memory region for a uart
> port twice:
> 
> First during the probe() function devm_ioremap_resource() is used to
> allocate and map the ports memory.
> Then a combo of pl011_config_port() and pl011_release_port() is used to
> request/release the same memory area. These functions are called by the
> serial core as soon as the uart is registered/unregistered.
> 
> However since the allocation request via devm_ioremap_resource() already
> succeeds, the attempt to claim the memory again via pl011_config_port()
> fails. This failure remains unnoticed, since the concerning return value is
> not evaluated.
> Later at module unload also the attempt to release the unclaimed memory
> in pl011_release_port() fails. This time the failure results in a “Trying
> to free nonexistent resource" warning printed by the serial core.
> 
> Fix these issues by removing the callbacks that implement the redundant
> memory allocation/release.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
> 
> This patch was tested on a 5.10 Raspberry Pi kernel with a CM3.

What commit id does this change fix?

thanks,

greg k-h
