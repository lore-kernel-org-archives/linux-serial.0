Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D24C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7412065D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595352787;
	bh=hIE7IQDtbAmiYNYeSMqGBiJWFu506qsD/cuqjgAsj8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lqqRvaDJP/WPas1h1HWLU16ztS4RLT5t4u/FuTiy8HwhbEJh2dATBB3wBegPwZRDb
	 IznjdRg6cZEXh/ujV1+b1hm9xf+pYPTJkpZLZk98QgT48xkbpTslfrJzvUj5Sp5Mcq
	 BN+YDCW77wdEx20UyxETRf0NhvaCKJYmUIHhbK08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGURdH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGURdG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 13:33:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25C22065D;
        Tue, 21 Jul 2020 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595352786;
        bh=hIE7IQDtbAmiYNYeSMqGBiJWFu506qsD/cuqjgAsj8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2/xKI63nCEey1Gp95d+3e6gHvSwy2mqdUlfpbjfiD+/uSWX6BzbjT+CmTRRhsUTG
         HrFFKO44zl6hok/FWX9Pzk+4+q8s/UbXXDGxuIpl40OTWUBybdXF9PuP3PwMcPyQRf
         R+wJl4UjWiOjepxcEE5AnnODKr8YxdXEmOryJaRE=
Date:   Tue, 21 Jul 2020 19:33:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart.c: prevent a bad shift
 operation
Message-ID: <20200721173313.GA2461958@kroah.com>
References: <20200721171311.xlt256fq2qmw4e6p@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721171311.xlt256fq2qmw4e6p@pesu.pes.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 21, 2020 at 10:43:11PM +0530, B K Karthik wrote:
> prevent a bad shift operation by verifying that
> sport->rx_dma_rng_buf_len is non zero.
> 
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What about setting the "Reported-by:" to the person who reported this
problem?  And cc:ing them to see if they agree with your change?

thanks,

greg k-h
