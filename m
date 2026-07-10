Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000C394463;
	Fri, 10 Jul 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667604; cv=none; b=rvspKHqUmvhZP8EKx4vpk+TEKaQPrqDI6gnP9rIEanm2SKJEAWt4WO/zH88YDkCfaHgkBee8Jw2ER25beXLxlnkv3Tp8Ra7YNFGE4tLKZkybeQyVQLfLVE/lFTb1w83PPHo4NT3Ey037VcqFLSWYRCpeVAciNo/I0sKvfVbN6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667604; c=relaxed/simple;
	bh=F+acnhbkSnT+dHWE3DY+MPKABX5PUoxxxPHmIYpzcvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OPfnC+rIidtk8AAPuTrUdKzmRaora/qhWkIwqCrwStQ33PqstKI5sJhKRgOL4+Ue4W9MjjnJxr9bgIVntEhLvAyFmx8GT5V+Iyf/ZGholSTm5cdBuEVIrrf29f3nGNZitB9eLKF8boY/RBU6m6hBZTlseLyVq5fn8pPHz+5Fk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksoolnFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksoolnFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B611F000E9;
	Fri, 10 Jul 2026 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783667602;
	bh=E57FZrou9F2hFPlQ8f8FZGqm8xkBMesJIoAgHQMthH0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ksoolnFI8uag7ZQPrgBlWgbcqp9HsrgL29swZ1ML07ul4xBMNFGNt8oFR+J+86+gU
	 QQWyCK/ARTWeXzySgi2IrKT4iQdmXU2u2z/+LOr85iw7R7/Wqi6vu5GAPKCsh0ZVKG
	 U6BPw8wfmMm+jkbtDavJTvaEdeE1mE9OeYMiie6qpFpbaQvQLRgV2Cqaw0TmtC0qDe
	 IeC1VjxsZg7ThSMK3P+wDPqC+/f687WC2bcsNziByG5sSXlqAvyuG8ZeTwFtITyQW8
	 NcICA+gx3ZFiIfnoAOnv6IQOqyxBPrWGWlpVwmGy2vdDLvDhqGRoLvTrwGk9k2IX2u
	 Ui8sX78pIlIWw==
Message-ID: <9062ca8c-e29d-4958-a3d3-c86e2a6a9e86@kernel.org>
Date: Fri, 10 Jul 2026 09:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] serial: 8250: Add Airoha SoC UART and HSUART support
To: Christian Marangi <ansuelsmth@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 John Ogness <john.ogness@linutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>, Gerhard Engleder <eg@keba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Rong Zhang
 <rongrong@oss.cipunited.com>, Lukas Wunner <lukas@wunner.de>,
 Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-5-ansuelsmth@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260709205656.319531-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 07. 26, 22:56, Christian Marangi wrote:
...
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_airoha.c
> @@ -0,0 +1,190 @@
...
> +struct airoha_8250_priv {
> +	int line;
> +};
> +
> +struct airoha_8250_data {

Do you need this struct at all? Can't you pass the type as data directly 
(using cast)?

> +	unsigned int type;
> +};
> +
> +struct airoha_8250_clk_div_info {
> +	int div;
> +	int mask;

Perhaps make them unsigned to avoid signed arithmetics?

> +};
> +
> +#define UART_BRDL_20M		0x01
> +#define UART_BRDH_20M		0x00
> +
> +#define XINDIV_CLOCK		20000000
> +#define XYD_Y			65000
> +
> +static const struct airoha_8250_clk_div_info airoha_clk_div_info[] = {
> +	{ .div = 10, .mask = BIT(2) },
> +	{ .div = 4, .mask = BIT(1) },
> +	{ .div = 2, .mask = BIT(0) },
> +};
> +
> +static const int clock_div_tab[] = { 10, 4, 2};
> +static const int clock_div_reg[] = {  4, 2, 1};

unsigned?

> +
> +/*
> + * Airoha UART baud rate calculation logic
> + *
> + * crystal_clock = 20 MHz (fixed frequency)
> + * xindiv_clock = crystal_clock / clock_div
> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
> + *
> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
> + *
> + * Selecting divider needs to fulfill
> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
> + * The clocks are unknown but a divider of value 1 did not result in a valid
> + * waveform.
> + *
> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 gives even values
> + * for usual baud rates.
> + */
> +static void airoha_set_termios(struct uart_port *port, struct ktermios *termios,
> +			       const struct ktermios *old)
> +{
> +	const struct airoha_8250_clk_div_info *clk_div_info;
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned int xyd_x, nom, denom;
> +	unsigned int baud;
> +	int i;
> +
> +	serial8250_do_set_termios(port, termios, old);
> +
> +	baud = serial8250_get_baud_rate(port, termios, old);
> +
> +	/* Set DLAB to access the baud rate divider registers (BRDH, BRDL) */
> +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> +
> +	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
> +	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
> +	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
> +
> +	/*
> +	 * Calculate XYD_x and XINCLKDR register by searching
> +	 * through a table of crystal_clock divisors.
> +	 */
> +	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
> +		clk_div_info = &airoha_clk_div_info[i];
> +
> +		denom = (XINDIV_CLOCK / 40) / clk_div_info->div;
> +		nom = baud * (XYD_Y / 40);

Are these "/ 40" to avoid overflow? Add a comment.

> +		xyd_x = ((nom / denom) << 4);

* don't you want to round to closest instead of down?
* I don't understand the purpose of the shift though.

> +		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
> +		if (port->type == UART_PORT_AIROHA_HS)
> +			xyd_x = xyd_x >> 1;

Do not use shifts for div/mul.

> +		if (xyd_x < XYD_Y)
> +			break;
> +	}
> +
> +	serial_port_out(port, UART_AIROHA_XINCLKDR, clk_div_info->mask);
> +	serial_port_out(port, UART_AIROHA_XYD, (xyd_x << 16) | XYD_Y);
> +
> +	/* unset DLAB */
> +	serial_port_out(port, UART_LCR, up->lcr);
> +}

thanks,
-- 
js
suse labs
