From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 02/15] serial: ar933x: remove unnecessary
 platform_set_drvdata()
Date: Tue, 25 Jun 2013 10:04:51 +0900
Message-ID: <000201ce713f$ff576900$fe063b00$@samsung.com>
References: <008701ce4af8$ac2d5540$0487ffc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39932 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3FYBEy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Jun 2013 21:04:54 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX000R9CC3GJ50@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 25 Jun 2013 10:04:52 +0900 (KST)
In-reply-to: <008701ce4af8$ac2d5540$0487ffc0$@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Barry Song <baohua.song@csr.com>, Tony Prisk <linux@prisktech.co.nz>, Shawn Guo <shawn.guo@linaro.org>

On Tuesday, May 07, 2013 4:59 PM, Jingoo Han wrote:
> 
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Hi Greg,

I will squash everything down into one patch with the ACKs,
and send it again.

Best regards,
Jingoo Han

> ---
>  drivers/tty/serial/ar933x_uart.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
> index 27f20c5..9824dfb 100644
> --- a/drivers/tty/serial/ar933x_uart.c
> +++ b/drivers/tty/serial/ar933x_uart.c
> @@ -703,7 +703,6 @@ static int ar933x_uart_remove(struct platform_device *pdev)
>  	struct ar933x_uart_port *up;
> 
>  	up = platform_get_drvdata(pdev);
> -	platform_set_drvdata(pdev, NULL);
> 
>  	if (up) {
>  		uart_remove_one_port(&ar933x_uart_driver, &up->port);
> --
> 1.7.2.5


