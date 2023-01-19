Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC4C004D4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 15:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjASPD2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 10:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjASPDZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 10:03:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE219018
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 07:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2CF61994
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 15:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96481C433D2;
        Thu, 19 Jan 2023 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674140603;
        bh=jnahgAwG4KDTrmMQmOZJjpwc7inbd5oE0PQlyh+R8jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmJXCyFWoMI6uKHRooB4ea/r3XT178tga4+ws+eJsxXlkr9sLRf305A7Xo3DxOrvR
         AmnHaVkcurh9X88+ja90vXmiSAfV13egCVpwX7gjP4ah4M6qpFPJkrnuJ3WnILkwZd
         3IM8gogXjyC79SYJRNiInmC151Ai/ID4by3s6WkI=
Date:   Thu, 19 Jan 2023 16:03:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     jirislaby@kernel.org, shc_work@mail.ru, arnd@arndb.de,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: clps711x: Fix error handling in
 uart_clps711x_init()
Message-ID: <Y8lbuHVwmnH+DXtn@kroah.com>
References: <20221124061236.31050-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124061236.31050-1-yuancan@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 24, 2022 at 06:12:36AM +0000, Yuan Can wrote:
> The uart_clps711x_init() returns the platform_driver_register() directly
> without checking its return value, if platform_driver_register() failed,
> the clps711x_uart is not unregistered.
> 
> Fix by unregister clps711x_uart when platform_driver_register() failed.
> 
> Fixes: bc00024502ed ("serial: clps711x: Driver refactor")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/tty/serial/clps711x.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index 404b43a5ae33..d6284244da1d 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -546,7 +546,13 @@ static int __init uart_clps711x_init(void)
>  	if (ret)
>  		return ret;
>  
> -	return platform_driver_register(&clps711x_uart_platform);
> +	ret = platform_driver_register(&clps711x_uart_platform);
> +	if (ret) {
> +		uart_unregister_driver(&clps711x_uart);
> +		return ret;
> +	}
> +
> +	return 0;

Minot nit, but this can be cleaned up to be even smaller:

	ret = platform_driver_register(&clps711x_uart_platform);
	if (ret)
		uart_unregister_driver(&clps711x_uart);

	return ret;

thanks,

greg k-h
