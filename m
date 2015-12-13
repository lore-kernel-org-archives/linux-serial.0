From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9] Serial:8250: New Port Type PORT_AMD_8250
Date: Sun, 13 Dec 2015 04:30:57 +0200
Message-ID: <CAHp75VcBSvQZoMsodD7nHyWn11q7fe7ctwuABxrh_t=zg5UPJg@mail.gmail.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-8-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1449199466-6081-8-git-send-email-annie.wang-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Li <tony.li-5C7GfCeVMHo@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ken Xue <ken.xue-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 4, 2015 at 5:24 AM, Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org> wrote:
> Set a new port type for AMD Carrizo.  Add has_pl330_dma to 8250_dw's
> private data and init fcr,ier as well as dma rx size.
>
> Signed-off-by: Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/acpi/acpi_apd.c             | 10 ++++++++++
>  drivers/tty/serial/8250/8250_dw.c   | 16 ++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |  9 +++++++++
>  include/linux/serial_8250.h         |  4 ++++
>  include/uapi/linux/serial_core.h    |  3 ++-
>  include/uapi/linux/serial_reg.h     |  2 ++
>  6 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 906a20f..787f477 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -23,6 +23,7 @@
>  #include <linux/sizes.h>
>  #include <linux/amba/pl330.h>
>  #include <linux/interrupt.h>
> +#include <linux/serial_8250.h>
>
>  #include "internal.h"
>
> @@ -49,6 +50,10 @@ static struct dma_pl330_platdata amd_pl330 = {
>         .acpi_xlate_filter = apd_acpi_xlate_filter,
>  };
>
> +static struct plat_dw8250_data amd_dw8250 = {
> +       .has_pl330_dma = 1,
> +};
> +
>  /**
>   * struct apd_device_desc - a descriptor for apd device.
>   * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM;
> @@ -164,6 +169,11 @@ static int acpi_apd_create_device(struct acpi_device *adev,
>                 goto err_out;
>
>         if (!strncmp(pdev->name, "AMD0020", 7)) {
> +               ret = platform_device_add_data(pdev, &amd_dw8250,
> +                                              sizeof(amd_dw8250));
> +               if (ret)
> +                       goto err_out;
> +
>                 memset(&amba_quirks, 0, sizeof(amba_quirks));
>                 setup_quirks(pdev, &amba_quirks);
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a5d319e..a5ae9b6 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -66,6 +66,8 @@ struct dw8250_data {
>
>         unsigned int            skip_autocfg:1;
>         unsigned int            uart_16550_compatible:1;

> +

Remove this

> +       unsigned                has_pl330_dma:1;

Use unsigned int.

>  };
>
>  #define BYT_PRV_CLK                    0x800
> @@ -304,6 +306,7 @@ static void dw8250_setup_port(struct uart_port *p)
>  {
>         struct uart_8250_port *up = up_to_u8250p(p);
>         u32 reg;
> +       struct dw8250_data *d = p->private_data;

Rename d -> data and move the line to be second in the definition list.

>
>         /*
>          * If the Component Version Register returns zero, we know that
> @@ -326,6 +329,16 @@ static void dw8250_setup_port(struct uart_port *p)
>                 p->flags |= UPF_FIXED_TYPE;
>                 p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
>                 up->capabilities = UART_CAP_FIFO;
> +               if (d->has_pl330_dma) {
> +                       p->type = PORT_AMD_8250;

> +                       p->flags |= UPF_SHARE_IRQ;

Isn't it a default?

> +
> +                       up->ier |= UART_IER_PTIME | UART_IER_THRI |
> +                               UART_IER_RLSI | UART_IER_RDI;
> +                       up->fcr |= UART_FCR_R_TRIG_10 | UART_FCR_T_TRIG_11 |
> +                               UART_FCR_DMA_SELECT;
> +                       up->tx_loadsz = p->fifosize / 2;
> +               }
>         }
>
>         if (reg & DW_UART_CPR_AFCE_MODE)
> @@ -339,6 +352,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         int irq = platform_get_irq(pdev, 0);
>         struct uart_port *p = &uart.port;
>         struct dw8250_data *data;
> +       struct plat_dw8250_data *pdata = dev_get_platdata(&pdev->dev);
>         int err;
>         u32 val;
>
> @@ -468,6 +482,7 @@ static int dw8250_probe(struct platform_device *pdev)
>                 p->handle_irq = NULL;
>         }
>
> +       data->has_pl330_dma = pdata ? pdata->has_pl330_dma : 0;
>         if (!data->skip_autocfg)
>                 dw8250_setup_port(p);
>
> @@ -475,6 +490,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         if (p->fifosize) {
>                 data->dma.rxconf.src_maxburst = p->fifosize / 4;
>                 data->dma.txconf.dst_maxburst = p->fifosize / 4;
> +               data->dma.rx_size = data->has_pl330_dma ? (p->fifosize / 2 + 2) : 0;
>                 uart.dma = &data->dma;
>         }
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 52d82d2..b258edc 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -269,6 +269,15 @@ configured less than Maximum supported fifo bytes */
>                 .rxtrig_bytes   = {1, 4, 8, 14},
>                 .flags          = UART_CAP_FIFO,
>         },
> +       [PORT_AMD_8250] = {
> +               .name           = "AMD_8250",
> +               .fifo_size      = 256,
> +               .tx_loadsz      = 128,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
> +                               UART_FCR_T_TRIG_11 | UART_FCR_DMA_SELECT,

So, do  your HW has no additional wires to DMA engine? This bit
usually is ignored if DMA has more signal lines connected to UART IP.
Please, check this.

> +               .rxtrig_bytes   = {1, 4, 8},
> +               .flags          = UART_CAP_FIFO,
> +       },
>  };
>
>  /* Uart divisor latch read */
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index faa0e03..4652783 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -42,6 +42,10 @@ struct plat_serial8250_port {
>         void            (*handle_break)(struct uart_port *);
>  };
>
> +struct plat_dw8250_data {
> +       unsigned has_pl330_dma:1;
> +};

It should be a part of include/linux/platform_data

> +
>  /*
>   * Allocate 8250 platform device IDs.  Nothing is implied by
>   * the numbering here, except for the legacy entry being -1.
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 93ba148..6a06651 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -56,7 +56,8 @@
>  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
>  #define PORT_RT2880    29      /* Ralink RT2880 internal UART */
>  #define PORT_16550A_FSL64 30   /* Freescale 16550 UART with 64 FIFOs */
> -#define PORT_MAX_8250  30      /* max port ID */
> +#define PORT_AMD_8250  31
> +#define PORT_MAX_8250  32      /* max port ID */
>
>  /*
>   * ARM specific type numbers.  These are not currently guaranteed
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index 1e5ac4e7..13e8294 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -25,6 +25,8 @@
>  #define UART_IER_RLSI          0x04 /* Enable receiver line status interrupt */
>  #define UART_IER_THRI          0x02 /* Enable Transmitter holding register int. */
>  #define UART_IER_RDI           0x01 /* Enable receiver data interrupt */
> +/* Enable Programmable Transmitter holding register int. */
> +#define UART_IER_PTIME          0x80

Move this to be first in the list. Put comment at the end of the line

>  /*
>   * Sleep mode for ST16650 and TI16750.  For the ST16650, EFR[4]=1
>   */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
