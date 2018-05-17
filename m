From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Thu, 17 May 2018 14:04:06 +0900
Message-ID: <20180517050406.GF20254@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180511103822.31698-6-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, richard.genoud@gmail.com, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
List-Id: linux-serial@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2018 at 01:38:21PM +0300, Radu Pirea wrote:

> +config SPI_AT91_USART
> +        tristate "Atmel USART Controller as SPI"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +        select MFD_AT91_USART
> +	help
> +	  This selects a driver for the AT91 USART Controller as SPI Master,
> +	  present on AT91 and SAMA5 SoC series.
> +

This looks like there's some tab/space mixing going on here.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.

Make the entire block a C++ comment so it looks more intentional rather
tha mixing C and C++.

> +static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
> +{
> +	unsigned int len = aus->current_transfer->len;
> +	unsigned int remaining = aus->current_tx_remaining_bytes;
> +	const u8  *tx_buf = aus->current_transfer->tx_buf;
> +
> +	if (tx_buf && remaining) {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, tx_buf[len - remaining]);
> +			aus->current_tx_remaining_bytes--;

Missing braces here - we only write to the FIFO if there's space but we
unconditionally decrement the counter.

> +	} else {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, US_DUMMY_TX);
> +	}
> +}

This looks like you're open coding SPI_CONTROLLER_MUST_TX

> +	int len = aus->current_transfer->len;
> +	int remaining = aus->current_rx_remaining_bytes;
> +	u8  *rx_buf = aus->current_transfer->rx_buf;
> +
> +	if (aus->current_rx_remaining_bytes) {
> +		rx_buf[len - remaining] = spi_readb(aus, RHR);
> +		aus->current_rx_remaining_bytes--;
> +	} else {
> +		spi_readb(aus, RHR);
> +	}

Similarly for _MUST_RX.

> +	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

You're actually setting both flags...  this means that the handling for
cases with missing TX or RX buffers can't happen.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9DUUACgkQJNaLcl1U
h9AZ8Af/TfudZuJqOMwmfzPzpWNjaK16fM6QqAxtb/t4AgLJi7gFUUFADP73Gxjs
2AMjNTH3hGmf6kHuRu2EcTmkLqg3a2TKXJ/pjJJxVABTwqwJ9X79hT9Sbt9lTRN9
jF2g/jHD21IbEEuC6q5W6m1sxmeJ5h5RKLLVy4D3k/Vtsak0iMN7STU/JoHHHjes
bge+7JUXHaJ4/L2p/a2tagPZ2UYtO/QstgEbytrtfVBXoG96KWL9zQ6gs7jNIFqb
iEaA/sdu9hEht0UgO3HAeKDj5wVaoo0W3vaFxxWXwc0bmUTjDT89KtjpjTkc+eY3
DAbap8+AlVu9k34DVGRPV1G13go1ZQ==
=o0Db
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
