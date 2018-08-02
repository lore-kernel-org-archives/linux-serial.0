From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v11 6/6] tty/serial: atmel: change the driver to work
 under at91-usart mfd
Date: Thu, 2 Aug 2018 10:11:21 +0200
Message-ID: <20180802081121.GA26520@kroah.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180713164736.26028-7-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713164736.26028-7-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 13, 2018 at 07:47:36PM +0300, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
