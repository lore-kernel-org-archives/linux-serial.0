Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95322207A02;
	Fri, 10 Jan 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496807; cv=none; b=YpnPnvigjqqGknPIEQdeaFhbukduFA+0RzuLlbkXWy67ks3hBsmN9kgNf0gayymMmgwrhvtLTWwA91Viyq92qXP8UVPAVP0+1toCXiYPuBU7A3KduZ5Cj8/1Tgh9l8YRBbvIAK8WbV07HB7kJ3Zky690poI3cshhhMQeJ9cEvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496807; c=relaxed/simple;
	bh=8GAdABkq5cheJjKrqWzxBbeJdfZkCT4QwrWlGbWqLls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhTIOB4Py2t5Du6OauviQtGJrSkMHQBmS3Diw5yDZb2MgE6SCtpTKQHLTS6pRk7u4JFUpq/z7kH8G06aJh62Fpf6Gmw3NSilpDcaC3Z6yDUHuhGUBig/LYPWn5xmxlmeUElZClef4oVr+hq5Ti98A8Out0rpXoRZAZbYgCCy2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MJK3vIa3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MJK3vIa3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04E07240002;
	Fri, 10 Jan 2025 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736496796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxSn76+HXS+LBGws2ThHr+S6dBafkbCiD1wgZAt8HHw=;
	b=MJK3vIa31kDZMfbecXlWrbQJ0sgpg90ldaVb/ml7+HNKPLoPIdk2kqKNEq7XNEDgkhem6m
	Ve53lgB4VZ0oM48fmWQDvIPt/nA9nkIrjcY+IWR3nKN3122VKbqNHv/1Ap36fFhY9hWf6b
	H1outDJitoPvgf8rIt5GzP/HbUtEEt+cib4mkBTKjaUN9K0+AzqMVIo4onHYw4nkvwxjzf
	PC85PuLOS0SDc62i38/gdCyig4zokF5TjBEckWCO9f5sawfOYXya90ivx+2pE8UDSjCvaX
	fx8vViJmTwk/C6X62X1GKwGt2lNxZg6d/J3mACDEtItIroOVaiwobOJROq3vQQ==
Message-ID: <baf1d437-917b-4fe6-bab8-65dfb3ac1e6a@bootlin.com>
Date: Fri, 10 Jan 2025 09:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel_serial: Use of_property_present() for
 non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250109182053.3970547-1-robh@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20250109182053.3970547-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

Le 09/01/2025 à 19:20, Rob Herring (Arm) a écrit :
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> As of_property_present() returns a boolean, use that directly
> and simplify the code a bit while we're here.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/tty/serial/atmel_serial.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0cf05ac18993..f44f9d20a974 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1727,26 +1727,16 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
>   
>   	/* DMA/PDC usage specification */
>   	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> -		if (of_property_read_bool(np, "dmas")) {
> -			atmel_port->use_dma_rx  = true;
> -			atmel_port->use_pdc_rx  = false;
> -		} else {
> -			atmel_port->use_dma_rx  = false;
> -			atmel_port->use_pdc_rx  = true;
> -		}
> +		atmel_port->use_dma_rx = of_property_present(np, "dmas");
> +		atmel_port->use_pdc_rx = !atmel_port->use_dma_rx;
>   	} else {
>   		atmel_port->use_dma_rx  = false;
>   		atmel_port->use_pdc_rx  = false;
>   	}
>   
>   	if (of_property_read_bool(np, "atmel,use-dma-tx")) {
> -		if (of_property_read_bool(np, "dmas")) {
> -			atmel_port->use_dma_tx  = true;
> -			atmel_port->use_pdc_tx  = false;
> -		} else {
> -			atmel_port->use_dma_tx  = false;
> -			atmel_port->use_pdc_tx  = true;
> -		}
> +		atmel_port->use_dma_tx = of_property_present(np, "dmas");
> +		atmel_port->use_pdc_tx = !atmel_port->use_dma_tx;
>   	} else {
>   		atmel_port->use_dma_tx  = false;
>   		atmel_port->use_pdc_tx  = false;

Acked-by: Richard Genoud <richard.genoud@bootlin.com>

The code is indeed nicer like that!
Thanks!

Regards,
Richard
