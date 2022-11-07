Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEBC43219
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 07:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKGHS3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 02:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKGHSO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 02:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBD513D3E;
        Sun,  6 Nov 2022 23:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4906C60E2C;
        Mon,  7 Nov 2022 07:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B846C433D6;
        Mon,  7 Nov 2022 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667805436;
        bh=cKXKT6wAgcAeCgNgRQkls/+1eRtAri5MEC86jKdGjwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdkUrlmPqgqAj/hoxQib20IYNYJwFP6NViizKLJsPT52T26opHZeVns+tzrv4Cx1H
         OcV9VexmyWwmZKEyV45u1/CQKynyLWP9asjG09IFfRt+CTMOc0q2vNP4fYdwDeEGDD
         3NrlmKBi5IR42c2/YTcIbvm/4b6/tS3rS1zi1zf8=
Date:   Mon, 7 Nov 2022 08:17:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        jirislaby@kernel.org, ben-linux@fluff.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.or
Subject: Re: [PATCH] tty: serial: samsung_tty: Fix clk resource leak issue
Message-ID: <Y2iw+QdyfGGNz9pU@kroah.com>
References: <20221107062120.20321-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107062120.20321-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 07, 2022 at 02:21:20PM +0800, Xiu Jianfeng wrote:
> In the s3c24xx_serial_get_options(), calling clk_get() without clk_put()
> will cause clk resource leak issue, this patch fixes it.
> 
> Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 77d1363029f5..8a3bb9832172 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2529,9 +2529,10 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
>  		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
>  
>  		clk = clk_get(port->dev, clk_name);
> -		if (!IS_ERR(clk))
> +		if (!IS_ERR(clk)) {
>  			rate = clk_get_rate(clk);
> -		else
> +			clk_put(clk);
> +		} else

How was this tested?

thanks,

greg k-h
