Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F86CDB483
	for <linux-serial@archiver.kernel.org>; Wed, 18 Oct 2023 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJRSgK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJRSgJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Oct 2023 14:36:09 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C6F7
        for <linux-serial@vger.kernel.org>; Wed, 18 Oct 2023 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=S4bnHD86oWYtj2SMd8MPd91Qh2Ov7m15hJzgCwTjgTI=; b=s2jCt4HsAX5fQQrVEKBCXF0YGZ
        xW7G4KcM0QIF1sOYEBAE+bCSWmBTyy9nwtVSDMBKs32bt40bSsc4ZxU6MvtUvgxWetvs5HVgssDDV
        QfWNwKkxpLKR5nTy1cfUBr7x3CylIO8/HHplhsAepU0XQ4MngIUEO1XuoKfhZN0J6tZ8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49052 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qtBOd-0007KA-3A; Wed, 18 Oct 2023 14:35:55 -0400
Date:   Wed, 18 Oct 2023 14:35:54 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <srinivas.kandagatla@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Message-Id: <20231018143554.c284a8285e9eec6c519b7269@hugovil.com>
In-Reply-To: <20231018091240.314620-1-yiyang13@huawei.com>
References: <20231018091240.314620-1-yiyang13@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH] serial: st-asc: Check return value of
 platform_get_irq() in asc_init_port()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 18 Oct 2023 09:12:40 +0000
Yi Yang <yiyang13@huawei.com> wrote:

Hi,

> The platform_get_irq() might be failed and return a negative result, there

Change to:

"platform_get_irq() might fail and return a negative result."

> should be return an error code when platform_get_irq() failed.
> Fix it by add check return value of platform_get_irq().

and maybe something along:

"Return an error code when platform_get_irq() fails."

Hugo.

 
> Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/tty/serial/st-asc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index a821f5d76a26..8321167502dc 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -683,12 +683,16 @@ static int asc_init_port(struct asc_port *ascport,
>  	struct resource *res;
>  	int ret;
>  
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	port->iotype	= UPIO_MEM;
>  	port->flags	= UPF_BOOT_AUTOCONF;
>  	port->ops	= &asc_uart_ops;
>  	port->fifosize	= ASC_FIFO_SIZE;
>  	port->dev	= &pdev->dev;
> -	port->irq	= platform_get_irq(pdev, 0);
> +	port->irq	= ret;
>  	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
>  
>  	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -- 
> 2.25.1
> 
