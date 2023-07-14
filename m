Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45121EB64DA
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jul 2023 04:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjGNEo4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jul 2023 00:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjGNEou (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jul 2023 00:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548541BFB;
        Thu, 13 Jul 2023 21:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E231D61BFB;
        Fri, 14 Jul 2023 04:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39C6C433C9;
        Fri, 14 Jul 2023 04:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689309888;
        bh=16qYXyv9GjVlWLIOgZtR6rNBawlsls2NbxhBuJjU4bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvV2h0OfCPZ3yH6ZmkwvN98n990BzlkoJbLWNPSMmrJahwmOxSYfEsEMeS5/Ura+i
         XGANqu7vali9D98sB4QSitrLM35qiOCvcpovLeN29Ar5V/a3CWsglVUGeQpekVwPTd
         0+k0DCC7jqgz7pKrETgjqxE06oh6JEcnV1G07lQU=
Date:   Fri, 14 Jul 2023 06:44:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liubin001@208suo.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] tty:Insert clk_put before return (clk) to release
 memory
Message-ID: <2023071424-folic-boss-18e3@gregkh>
References: <tencent_EF85BF6D0EE7D05E10D527FD335467508106@qq.com>
 <57adb092639743f2619c4765379b3ec7@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57adb092639743f2619c4765379b3ec7@208suo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 14, 2023 at 12:30:14PM +0800, liubin001@208suo.com wrote:
> 
> tty/serial:Insert clk_put before return (clk) to release memory
> Signed-off-by: Liu Bin <liubin001@08suo.com>
> ---
>  drivers/tty/serial/bcm63xx_uart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c
> b/drivers/tty/serial/bcm63xx_uart.c
> index 55e82d0bf92d..7353b683952d 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>          clk = of_clk_get(pdev->dev.of_node, 0);
> 
>      if (IS_ERR(clk))
> +        clk_put(clk);
>          return -ENODEV;
> 
>      port->iotype = UPIO_MEM;

This obviously has not even been tested :(
