Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6445FFCF
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343651; cv=none; b=QfVno+aG3HpEpEgqQ4j1NdDwshGV/ZEvF+yQ5fAhb2+Mxzw2FY2szOXcUQyxvAS4klGLFuy1A0O+rycrX5uGrMOHV4NdwPUgFcZ1vpGVW/7qxltottA4Eif32SvnuvOzK1cOwRBF9gkbny0KJxWEtDUifESxPVE3KEIIzIjU7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343651; c=relaxed/simple;
	bh=+PpNwi1vZXqxml2VLergyEeRQSzjLzkApjMsctYbraM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bRF8hesaydfW+0yo+Fg3AjSpAu4Wpwa/YYD1gzj5z5Ci1XqHokXne0V6MVKlm0nYfwkT7VzqUupK9HhpgubmQgIy9ltDw1WdC7mhP/8AHQzsluAfijgSCJ4tGbAuK4GspG+uq0gC8AjTW14Kx1h36FibniD33mAye8RRvKHPIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rmo5b+ZE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rmo5b+ZE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18DBCC653F3;
	Fri, 25 Sep 2026 13:41:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29A646073B;
	Fri, 25 Sep 2026 13:40:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C07A210329294;
	Fri, 25 Sep 2026 15:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790343642; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aqURjQmVUYurOv/7ZRWKH6px/QZh0hv5ba7S/b8JXTQ=;
	b=Rmo5b+ZE3x4/KSY9Ppmxa7mAbK/3NPEmqXeiotMmPhXRAUUvvuMLxfYYezVp7AJAL+8CAn
	16t+iW2/RJlwl1SgJBWFLqHy5KkAEUKH1UEjOVxgw/MyOAkeEJkYk30s3Age8TpD02aTF3
	8Yr13FC8qbY4hRZzFWYvmZRL6Ri3HH8AybHnU9fLl30OJrs3Mv43Y4Q8+QsA5PdSiQHtPD
	LDcawsP3rffpQD9Tb9zLTbUp86VcnmMVhGBcNtLb3ktrAjRx+cT58cEYgT4YXw4FXX12ZL
	bkx0/3FAUGWVCVAhuCWy1U6giT5eLLRb0/aiuvIKvsglwf7PG8loxTkARR5c6A==
Message-ID: <908e8237-f17a-46b1-be55-41a3c9146750@bootlin.com>
Date: Fri, 25 Sep 2026 15:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-serial@vger.kernel.org
References: <20260908113719.4078979-1-lijun01@kylinos.cn>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260908113719.4078979-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 08/09/2026 à 13:37, Li Jun a écrit :
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled.
> When CONFIG_PM=y but CONFIG_PM_SLEEP=n (a valid configuration that
> enables runtime PM but disables system suspend/hibernation), this
> keeps a completely empty dev_pm_ops structure -- all callbacks are
> NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.
> 
Acked-by: Richard Genoud <richard.genoud@bootlin.com>

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>   drivers/tty/serial/atmel_serial.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 5d8c1cfc1c60..c3880259e3bc 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2723,7 +2723,7 @@ static bool atmel_serial_clk_will_stop(void)
>   #endif
>   }
>   
> -static int __maybe_unused atmel_serial_suspend(struct device *dev)
> +static int atmel_serial_suspend(struct device *dev)
>   {
>   	struct uart_port *port = dev_get_drvdata(dev);
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -2765,7 +2765,7 @@ static int __maybe_unused atmel_serial_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int __maybe_unused atmel_serial_resume(struct device *dev)
> +static int atmel_serial_resume(struct device *dev)
>   {
>   	struct uart_port *port = dev_get_drvdata(dev);
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> @@ -2996,7 +2996,7 @@ static void atmel_serial_remove(struct platform_device *pdev)
>   	pdev->dev.of_node = NULL;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
>   			 atmel_serial_resume);
>   
>   static struct platform_driver atmel_serial_driver = {
> @@ -3005,7 +3005,7 @@ static struct platform_driver atmel_serial_driver = {
>   	.driver		= {
>   		.name			= "atmel_usart_serial",
>   		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
> -		.pm			= pm_ptr(&atmel_serial_pm_ops),
> +		.pm			= pm_sleep_ptr(&atmel_serial_pm_ops),
>   	},
>   };
>   

Thanks!
