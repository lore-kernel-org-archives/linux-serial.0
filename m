Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081350;
	b=LNKQ+DDmH2KPTgbUw2qMa+BYvG1piZB9Ku/YwjNEdCRdfpz2+ZeosjHt+ZHPHkcmkaNU
	 sexlXUoMvL/Y0VXN7eyTVqD/fR3KjehkaI95Qvae8NCOu+bUr9QokUHtWUr6xhBWDVfxo
	 pIt+mPZeSCZbFBm2cmSZJlYzgyo6nJKMnxWoSOG7RioARCoeG6jcrGTn/RAHgtDCHS0fh
	 a5Kwxs92yWR2mcjvgpy3eT3bbk4mDa6OopThcCeBPW15epGgNnU5PZDVgL1Zfc15TrhJM
	 gKEX3Dtgkjx8uYGymlUuhOQf7/dr33uL7hTOCYFwnoprQv/1ygtg9/zUrpxxsMtF+2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081350;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PvUfohqTveZnoV3DgFtksSsIE02EL0Iiz/+3F4CWDFk=;
	b=W1NUrD3wzlHv6oSGVq/zjq9XnGsyPOmhQWLOHlmWZzRyfa9S16i+H9JzXl65tgW94Nka
	 dBkDXDoyAzUxtwJ8Ind+YLv93ch2ME/nFYWLtlvNhGG0nWhPCZxpLPha46p/9xL7NHo5m
	 Bu8oKFprN1xutZ6oY/MZGhL2DTZ7h0vmSHJyYdQjf+o3nh9ItP1yo+sy/FUlU1ErNXswu
	 PW9Ug2D8qXyyXpkqOxnDO3ab1GHAnQrrv5kcEZAAAMpR5Z7LcgJ2cVLiDx3T62U8Wl5F5
	 eQpzEG07qI6ytGOkYj3o7KIhz0wLiF1coccP0dyE9SCmy7JiS/nBhSYB4sJbROHBWBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZY62ca9F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F2606A31A;
	Tue, 27 Oct 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZY62ca9F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C75C1F01825;
	Tue, 27 Oct 2026 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793081349;
	bh=PvUfohqTveZnoV3DgFtksSsIE02EL0Iiz/+3F4CWDFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZY62ca9FjdH0FUeYesY6VkwRjc+4tmxUFt0orOxyEXsd2joZPCANqPk2eZR7MseYl
	 S8jLo+ASnLYPll5PcE7izn+lKIMotVAEiPe0Sr4iUJM3115VYr+2rBc7Y2ZELbwLhV
	 GBWwgH+UPmjiDEZIJzvs5wxfG/gcxmOdRS/WpqRJSPQOy+8tHK5EnC7tm/DgFK7U5G
	 pB8dRRp5oi9b7OzppcZ9SaNQdsOOB7z4BFEpsaLOjMhcz3h3eBdOwLSXjz61k0QY12
	 PYHDQCkFMnMvA2AgQozqJ5NmIW3N2v2Wqnq4y8GWRXC0mYAVxfBJttA1HFgaloaFze
	 dTLE02M93gWlQ==
Message-ID: <53624662-e94e-4fcb-9902-7fa4143c7689@kernel.org>
Date: Tue, 27 Oct 2026 07:09:05 +0100
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
Subject: Re: [PATCH] serial: 8250: clear RX trigger callbacks when removing a
 port
To: James Hilliard <james.hilliard1@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 10. 26, 22:05, James Hilliard wrote:
> serial8250_unregister_port() removes the device supplied by a driver and
> normally re-registers the persistent slot as an unknown legacy port. The
> slot retains its RX trigger callbacks and sysfs attribute group, so the
> replacement rx_trig_bytes attribute can still call the removed driver's
> code. Unloading that driver leaves the callbacks pointing into freed
> module text.
> 
> Clear both callbacks after uart_remove_one_port() has drained the old
> sysfs users and before registering the fallback port. Its RX trigger
> attribute then uses the generic handlers, which reject a port without
> FIFO capabilities.
> 
> Also copy the callbacks unconditionally during registration. A replacement
> port without custom handlers must use the generic implementation instead
> of inheriting callbacks from the previous owner of the slot.

I don't understand why this is a problem only for the two callbacks. 
Care to elaborate?

> Fixes: 8a6c543cf8b3 ("serial: 8250: allow UART drivers to override rx_trig_bytes handling")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 42319843cb5b..c638e10c43e2 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -830,10 +830,8 @@ static int __serial8250_register_8250_port(struct uart_8250_port *uart,
>   		uart->port.get_divisor = up->port.get_divisor;
>   	if (up->port.set_divisor)
>   		uart->port.set_divisor = up->port.set_divisor;
> -	if (up->port.get_rxtrig)
> -		uart->port.get_rxtrig = up->port.get_rxtrig;
> -	if (up->port.set_rxtrig)
> -		uart->port.set_rxtrig = up->port.set_rxtrig;
> +	uart->port.get_rxtrig = up->port.get_rxtrig;
> +	uart->port.set_rxtrig = up->port.set_rxtrig;
>   	if (up->port.startup)
>   		uart->port.startup = up->port.startup;
>   	if (up->port.shutdown)
> @@ -953,6 +951,9 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
>   	}
>   
>   	uart_remove_one_port(&serial8250_reg, &uart->port);
> +	/* The fallback port must use the generic RX trigger handlers. */
> +	uart->port.get_rxtrig = NULL;
> +	uart->port.set_rxtrig = NULL;
>   	if (serial8250_isa_devs) {
>   		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
>   		uart->port.type = PORT_UNKNOWN;

thanks,
-- 
js
suse labs
