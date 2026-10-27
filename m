Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081773;
	b=NAcx4tyTbg/WS9yE1p7sg9TzK8mhKuYyEYjZehwxYTc9nQK5P5a7mkycr4c+C6w91Pay
	 16d/9tlvc+g1fswZDnZCsOixU48VSNjEQPH8dQv0a98lJ4iGucewpFFBrvNIXaH9psD3w
	 6h4aExALSx54zfUdsDwtWKQ4ZMvF/ZPgNPGQlQ2zXMvNxdqhdELOUoBWYySx4HqxSVtxc
	 S41E3KahSRjgninNQlgeV59MJEf3Zpb3LTx06uXzBNXycDkYaz3Myshu33DXKAFCVjBK2
	 UVpw7W6ARfEn3Xn70s8+Ky/lniincxBxyWvUJ2BrggLQr3+wKr7QOSZupJhwCua7r5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081773;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=uvoFAdGfaZ4vmb8FThF11NeU4sr1Yi3mbqW/0R0Xc/4=;
	b=tdo4Fn9dN8CSQe5tfs80oH2inW1e0XgHHk9Vyw0+ghQCuVgqy7DjOIbv2DUXkVXfrHWB
	 /v1EIFg/PpoIGz8XFllJPkLXfwTrlSxHH876Gb8NXQX4iLaQKE7frclUh946a9X93UmA6
	 7EeOzc7UWBu6NETswaf+SGbGaE7nscKKXMY91GqJ8yBiFpbqQ8h5T6Ndr7g2dCXq7QFVT
	 Apfl4fpFvb6jgFJF4+8mXp8n28YV9RHoc6kZOErdSFkgTQg3hGUpw+Th70vGh0ozAvKr/
	 gslTe7HY3hySn6jo4pF7g6mT9WnweBmDRa9XPItbBWTxkZzRvambag4iuUo2Ddyn4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNl64iyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA07606A31A;
	Tue, 27 Oct 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNl64iyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1361F01825;
	Tue, 27 Oct 2026 06:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793081772;
	bh=uvoFAdGfaZ4vmb8FThF11NeU4sr1Yi3mbqW/0R0Xc/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gNl64iyIyZ4W8GCcXum/V4JdJxjcGeaRNkWl7qKsaRp/BFaacPW33xuthTBsNIuYC
	 NrhSYSSjYD4iOKkYysX4kfSyrQ+AbHDwYohMoK7vccm6mARdHkB9C5XM3pGSUpHSG2
	 1CJpfcUzrsMbsSYE/53UAbKFFvbAITf3JlYdlo5xeFLH/N8hlVWz0eH/l/JgzvLVta
	 T3/rBMXkprZ4qwOSnFmQzVABINNXqc4NIgitAENXIUbOnH7E3/DtQkzQ0Zu5t3Cf0K
	 0tNREa0hYCgFMyXZE+oqEpjtP832mky/A7AbpGVTAZE0qtTRvEPUQ0XZWq9h0V+NKI
	 miHlkUNqsHI8g==
Message-ID: <66361595-cbda-413f-9559-9fae22001bbd@kernel.org>
Date: Tue, 27 Oct 2026 07:16:08 +0100
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
Subject: Re: [PATCH v3 3/4] serial: 8250_dw: configure the Allwinner H616 UART
To: James Hilliard <james.hilliard1@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-3-286fc1b8c3c1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 10. 26, 22:22, James Hilliard wrote:
> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
> 
> Keep PORT_16550A and preserve the FIFO size read from firmware by
> uart_read_port_properties(). Use it for the transmit load and derive the
> receive thresholds from the documented 1-byte, quarter-full, half-full
> and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128 and 254
> bytes; the normal 16550A half-full FCR setting selects 128 bytes.
> 
> Serialize trigger changes with termios and hold a runtime PM reference
> while programming FCR, preserving the FIFO contents. Propagate runtime
> resume errors before changing either the FCR shadow or the hardware.
> 
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> DesignWare termios path selects hardware CTS handling, so the capability
> must be present for the corresponding hardware control to be enabled.
> 
> Select the fixed configuration through the platform setup callback.
> H616 has debug-divisor and RS485 control registers at the offsets used to
> detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> those probes and retain the BUSY-safe integer divisor hook and software
> RS485 handling.
> 
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather than
> an independent baud-rate generator.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_dw.c | 75 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 9c171c5775a6..557832254c37 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -19,6 +19,7 @@
>   #include <linux/io.h>
>   #include <linux/lockdep.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/property.h>
> @@ -648,6 +649,73 @@ static void dw8250_setup(struct uart_port *p)
>   	dw8250_setup_dma(p);
>   }
>   
> +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, unsigned int trigger)
> +{
> +	switch (trigger) {
> +	case 0:
> +		return 1;
> +	case 1:
> +		return p->fifosize / 4;
> +	case 2:
> +		return p->fifosize / 2;
> +	default:
> +		return p->fifosize - 2;

These constants are counterintuitive. Can you pass the fcr masked, 
unshifted and do:
case UART_FCR_TRIGGER_1:
   ...
case UART_FCR_TRIGGER_4:
   ...
...
instead?

> +	}
> +}
> +
> +static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	guard(uart_port_lock_irqsave)(p);
> +
> +	return dw8250_sunxi_rxtrig_bytes(p, UART_FCR_R_TRIG_BITS(up->fcr));

Here:
up->fcr & UART_FCR_TRIGGER_MASK

thanks,
-- 
js
suse labs
