Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879288;
	b=i++pyaJLp3jsZKBWB7yEM5HmK5nNriJ63Fuoi2jXgT/4ZuwRlGq1TERcGSgeQ2mcXOi5
	 Z+lpvmHpTxoZGnOBjRNE7v8i96uxwD4AxKKlH2q4/zugs5+WcLxTm22EfSyfqxHt5ApVr
	 foz925jugfOPLhXPb4oz3T171lV4M73Q8Rx1o+vBbmuW4Tr0eWONVR1oYifb8ae8/8ghY
	 GEuxKUoQZYxO/0NmOuSpn/IWrkyb7/Jv5DVbyJX4AX++vZF8/JrdLsu81rUdJNuLXaghq
	 euEymoLgk7Xiay2Uujo+w4xQM9H23013hw2bL/aia3iHCIv/YN0JRUG0Bcj9FwemfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879288;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent;
	bh=UHz6AMzM93tCKEmiVWYUGJVjJ6331bl28dTuRqH9PMY=;
	b=e0hFz7hZCHzj9cveTYHQ8YDjpgCFJhNeGjzG953TsYCjs4XVWLkuB5Qa6+HYwUmo3MNJ
	 ts1Ij2yms+/6LJDQR4aD2mnF462F4nvA2SvRWSXU7rxMYIkQeucZHf8uzoeWjBHBxIbgx
	 J7Pflls5wyv1TA/Okzvctkuz3j5Yf4JU9MNVgsknlOOgIeax8t47ljZYrf3kOunhlpa8B
	 BlBcgXz4gSduE0bU0xc/K0sgDoTR2fER6KK7rLeCAWZqTYC1F3xpgXx2kTz1Lo97npppx
	 9Ap2tWYjYcVqUmBjU/bLbiV0GoKsBngKWK8i7d2LGezVJdo4WKhPjLOs5Vfv3jwkVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkWQKk1e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28471606B57E;
	Thu,  5 Nov 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkWQKk1e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5716A1F000C1;
	Thu,  5 Nov 2026 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879287;
	bh=UHz6AMzM93tCKEmiVWYUGJVjJ6331bl28dTuRqH9PMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NkWQKk1eDpVDkTkyffjFSgbMXS+MdiyDL50DVuWxPq0DemLDhz0ZsBZ/5BwyCQqus
	 ZIdDPCKXSc306r51dm+OY4sL8Gyg9rxw4lXbCPnoSo0tepGZ6wlv+MrNgXsfJGEb38
	 I0xRjasgDrh2ZLnmLFkOh/i4i4boDSftiF3BCO26Ne4oXh1h7qYaAl1wYH4QLPXx3t
	 BkKF3tMk4ivdXIHveFTZlr27cip4Bcqd6W5G0d1TRIl7s4FWuNqda9/OYMF8+W01qA
	 AIPN0CGX14EUKPhbBzoUZUQk/RlWmvgdrd2UmHjhoki4kSPl+nCrQWpzuEEccoGKFi
	 jApbyZYMiK/YQ==
Received: by pali.im (Postfix)
	id E1D10524; Thu,  5 Nov 2026 12:48:04 +0100 (CET)
Date: Thu, 5 Nov 2026 12:48:04 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Bramwel Barack <bramwelbarack89@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: serial: mvebu-uart: use device_get_match_data()
Message-ID: <20261105114804.vqbs6ooleagwutal@pali>
References: <20261103201305.18963-1-bramwelbarack89@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103201305.18963-1-bramwelbarack89@gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 03 November 2026 23:13:05 Bramwel Barack wrote:
> Modernize the driver by replacing the legacy of_match_device() call
> with the modern device_get_match_data() helper API. This cleans up
> the boilerplate code by extracting the match driver data configuration
> directly.
> 
> Consequently, drop the explicit inclusions of <linux/of_device.h> and
> <linux/of_platform.h> as they are no longer required by the driver.
> This allows us to also remove a now-redundant forward declaration and
>  drop the problematic of_match_ptr() macro wrapper.
> 
> Signed-off-by: Bramwel Barack <bramwelbarack89@gmail.com>

Looks good,

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> Changes in v3:
>   - Removed the redundant type cast from device_get_match_data() assignment as suggested by Jiri Slaby.
>   - Marked the data pointer in struct mvebu_uart as const to match the return type of device_get_match_data() and prevent build errors.
> 
> Changes in v2:
>   - Dropped the redundant forward declaration of mvebu_uart_of_match.
>   - Removed the of_match_ptr() macro wrapper from the platform driver structure
>     to prevent build warnings when compiling with CONFIG_OF disabled.
> ---
>  drivers/tty/serial/mvebu-uart.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 33ea496c93b2..fcb8f3d52df8 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -18,9 +18,7 @@
>  #include <linux/math64.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> @@ -154,7 +152,7 @@ struct mvebu_uart {
>  	struct uart_port *port;
>  	struct clk *clk;
>  	int irq[UART_IRQ_COUNT];
> -	struct mvebu_uart_driver_data *data;
> +	const struct mvebu_uart_driver_data *data;
>  #if defined(CONFIG_PM)
>  	struct mvebu_uart_pm_regs pm_regs;
>  #endif /* CONFIG_PM */
> @@ -859,15 +857,12 @@ static const struct dev_pm_ops mvebu_uart_pm_ops = {
>  };
>  #endif /* CONFIG_PM */
>  
> -static const struct of_device_id mvebu_uart_of_match[];
>  
>  /* Counter to keep track of each UART port id when not using CONFIG_OF */
>  static int uart_num_counter;
>  
>  static int mvebu_uart_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
> -							   &pdev->dev);
>  	struct uart_port *port;
>  	struct mvebu_uart *mvuart;
>  	struct resource *reg;
> @@ -919,7 +914,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* Get controller data depending on the compatible string */
> -	mvuart->data = (struct mvebu_uart_driver_data *)match->data;
> +	mvuart->data = device_get_match_data(&pdev->dev);
>  	mvuart->port = port;
>  
>  	port->private_data = mvuart;
> @@ -1016,7 +1011,7 @@ static struct platform_driver mvebu_uart_platform_driver = {
>  	.probe	= mvebu_uart_probe,
>  	.driver	= {
>  		.name  = "mvebu-uart",
> -		.of_match_table = of_match_ptr(mvebu_uart_of_match),
> +		.of_match_table = mvebu_uart_of_match,
>  		.suppress_bind_attrs = true,
>  #if defined(CONFIG_PM)
>  		.pm	= &mvebu_uart_pm_ops,
> -- 
> 2.56.0
> 
