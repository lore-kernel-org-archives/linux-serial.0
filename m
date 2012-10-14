From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] serial: clps711x: Add platform_driver interface to clps711x driver
Date: Sun, 14 Oct 2012 07:54:16 +0000
Message-ID: <201210140754.17066.arnd@arndb.de>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59715 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2JNHyV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:54:21 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sunday 14 October 2012, Alexander Shiyan wrote:
> +
> +static int __init uart_clps711x_init(void)
> +{
> +       return platform_device_register(&clps711x_uart_device);
> +}
> +module_init(uart_clps711x_init);
> +
> +static void __exit uart_clps711x_exit(void)
> +{
> +       platform_device_unregister(&clps711x_uart_device);
> +}
> +module_exit(uart_clps711x_exit);

Patch looks good in general, but the above could be simplified to use
module_platform_driver();

	Arnd
