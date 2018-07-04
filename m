From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Date: Wed, 4 Jul 2018 07:23:16 +0100
Message-ID: <20180704062316.GY20176@dell>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-3-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625172230.29686-3-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 25 Jun 2018, Radu Pirea wrote:

> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I already Acked this in V4.

> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  include/dt-bindings/mfd/at91-usart.h          | 17 +++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
