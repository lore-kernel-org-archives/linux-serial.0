From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Date: Mon, 11 Jun 2018 17:37:58 +0200
Message-ID: <20180611153758.GH10521@piout.net>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-3-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607110020.20565-3-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 07/06/2018 14:00:16+0300, Radu Pirea wrote:
> diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
> new file mode 100644
> index 000000000000..ac811628a42d
> --- /dev/null
> +++ b/include/dt-bindings/mfd/at91-usart.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides macros for AT91 USART DT bindings.
> + *
> + * Copyright (C) 2018 Microchip Technology
> + *
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_AT91_USART_H__
> +#define __DT_BINDINGS_AT91_USART_H__
> +
> +#define AT91_USART_MODE_SERIAL	1
> +#define AT91_USART_MODE_SPI	2
> +

Nitpick, I'd make that 0 and 1 instead of 1 and 2. That would feel more
natural to me regarding the default value.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
