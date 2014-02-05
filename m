From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: pch_uart: Fix build warning when
 CONFIG_DEBUG_FS=n
Date: Wed, 05 Feb 2014 10:12:03 -0800
Message-ID: <1391623923.2835.1.camel@dvhart-mobl.amr.corp.intel.com>
References: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
	 <000601cf2176$766f7ff0$634e7fd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63873 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaBESM2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Feb 2014 13:12:28 -0500
In-Reply-To: <000601cf2176$766f7ff0$634e7fd0$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 'Johan Hovold' <jhovold@gmail.com>

On Tue, 2014-02-04 at 15:58 +0900, Jingoo Han wrote:
> Add CONFIG_DEBUG_FS to 'char name' in order to fix the following
> build warning, because 'char name' is used only when CONFIG_DEBUG_FS
> is enabled.
> 
> drivers/tty/serial/pch_uart.c:1765:7: warning: unused variable 'name' [-Wunused-variable]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Darren Hart <dvhart@linux.intel.com>

> ---
>  drivers/tty/serial/pch_uart.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 8fa1134..0931b3f 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -1762,7 +1762,9 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
>  	int fifosize;
>  	int port_type;
>  	struct pch_uart_driver_data *board;
> +#ifdef CONFIG_DEBUG_FS
>  	char name[32];	/* for debugfs file name */
> +#endif
>  
>  	board = &drv_dat[id->driver_data];
>  	port_type = board->port_type;

-- 
Darren Hart
Yocto Project - Linux Kernel
Intel Open Source Technology Center

