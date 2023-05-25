Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC73C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 04:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjEYEOH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjEYENi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 00:13:38 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57119AC;
        Wed, 24 May 2023 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UviYOKHOAQA1VQzgBo6ztxXR+Aqfge1Zw3705YVK4Fs=; b=rh9UB031sEC44GthodVOJHjCcv
        LbtT7u/11tHq4jJQ8wcF1InsfFhyMU3Tjxgfohjgx5ZFmeNRFjhXBVQv/z4Es5Fk9mcaG/n+jRSqE
        VyP/wUZsEK5PMLk+W5Vyro/Uc31vdgZcgjI7FRgvXFGANGZAV3WdLVJEKduQHGUMNFLA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59660 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22H9-0001l4-7o; Thu, 25 May 2023 00:08:31 -0400
Date:   Thu, 25 May 2023 00:08:30 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230525000830.f9afb7683a12c6d109a757cb@hugovil.com>
In-Reply-To: <20230517141229.3792446-1-hugo@hugovil.com>
References: <20230517141229.3792446-1-hugo@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH] serial: sc16is7xx: fix syntax error in comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 17 May 2023 10:12:29 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> cotroller -> controller
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index abad091baeea..5bd98e4316f5 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1501,7 +1501,7 @@ static int sc16is7xx_probe(struct device *dev,
>  
>  #ifdef CONFIG_GPIOLIB
>  	if (devtype->nr_gpio) {
> -		/* Setup GPIO cotroller */
> +		/* Setup GPIO controller */
>  		s->gpio.owner		 = THIS_MODULE;
>  		s->gpio.parent		 = dev;
>  		s->gpio.label		 = dev_name(dev);
> -- 
> 2.30.2

This patch is now integrated in the following series:
https://lkml.org/lkml/2023/5/25/7
