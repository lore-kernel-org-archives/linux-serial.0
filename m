From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
Date: Tue, 29 May 2018 11:32:00 +0200
Message-ID: <20180529093200.GB4793@piout.net>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
 <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Radu Pirea <radu.pirea@microchip.com>, Lee Jones <lee.jones@linaro.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 28/05/2018 11:00:49+0300, Andy Shevchenko wrote:
> On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> > This mfd driver is just a wrapper over atmel_serial driver and
> > spi-at91-usart driver. Selection of one of the drivers is based on a
> > property from device tree. If the property is not specified, the default
> > driver is atmel_serial.
> 
> > +       depends on OF
> 
> What makes this driver OF specific?
> 
> > +       err = of_property_read_u32(np, "atmel,usart-mode", &opmode);
> 
> Check unified device property API.
> 

We don't care, this makes the driver OF specific and this is the correct
thing to do.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
