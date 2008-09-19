From: Anti Sullin <anti.sullin@artecdesign.ee>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match serial
 core
Date: Fri, 19 Sep 2008 18:19:53 +0300
Message-ID: <48D3C319.4040605@artecdesign.ee>
References: <1221837111-20107-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.artecdesign.ee ([195.50.213.123]:41701 "EHLO
	postikukk.artecdesign.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYISPos (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2008 11:44:48 -0400
In-Reply-To: <1221837111-20107-1-git-send-email-haavard.skinnemoen@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>

One more bug of mine...

Haavard Skinnemoen wrote:
>  }
> @@ -1491,11 +1498,9 @@ static int atmel_serial_resume(struct platform_device *pdev)
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
> -	if (atmel_port->suspended) {
> -		uart_resume_port(&atmel_uart, port);
> -		atmel_port->suspended = 0;
> -	} else
> -		disable_irq_wake(port->irq);
> +	device_set_wakeup_enable(&pdev->dev, atmel_port->may_wakeup);
> +
> +	uart_resume_port(&atmel_uart, port);
Just now noticed - these two lines should be switched.
>  
>  	return 0;
>  }



-- 
Anti Sullin
Embedded Software Engineer
Artec Design LLC
Akadeemia tee 23A, 12618, Tallinn, Estonia
http://www.artecdesign.ee 
