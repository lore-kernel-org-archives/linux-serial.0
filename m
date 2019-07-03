From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch v3 2/5] build configuration for AST2500 DMA UART driver
Date: Wed, 3 Jul 2019 19:50:29 +0200
Message-ID: <20190703175029.GB12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-3-git-send-email-open.sudheer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561459476-14268-3-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sudheer.v" <open.sudheer@gmail.com>
Cc: jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com, sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:33PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> build config for DMA based UART driver in AST2500.
> Total Available  UARTs in AST2500 are 4
> 
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
> ---
> 
> Changes in v3:
> - change logs added
> 
> drivers/tty/serial/8250/Kconfig  | 35 +++++++++++++++++++++++++++++++-
>  drivers/tty/serial/8250/Makefile |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 15c2c5463835..c793466a1c47 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -45,7 +45,7 @@ config SERIAL_8250_DEPRECATED_OPTIONS
>  	  keep the 8250_core.* options around until they revert the changes
>  	  they already did.
>  
> -	  If 8250 is built as a module, this adds 8250_core alias instead. 
> +	  If 8250 is built as a module, this adds 8250_core alias instead.
>  
>  	  If you did not notice yet and/or you have userspace from pre-3.7, it
>  	  is safe (and recommended) to say N here.

Why did you change this line?

> @@ -189,6 +189,39 @@ config SERIAL_8250_RUNTIME_UARTS
>  	  with the module parameter "nr_uarts", or boot-time parameter
>  	  8250.nr_uarts
>  
> +config  AST_SERIAL_DMA_UART
> +        tristate "AST UART driver with DMA"
> +        select SERIAL_CORE
> +        help
> +          UART driver with DMA support for Aspeed BMC AST25XX.
> +          this driver supports UARTs in AST2500,AST2600. It uses
> +          DMA channel of DMA engines present in these chips.
> +          since this dma engine is used only by UARTs it is not
> +          added as a separate DMA driver instead added as a layer
> +          within UART driver.
> +
> +
> +config AST_NR_DMA_UARTS
> +        int "Maximum number of uart dma serial ports"
> +        depends on AST_SERIAL_DMA_UART
> +        default "4"
> +        help
> +          Set this to the number of serial ports you want the driver
> +          to support.  This includes any ports discovered via ACPI or
> +          PCI enumeration and any ports that may be added at run-time
> +          via hot-plug, or any ISA multi-port serial cards.
> +
> +config AST_RUNTIME_DMA_UARTS
> +        int "Number of uart dma serial ports to register at runtime"
> +        depends on AST_SERIAL_DMA_UART
> +        range 0 AST_NR_DMA_UARTS
> +        default "4"
> +        help
> +          Set this to the maximum number of serial ports you want
> +          the kernel to register at boot time.  This can be overridden
> +          with the module parameter "nr_uarts", or boot-time parameter
> +          8250.nr_uarts

That boot paramter is not correct, right?

Are you sure these all work like you think they work?

thanks,

greg k-h
