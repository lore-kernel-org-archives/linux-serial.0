Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A462C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 12:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DCC610CA
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 12:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1MYn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1MYm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Oct 2021 08:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9807760238;
        Thu, 28 Oct 2021 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635423735;
        bh=sNViopt2AGTtGw527JuqTqB1yq2eoISJmKY8LUifpCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKX/4zI6IWHcPtl7pW3anmaQmlXeBb4YgFJOp/BU2SAJuIN3NW0EEzmC5p7dHppqU
         zo9JBqBGeQAPw1RDqiumR6BA4dNwpxHy2rXxKscMYKDh6NeF8aA4rzrHDqmmv2kL+X
         OSh4+0vYvXrL98kcOYjt0aafPlxXSw8FCIOu6MJ3ifW8R1aQ3WyMX2Wyh/FFwn8T52
         4eyzLpbMoby1OLMO46v12CZMwzTnczzgeTrQXWxl56o6lgx86VGAf17mzes2ymRjUo
         XZ8/9Ixb/16kTjsyiuJlM+5ycsJVeEMVEs8ZwhOZTtSvbRlPSwTs0THkgM4um3YTyo
         z329vdIQiPhVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mg4Q9-00053D-8y; Thu, 28 Oct 2021 14:22:13 +0200
Date:   Thu, 28 Oct 2021 14:22:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        macro@orcam.me.uk, fancer.lancer@gmail.com, andrew@aj.id.au,
        pali@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: tty: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YXqV9V0eWhqFTc+i@hovoldconsulting.com>
References: <20211028101350.14172-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028101350.14172-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 28, 2021 at 10:13:50AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>

Where's the commit message?

Also, look at the log for the driver you're changing for the Subject
prefix you should use. Including "drivers:" is never right.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5775cbff8f6e..557e8b13b5c1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3099,7 +3099,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
>  	if (rxtrig_bytes < 0)
>  		return rxtrig_bytes;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
> +	return sysfs_emit(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);

FFS... This would not even compile, at least not without a warning, as
it's completely broken.

You do know that you have to at least compile-test your patches, right?

>  }
>  
>  static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)

Johan
