Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEFAC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71636143F
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhEGNV7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 09:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhEGNV7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 09:21:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0065F6143F;
        Fri,  7 May 2021 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620393659;
        bh=sobQ8pQQF202nP8+bQmgCwGEkUv/nvmLT0VVBtITVhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkHh6Q7P/Ojek+wyXL2YSye3vNMX7L/8Ls+tnsAGHNVGwlYzT1xDUxdR4cY4EbwkY
         MD9C54t5ee8gqUVDyROeFbSlpI3geNEocCjfIQZKzcvfLjpiJcD8t7tAtSyBCj44IV
         ruEjjjUKxiTBmPbxmiNVmaakoELTddImqSNBGodA=
Date:   Fri, 7 May 2021 15:20:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Use fallthrough pseudo-keyword
Message-ID: <YJU+uJcJ6Y+2PEUc@kroah.com>
References: <20210507130403.11144-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507130403.11144-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 07, 2021 at 09:04:03PM +0800, Wei Ming Chen wrote:
> Add pseudo-keyword macro fallthrough[1]
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 689d8227f95f..4158f06de4d5 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -847,8 +847,11 @@ static int pci_netmos_init(struct pci_dev *dev)
>  
>  	switch (dev->device) { /* FALLTHROUGH on all */
>  	case PCI_DEVICE_ID_NETMOS_9904:
> +		fallthrough;
>  	case PCI_DEVICE_ID_NETMOS_9912:
> +		fallthrough;
>  	case PCI_DEVICE_ID_NETMOS_9922:
> +		fallthrough;
>  	case PCI_DEVICE_ID_NETMOS_9900:

I really doubt this is needed here.  If so, something is really wrong
with the static checkers.

thanks,

greg k-h
