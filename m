Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB6C48BD1
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881FC61354
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFIMj6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhFIMj5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 08:39:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C52E6139A;
        Wed,  9 Jun 2021 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623242266;
        bh=j1He01BL+/BPL/pQH/frjE9ujMsnGBiizbfO/VqeQWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwccwyeTzNzTmexBM1MPkKNPl9QgsGQHQBo6OOMqHvEtZDFdLARZVs/ZDqjpErcvK
         YUMwi5BoLnSFjM0Z3SmcZ7LNbpz7ngCV+/iCkm57q2Bg4x6hp0d2OjXwx/RKHJLgrj
         mgrv+9oOxHldciqn3SYhdclvocihkClSwh+YMbCA=
Date:   Wed, 9 Jun 2021 14:37:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] serial: sh-sci: Stop dmaengine transfer in
 sci_stop_tx()
Message-ID: <YMC1+n/w74x33bLX@kroah.com>
References: <20210609014902.271237-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609014902.271237-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 09, 2021 at 10:49:02AM +0900, Yoshihiro Shimoda wrote:
> Stop dmaengine transfer in sci_stop_tx(). Otherwise, the following
> message is possible output when system enters suspend and while
> transferring data, because clearing TIE bit in SCSCR is not able to
> stop any dmaengine transfer.
> 
>     sh-sci e6550000.serial: ttySC1: Unable to drain transmitter
> 
> Note that this patch uses dmaengine_terminate_async() so that
> we can apply this patch into longterm kernel v4.9.x or later.

What should it be using instead of this?  Don't worry about older
kernels (you didn't cc: stable@vger.kernel.org so I guess you don't
either), get it right here and then we can deal with backports later.

thanks,

greg k-h
