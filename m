Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0ECC6FA86
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiIVOLl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiIVOLS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 10:11:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22EF3730;
        Thu, 22 Sep 2022 07:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF84AB83708;
        Thu, 22 Sep 2022 14:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C02C433D6;
        Thu, 22 Sep 2022 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663855861;
        bh=vJpB1Q9Xbs3OPamaddgh9K979emAbEVOcguCGSX+BAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yARhH8SRoi18lk0iseUvkPSD06eqTJVvJT/n6cPz1xKTVGzbRmxTVxTIkGsaC19Dv
         RXHTVII+N9uhQgt8ycbxZobTgIoc1vpBIc3AsNHmzFEOr/7G6lAL7P0bD1HZc+MEXE
         muI57HtY30QJdm316EolHra8xxu81TmRuOcQCm1M=
Date:   Thu, 22 Sep 2022 16:10:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <Yyxs8o7tB6BVS0Kt@kroah.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 09, 2022 at 12:11:02PM +0300, Andy Shevchenko wrote:
> uart_xmit_advance() provides a common way on how to advance
> the Tx queue. Use it for the sake of unification and robustness.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index d99020fd3427..b85c82616e8c 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -26,9 +26,7 @@ static void __dma_tx_complete(void *param)
>  
>  	dma->tx_running = 0;
>  
> -	xmit->tail += dma->tx_size;
> -	xmit->tail &= UART_XMIT_SIZE - 1;
> -	p->port.icount.tx += dma->tx_size;
> +	uart_xmit_advance(&p->port, dma->tx_size);
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
> -- 
> 2.35.1
> 

Breaks the build :(
