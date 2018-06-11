From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v6 3/6] mfd: at91-usart: added mfd driver for usart
Date: Mon, 11 Jun 2018 17:36:32 +0200
Message-ID: <20180611153632.GG10521@piout.net>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-4-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607110020.20565-4-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/06/2018 14:00:17+0300, Radu Pirea wrote:
> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +	struct mfd_cell cell;
> +	u32 opmode;

This has to be initialized to AT91_USART_MODE_SERIAL...

> +	int err;
> +
> +	err = device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> +

because if the property is not present, then opmode will not be modified
which means it could hold the value of AT91_USART_MODE_SPI.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
