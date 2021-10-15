Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD8C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8861163
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 06:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJOHAF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 03:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235806AbhJOHAF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 03:00:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9625B6108B;
        Fri, 15 Oct 2021 06:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634281079;
        bh=aV5aNS+CjapJRcawRhUEtxjrkQRFiQpiNmzl1k0dNDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIVVfaczpV+gPuxwxTblzQqiuGIfk9twnF9CbPcNzd8XoXgQqWeKzETUPr7ACRoBl
         rL48+jXZO3fkrX1d+M1WAuHZ312TkKJTXxcc8PeqmR3vm5lSxJZyYGO2Er3t/bYNga
         zMKHSCSmt80l7ieaTLz2W7bcO5c5JokTs06sIP8A=
Date:   Fri, 15 Oct 2021 08:57:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: 8250: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YWkmdELuWa6ITIIR@kroah.com>
References: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 14, 2021 at 11:51:22PM -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.

Why must it not?  What is broken in the existing code?

> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
>  drivers/tty/serial/8250/8250_port.c         | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 2350fb3..082b9bd 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
>  	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
>  		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
>  
> -	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
> +	return sysfs_emit(buf - 1, "0x%x\n", addr);

what is the buf-1 thing here for?

Doing a tree-wide change for this type of thing might not be wanted by
many maintainers, especially if you introduce bugs like this :(

greg k-h
