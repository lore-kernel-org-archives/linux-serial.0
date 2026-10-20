Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486066;
	b=OcHvZnvBGfURp09iELsBxU7p+F+/6/7QQqKYozU8c+YIvOcffabnjYU0g+vejhtIVzTW
	 E31FY3MC3nva2ZhHL9XsSUPZRC1VSj4DGW3JmTKJnMEe5w7pMEMRMxzgn+6vBhQpUhZeE
	 Ylk8MOokGmuQycI1UsUim+kkfSLn6/irNR+/FkuaQeLeiZbCetmesyx5SzNvo1aS/lrzm
	 0ojMyPL8qiM2V8ZXHNIwAE9rpTCSpagZn/zHnO+0yXQT21EuEn9rqKXShjaL3WSZuEa4+
	 pbHRsqFxzNg0HO283efVzVh50GEuN3f+RpoeDRX+88gCJ02XxGXAGYFHWW58IEwXRlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486066;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=IB8GwhzcGxUoXiq+8nwTsLkT0LxHk6EGeaIdo3q2Cok=;
	b=b4qBLWEnz6FqlRbboNmrCKy7NVFIBR9a3q0lWngKtYVRSs98BTq3vG2SD5w/rsbwfQyA
	 QvDTAT0+wC2VYvhAVvZL1/IT4VJKniG2IMXt/3PfRgLL6j6zCbUDYNQe2zjdE88Je+leA
	 DbD1siPNOUeV8qWHFJbQEYhd4qfXYCQXcviRdV6NTw8SvyBW3FMUWkyjs+2u2BoiUKvIZ
	 Jffqd1XVgHuFh43a06tFI/vA0jK0c11XVo5eYyQZj7iX2qcvDVTkrQ+YgzNkEBpmem27G
	 rZQT5i/mWh0VCpAksD7ySktpMVkwhts6LW44WxG33yNBPhZiu8qjqRCujyqquvuwRfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TEy4gGD+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3160A2612
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC3160A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TEy4gGD+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C9EBE1A12A4
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:47:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96E3960393;
	Tue, 20 Oct 2026 08:47:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE8FC1032840C;
	Tue, 20 Oct 2026 10:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792486062; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IB8GwhzcGxUoXiq+8nwTsLkT0LxHk6EGeaIdo3q2Cok=;
	b=TEy4gGD+QEEA9bz7AXwtA2dWHkOJqZC9HG5kxjTy3ags1owStIkSzusGtkMXN5irtwtDYe
	FHVfHQ7fYe8rRshS8txW8vsyk0KAwPBnkvquDMp1+30c43+Ej4gTCQuypxgQ4TYwjvidJ2
	bqPHo4lRMuw7VSNjLr6DA9mvn9MrB7QIUWf71Q7rL/kUetoXnpjQTwxdqMoL9Qe17gwPo3
	RJO818U6aOYXuylW6r9UUQzHWjRTWHYC1Jr07GGLu/DISoeOQQjRh/0Byzh584aMG7xtvn
	ddCu4px0OeBf2uTm8C2Y672UCliZ0tCSsooazujFxz8l3Vzb1sHH0FE989PvdQ==
Message-ID: <745706ca-58cc-48cb-8ef1-69a69aa34ac2@bootlin.com>
Date: Tue, 20 Oct 2026 10:47:40 +0200
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-serial@vger.kernel.org
References: <20261020084113.853878-1-lijun01@kylinos.cn>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261020084113.853878-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 20/10/2026 à 10:41, Li Jun a écrit :
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled.
> When CONFIG_PM=y but CONFIG_PM_SLEEP=n (a valid configuration that
> enables runtime PM but disables system suspend/hibernation), this
> keeps a completely empty dev_pm_ops structure -- all callbacks are
> NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.
> 
Re-addind my acked-by, since it wasn't gather
(For next time, when you resend a patch, you may add [PATCH RESEND] in 
the subject)

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


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
