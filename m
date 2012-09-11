From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 08/14] tty: atmel_serial: add pinctrl support
Date: Tue, 11 Sep 2012 12:33:57 +0200
Message-ID: <504F1395.8070509@atmel.com>
References: <20120810124820.GA20557@game.jcrosoft.org> <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com> <1344603731-32667-8-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:34789 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab2IKKeE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 06:34:04 -0400
In-Reply-To: <1344603731-32667-8-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-serial@vger.kernel.org
> ---
> Hi Greg,
> 
> 	if you don't mind I would like to apply with the rest of the pinctrl
> 	patch series
> 
> Best Regards,
> J.
>  drivers/tty/serial/atmel_serial.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 3d7e1ee..65f891b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -39,6 +39,7 @@
>  #include <linux/atmel_pdc.h>
>  #include <linux/atmel_serial.h>
>  #include <linux/uaccess.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <asm/io.h>
>  #include <asm/ioctls.h>
> @@ -1773,6 +1774,7 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
>  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>  	void *data;
>  	int ret = -ENODEV;
> +	struct pinctrl *pinctrl;
>  
>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
> @@ -1805,6 +1807,12 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
>  
>  	atmel_init_port(port, pdev);
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		ret = PTR_ERR(pinctrl);
> +		goto err;
> +	}
> +
>  	if (!atmel_use_dma_rx(&port->uart)) {
>  		ret = -ENOMEM;
>  		data = kmalloc(sizeof(struct atmel_uart_char)


No: you should branch to "err_alloc_ring:".

Bye,
-- 
Nicolas Ferre
