Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D3C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576762076A
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592225459;
	bh=opXdZXt2DFTPHJA+O55Kbh4HKBceFmOFhEyjhINS4eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VxKamIZBGzGZITjJqFNGnBh8fMFEprTx5HSYrd0kD6CkfdhUhEOyMIlri5IEcaXoX
	 NUdX7JRCF8bwltI6EV8XzDTXy/SWpi8wlSD0XaBL4Mg+vrfZcX5tClDNSLYWby2grP
	 BYF1cfUMOWH1rOl/puoAwRQH7FfvMqmRPaNA/uOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgFOMu6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbgFOMu6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4889206B7;
        Mon, 15 Jun 2020 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592225458;
        bh=opXdZXt2DFTPHJA+O55Kbh4HKBceFmOFhEyjhINS4eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vz306RLiesNwax8KplFcYnagKnClmMl58mSEPOq40mt50jZY+UPNYS9wsGAby/EZI
         iH5tvl8s9qChdjSfTmDqHPFHBoqgpOGOGbSziPI3KfWS/Kha0gAQS754BoAokyk9eW
         SPuj2kVwkCIT7twI8wPFXBgMfgkDw9IkWfNhTc38=
Date:   Mon, 15 Jun 2020 14:50:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, krzk@kernel.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [RFC PATCH] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Message-ID: <20200615125045.GA946844@kroah.com>
References: <CGME20200615124355epcas5p446ae2f1b63331ef87334cd7d696c3c43@epcas5p4.samsung.com>
 <20200615122609.71884-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615122609.71884-1-m.shams@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 15, 2020 at 05:56:09PM +0530, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following warning:
> "IRQ index 1 not found" on recent platforms.
> 
> This patch re-factors the IRQ resources handling for
> each platform and hence fixing the above warnings seen
> on some platforms.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

RFC means "I do not trust this so I don't want anyone to merge it", so
I'll just delete it from my queue and wait for you to come up with
something that you feel confident with :)

thanks,

greg k-h
