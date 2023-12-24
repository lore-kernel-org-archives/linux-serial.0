Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1393FE6
	for <linux-serial@vger.kernel.org>; Sun, 24 Dec 2023 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7D8A6100D943F;
	Sun, 24 Dec 2023 13:32:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4CF4A43219; Sun, 24 Dec 2023 13:32:54 +0100 (CET)
Date: Sun, 24 Dec 2023 13:32:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Sergey Organov <sorganov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tom Rix <trix@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] serial: imx: Ensure that imx_uart_rs485_config() is
 called with enabled clock
Message-ID: <20231224123254.GA15377@wunner.de>
References: <20231222221101.2380-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222221101.2380-1-cniedermaier@dh-electronics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Dec 22, 2023 at 11:11:01PM +0100, Christoph Niedermaier wrote:
> There are register accesses in the function imx_uart_rs485_config(). The
> clock must be enabled for these accesses. This was ensured by calling it
> via the function uart_rs485_config() in the probe() function within the
> range where the clock is enabled. With the commit 7c7f9bc986e6 ("serial:
> Deassert Transmit Enable on probe in driver-specific way") it was removed
> from the probe() function and is now only called through the function
> uart_add_one_port() which is located at the end of the probe() function.
> But the clock is already switched off in this area. To ensure that the
> clock is enabled during register access, move the disabling of the clock
> to the very end of the probe() function.

Thanks for catching this and sorry for the breakage.


> @@ -2467,7 +2465,11 @@ static int imx_uart_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sport);
>  
> -	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +
> +	clk_disable_unprepare(sport->clk_ipg);
> +
> +	return ret;
>  }

There are a bunch of return statements in the "if (txirq > 0) ... else"
clause a little further up.  You need to add a goto label in front of
the "clk_disable_unprepare()" and change the return statements to gotos
to avoid leaking enabled clocks in those error paths.

Thanks,

Lukas
