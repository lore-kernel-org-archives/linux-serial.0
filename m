From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Date: Wed, 30 May 2018 20:00:18 -0500
Message-ID: <20180531010018.GA24002@rob-hp-laptop>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-3-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525171941.26766-3-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, richard.genoud@gmail.com, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, May 25, 2018 at 08:19:37PM +0300, Radu Pirea wrote:
> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)

Reviewed-by: Rob Herring <robh@kernel.org>
