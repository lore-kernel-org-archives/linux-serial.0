Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B50C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 08:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7040461075
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 08:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhDZIJQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbhDZIJP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 04:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B22C661075;
        Mon, 26 Apr 2021 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619424513;
        bh=/sO2t0hU88ihYrgppTs+DSbTAXvGpptkwOt7IzR76uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jk8u5CJ9jK8F1AgHr9yS7fAuZvZIBF1VnI0xl9JMRZ7AG9RzX0T5jr4M8WfPgi+uP
         03QS86rcI9mLsu8Do/LTvzrl1fK3h5KG3d4XVAvYZQzEycoNl6ghTdjgtEDZxhNiZa
         OxrVoPfuYaZEn58pXsC23q9l1GUSwtV6oQ+g8AkU=
Date:   Mon, 26 Apr 2021 10:08:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Message-ID: <YIZ0/vRLASlUph6x@kroah.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426074935.11131-2-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 03:49:34PM +0800, Sherry Sun wrote:
> This issue is reported by Coverity Check.
> In lpuart32_console_get_options, division or modulo by zero may results
> in undefined behavior.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 794035041744..777d54b593f8 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2414,6 +2414,9 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
>  
>  	bd = lpuart32_read(&sport->port, UARTBAUD);
>  	bd &= UARTBAUD_SBR_MASK;
> +	if (!bd)
> +		return;

How can this ever happen?

Not to say this is a bad check, but it feels like this can't really
happen in real life, what code patch could create this result?

And have you tested this on real hardware?

thanks,

greg k-h
