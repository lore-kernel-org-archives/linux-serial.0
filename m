From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Tue, 05 Apr 2005 09:28:51 -0600
Message-ID: <1112714931.4874.10.camel@eeyore>
References: <20050405140457.GE6885@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:11975 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261784AbVDEP25 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Apr 2005 11:28:57 -0400
In-Reply-To: <20050405140457.GE6885@stusta.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Looks OK to me.

On Tue, 2005-04-05 at 16:04 +0200, Adrian Bunk wrote:
> This patch fixes the following warning:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/serial/8250_acpi.o
> drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> drivers/serial/8250_acpi.c:51: warning: implicit declaration of function 
> `acpi_register_gsi'
> ...
> 
> <--  snip  -->
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old	2005-04-05 15:58:59.000000000 +0200
> +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c	2005-04-05 16:01:47.000000000 +0200
> @@ -9,6 +9,7 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/config.h>
>  #include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> 

