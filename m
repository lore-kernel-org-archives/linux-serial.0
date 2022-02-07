Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E31AC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Feb 2022 07:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiBGHbP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiBGHTe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Feb 2022 02:19:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC23C03FEE6;
        Sun,  6 Feb 2022 23:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C1C1CE0E66;
        Mon,  7 Feb 2022 07:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E38C004E1;
        Mon,  7 Feb 2022 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644218310;
        bh=JBTRJGgMjccwQfUbbCcxtKgBVyq2KJYTH13BoW+Xa2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbHHGFa8hPRReLVpX/FFdLhZtX8JeaON0Jh5Ynxz9d88gs2SAAjsQL7HCivVbY9yf
         OMnTr5fOIhOJcbusthWjQapNzAqrVIg42lx4cyhhEG+kf3c8aPxFiUAF4jfsypVqBq
         6F0pY2E0nHzzDNgb0UJ+/d02KZEgmcStMDXpOWIQ=
Date:   Mon, 7 Feb 2022 08:18:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        hammer.hsieh@sunplus.com
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YgDHwgg0s6U3bFxF@kroah.com>
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644213481-20321-3-git-send-email-hammerh0314@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 07, 2022 at 01:58:01PM +0800, Hammer Hsieh wrote:
> Add Sunplus SoC UART Driver
> 

We need more of a changelog comment here please.  Describe the hardware,
what the new tty name you are using, and other stuff.  Be descriptive.

> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -274,4 +274,7 @@
>  /* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	122
>  
> +/* Sunplus UART */
> +#define PORT_SUNPLUS	123

Why is this needed?  Are you going to require this in some userspace
code?  If not, please do not add it.

thanks,

greg k-h
