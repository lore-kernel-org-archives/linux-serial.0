From: srinivas kandagatla <srinivas.kandagatla@st.com>
Subject: Re: [PATCH 1/3] serial: st-asc: Use SIMPLE_DEV_PM_OPS macro
Date: Tue, 4 Mar 2014 09:13:13 +0000
Message-ID: <53159929.8020906@st.com>
References: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:49950 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677AbaCDJTt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Mar 2014 04:19:49 -0500
In-Reply-To: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Thanks for the patch, It looks ok to me.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

On 27/02/14 11:43, Jingoo Han wrote:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/tty/serial/st-asc.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 21e6e84..93e27b9 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -883,9 +883,8 @@ static struct uart_driver asc_uart_driver = {
>  	.cons		= ASC_SERIAL_CONSOLE,
>  };
>  
> -static const struct dev_pm_ops asc_serial_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(asc_serial_suspend, asc_serial_resume)
> -};
> +static SIMPLE_DEV_PM_OPS(asc_serial_pm_ops, asc_serial_suspend,
> +			 asc_serial_resume);
>  
>  static struct platform_driver asc_serial_driver = {
>  	.probe		= asc_serial_probe,
> 

