Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9360C12002
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jul 2021 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C628E6101B
	for <linux-serial@archiver.kernel.org>; Wed, 21 Jul 2021 11:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhGUKnO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239487AbhGUKFd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jul 2021 06:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 851FC60238;
        Wed, 21 Jul 2021 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626864369;
        bh=lekz1x8Vr+mtj6/j1CLlcAW/8TwIhmgKM8+wU/jnTd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3WtQXqEESn30zVXhTZ7Rf7axCV+VRasQnprlkR/u7LSKrlVylGYfkUewLhoVp/fD
         IJedpcadAQ0QHFTl0SxxRdlu3rgGAekSV4pzAQKudjBQLW1i2XbfTFGXtpKAp6cjKL
         fgNulM80bhGQechPnYIiFF3/dCAs0n+WaEjdVWuE=
Date:   Wed, 21 Jul 2021 12:46:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     timur@kernel.org, linux@armlinux.org.uk, alcooperx@gmail.com,
        tklauser@distanz.ch, sean.wang@kernel.org,
        srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        yuchen.huang@mediatek.com, huihui.wang@mediatek.com,
        eddie.huang@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart: mediatek: fix memory corruption issue
Message-ID: <YPf67gw2KJCk/Ucs@kroah.com>
References: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
 <20210710090103.2643-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710090103.2643-2-zhiyong.tao@mediatek.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 10, 2021 at 05:01:03PM +0800, Zhiyong Tao wrote:
> This patch is used to fix memory corruption issue when rx power off.
> 1. add spin lock in mtk8250_dma_rx_complete function in APDMA mode.

What does a lock protect from?  Please be explicit and detailed.

> 2. add processing mechanism which count value is 0

What does this do?  And why is it needed?

> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

What commit does this fix?  Does this need to go to stable kernel trees?
If so, how far back?

> ---
>  drivers/tty/serial/8250/8250_mtk.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index f7d3023f860f..09f7d2166315 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -91,12 +91,15 @@ static void mtk8250_dma_rx_complete(void *param)
>  	struct mtk8250_data *data = up->port.private_data;
>  	struct tty_port *tty_port = &up->port.state->port;
>  	struct dma_tx_state state;
> -	int copied, total, cnt;
> +	unsigned int copied, total, cnt;
>  	unsigned char *ptr;
> +	unsigned long flags;
>  
>  	if (data->rx_status == DMA_RX_SHUTDOWN)
>  		return;
>  
> +	spin_lock_irqsave(&up->port.lock, flags);
> +
>  	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
>  	total = dma->rx_size - state.residue;
>  	cnt = total;
> @@ -104,9 +107,11 @@ static void mtk8250_dma_rx_complete(void *param)
>  	if ((data->rx_pos + cnt) > dma->rx_size)
>  		cnt = dma->rx_size - data->rx_pos;
>  
> -	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -	copied = tty_insert_flip_string(tty_port, ptr, cnt);
> -	data->rx_pos += cnt;
> +	if (cnt != 0) {

Why does cnt matter here?  If cnt is 0, the code above should not do
anything at all, right?

Or if it does, should we change tty_insert_flip_string() to always check
for cnt != 0 before it does the first loop?  Hm, it looks like it will
abort if cnt is 0, so what is this change really doing?  Why do you need
it?  What is it "fixing"?

thanks,

greg k-h
