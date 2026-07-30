Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EC33F8B2;
	Thu, 30 Jul 2026 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391320; cv=none; b=rW6aRtoxgzzNLvhFfeYGEV2q4tTRl6dKxJcBakgWz47vpUoJ/6Qlu1AJNMG/RjDCiXrdRMHdt4R06kSQsRcDb07QxAuFfVSX+vCrfJSJpxoLkVCkqqSgabUDq0Qq2uKXvuC6GAa6lgIrftciSQWz2tXXmhTB6neHX95PHRmvwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391320; c=relaxed/simple;
	bh=CHRcDAcvCwYt7QmhZ9W30DATbHC2RoGiI/hskcwBRs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2Dn4gB1KGVCYcGJhueRtiG2b9XmPO+OuM/lySy4zPvmMqIJpl3h9GLQ6mdZwVZgvEUuYcz6XAfteVsExvyHL2OkrqolXFpf6JSsT+ZbYW1tvHj3nfv3ZGVr71HLDLC1Q5oa+QcFtzJWGDy8FBo0cMYqxkTpWvrc2YWyrSd0iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g++jFDeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g++jFDeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5D1F000E9;
	Thu, 30 Jul 2026 06:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785391314;
	bh=vzf5E9YWmAZhDySeQdCiaA8p9qnrfA18758sslrcdpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g++jFDeQmsP0fpaGxVUet1TluXjoHAC16+WEi0wcahlFrxUCP3V+/i7z0dqbP3DIn
	 UQKqzComer9/SqrBVRHVCvv6HQnZ+z9jwjCkvoZE3prcGqzPX+Bhy05AOm4ZI8w/M5
	 pbkOjwvu2EsAfPsQ5CLdgyYGtBOcgC7KEUQ65wh4nNng7NGvh8gbGYBP8MtWqn8sJH
	 rZD5tdUfhDzUPm8if0xwu+uMBnVzx0VH3U5+o68tDVlYpobKdUO3NQFn7Xgqex9Jzb
	 +BiS24s/GtK3jf3O4JVGXmIFfj8gh69Q/HPK2QofMrKXhw/rWi0PLkocGLBEYQSCVl
	 XxV1JI7VFBv7w==
Message-ID: <1abc49c7-fca8-4aea-ab5e-0881176de840@kernel.org>
Date: Thu, 30 Jul 2026 08:01:49 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] serial: 8250_mxpcie: add break support for RS485
 using MUEx50 features
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
 <20260729060602.492430-12-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260729060602.492430-12-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 07. 26, 8:05, Crescent Hsieh wrote:
> On MUEx50, break signaling under RS485 requires a driver-specific
> sequence and cannot be handled correctly by the generic 8250 break
> implementation alone.
> 
> Implement a mxpcie break_ctl callback that performs MUEx50-specific
> break handling when RS485 is enabled and fall back to the default 8250
> break handling for other modes.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_mxpcie.c | 49 +++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
> index 927615f2d724..878fc64c4451 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -54,6 +54,7 @@
>   
>   /* Special Function Register (SFR) */
>   #define MOXA_PUART_SFR		0x07
> +#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
>   #define MOXA_PUART_SFR_950	BIT(5)
>   
>   /* Enhanced Function Register (EFR) */
> @@ -384,6 +385,53 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
>   	return 1;
>   }
>   
> +static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	struct tty_struct *tty = port->state->port.tty;
> +	unsigned char tx_byte = 0x01;

Do you actually need the variable? If so, it should be u8, given you 
call byte and use it as such.

> +	unsigned int baud, quot;
> +	u8 sfr;
> +
> +	guard(uart_port_lock_irqsave)(port);
> +
> +	if (break_state == -1) {
> +		serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
> +		serial_dl_write(up, 0);
> +		serial_out(up, UART_LCR, up->lcr);
> +
> +		serial_out(up, MOXA_PUART_TX_FIFO_MEM, tx_byte);

thanks,
-- 
js
suse labs
