Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AAFC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 08:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FC661076
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDZIKM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbhDZIKL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 04:10:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 826BB61075;
        Mon, 26 Apr 2021 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619424569;
        bh=N3xipdZyTQK1baUwTtMtaGa4JYA/srKU2LF77EDS5JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBrtAPEjBDP71kiG+DSMUamo3zwY1lJr6cP5QpJmQxKgLhW4P8LtkRWb3EGmX2rNG
         p7K/WS8jspJWf5vmgr2Z0U9HroWbTlqBg3ZRBGdeVpdBP1NxmZB1JwLGORskPaxF4C
         Vdyvrh4lA/30Zl4SDzHSQ7V2JmOKS3sMOAo4m1xI=
Date:   Mon, 26 Apr 2021 10:09:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Message-ID: <YIZ1NvISshNHtX/Z@kroah.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426074935.11131-3-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 03:49:35PM +0800, Sherry Sun wrote:
> This issue is reported by Coverity Check.
> In lpuart_probe, return value of function which returns null is
> dereferenced without checking.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 777d54b593f8..c95e71fd2ca0 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2589,6 +2589,9 @@ static int lpuart_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  
> +	if (!sdata)
> +		return -ENODEV;

How can sdata be NULL?

thanks,

greg k-h
