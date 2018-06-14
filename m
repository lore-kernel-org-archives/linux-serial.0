From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v7 3/6] mfd: at91-usart: added mfd driver for usart
Date: Thu, 14 Jun 2018 10:32:20 +0200
Message-ID: <20180614083220.GU10521@piout.net>
References: <20180613163621.23995-1-radu.pirea@microchip.com>
 <20180613163621.23995-4-radu.pirea@microchip.com>
 <20180614075849.dfiqwcu6rtzgpzq7@rfolt0960.corp.atmel.com>
 <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 14/06/2018 11:22:25+0300, Radu Pirea wrote:
> On 06/14/2018 10:58 AM, Ludovic Desroches wrote:
> > > +static int at91_usart_mode_probe(struct platform_device *pdev)
> > > +{
> > > +	struct mfd_cell cell;
> > > +	u32 opmode = AT91_USART_MODE_SERIAL;
> > > +
> > > +	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > > +
> > > +	switch (opmode) {
> > > +	case AT91_USART_MODE_SPI:
> > > +		cell = at91_usart_spi_subdev;
> > > +		break;
> > > +	case AT91_USART_MODE_SERIAL:
> > > +		cell = at91_usart_serial_subdev;
> > > +		break;
> > > +	default:
> > > +		break;
> > 
> > If there is an invalid opmode from the DT, you will pass a non initialized cell
> > to mfd_add_device().
> > 
> > Regards
> > 
> > Ludovic
> 
> Hi Ludovic,
> 
> Tnx. That's true. How is better to do if atmel,usart-mode has an invalid
> value? To initialize cell with at91_usart_serial_subdev or to print an error
> message and return -EINVAL?
> 

Returning an error is probably the correct choice because it means the
DT has an invalid value (something was done and is wrong).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
