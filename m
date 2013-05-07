From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 07/15] serial: imx: remove unnecessary
 platform_set_drvdata()
Date: Tue, 7 May 2013 16:30:33 +0800
Message-ID: <20130507083032.GM1749@S2101-09.ap.freescale.net>
References: <008c01ce4af9$45e6f880$d1b4e980$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:12926
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758436Ab3EGIaT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:30:19 -0400
Content-Disposition: inline
In-Reply-To: <008c01ce4af9$45e6f880$d1b4e980$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, May 07, 2013 at 05:02:50PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/imx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 147c9e1..3d17f5b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1559,8 +1559,6 @@ static int serial_imx_remove(struct platform_device *pdev)
>  
>  	pdata = pdev->dev.platform_data;
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	uart_remove_one_port(&imx_reg, &sport->port);
>  
>  	clk_disable_unprepare(sport->clk_per);
> -- 
> 1.7.2.5
> 
> 

