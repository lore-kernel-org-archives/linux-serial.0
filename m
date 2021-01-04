Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7445CC433DB
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EC321E92
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 10:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhADKDF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbhADKDE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jan 2021 05:03:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC53B20780;
        Mon,  4 Jan 2021 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609754544;
        bh=DTQgfinQxH3xCqywDfhY454jpPb5ATM8H7eYA7h4GXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWT0quJnpKJqNAm4nX+AAQTwVQrJWVBZv+YuI81WWr07jSpyESECSAPQ+0VkOnair
         lujVi/C2OSKQRhdbVLq8aLrCd4VKHpaikcwUWypNfK/aNfQfIchbD/KpwB60qyvqLf
         rcYl4Dy2McyP6wEMdkKey1k23Irij6Ky0xiAPXBI=
Date:   Mon, 4 Jan 2021 11:03:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     kgene@kernel.org, krzk@kernel.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
Subject: Re: [PATCH] serial: samsung: Checks the return value of function
Message-ID: <X/LoBqoVf9H6wI8U@kroah.com>
References: <CGME20210104082958epcas5p12c5c0e78dec7f106375b4f507a3b152b@epcas5p1.samsung.com>
 <20210104083551.1393-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104083551.1393-1-m.shams@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 04, 2021 at 02:05:51PM +0530, Tamseel Shams wrote:
> "uart_add_one_port" function call may fail and return
> some error code, so adding a check for return value.
> If it is returning some error code, then displaying the
> result and returning back from there.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 6ef614d8648c..a220ba166ffe 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2072,7 +2072,11 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	}
>  
>  	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
> -	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	ret = uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add uart port, err %d\n", ret);
> +		return ret;

Why are you not unwinding the other logic that happened above?  If this
fails, you need to properly do that as well, otherwise the driver is
still registered, right?

thanks,

greg k-h
