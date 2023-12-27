Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA046424
	for <linux-serial@vger.kernel.org>; Wed, 27 Dec 2023 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1231F2800B4B4;
	Wed, 27 Dec 2023 19:43:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02B0E5AF5; Wed, 27 Dec 2023 19:43:20 +0100 (CET)
Date: Wed, 27 Dec 2023 19:43:20 +0100
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
Subject: Re: [PATCH V2] serial: imx: Ensure that imx_uart_rs485_config() is
 called with enabled clock
Message-ID: <20231227184320.GA23940@wunner.de>
References: <20231226113647.39376-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226113647.39376-1-cniedermaier@dh-electronics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 26, 2023 at 12:36:47PM +0100, Christoph Niedermaier wrote:
> There are register accesses in the function imx_uart_rs485_config(). The
> clock must be enabled for these accesses. This was ensured by calling it
> via the function uart_rs485_config() in the probe() function within the
> range where the clock is enabled. With the commit 7c7f9bc986e6 ("serial:
> Deassert Transmit Enable on probe in driver-specific way") it was removed
> from the probe() function and is now only called through the function
> uart_add_one_port() which is located at the end of the probe() function.
> But the clock is already switched off in this area. To ensure that the
> clock is enabled during register access, move the disabling of the clock
> to the very end of the probe() function. To avoid leaking enabled clocks
> on error also add an error path for exiting with disabling the clock.
> 
> Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
