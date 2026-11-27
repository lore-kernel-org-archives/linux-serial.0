Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778764;
	b=jBs3oh/Ce4C2geJ6FBS1J7qRQYxJBsC38rnh5VX1ZmUXB3MXYixuOqbj5YqFqUeh1KdA
	 38MT2C8jEbX7hfBnTn6G/IJal5ENHACwS7VRxHv08fUQiryvpAqM1o/h+fhGOL50q366O
	 pwnu6X1JVz1DRRXydiZrlRlxp5L8KNVHlD7DQWa1+KCaKzhUYhDdhdM0aoGmSoXb0iowZ
	 ES+oYxCdths00DJbx68JJLrBbh8leDwfY1AYhXierbm5H/vKQjvazB9r13LQrgDbkMVM5
	 K8CL06E/my2oG9aX0jUk7EQyO8G7yCdjUfw/nsxYlxc2NI4cp5gjCDN+Hd/IuQKX4sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778764;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam;
	bh=gylHRjpeZgc0KMmOGoSwKhRI/dWgfEWcm+Z3zoHm3Xc=;
	b=x/sdPNusPpxFI2gVABBpiqYXrRyp6VCF8j5WcJqItCWXillZI5MbcB6NZJkeGsyEJruM
	 Q5oC/EJzj5wSe1OWZzbHegiQDz+s1PkcrEyoeDgkcc/aCpcZgffhRloelNohSLBKWQe0B
	 y8VOmVjFZXJlA4GwvCt08UxqhLyn7RWpq+i4v2hOSuzpo5O4raVSIiCwhmJpLeXdXwy4Q
	 soVeE6IIWI12YMH/443aIFJgFtRj7SOsrbiqhTuBMWhoLWObOE5zghUZlSmdeqzTa1TM/
	 2fch3dVcEAzZhWAhBcz4hVBnQCbpLieLbrAZSbwJDSyBAw1jSXwrO5e5+e81ddAP8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=WL26CJBI;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E11606A6A8;
	Fri, 27 Nov 2026 11:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E11606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=WL26CJBI
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 9DD344C995;
	Fri, 27 Nov 2026 22:25:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795778758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gylHRjpeZgc0KMmOGoSwKhRI/dWgfEWcm+Z3zoHm3Xc=;
	b=WL26CJBInT1wxWKLJbeyA6lm6x5/tUst/LtvbJa5xiepEzREvugQdt+P4F5C6VeC/50zdy
	cu2bS/D33g0ukplGQJmmibvm4kTgCsjFci0VsWaKC5yBkmfFUdNe6WN2Xu0akZQNQdqfVb
	logrBI6sojYi02lEYb6jsfT0z0tpQzmTakCoWYXymH4KxWNMRxU1RF+2MAWX97ybbSA1ns
	YiGymRriTH6Hrf03m92FWz9uX7iXGqPDTH0RSRV+SypXyvgrvYzLd82pNEhy/MSSdFtLJa
	a1xyrOAg7c7BCNoPTjlWiUGP68ISGC+1e0UrLrVcpJxjSiWifzxHZPXa3jcIzw==
From: Alastair D'Silva <alastair@d-silva.org>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF readback
Date: Fri, 27 Nov 2026 22:25:58 +1100
Message-ID: <20261127112558.2585489-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

On Mon, 19 Oct 2026 17:06:11 -0300, Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com> wrote:
> dw8250_setup_port() writes all ones to offset 0xc0 and treats any
> nonzero readback as the DLF register. DLF is a bit field starting at
> bit 0, so a real one reads back as a contiguous 2^n - 1 mask. On some
> Allwinner SoCs offset 0xc0 is the RS485 control register instead
> (UART_485_CTL in the A733 User Manual), whose implemented bits are not
> contiguous. The probe still takes its readback for a DLF of fls(readback)
> bits, and every later divisor change writes the fractional divisor into
> the RS485 control register.
>
> Only accept a readback of the form 2^n - 1.
>
> The probe itself is unchanged: it still writes all ones to offset 0xc0
> and then restores the old value, so this only changes how the readback
> is interpreted.
>
> The A733 reads back 0x19f, and Andre Przywara observed 0x9f on the
> A523. Without this check the A733 RS485 control register reads 0xb after
> boot; with it, the register stays 0 across 300 termios toggle and
> restore cycles.
>
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 325793f20256..1b0192efe162 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -225,7 +225,11 @@ void dw8250_setup_port(struct uart_port *p)
>  	reg = dw8250_readl_ext(p, DW_UART_DLF);
>  	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
>  
> -	if (reg) {
> +	/*
> +	 * DLF is a bit field starting at bit 0, so a real one reads back as
> +	 * 2^n - 1. Any other value means this offset is something else.
> +	 */
> +	if (reg && !(reg & (reg + 1))) {
>  		pd->dlf_size = fls(reg);
>  		p->get_divisor = dw8250_get_divisor;
>  		/* Keep a hook the driver has already installed */

Tested on Xunlong OrangePi 4 Pro (Allwinner A733):
- UART0 (2500000.serial, ttyS0, base_baud = 1500000) boots to shell and
  echoes interactive console input at 115200 baud.

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Tested-by: Alastair D'Silva <alastair@d-silva.org> # OrangePi 4 Pro
