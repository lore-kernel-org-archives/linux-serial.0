Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656AC433E5
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 07:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371072074B
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594971133;
	bh=79GYOPztT7j+u1DNb4EJ2AXdoEPceC09tlWPBjrpY/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhpglnqhPGZvUjavMFfZxjBbQHx/DbqOxwUrwB/+eedS6Sw5IgN1wlqNOGlZAuRMI
	 SZvSbWUgONIviN+nd6dtVXVcUY8CtxrqDJ3GF15rPQzUpJTOVEWs1LK6Bm+A+JuBky
	 PJc1mSIxmBtNLz7qdvtX9slimz0HZYvXtoEu+xqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQHcM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgGQHcM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 03:32:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DF420737;
        Fri, 17 Jul 2020 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594971132;
        bh=79GYOPztT7j+u1DNb4EJ2AXdoEPceC09tlWPBjrpY/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsDvHjI8tGUdcIEWWEJpNG637Kw2Rfg/3ESmFhz1og9fmPd1eQ7EYVWrdQFjarEvZ
         IeVgVK3ETaggohcIgYsVIP/PPVo7+OZKO6xA7Hj6sv4fYXlBi64YutYVc2AG05rSQd
         6QRmJn1/pypcp6bnQ9uRwgGHAhLKwM7Vy+z9pONU=
Date:   Fri, 17 Jul 2020 09:32:04 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
Cc:     "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: tty: serial: lpuart driver (drivers/tty/serial/fsl_lpuart.c):
 commit 5887ad43ee02a00f1
Message-ID: <20200717073204.GA694429@kroah.com>
References: <VI1PR04MB4800E14DE8DC62AEB23C89ECF37C0@VI1PR04MB4800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4800E14DE8DC62AEB23C89ECF37C0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 17, 2020 at 07:01:03AM +0000, Vabhav Sharma (OSS) wrote:
> Hello Greg, Bhuvanchandra DV,
> Static analysis tool is run against upstream kernel tree and found medium priority coverity issue against changes: commit 5887ad43ee02a00f17a6132b7fb256dc6865474c
> 
> Below are details
> sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
> 
> Bad bit shift operation, The operation may have an undefined behavior or yield an unexpected result.
> A bit shift operation has a shift amount which is too large or has a negative value.
> 
> zero_return: Function call fls(sport->rx_dma_rng_buf_len) returns 0
> CID 9000793 (#5 of 5):
> Bad bit shift operation (BAD_SHIFT)4. negative_shift: In expression 1 << fls(sport->rx_dma_rng_buf_len) - 1, shifting by a negative amount has undefined behavior. The shift amount, fls(sport->rx_dma_rng_buf_len) - 1, is -1.
> 
> Would you like to push changes for fixing the coverity issue.

Can you submit a patch for this, no need to make someone else do it :)

And note, html email is rejected by the mailing lists.

thanks,

greg k-h
