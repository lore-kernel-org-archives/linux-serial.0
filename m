Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFFC47409
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B624650
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 21:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581717297;
	bh=tVn7U406yIiOIQ3QrobWuWaQw3CMzXxdmkgIycIy/3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SmaZSI0UL1npGPI4bjiiBkVTqp/aS7HjrCaLhngCoHXKVfnBeYg4aoNIcQsOcasMh
	 RCjfJ9+deXqxEvkRn1+ptKKrOjtdVhMLHjJpbE9vlLcmJeeZFyBPt/FdWx529IslD9
	 bO0DK7luH0YqO5Yqrjg1im3TERmA77n/7zB2Cn0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgBNVyt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388145AbgBNVym (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 16:54:42 -0500
Received: from localhost (unknown [65.119.211.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1952F22314;
        Fri, 14 Feb 2020 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581717281;
        bh=tVn7U406yIiOIQ3QrobWuWaQw3CMzXxdmkgIycIy/3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yt5bXkGWsp+FXJmF0epytl7xVwnQQFx3XByc3J7MSNwvfKCq6dfKIxVLAj9243vrc
         vXxxYIRO7JTgsm6WClUJP1RxY5whwzd2pJHS6VwxNFsM0884TZaGSziXTrIwNsRN/j
         1D5Z09gisCBO+2fhCgqbmTMYPRTwMo3a1N0k6WA0=
Date:   Fri, 14 Feb 2020 16:50:59 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hulk Robot <hulkci@huawei.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.5 188/542] tty: omap-serial: remove set but
 unused variable
Message-ID: <20200214215059.GJ4193448@kroah.com>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-188-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214154854.6746-188-sashal@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 10:43:00AM -0500, Sasha Levin wrote:
> From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> [ Upstream commit e83c6587c47caa2278aa3bd603b5a85eddc4cec9 ]
> 
> Fix the following warning:
> drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
> drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]
> 
> The character read is useless according to the table 23-246 of the omap4
> TRM. So we can drop it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Link: https://lore.kernel.org/r/1575617863-32484-1-git-send-email-wangxiongfeng2@huawei.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/tty/serial/omap-serial.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 6420ae581a802..5f808d8dfcd5c 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -493,10 +493,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> -	unsigned char ch = 0;
>  
> +	/*
> +	 * Read one data character out to avoid stalling the receiver according
> +	 * to the table 23-246 of the omap4 TRM.
> +	 */
>  	if (likely(lsr & UART_LSR_DR))
> -		ch = serial_in(up, UART_RX);
> +		serial_in(up, UART_RX);
>  
>  	up->port.icount.rx++;
>  	flag = TTY_NORMAL;
> -- 
> 2.20.1
>

Please drop.

