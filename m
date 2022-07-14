Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503CC43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 14:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiGNOb0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGNObR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 10:31:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5296170C
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 07:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12684B82630
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 14:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20281C341C8;
        Thu, 14 Jul 2022 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657809073;
        bh=SMjyzLPWoQW6CTtjE3EqujOa2nT6FbEeKzvZByntUpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsipvFyAoouC/gvaWmP5fWFvqzxdU1kUuoFbd1lVjd0+UHfOeV74fYraOJ108Aizk
         frf4x09DT0Liv6VfuqwHQtJ/AOmRTXVpkTK4WdzNK2NmMTJiLEZqrgrqNVIP2rG81R
         WyIPOEUgcSNllNzec1uWqbLBFK7fBk7XUtgnv7Mk=
Date:   Thu, 14 Jul 2022 16:31:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shenwei.wang@nxp.com
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit in CS7
 mode
Message-ID: <YtAorn/GVtoTRkdO@kroah.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708195800.325933-1-shenwei.wang@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> The LPUART hardware doesn't zero out the parity bit on the received
> characters. This behavior won't impact the use cases of CS8 because
> the parity bit is the 9th bit which is not currently used by software.
> But the parity bit for CS7 must be zeroed out by software in order to
> get the correct raw data.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
> changes in v1
> - fix the code indent and whitespace issue;

Normal patches start numbering at v1 :)

>  drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 8fe0494d4057b..a8f59fb27c825 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -274,6 +274,8 @@ struct lpuart_port {
>  	int			rx_dma_rng_buf_len;
>  	unsigned int		dma_tx_nents;
>  	wait_queue_head_t	dma_wait;
> +	bool			is_cs7; /* Set to true when character size is 7 */
> +					/* and the parity is enabled		*/
>  };
> 
>  struct lpuart_soc_data {
> @@ -1022,6 +1024,9 @@ static void lpuart32_rxint(struct lpuart_port *sport)
>  				flg = TTY_OVERRUN;
>  		}
> 
> +		if (sport->is_cs7)
> +			rx &= 0x7F;
> +
>  		if (tty_insert_flip_char(port, rx, flg) == 0)
>  			sport->port.icount.buf_overrun++;
>  	}
> @@ -1107,6 +1112,17 @@ static void lpuart_handle_sysrq(struct lpuart_port *sport)
>  	}
>  }
> 
> +static inline int lpuart_tty_insert_flip_string(struct tty_port *port,
> +	unsigned char *chars, size_t size, bool is_cs7)

Why inline?  Don't do that unless it is measurable with and without it,
good compilers will guess this correctly.

thanks,

greg k-h
