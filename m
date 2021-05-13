Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5CC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5596142C
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 14:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhEMOUl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 10:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhEMOUU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 10:20:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C07B6142C;
        Thu, 13 May 2021 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620915549;
        bh=4ZfGgMKCI/cI5RBHRWLjHYp9AqtZG2RVPTzXZprYUog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N267V8gt2mcIkXDiRX+QXiWDbChAFFrGze9w+zciV7tsbejBZ3uFuxbSoeqG8WUGD
         lH7bkb5HNNurM8rnjIpTBzDlDVGSitCe4cgdYeGKN/lp2sDHPAYbC/Q9lr4o6bdQ61
         c2aeHAS5nAElTV1YBdeEH/UnDKtdAtw8qMKOB6nM=
Date:   Thu, 13 May 2021 16:19:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hjk@linutronix.de, jirislaby@kernel.org, lee.jones@linaro.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: serial_cs: Fix a memory leak in error
 handling path
Message-ID: <YJ01W4zWfG601Sbv@kroah.com>
References: <562910a450cb86db7c2c4a4328a60e53ef95f504.1620548790.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562910a450cb86db7c2c4a4328a60e53ef95f504.1620548790.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 09, 2021 at 10:28:18AM +0200, Christophe JAILLET wrote:
> In the probe function, if the final 'serial_config()' fails, 'info' is
> leaking.
> 
> Use 'devm_kzalloc' instead to fix the leak and simplify the .remove
> function.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I've not been able to find a Fixes tag. All I know is that it is old!
> ---
>  drivers/tty/serial/8250/serial_cs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
> index 63ea9c4da3d5..d18c98e0d0b0 100644
> --- a/drivers/tty/serial/8250/serial_cs.c
> +++ b/drivers/tty/serial/8250/serial_cs.c
> @@ -310,7 +310,7 @@ static int serial_probe(struct pcmcia_device *link)
>  	dev_dbg(&link->dev, "serial_attach()\n");
>  
>  	/* Create new serial device */
> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	info = devm_kzalloc(&link->dev, sizeof(*info), GFP_KERNEL);

Ick, let's not mix and only use some devm_ calls here, why not just fix
it up and free it in the error path?


thanks,

greg k-h
