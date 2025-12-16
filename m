Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25934DB53
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899896; cv=none; b=CBiemqt18fCLTvI0+61/88hQFZL3+RNwR7+ad9wqBd+Iv/DzUEqMgLdAl54dgM81v2h8zi+iGUPar9/pqw1eCGtB0NCONlUupi+bt1NOgB4VBRJl7UmVZ2cm/QSnKUvNRWXI8y5d2OuRKtnXHH/Ho2hdWpolTUH6bhBK0jmeKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899896; c=relaxed/simple;
	bh=UIWAeJbgAFn1kFE20QeLwfWB5TzrWBNThWxnTglJfw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM/uRQD3DmGHPSzMQbg6FeF919kNcAPAqL3sRGss76gXWF46Z1mXX6NLrpzopdxvkb8XcuTOF5UrejX6aJkMdeNpvIopm5VDxAjFtsZoK+IStgj1BceuoSis0cBwRiKHGypjbBYEs6QtzVg6FVN/8LpJOOx6KloJr935H5Yux/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A06oI68C; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A06oI68C"
Message-ID: <7f42e053-b7d6-4216-9ed1-c496db3a54d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765899882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWhAy9+9PNeOPwF/R4/xqInvj31Q4dE74xVNHSXPp8A=;
	b=A06oI68CcEav+v+vYa/lHCpPzjs52pwkzI5ahVnbFirnpvlIYTrsAMRD2nenKuaVv3BWgT
	UhwzqRJ9tPqUGFMdfK6T8QlTOGgzIcMQEzce2TFTeEQhYNl6a5a1qtg27Rt/foouw5b9RW
	Lu4l2a79fIqlZJddYQPMEozwDcYqL+k=
Date: Tue, 16 Dec 2025 10:44:34 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] serial: xilinx_uartps: fix rs485 initialization at boot
To: "j.turek" <jakub.turek@elsta.tech>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: michal.simek@amd.com, namcao@linutronix.de, tglx@linutronix.de,
 zack.rusin@broadcom.com, hshah@axiado.com, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251216152641.196221-1-jakub.turek@elsta.tech>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251216152641.196221-1-jakub.turek@elsta.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/16/25 10:26, j.turek wrote:
> When 'linux,rs485-enabled-at-boot-time;' property is enabled in device-tree
> and there is no rts-gpio defined there is NULL pointer dereference in
> function 'cdns_rts_gpio_enable' because 'cdns_uart->port->membase' pointer
> is not set at this point
> 
> Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
> 
> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
> ---
>  drivers/tty/serial/xilinx_uartps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index c793fc74c26b..1e4d54fd5762 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1816,8 +1816,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  		console_port = port;
>  	}
>  #endif
> -	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> -		cdns_rs485_rx_setup(cdns_uart_data);
>  
>  	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
>  	if (rc) {
> @@ -1826,6 +1824,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  		goto err_out_pm_disable;
>  	}
>  
> +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart_data);
> +
>  #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
>  	/* This is not port which is used for console that's why clean it up */
>  	if (console_port == port &&

Is probe the right place to do this configuration? Maybe
cdns_rs485_rx_setup should get moved to cdns_rs485_config.

--Sean
