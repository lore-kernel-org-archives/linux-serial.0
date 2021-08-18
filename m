Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F3C4338F
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB56761076
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 14:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhHROFw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238531AbhHROFu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 10:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EED5861076;
        Wed, 18 Aug 2021 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629295515;
        bh=/g9jlcYbBNlkfpqyuK7GTFt7XBuhX4Lcs2nELfNmEEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrcFFI/8DENxT2EoJblBqcuw2bt/iZ+tCeaaN9A1yab2alBXsFHln7HeS+iXWYBNh
         QE/tF1wfkzkJqP7eNnUTeozO3ZIQhi+NqolVQMR+NibVTji3c0Aib9/p8Dylmls/Cm
         0jtmwB1HLdIinFzi+z4VsF0mXOHGHXXmj1kVca1Y=
Date:   Wed, 18 Aug 2021 16:05:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Message-ID: <YR0TmJJ/WkfE2zkR@kroah.com>
References: <20210817063058.4718-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817063058.4718-1-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 17, 2021 at 02:30:58PM +0800, Sherry Sun wrote:
> From: Andy Duan <fugang.duan@nxp.com>
> 
> Register offset needs to be applied on mapbase also.
> dma_tx/rx_request use the physical address of UARTDATA.
> Register offset is currently only applied to membase (the
> corresponding virtual addr) but not on mapbase.
> 
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Why is there no signed-off-by from the author?

Please fix up.

thanks,

greg k-h
