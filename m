From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 6/6] Serial:8250: New Port Type PORT_AMD_8250
Date: Tue, 5 Jan 2016 14:01:37 +0200
Message-ID: <20160105120137.GA19451@kuha.fi.intel.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
 <1451885501-2710-7-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451885501-2710-7-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

Hi Hongcheng,

My comments below..

On Mon, Jan 04, 2016 at 01:31:41PM +0800, Wang Hongcheng wrote:
> Set a new port type for AMD Carrizo.  Add has_pl330_dma to 8250_dw's
> private data and init fcr,ier as well as dma rx size.
> 
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>  drivers/acpi/acpi_apd.c               | 11 +++++++++++
>  drivers/tty/serial/8250/8250_dw.c     | 15 +++++++++++++++
>  drivers/tty/serial/8250/8250_port.c   |  9 +++++++++
>  include/linux/platform_data/8250-dw.h |  8 ++++++++
>  include/uapi/linux/serial_core.h      |  3 ++-
>  include/uapi/linux/serial_reg.h       |  1 +
>  6 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/platform_data/8250-dw.h
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 1f16cca..e8e43fb 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -23,6 +23,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/amba/pl330.h>
> +#include <linux/platform_data/8250-dw.h>
>  
>  #include "internal.h"
>  
> @@ -56,6 +57,11 @@ static struct dma_pl330_platdata amd_pl330[] = {
>  		.num = 0,
>  	}
>  };
> +
> +static struct plat_dw8250_data amd_dw8250 = {
> +	.has_pl330_dma = 1,
> +};

Why do you need this? Can't you identify this platform in 8250_dw.c
based on the ACPI ID?

>  /**
>   * struct apd_device_desc - a descriptor for apd device
>   * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
> @@ -115,6 +121,11 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
>  	char amba_devname[100];
>  	int devnum;
>  
> +	ret = platform_device_add_data(pdev, &amd_dw8250,
> +				       sizeof(amd_dw8250));
> +	if (ret)
> +		goto resource_alloc_err;
> +
>  	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>  	if (!resource)
>  		goto resource_alloc_err;

The above needs to be separated to its own patch in any case.


> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a5d319e..e7d9f01 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/platform_data/8250-dw.h>
>  
>  #include <asm/byteorder.h>
>  
> @@ -66,6 +67,7 @@ struct dw8250_data {
>  
>  	unsigned int		skip_autocfg:1;
>  	unsigned int		uart_16550_compatible:1;
> +	unsigned int		has_pl330_dma:1;

I don't think there is any use for this flag. You can do all the
platform specific tricks in a single quirk that you add to
dw8250_quirks()..

>  };
>  
>  #define BYT_PRV_CLK			0x800
> @@ -303,6 +305,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  static void dw8250_setup_port(struct uart_port *p)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(p);
> +	struct dw8250_data *data = p->private_data;
>  	u32 reg;
>  
>  	/*
> @@ -326,6 +329,14 @@ static void dw8250_setup_port(struct uart_port *p)
>  		p->flags |= UPF_FIXED_TYPE;
>  		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
>  		up->capabilities = UART_CAP_FIFO;
> +		if (data->has_pl330_dma) {
> +			p->type = PORT_AMD_8250;
> +
> +			up->ier |= UART_IER_PTIME | UART_IER_THRI |
> +				UART_IER_RLSI | UART_IER_RDI;
> +			up->fcr |= UART_FCR_R_TRIG_10 | UART_FCR_T_TRIG_11;
> +			up->tx_loadsz = p->fifosize / 2;

So these need to be set in the quirk. Btw, now up->ier and up->fcr
will just be forgotten when serial8250_register_8250_port() is
called.

The UART_IER_PTIME needs to be set based on THRE_MODE. Add a flag for
that instead of the "has_pl330_dma", and set it in this function based
on the THRE_MODE bit in CPR. Then I think the correct place to fix
up->ier is actually our up->set_termios hook.

> +		}
>  	}
>  
>  	if (reg & DW_UART_CPR_AFCE_MODE)
> @@ -339,6 +350,7 @@ static int dw8250_probe(struct platform_device *pdev)
>  	int irq = platform_get_irq(pdev, 0);
>  	struct uart_port *p = &uart.port;
>  	struct dw8250_data *data;
> +	struct plat_dw8250_data *pdata = dev_get_platdata(&pdev->dev);
>  	int err;
>  	u32 val;
>  
> @@ -468,6 +480,7 @@ static int dw8250_probe(struct platform_device *pdev)
>  		p->handle_irq = NULL;
>  	}
>  
> +	data->has_pl330_dma = pdata ? pdata->has_pl330_dma : 0;
>  	if (!data->skip_autocfg)
>  		dw8250_setup_port(p);
>  
> @@ -475,6 +488,8 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (p->fifosize) {
>  		data->dma.rxconf.src_maxburst = p->fifosize / 4;
>  		data->dma.txconf.dst_maxburst = p->fifosize / 4;
> +		data->dma.rx_size
> +			= data->has_pl330_dma ? (p->fifosize / 2 + 2) : 0;

This you also need to set in the quirk.

>  		uart.dma = &data->dma;
>  	}
>  
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 52d82d2..b89a326 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -269,6 +269,15 @@ configured less than Maximum supported fifo bytes */
>  		.rxtrig_bytes	= {1, 4, 8, 14},
>  		.flags		= UART_CAP_FIFO,
>  	},
> +	[PORT_AMD_8250] = {
> +		.name		= "AMD_8250",
> +		.fifo_size	= 256,
> +		.tx_loadsz	= 128,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
> +				UART_FCR_T_TRIG_11,
> +		.rxtrig_bytes	= {1, 4, 8},
> +		.flags		= UART_CAP_FIFO,
> +	},

There is no use for this new type. In fact, there is no use for any
new types. If we need to modify fcr for example, we can do that in a
custom up->startup or up->set_termios hook.

>  };
>  
>  /* Uart divisor latch read */
> diff --git a/include/linux/platform_data/8250-dw.h b/include/linux/platform_data/8250-dw.h
> new file mode 100644
> index 0000000..97cdb9d
> --- /dev/null
> +++ b/include/linux/platform_data/8250-dw.h
> @@ -0,0 +1,8 @@
> +#ifndef _PLATFORM_DATA_8250_DW_H
> +#define _PLATFORM_DATA_8250_DW_H
> +
> +struct plat_dw8250_data {
> +	unsigned int has_pl330_dma:1;
> +};
> +
> +#endif

Let's not add any new driver specific platform data files unless we
absolutely have to. In this case there is no need for it. If you
really need to deliver this kind of detail to the driver, you need to
deliver it to the driver with build-in device property. So instead of
platform_device_add_data() you should use device_add_property_set().
Or actually, in linux-next there is already helper for platform bus
called platform_device_add_properties().

But I don't think there is any need for this kind of detail. You can
just identify your platform in 8250_dw.c based on the ACPI ID, no?


Thanks,

-- 
heikki
