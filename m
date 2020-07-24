Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D336C433E3
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 09:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3322074F
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595583560;
	bh=+UpGlzTq+I8TiROd3n+vJD7WBiaJrWE5fpqKr9/90os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fYWuhHuh+ieKu9ACVfyMy+ME+Tn+LgzlKWVkdo6vGCPwVl3DxKGa4qhCvpJgFPSZJ
	 h9n4KDJ4dbwslNGADrHJK6NGrlDr50XIxHUaFgXmZmuuT5FGDHLjSd9G+dkqpqFc9d
	 al61hXp8izx6W3Vz75QgFbjBr0AApJAw9yJWlku8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXJjT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJjT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 05:39:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F689206EB;
        Fri, 24 Jul 2020 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583559;
        bh=+UpGlzTq+I8TiROd3n+vJD7WBiaJrWE5fpqKr9/90os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBfMOEy0HI+xhJnJIFMUVpNimwi9UF/PbA/znpe6jC4KK+kqWWsIKY7s5QATh358W
         8L6+ifoHPSaIIFEJydZh/exj3Ym1kFMt6003TRIe1XOI7HMpGRPigtHX+yzAG4uXGd
         5Bz5T5KlP0T5lDe1ub60VcLkcPvVzWUstOp8cxoA=
Date:   Fri, 24 Jul 2020 11:39:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: Re: [PATCH v4] serial: exar: Fix GPIO configuration for Sealevel
 cards based on XR17V35X
Message-ID: <20200724093920.GA4170651@kroah.com>
References: <alpine.DEB.2.21.2007221605270.13247@tstest-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007221605270.13247@tstest-VirtualBox>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 22, 2020 at 04:11:24PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based devices are inoperable on kernel versions
> 4.11 and above due to a change in the GPIO preconfiguration introduced in
> commit
> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
> cards to the value (0x00) used prior to commit 7dea8165f1d
> 
> With GPIOs preconfigured as per commit 7dea8165f1d all ports on
> Sealevel XR17V35X based devices become stuck in high impedance
> mode, regardless of dip-switch or software configuration. This
> causes the device to become effectively unusable. This patch (in
> various forms) has been distributed to our customers and no issues
> related to it have been reported.
> 
> Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> ---
> 
> Revised based on comments received on previous submission
> https://www.spinics.net/lists/linux-serial/msg39482.html
> 
> It had previously passed checkpatch.pl in "patch" mode (--patch)
> without errors. However, when running it in "file" mode (-f) it finds
> stling issues that did not show up in "patch" mode. These styling
> issues are now resolved according to checkpatch.pl. It appears my
> editor (and email client) were automatically converting tabs
> to spaces.
> 
> Let me know if the tabs are still being converted to spaces somehow
> or if anything else looks wrong.

All looks good, thanks for sticking with it, now queued up.

greg k-h
