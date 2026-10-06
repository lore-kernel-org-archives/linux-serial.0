Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423B39A7EF;
	Tue,  6 Oct 2026 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288987; cv=none; b=tWCYUsRtLdR58FmS414Ne9WX29uYMqqBTxOh79fhHAc7bxa+J/svYB3P6AfVcfY3R+v2q6soZGBevUSsvCbhonTu9yNgHj61J/Lw2sf13TVXrQ4Ou4HbE0NqptYPGndQGkobLbjC27p7QXMHC3Jb3smVauPpHHhlLgS11+DC08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288987; c=relaxed/simple;
	bh=TBS5GBEQ+BQ1mfJ/fxBa32HZcsgKA+CW7tg1R0oCgqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgWC/PVWkNSdHhjc7X+pw75vNDmCFUqogceloiaTo6NqioGiSsMOMKmU/GOIZspy6tGNr9+bm0FwGHwysR61qkqR5xYO0wT0m58HTy1RhobadI9fyyrP226If1gjlHO3T6YsNi47ICwmf7cgl/oYmyE6li28m17TtG6Ul6YMrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jzckIVqE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jzckIVqE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745491516;
	Tue,  6 Oct 2026 05:16:21 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51F73F66F;
	Tue,  6 Oct 2026 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791288984; bh=TBS5GBEQ+BQ1mfJ/fxBa32HZcsgKA+CW7tg1R0oCgqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jzckIVqEn6x7dUQWuh/LMixBqqMfPzPxRr2+z0EDMQN+GaRRYPotA//6f3z7yqkQN
	 kr/bIlyMo68oM4bckrS8hgl+SYaDn+PqSxtZNPRhq+VEViy47pArx3Vpku30C6JNV+
	 v6n8PvMIhi7vl0eWXEaX5cTPPf6/zCZyKwu69B7Y=
Message-ID: <603b4f40-2a60-4bc5-8b98-ada7a52fead9@arm.com>
Date: Tue, 6 Oct 2026 14:16:21 +0200
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

Hi,

about the rate settting ...

On 10/5/26 19:25, Vinicius Pedrosa wrote:
> The A733 UART is clocked from its bus clock gate, which can't change
> rate. dw8250_set_termios() still gates it around a no-op clk_set_rate()
> on every termios change. That stalls the character being shifted out

So isn't that a bug somewhere else then? Why would it gate the clock to 
set the rate? Shouldn't this decision be left to the CCF, where we have 
CLK_SET_RATE_GATE and CLK_SET_RATE_UNGATE to describe the clock's 
requirement? For instance the A733 manual says:
"Note: The clock MUX/DIV provides glitch-free switching
and supports dynamic configuration."
So we can both change the mux and the divider without gating.

And secondly, why does the termios code gate the clock when it's 
apparently not safe to do so, because the UART is not quiescent?

And what is your use case here, exactly? Do you reconfigure the baud 
rate while characters are incoming? That would garble characters anyway?

One thing you could try: the binding and the code support separate bus 
gate and baud rate clocks. So can you just expose CLK_APB1 as the baud 
rate clock in the DT? This would allow to change the rate, which is also 
beneficial, because at least on the current H6 generation U-Boot code 
(clock_sun50i_h6.c) we set the UART APB to 24MHz, so limit ourselves to 
1.5Mpbs. With APB1 set to 100 or 160 MHz, we could get higher baud 
rates, and exposing the mux+divider clock should allow to set the rate. 
I think the CCF would still need to negotiate with the other users, 
which are I2C and PWM, but that's something to solve there.

Cheers,
Andre.

  > and corrupts it on the wire. Use the existing SKIP_SET_RATE quirk, as
> other SoCs with a fixed UART clock do.
> 
> Offset 0xc0 is the RS485 control register on this SoC (A733 User
> Manual, UART_485_CTL), not DLF. dw8250_setup_port() writes all ones
> there, reads back a nonzero 9-bit value and takes it for a 9-bit DLF.
> Every later divisor change then writes the fractional divisor into the
> RS485 control register. Add a NO_DLF quirk so dwlib skips that probe.
> 
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

