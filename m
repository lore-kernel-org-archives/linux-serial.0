From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch v3 4/5] defconfig and MAINTAINERS updated for AST2500 DMA
 UART driver
Date: Wed, 3 Jul 2019 19:51:37 +0200
Message-ID: <20190703175137.GD12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-5-git-send-email-open.sudheer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561459476-14268-5-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sudheer.v" <open.sudheer@gmail.com>
Cc: jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com, sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:35PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> defconfig changes to add DMA based UART in AST2500
> Maintainers File updated.
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>

Blank line needed before signed-off-by.


> ---
> 
> Changes in v3:
> - Added changes logs 
> 
>  MAINTAINERS                          | 13 +++++++++++++
>  arch/arm/configs/aspeed_g5_defconfig |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 997e27ab492f..c9a9790b97f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1347,6 +1347,19 @@ F:	drivers/crypto/axis
>  F:	drivers/pinctrl/pinctrl-artpec*
>  F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>  
> +ARM/ASPEED DMA UART DRIVER
> +M:	sudheer v <sudheer.open@gmail.com>
> +M:	ShivahShankar <shivahshankar.shankarnarayanrao@aspeedtech.com>
> +R:	Joel Stanley <joel@jms.id.au>
> +R:	Andrew Jeffery <andrew@aj.id.au>
> +R:	Vinod Koul <vkoul@kernel.org>
> +L:	dmaengine@vger.kernel.org
> +L:	openbmc@lists.ozlabs.org
> +L:	linux-aspeed@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> +F:	Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
> +
>  ARM/ASPEED I2C DRIVER
>  M:	Brendan Higgins <brendanhiggins@google.com>
>  R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 1849cbc161b4..25bf26630939 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_NR_UARTS=6
>  CONFIG_SERIAL_8250_RUNTIME_UARTS=6
> +CONFIG_AST_SERIAL_DMA_UART=y

This shows that the config option should be:
	CONFIG_SERIAL_AST_DMA_UART
right?

thanks,

greg k-h
