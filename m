Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50847C43334
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jul 2022 06:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiGOG7N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGOG7D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jul 2022 02:59:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12391A042;
        Thu, 14 Jul 2022 23:59:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0473D22238;
        Fri, 15 Jul 2022 08:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657868340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mLRTaRDGXgpkH+hihE3uyVt6q2SF/pcz5ieGtWUJKU=;
        b=GERYpNTOyfh5jTSDGbiShfTzmio1GZJux7pai8jiEuykBGlqzwEuJ4catXYuKkDHELAGZc
        Sc1RgJNNkSltzoaUpkleNV+99fSOsQ6BJvHi1AYzbE6TY+WEfHJqbhTtXCNlaR+lY4yhxi
        uIxLyvxqntHE0JKTmqCuVetBwn8fJYU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jul 2022 08:58:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of break
 characters
In-Reply-To: <20220715025944.11076-2-sherry.sun@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-2-sherry.sun@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f480572d82310c3ed14e476b7cfbe7f2@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2022-07-15 04:59, schrieb Sherry Sun:
> The LPUART can't distinguish between a break signal and a framing 
> error,
> so need to count the break characters if there is a framing error and
> received data is zero instead of the parity error.

Ah, it seems I mixed up the framing and the partiy error. Did you test
the break in the receive path, though?

-michael

> 
> Fixes: 5541a9bacfe5 ("serial: fsl_lpuart: handle break and make sysrq 
> work")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c 
> b/drivers/tty/serial/fsl_lpuart.c
> index fc7d235a1e27..b6365566a460 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -990,12 +990,12 @@ static void lpuart32_rxint(struct lpuart_port 
> *sport)
> 
>  		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
>  			if (sr & UARTSTAT_PE) {
> +				sport->port.icount.parity++;
> +			} else if (sr & UARTSTAT_FE) {
>  				if (is_break)
>  					sport->port.icount.brk++;
>  				else
> -					sport->port.icount.parity++;
> -			} else if (sr & UARTSTAT_FE) {
> -				sport->port.icount.frame++;
> +					sport->port.icount.frame++;
>  			}
> 
>  			if (sr & UARTSTAT_OR)
> @@ -1010,12 +1010,12 @@ static void lpuart32_rxint(struct lpuart_port 
> *sport)
>  			sr &= sport->port.read_status_mask;
> 
>  			if (sr & UARTSTAT_PE) {
> +				flg = TTY_PARITY;
> +			} else if (sr & UARTSTAT_FE) {
>  				if (is_break)
>  					flg = TTY_BREAK;
>  				else
> -					flg = TTY_PARITY;
> -			} else if (sr & UARTSTAT_FE) {
> -				flg = TTY_FRAME;
> +					flg = TTY_FRAME;
>  			}
> 
>  			if (sr & UARTSTAT_OR)

-- 
-michael
