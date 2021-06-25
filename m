Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78459C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E9F61427
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYJjN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFYJjM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:39:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4AA861423;
        Fri, 25 Jun 2021 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624613812;
        bh=DNFuFIckkd8ekPgtQqtO6pB3vi846cg8bFoijGUB120=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIcYre7r4+0N33D05Rq2oGiDFuRU8qODpV2kNTDbQV36xL7LqgWYarf7Q2q+YXUmm
         Rw8tY0jE8e7fAjrcuFZP6PjkFqCmMu1TZiJne+yP5OaQup1wND835nLM4STLLqgKKB
         SfbsfSpvH2LNoWmwt0PFXWyZ1wQev3+MTVp8hyiQ=
Date:   Fri, 25 Jun 2021 11:36:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC serial port driver
Message-ID: <YNWjsVNEIiL+Zi0O@kroah.com>
References: <20210625092952.12601-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625092952.12601-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 05:29:52PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX SDC serial port
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Edward Lee <Edward.lee@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 603137d..e440760 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -518,3 +518,18 @@ config SERIAL_OF_PLATFORM
>  	  are probed through devicetree, including Open Firmware based
>  	  PowerPC systems and embedded systems on architectures using the
>  	  flattened device tree format.
> +
> +config SERIAL_8250_SDC
> +	tristate "SUNIX SDC serial port support"
> +	depends on SERIAL_8250 && MFD_SUNIX_SDC
> +	help
> +	  Support for SUNIX SDC serial port.
> +
> +config SERIAL_OF_PLATFORM
> +	tristate "Devicetree based probing for 8250 ports"
> +	depends on SERIAL_8250 && OF
> +	help
> +	  This option is used for all 8250 compatible serial ports that
> +	  are probed through devicetree, including Open Firmware based
> +	  PowerPC systems and embedded systems on architectures using the
> +	  flattened device tree format.

Why did you duplicate this last entry again?

Did you test this?

thanks,

greg k-h
