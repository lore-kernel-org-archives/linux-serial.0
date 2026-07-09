Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD12F49FD;
	Thu,  9 Jul 2026 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577619; cv=none; b=IhU/+buK1yPRqJmh4kt9BaL6BtxQgCGEPI7WvczHKD80iK3psN5BOWroUqAVIDLZprOBkYWxZDN70UBi0yi1CB+GNRbV8gUQKevCLYmu8aBlQWY8fuTTiMsagIa+f1nXDZEyQ93tDEpVLdxg2XpZ/UHoh7R/ZEraaP3UQl6bszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577619; c=relaxed/simple;
	bh=ny7gKZaoBh/5pt3ew3NmNzsfkA3kQtiA4Lis/q870Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8VYXjQdBT2qYxGNGtZB+ekpsFm3bxhFz6oNEpbZL6cEsjBMxIOPhphoBYX10BVzQv3kR2omLjDAo+2JaJ7f8GMzLMSY5kMEyMW/fil4ZpnkdworcPcvE+elWcI+WL39pxSB4A/e3ZvjYWDBmJ1vp/bH09tcJdW6LZvJa1hddwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3epYqeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3epYqeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02021F000E9;
	Thu,  9 Jul 2026 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577618;
	bh=mSgvoY4fjEHOrUrVemDk48OKC91OfXxcjmGp61T04vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o3epYqeV9mnd0iM/1IO/P/7f00pSJrm4utMLjjbjUzXOEDz1fQem+91zHFWF//1ty
	 rnpi4szImJdTDJ0yPJjEAvd2W9rc4OiWYiGIeh66C/HpBKDLPq4BMbAQf974F0D7gc
	 u+dzMiK7ssyJP2npWr9sd+zVWcLb1azLM6+Ud/tZSRbQy+qQokcDVdB0kV1AL9YJB1
	 vN6iajeoJPHaVy25fMMwdMYVnM9B2GC20gKl7nNAnP1QFx+QVX7Ahn7f5aHbVqPZ9g
	 CLUy24wDDtKT9nH6hnEuGBLs7wrizhWVlJ7rzopdCenHbVIbMk93aQXwrJhGYyL7xM
	 wXjolRZPr4ihA==
Message-ID: <0eee4eba-c3aa-4872-b0d8-9bd714441883@kernel.org>
Date: Thu, 9 Jul 2026 08:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] serial: 8250_mxpcie: offload XON/XOFF flow
 control to MUEx50 hardware
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
 <20260709053314.435629-6-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260709053314.435629-6-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09. 07. 26, 7:33, Crescent Hsieh wrote:
> The MUEx50 UART can handle in-band software flow control (XON/XOFF)
> directly in hardware.
> 
> Program the on-chip XON/XOFF characters from termios settings and enable
> the corresponding MUEx50 flow control modes when IXON or IXOFF is
> requested. Provide throttle and unthrottle callbacks so RX can be
> stopped and resumed cleanly.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_mxpcie.c | 55 ++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
> index 0f5323581bba..0cdb7984cbcc 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -53,13 +53,31 @@
>   #define MOXA_PUART_SFR_950	BIT(5)
>   
>   /* Enhanced Function Register (EFR) */
> +/*
> + * EFR[1:0] - In-Band Receive Flow Control Mode (Compare XON/XOFF):
> + *	00b (0x00) = Disabled
> + *	01b (0x01) = Recognize XON2 & XOFF2 as XOFF character
> + *	10b (0x02) = Recognize XON1 & XOFF1 as XOFF character
> + *	11b (0x03) = Depends on EFR[3:2]
> + * EFR[3:2] - In-Band Transmit Flow Control Mode (Insert XON/XOFF):
> + *	00b (0x00) = Disabled
> + *	01b (0x04) = Use XON2 & XOFF2 as XOFF character
> + *	10b (0x08) = Use XON1 & XOFF1 as XOFF character
> + *	11b (0x0C) = Reserved
> + */
>   #define MOXA_PUART_EFR			0x0A
> +#define MOXA_PUART_EFR_RX_FLOW		0x02	/* Recognize XON1 & XOFF1 as XOFF character */
> +#define MOXA_PUART_EFR_TX_FLOW		0x08	/* Use XON1 & XOFF1 as XOFF character */

For the above, see below:

>   #define MOXA_PUART_EFR_ENHANCED		BIT(4)
>   #define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
>   #define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
>   #define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
>   #define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)

So instead of the above new comment and defines, what about:
#define MOXA_PUART_EFR_RX_FLOW_DISABLED		0x0
#define MOXA_PUART_EFR_RX_FLOW_XON2_XOFF2	0x1
#define MOXA_PUART_EFR_RX_FLOW_XON1_XON2	0x2
#define MOXA_PUART_EFR_RX_FLOW_COPY_TX		0x3

Similarly for TX. And the use below:

> @@ -169,6 +187,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
>   		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
>   		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>   	}
> +	/* Set on-chip software flow control character */
> +	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
> +
> +	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);
> +
> +	if (I_IXON(tty))
> +		efr |= MOXA_PUART_EFR_RX_FLOW;

This would become:
unsigned val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XON2 : 
MOXA_PUART_EFR_RX_FLOW_DISABLED;

efr = FIELD_SET(MOXA_PUART_EFR_RX_FLOW_MASK, val, efr);

> +
> +	if (I_IXOFF(tty)) {
> +		efr |= MOXA_PUART_EFR_TX_FLOW;
> +		up->port.status |= UPSTAT_AUTOXOFF;
> +	}

Similarly.

>   	serial_out(up, MOXA_PUART_EFR, efr);
>   }
>   

thanks,
-- 
js
suse labs
