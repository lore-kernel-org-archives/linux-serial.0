Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246A61FDA;
	Tue, 13 Aug 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536412; cv=none; b=qPi/hJa4zl1cp3WlZK1yURNXn6pmz92pEl/MDWmgyOYKyFIpjWc7YK2kM4i6Oi9EBtpsF5i52yuexsafVbVxAz/bj5hOzefjBZJ9chtGiXSENvQ7gDACqm+tfTIErS9t7c4IcTRCWwUM+Mjo/sOz2pcmiEZM/NHDRm2S1nOiGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536412; c=relaxed/simple;
	bh=lRCQuiNobHMBXYSfL9Jb0rozCZiVBAIK+nJJBMDE7k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2O5Dl8ZVyGd4Q4iC1mo6GJJyK5MR3vxGF8VW1u+OFza1tLC6GIuaRQ2IZl+oNsHoRApiD/FhGkfng0II/Om7pQzOSaejzEPqIn79/gUQk8c4cjZBjwyDqx1gjsZPHfsrn9H+6Ebvg/+BgsjxvsjDawZCJsyyHG4xBv3auPlW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=BIglsb3t; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="BIglsb3t"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A457148028B;
	Tue, 13 Aug 2024 09:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1723536001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wehv1/Y6utVzwpAWRYGCv0ZqekTM2rrEH5oNBghZoN8=;
	b=BIglsb3t05HmI9NwE/7MEvr8neiKlsLMtF6wQ0SxiawwKyZq2dPWjMs5gNsptS1+fqTc3y
	Rv7h1KjVijA/v6rySzEh7S0fNkF6cVQ9iSsVKLT1bHoT/Ws50zqJTLaxEBK/BkR1wWgPhS
	ig+tVGLK12V0UwlkxjaY0ivYTyV+cwTyvtwUJvqcHJ7OC74O9WGWd+wmMTbV5tbZ54tLLp
	zi9nlfV9mq979EhvzN3pfP5e5RGxmuuZqykCXf9+BGOxHhb/kXp3vfsKgjcPpQEkR4hFRY
	PgaysLPDBiV5SoZ6i6enfHcOdpm3nT9PXQ+3Tt9T3pFB4cRENH7wxdOYcO9NTw==
Date: Tue, 13 Aug 2024 09:59:51 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] tty: atmel_serial: use the correct RTS flag.
Message-ID: <20240813-absinthe-plaza-70575e847015@thorsis.com>
Mail-Followup-To: Mathieu Othacehe <othacehe@gnu.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240808060637.19886-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808060637.19886-1-othacehe@gnu.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Mathieu,

Am Thu, Aug 08, 2024 at 08:06:37AM +0200 schrieb Mathieu Othacehe:
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

I've seen this warning already, when migrating a sam9x60 based board
from LTS kernel 6.1 to 6.6, so thanks for taking care of this.

I can confirm after applying the patch on top of 6.6.44 the warning is
gone, and RS-485 communication still works on our platform, so …

Tested-by: Alexander Dahl <ada@thorsis.com>

Does this deserve a Fixes tag for the change which introduced struct
serial_rs485 to the atmel serial driver?  Then it should be this:

Fixes: af47c491e3c7 ("serial: atmel: Fill in rs485_supported")

Greets
Alex

> which is contradictory with what's really happening.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  drivers/tty/serial/atmel_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0a90964d6d107..09b246c9e389e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2514,7 +2514,7 @@ static const struct uart_ops atmel_pops = {
>  };
>  
>  static const struct serial_rs485 atmel_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
>  	.delay_rts_before_send = 1,
>  	.delay_rts_after_send = 1,
>  };
> -- 
> 2.45.2
> 
> 
