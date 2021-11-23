Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6CC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhKWTCX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232807AbhKWTCX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 14:02:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3F6260F51;
        Tue, 23 Nov 2021 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637693954;
        bh=z4NtIRFQ5Odickd6qKlGv9AwWCtte8Ggehm9SETVygs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/LyPyvXgqU2BY2+9M3yFEsQhja78ZYhvxICKWoNYjJcdRa9qvxs8d1wJaE1+Rz1h
         NebXeJw7tBmpWUH6L9sFSkTw+Al/vTpWZiYjC5/ehYxIQwiqTA4lpasIY8nBasvaPp
         vshQWHZ1qtNaULQRNGM/BOLTleUmrhHp0uKRuq5c=
Date:   Tue, 23 Nov 2021 19:59:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jacmet@sunsite.dk
Subject: Re: [PATCH 1/1] tty: serial: uartlite: allow 64 bit address
Message-ID: <YZ05/73+BhIANNGF@kroah.com>
References: <20211123184506.1184561-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123184506.1184561-1-lizhi.hou@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 10:45:06AM -0800, Lizhi Hou wrote:
> Fix the uartlite probe failure when it is mapped to address above 4G.

Fix it how?

> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

What commit caused this problem?  What commit does this fix?  Should it
go to stable kernels?

> ---
>  drivers/tty/serial/uartlite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index d3d9566e5dbd..e1fa52d31474 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -626,7 +626,7 @@ static struct uart_driver ulite_uart_driver = {
>   *
>   * Returns: 0 on success, <0 otherwise
>   */
> -static int ulite_assign(struct device *dev, int id, u32 base, int irq,
> +static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
>  			struct uartlite_data *pdata)

So you changed the variable type which does what exactly here?

thanks,

greg k-h
