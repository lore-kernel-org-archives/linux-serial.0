Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355033ABDA8;
	Tue,  6 Oct 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280025; cv=none; b=uoSCsxMaT6JNcyUCft3ouiRA2UOS6P/dWf5kiOoEOUyz2uar8U02ceA7Burl/eKNuwuMmDhcqGRwM4uGgel8kdqwGnK2AA+eSMy00wqsirsPwgBjvwKL9Bpr65GjmRSkTIZf2QHAHmjDt/BI4pnRUd71/TkSxV3FQi6WXtK67ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280025; c=relaxed/simple;
	bh=FLHj0G5aOhXs16x0OKE7+C6AYvH6VvieuGt1QUJ8GBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7t3ut55w56MqAWyuvZ9cYaDmNeF0FIzt8ID/ZoJJ+FExMfRwrjitGblf6zETuLPmL8Vm5AgpJXgB9FDRAmJa02CiULMyRcgGLNvPFWUZNqlRfCzdOmLLXjBaYMkXb8HxnT/Xm1iUD76fao4l/QbZLPWtAbkC6G9I/qn9Bs+k/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q3i20Eq+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q3i20Eq+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D46B1516;
	Tue,  6 Oct 2026 02:47:00 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 483123F763;
	Tue,  6 Oct 2026 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791280023; bh=FLHj0G5aOhXs16x0OKE7+C6AYvH6VvieuGt1QUJ8GBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q3i20Eq+Va1cYGLHzHDjsaxDQ6/8kKdT9HfUX2/YU9b59PkMqzReJ3bYlgbAAACi7
	 MVlx22Wz3O4rozJTYWcAV6Uxl4T3QAkRD0Nv2E/eWhLIzHp5Y4oTvw9/PrA5w/GZCd
	 byo17B/sRhxboDUuQH/48nb+kLyKHpqoHkaAG+w0=
Message-ID: <db561de8-cef7-4945-93ee-b0d434eb806b@arm.com>
Date: Tue, 6 Oct 2026 11:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] serial: 8250_dw: Add Allwinner A733 UART
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Enzo Adriano <enzo.adriano.code@gmail.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
 <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vinicius,

On 10/5/26 19:25, Vinicius Pedrosa wrote:
> The A733 UART is clocked from its bus clock gate, which can't change
> rate. dw8250_set_termios() still gates it around a no-op clk_set_rate()
> on every termios change. That stalls the character being shifted out
> and corrupts it on the wire. Use the existing SKIP_SET_RATE quirk, as
> other SoCs with a fixed UART clock do.
> 
> Offset 0xc0 is the RS485 control register on this SoC (A733 User
> Manual, UART_485_CTL), not DLF. dw8250_setup_port() writes all ones
> there, reads back a nonzero 9-bit value and takes it for a 9-bit DLF.
> Every later divisor change then writes the fractional divisor into the
> RS485 control register. Add a NO_DLF quirk so dwlib skips that probe.

many thanks for digging into this, and superficially it looks like the 
right thing to do. But looking into some manuals, it seems like 
Allwinner added this RS485 support on registers +0xc0, 0xc4 and 0xc8 
already a while ago: I find it in the H6, H616, A523 manuals, for 
instance. And while register 0x50004c0 ignores writes on the H616, the 
corresponding 0x25004c0 reacts on the A523, so at least that one is 
already broken.
So as Sashiko mentioned, we would technically need to drop the fallback 
compatible, and doing this also for the A523 would break all older 
kernels, so that isn't a good option.

Now when I write 0xffffffff into +0xc0 on the A523, I read 0x9f back, so 
there are zero bits in the middle, which doesn't match the expected 
contiguous bitmask for the fractional divider bits.
So I was wondering if we should refine the DLF detection instead? Only 
when the readback from 0xc0 returns some 2^n-1 value we assume DLF is 
implemented?

Alternatively making DLF a (negative?) DT/ACPI property instead, and 
keep the fallback compatible?
I guess this all depends a bit on what the snps,dw-apb-uart compatible 
string really covers, and if Allwinner hacked^Wchanged the IP, by adding 
their RS485 bits on top of on older Designware IP, or if this is a valid 
configuration.

Cheers,
Andre

> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_dw.c    | 13 +++++++++++++
>   drivers/tty/serial/8250/8250_dwlib.c | 22 ++++++++++++----------
>   drivers/tty/serial/8250/8250_dwlib.h |  1 +
>   3 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index ba414306c98a..ea33aa644cda 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -52,6 +52,7 @@
>   #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
>   #define DW_UART_QUIRK_IER_KICK		BIT(6)
>   #define DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ	BIT(7)
> +#define DW_UART_QUIRK_NO_DLF		BIT(8)
>   
>   /*
>    * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
> @@ -606,6 +607,8 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>   		p->serial_out = dw8250_serial_out38x;
>   	if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
>   		p->set_termios = dw8250_do_set_termios;
> +	if (quirks & DW_UART_QUIRK_NO_DLF)
> +		data->data.no_dlf = true;
>   	if (quirks & DW_UART_QUIRK_IS_DMA_FC) {
>   		data->data.dma.txconf.device_fc = 1;
>   		data->data.dma.rxconf.device_fc = 1;
> @@ -892,6 +895,15 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
>   	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
>   };
>   
> +/*
> + * The baud clock is the bus clock gate, whose rate cannot change, and offset
> + * 0xc0 is the RS485 control register rather than DLF.
> + */
> +static const struct dw8250_platform_data dw8250_sun60i_a733_data = {
> +	.usr_reg = DW_UART_USR,
> +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE | DW_UART_QUIRK_NO_DLF,
> +};
> +
>   static const struct dw8250_platform_data dw8250_intc10ee = {
>   	.usr_reg = DW_UART_USR,
>   	.quirks = DW_UART_QUIRK_IER_KICK,
> @@ -913,6 +925,7 @@ static const struct dw8250_platform_data dw8250_tda54 = {
>   
>   static const struct of_device_id dw8250_of_match[] = {
>   	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
> +	{ .compatible = "allwinner,sun60i-a733-uart", .data = &dw8250_sun60i_a733_data },
>   	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>   	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>   	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 9bb02a4ab11f..9c6f3d926ad5 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -209,16 +209,18 @@ void dw8250_setup_port(struct uart_port *p)
>   	}
>   	up->capabilities |= UART_CAP_NOTEMT;
>   
> -	/* Preserve value written by firmware or bootloader  */
> -	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
> -	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> -	reg = dw8250_readl_ext(p, DW_UART_DLF);
> -	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
> -
> -	if (reg) {
> -		pd->dlf_size = fls(reg);
> -		p->get_divisor = dw8250_get_divisor;
> -		p->set_divisor = dw8250_set_divisor;
> +	if (!pd->no_dlf) {
> +		/* Preserve value written by firmware or bootloader  */
> +		old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
> +		dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> +		reg = dw8250_readl_ext(p, DW_UART_DLF);
> +		dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
> +
> +		if (reg) {
> +			pd->dlf_size = fls(reg);
> +			p->get_divisor = dw8250_get_divisor;
> +			p->set_divisor = dw8250_set_divisor;
> +		}
>   	}
>   
>   	reg = dw8250_readl_ext(p, DW_UART_UCV);
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index ee7a07fac0f6..ca0dfd6d056e 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -88,6 +88,7 @@ struct dw8250_port_data {
>   	/* Hardware configuration */
>   	u32			cpr_value;
>   	u8			dlf_size;
> +	bool			no_dlf;		/* Offset 0xc0 is not DLF */
>   
>   	/* RS485 variables */
>   	bool			hw_rs485_support;

