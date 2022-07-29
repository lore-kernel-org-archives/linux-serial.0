Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AD9C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiG2NrD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiG2NrC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 09:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C545357FB
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 06:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D4061F28
        for <linux-serial@vger.kernel.org>; Fri, 29 Jul 2022 13:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B885C433D6;
        Fri, 29 Jul 2022 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102420;
        bh=fEdDpsT3y7K/2xz0Z9xDsbbn3g6LtyjCObDqBM0CUyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7XUw99YIJOBdFHVNKyWzVeWdI3kPqwCq2TiF+gjwTbCakUT6qk9ocGoMe2gdL2CC
         yiSAh2k7pL9kxKjnrndT3FrtuUecZ6weX5b/5YJKeE+OfNtcmj4V3oD2XqJlGAxS9+
         FD2FgJm2c1v8heXq8Nd9Fsw6laYWYQZrHyxv3Xbo=
Date:   Fri, 29 Jul 2022 15:46:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        shubhrajyoti.datta@gmail.com, git@amd.com
Subject: Re: [PATCH v2 2/7] tty: xilinx_uartps: Update copyright text to
 correct format
Message-ID: <YuPk0bAqMIg33EQw@kroah.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
 <20220729114748.18332-3-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729114748.18332-3-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 29, 2022 at 05:17:43PM +0530, Shubhrajyoti Datta wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> Based on recommended guidance Copyright term should be also present in
> front of (c). That's why aligned drivers to match this pattern.
> It helps automated tools with source code scanning.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 51fd09e14eda..8d2c21718869 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -2,7 +2,7 @@
>  /*
>   * Cadence UART driver (found in Xilinx Zynq)
>   *
> - * 2011 - 2014 (C) Xilinx Inc.
> + * Copyright (c) 2011 - 2014 Xilinx, Inc.

This is great, but as you did just touch this thing in 2022, shouldn't
you write this as:
	Copyright (c) 2011 - 2014, 2022 Xilinx, Inc.

You can do an add-on patch for that if you want.

thanks,

greg k-h
