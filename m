Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEDC433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010D96146D
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCWJYQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCWJYL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9176C61984;
        Tue, 23 Mar 2021 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616491451;
        bh=DPywEhpZNo0wJHcWiKZrIfCpAVQnGNuCBlmXyMkMAbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk3u/yo5T+Jhe0wSJKsz1HCe7s9TyipXtva0RG46qwXFV/z4lDtnf6M3yZh1xDZOH
         7vm8LdsQkh9iu4aEbHrstJHXJQT2M0shByGXGoU8YM+tREo9HbOHc8nE0L9HnuMvn9
         tFBt7pSgczjTDdYErf/DiDOXgkSMtoCWOycM5rY4=
Date:   Tue, 23 Mar 2021 10:24:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YFmzuEfpN7zzKel3@kroah.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
> +static struct cortina_uart_port *cortina_uart_ports;

Why is this not a per-device pointer?

> +static void __exit cortina_uart_exit(void)
> +{
> +	platform_driver_unregister(&serial_cortina_driver);
> +	uart_unregister_driver(&cortina_uart_driver);
> +	kfree(cortina_uart_ports);

Should not need to free this here, it should be tied to the device, not
the driver.


> +}
> +
> +module_init(cortina_uart_init);
> +module_exit(cortina_uart_exit);
> +
> +MODULE_AUTHOR("Cortina-Access Inc.");
> +MODULE_DESCRIPTION(" Cortina-Access UART driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 62c2204..1931892 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -277,4 +277,7 @@
>  /* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	122
>  
> +/* Cortina-Access UART */
> +#define PORT_CORTINA_ACCESS	123

Also, no need for this, right?  I would prefer to not add new ids if at
all possible.

thanks,

greg k-h
