From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 14/15] serial: vt8500: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 20:17:18 +1200
Message-ID: <5188B88E.9050700@prisktech.co.nz>
References: <009301ce4af9$eecae6f0$cc60b4d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:57978 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758231Ab3EGIRQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:17:16 -0400
In-Reply-To: <009301ce4af9$eecae6f0$cc60b4d0$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org

On 07/05/13 20:07, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/tty/serial/vt8500_serial.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 1a8bc22..053de1b 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -630,7 +630,6 @@ static int vt8500_serial_remove(struct platform_device *pdev)
>   {
>   	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
>   
> -	platform_set_drvdata(pdev, NULL);
>   	clk_disable_unprepare(vt8500_port->clk);
>   	uart_remove_one_port(&vt8500_uart_driver, &vt8500_port->uart);
>   
Acked-by: Tony Prisk <linux@prisktech.co.nz>
