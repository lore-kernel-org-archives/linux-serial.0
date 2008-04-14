From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] avr32: don't offer SERIAL_8250
Date: Mon, 14 Apr 2008 15:36:24 +0100
Message-ID: <20080414153625.6150e999@core>
References: <20080414141721.GI6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56259 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755122AbYDNOkq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2008 10:40:46 -0400
In-Reply-To: <20080414141721.GI6695@cs181133002.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: hskinnemoen@atmel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 Apr 2008 17:17:21 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This patch fixes the following build error:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/serial/8250.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/serial/8250.c:95:24: error: asm/serial.h: No such file or directory
> make[3]: *** [drivers/serial/8250.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 3cb4ef80d75e118ccfd44f7006aea3db54afb31c diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index b1bbaa0..b0e216d 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -11,7 +11,7 @@ menu "Serial drivers"
>  # The new 8250/16550 serial drivers
>  config SERIAL_8250
>  	tristate "8250/16550 and compatible serial support"
> -	depends on (BROKEN || !SPARC)
> +	depends on (BROKEN || !SPARC) && !AVR32
>  	select SERIAL_CORE
>  	---help---

NAK.

Add an asm/serial.h to the platform as it has PCI so will have 8250 PCI
devices available to it. A copy of the MIPS one should be right.

Alan
