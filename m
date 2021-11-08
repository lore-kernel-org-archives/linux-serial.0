Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D86EC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD8861039
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhKHJ5J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238471AbhKHJ5C (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 04:57:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C1561039;
        Mon,  8 Nov 2021 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636365258;
        bh=L2Ix2vEwlgwUCz4M38Df7/lObXnBdKVo3WLE/p151LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AokKpJV59zKKiz9/RDeuoLzi8V5vgjhyZaiMLQJneZXIONGLg/WAMWFtu4PJY0kvJ
         VFb4T8C9GwBuw8YjTPogpJ3ijzjDPoDMq3IxscLGgsTxYmzI+ph2QSSQRifKPJXVVu
         bC14ZYYlYRlWczWA0FjGzFYPC/YEjnayif8Hhh/BaH5nHVOt/cATu9+E2BUxB+uQQL
         qEWBqGG3IFIn6xaiAh/v7ru0EU9rzIwdH3ZHXXMBRf5S21isYOtUswcttapGHAwelY
         L5I1MXOug/9xU66405oa5HGqWaXY6lmOLsTna6g+U39Z8/RduWSB59I05/qKhp4v9I
         GZQaPf3y81E4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mk1Lz-0003ai-7l; Mon, 08 Nov 2021 10:54:15 +0100
Date:   Mon, 8 Nov 2021 10:54:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     andrew@aj.id.au, fancer.lancer@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        macro@orcam.me.uk, pali@kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: Re: [PATCH v3] serial: 8250: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYjzxzJAqVen8z+7@hovoldconsulting.com>
References: <YYDsU778y71byGdj@hovoldconsulting.com>
 <20211104114754.30983-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104114754.30983-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 04, 2021 at 11:47:54AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---
> 
> Changes since v1 & v2:
>  - Remove excess and wrong parameter 'PAGE_SIZE' in sysfs_emit function.
>  - Revise the wrong patch Subject.

Looks like there are a few more cases in 

	drivers/tty/serial/8250/8250_aspeed_vuart.c

which you could convert in a follow up patch.

>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5775cbff8f6e..3d58f383152e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
>  	if (rxtrig_bytes < 0)
>  		return rxtrig_bytes;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
> +	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
>  }
>  
>  static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)

This one looks good as is now:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
