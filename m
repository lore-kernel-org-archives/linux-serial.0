Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BD2940D;
	Fri,  9 Aug 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221966; cv=none; b=EvU0wiUqGEhsQmFYa9Jyt/V8063GP1pdegkg0TwzKaJQpsAFG/iz6xtLeTOHmK781Mdim7ZoewhBLfoLrDQnfiNH8HJofKqQpo2+as+Hgw/1VhbmaNFTwir487En+iKlglYouSBWJFAY6M6jySOV5zMpIE+BTbzovTvJzxUNbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221966; c=relaxed/simple;
	bh=t4l+MwG7NrsXOm2ouLdYt3dA/kbtKWYbztJk+8tBBsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiEyTDg37u79BA5O9hbu3labs+zL3YpmPGIUkq+HCOeaBYER7rOm6I7ehXjDxW6lLFMkksrSli/8SjxxfUv8fCPWuns65HZ5eXwDEVGsRGXkmKgItGTaJzbNfP2itJbqprpuKjTj/eUxG6fNK0DlyunbtV+/FX37SplCmyZf3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hLci8FdM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hLci8FdM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A13820002;
	Fri,  9 Aug 2024 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723221955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpE2A/OHON4dZm6Kn/ZhxwJiG215XUnQL6wSsRjpv8w=;
	b=hLci8FdM+HEs3bG4Dpgy/vdMnHLR7XBmfowZ91jsyz9Dg0aO8nef5m1+hv3NVN6sjD4Et4
	dfF80l5qbcd2c0Y4kJ0xiEdKvhraQfrICTQjxLn3b5MShyjHsoi/bfgp8wMMqfqV9dVFaT
	L/TFHhW0JnOCBI//ehkWU2RGxGRCFXVjboBE2ALBVo+fm+mCaPZTOyVf7A4NRg4l1S7nZ6
	hrTSZDdZuSVN67JbV4BkI/PnoEApagKwZVHJQTxU5Aynsg9Bp5HMj/z9oBczyeWiqKJqkg
	jYQj4CW60+yusoU9TCxh22Ap+vLFGjWRR27hWtiC+chvgSoAR7QIf8glNjHo6g==
Message-ID: <f6266cc7-bdf2-413e-929e-1d1c0d7e2786@bootlin.com>
Date: Fri, 9 Aug 2024 18:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel_serial: use the correct RTS flag.
To: Mathieu Othacehe <othacehe@gnu.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, Jiri Slaby <jirislaby@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20240808060637.19886-1-othacehe@gnu.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20240808060637.19886-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

Hi,

Adding Ilpo to the list since he was the author.

Le 08/08/2024 à 08:06, Mathieu Othacehe a écrit :
> In RS485 mode, the RTS pin is driven high by hardware when the transmitter
> is operating. This behaviour cannot be changed. This means that the driver
> should claim that it supports SER_RS485_RTS_ON_SEND and not
> SER_RS485_RTS_AFTER_SEND.
> 
> Otherwise, when configuring the port with the SER_RS485_RTS_ON_SEND, one
> get the following warning:
> 
> kern.warning kernel: atmel_usart_serial atmel_usart_serial.2.auto:
> ttyS1 (1): invalid RTS setting, using RTS_AFTER_SEND instead
> 
> which is contradictory with what's really happening.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   drivers/tty/serial/atmel_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0a90964d6d107..09b246c9e389e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2514,7 +2514,7 @@ static const struct uart_ops atmel_pops = {
>   };
>   
>   static const struct serial_rs485 atmel_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
>   	.delay_rts_before_send = 1,
>   	.delay_rts_after_send = 1,
>   };
Regards,
Ricahrd
