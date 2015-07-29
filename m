From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/5] tty/serial: at91: add support to FIFOs
Date: Wed, 29 Jul 2015 17:51:38 +0300
Message-ID: <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw@mail.gmail.com>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com>
	<4d8e90ad2cbb0d020dae4a4806ffc8864b5b22b6.1435842688.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d8e90ad2cbb0d020dae4a4806ffc8864b5b22b6.1435842688.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 2, 2015 at 4:18 PM, Cyrille Pitchen
<cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Depending on the hardware, TX and RX FIFOs may be available. The RX
> FIFO can avoid receive overruns, especially when DMA transfers are
> not used to read data from the Receive Holding Register. For heavy
> system load, The CPU is likely not be able to fetch data fast enough
> from the RHR.

This patch broke avr32 console (as seen in today's linux-next) on ATNGW100.
Reverting helps. I'm pretty sure the issue is in 8 bit vs. 32 bit I/O access.

# uname -a
Linux buildroot 4.2.0-rc4-next-20150729+ #97 Wed Jul 29 17:50:11 EEST
2015 avr32 GNU/Linux

Do you, guys, have that board (NGW100) or it's officially unsupported?
If the latter is the case I would really appreciate if you remove the
support from the kernel side.

>
> In addition, the RX FIFO can supersede the DMA/PDC to control the RTS
> line when the Hardware Handshaking mode is enabled. Two thresholds
> are to be set for that purpose:
> - When the number of data in the RX FIFO crosses and becomes lower
>   than or equal to the low threshold, the RTS line is set to low
>   level: the remote peer is requested to send data.
> - When the number of data in the RX FIFO crosses and becomes greater
>   than or equal to the high threshold, the RTS line is set to high
>   level: the remote peer should stop sending new data.
> - low threshold <= high threshold
> Once these two thresholds are set properly, this new feature is
> enabled by setting the FIFO RTS Control bit of the FIFO Mode Register.
>
> FIFOs also introduce a new multiple data mode: the USART works either
> in multiple data mode or in single data (legacy) mode.
>
> If MODE9 bit is set into the Mode Register or if USMODE is set to
> either LIN_MASTER, LIN_SLAVE or LON_MODE, FIFOs operate in single
> data mode. Otherwise, they operate in multiple data mode.
>
> In this new multiple data mode, accesses to the Receive Holding
> Register or Transmit Holding Register slightly change.
>
> Since this driver implements neither the 9bit data feature (MODE9 bit
> set into the Mode Register) nor LIN modes, the USART works in
> multiple data mode whenever FIFOs are available and enabled. We also
> assume that data are 8bit wide.
>
> In single data mode, 32bit access CAN be used to read a single data
> from RHR or write a single data into THR.
> However in multiple data mode, a 32bit access to RHR now allows us to
> read four consecutive data from RX FIFO. Also a 32bit access to THR
> now allows to write four consecutive data into TX FIFO. So we MUST
> use 8bit access whenever only one data have to be read/written at a
> time.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/tty/serial/atmel_serial.c | 100 +++++++++++++++++++++++++++++++++++---
>  include/linux/atmel_serial.h      |  36 ++++++++++++++
>  2 files changed, 130 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index e7c337de31d1..87de21f0c7a3 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -56,6 +56,15 @@
>  /* Revisit: We should calculate this based on the actual port settings */
>  #define PDC_RX_TIMEOUT         (3 * 10)                /* 3 bytes */
>
> +/* The minium number of data FIFOs should be able to contain */
> +#define ATMEL_MIN_FIFO_SIZE    8
> +/*
> + * These two offsets are substracted from the RX FIFO size to define the RTS
> + * high and low thresholds
> + */
> +#define ATMEL_RTS_HIGH_OFFSET  16
> +#define ATMEL_RTS_LOW_OFFSET   20
> +
>  #if defined(CONFIG_SERIAL_ATMEL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>  #define SUPPORT_SYSRQ
>  #endif
> @@ -141,6 +150,9 @@ struct atmel_uart_port {
>         struct mctrl_gpios      *gpios;
>         int                     gpio_irq[UART_GPIO_MAX];
>         unsigned int            tx_done_mask;
> +       u32                     fifo_size;
> +       u32                     rts_high;
> +       u32                     rts_low;
>         bool                    ms_irq_enabled;
>         bool                    is_usart;       /* usart or uart */
>         struct timer_list       uart_timer;     /* uart timer */
> @@ -191,6 +203,16 @@ static inline void atmel_uart_writel(struct uart_port *port, u32 reg, u32 value)
>         __raw_writel(value, port->membase + reg);
>  }
>
> +static inline u8 atmel_uart_readb(struct uart_port *port, u32 reg)
> +{
> +       return __raw_readb(port->membase + reg);
> +}
> +
> +static inline void atmel_uart_writeb(struct uart_port *port, u32 reg, u8 value)
> +{
> +       __raw_writeb(value, port->membase + reg);
> +}
> +
>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>  static bool atmel_use_pdc_rx(struct uart_port *port)
>  {
> @@ -635,7 +657,7 @@ static void atmel_rx_chars(struct uart_port *port)
>
>         status = atmel_uart_readl(port, ATMEL_US_CSR);
>         while (status & ATMEL_US_RXRDY) {
> -               ch = atmel_uart_readl(port, ATMEL_US_RHR);
> +               ch = atmel_uart_readb(port, ATMEL_US_RHR);
>
>                 /*
>                  * note that the error handling code is
> @@ -686,7 +708,7 @@ static void atmel_tx_chars(struct uart_port *port)
>
>         if (port->x_char &&
>             (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_mask)) {
> -               atmel_uart_writel(port, ATMEL_US_THR, port->x_char);
> +               atmel_uart_writeb(port, ATMEL_US_THR, port->x_char);
>                 port->icount.tx++;
>                 port->x_char = 0;
>         }
> @@ -695,7 +717,7 @@ static void atmel_tx_chars(struct uart_port *port)
>
>         while (atmel_uart_readl(port, ATMEL_US_CSR) &
>                atmel_port->tx_done_mask) {
> -               atmel_uart_writel(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
> +               atmel_uart_writeb(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
>                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>                 port->icount.tx++;
>                 if (uart_circ_empty(xmit))
> @@ -1796,6 +1818,29 @@ static int atmel_startup(struct uart_port *port)
>                         atmel_set_ops(port);
>         }
>
> +       /*
> +        * Enable FIFO when available
> +        */
> +       if (atmel_port->fifo_size) {
> +               unsigned int txrdym = ATMEL_US_ONE_DATA;
> +               unsigned int rxrdym = ATMEL_US_ONE_DATA;
> +               unsigned int fmr;
> +
> +               atmel_uart_writel(port, ATMEL_US_CR,
> +                                 ATMEL_US_FIFOEN |
> +                                 ATMEL_US_RXFCLR |
> +                                 ATMEL_US_TXFLCLR);
> +
> +               fmr = ATMEL_US_TXRDYM(txrdym) | ATMEL_US_RXRDYM(rxrdym);
> +               if (atmel_port->rts_high &&
> +                   atmel_port->rts_low)
> +                       fmr |=  ATMEL_US_FRTSC |
> +                               ATMEL_US_RXFTHRES(atmel_port->rts_high) |
> +                               ATMEL_US_RXFTHRES2(atmel_port->rts_low);
> +
> +               atmel_uart_writel(port, ATMEL_US_FMR, fmr);
> +       }
> +
>         /* Save current CSR for comparison in atmel_tasklet_func() */
>         atmel_port->irq_status_prev = atmel_get_lines_status(port);
>         atmel_port->irq_status = atmel_port->irq_status_prev;
> @@ -2213,7 +2258,7 @@ static int atmel_poll_get_char(struct uart_port *port)
>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_RXRDY))
>                 cpu_relax();
>
> -       return atmel_uart_readl(port, ATMEL_US_RHR);
> +       return atmel_uart_readb(port, ATMEL_US_RHR);
>  }
>
>  static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
> @@ -2221,7 +2266,7 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>                 cpu_relax();
>
> -       atmel_uart_writel(port, ATMEL_US_THR, ch);
> +       atmel_uart_writeb(port, ATMEL_US_THR, ch);
>  }
>  #endif
>
> @@ -2328,7 +2373,7 @@ static void atmel_console_putchar(struct uart_port *port, int ch)
>  {
>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>                 cpu_relax();
> -       atmel_uart_writel(port, ATMEL_US_THR, ch);
> +       atmel_uart_writeb(port, ATMEL_US_THR, ch);
>  }
>
>  /*
> @@ -2603,6 +2648,48 @@ static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
>         return 0;
>  }
>
> +static void atmel_serial_probe_fifos(struct atmel_uart_port *port,
> +                                    struct platform_device *pdev)
> +{
> +       port->fifo_size = 0;
> +       port->rts_low = 0;
> +       port->rts_high = 0;
> +
> +       if (of_property_read_u32(pdev->dev.of_node,
> +                                "atmel,fifo-size",
> +                                &port->fifo_size))
> +               return;
> +
> +       if (!port->fifo_size)
> +               return;
> +
> +       if (port->fifo_size < ATMEL_MIN_FIFO_SIZE) {
> +               port->fifo_size = 0;
> +               dev_err(&pdev->dev, "Invalid FIFO size\n");
> +               return;
> +       }
> +
> +       /*
> +        * 0 <= rts_low <= rts_high <= fifo_size
> +        * Once their CTS line asserted by the remote peer, some x86 UARTs tend
> +        * to flush their internal TX FIFO, commonly up to 16 data, before
> +        * actually stopping to send new data. So we try to set the RTS High
> +        * Threshold to a reasonably high value respecting this 16 data
> +        * empirical rule when possible.
> +        */
> +       port->rts_high = max_t(int, port->fifo_size >> 1,
> +                              port->fifo_size - ATMEL_RTS_HIGH_OFFSET);
> +       port->rts_low  = max_t(int, port->fifo_size >> 2,
> +                              port->fifo_size - ATMEL_RTS_LOW_OFFSET);
> +
> +       dev_info(&pdev->dev, "Using FIFO (%u data)\n",
> +                port->fifo_size);
> +       dev_dbg(&pdev->dev, "RTS High Threshold : %2u data\n",
> +               port->rts_high);
> +       dev_dbg(&pdev->dev, "RTS Low Threshold  : %2u data\n",
> +               port->rts_low);
> +}
> +
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
>         struct atmel_uart_port *port;
> @@ -2639,6 +2726,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>         port = &atmel_ports[ret];
>         port->backup_imr = 0;
>         port->uart.line = ret;
> +       atmel_serial_probe_fifos(port, pdev);
>
>         spin_lock_init(&port->lock_suspended);
>
> diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
> index c384c21d65f0..ee696d7e8a43 100644
> --- a/include/linux/atmel_serial.h
> +++ b/include/linux/atmel_serial.h
> @@ -35,6 +35,11 @@
>  #define        ATMEL_US_DTRDIS         BIT(17) /* Data Terminal Ready Disable */
>  #define        ATMEL_US_RTSEN          BIT(18) /* Request To Send Enable */
>  #define        ATMEL_US_RTSDIS         BIT(19) /* Request To Send Disable */
> +#define        ATMEL_US_TXFCLR         BIT(24) /* Transmit FIFO Clear */
> +#define        ATMEL_US_RXFCLR         BIT(25) /* Receive FIFO Clear */
> +#define        ATMEL_US_TXFLCLR        BIT(26) /* Transmit FIFO Lock Clear */
> +#define        ATMEL_US_FIFOEN         BIT(30) /* FIFO enable */
> +#define        ATMEL_US_FIFODIS        BIT(31) /* FIFO disable */
>
>  #define ATMEL_US_MR            0x04    /* Mode Register */
>  #define        ATMEL_US_USMODE         GENMASK(3, 0)   /* Mode of the USART */
> @@ -124,6 +129,37 @@
>  #define ATMEL_US_NER           0x44    /* Number of Errors Register */
>  #define ATMEL_US_IF            0x4c    /* IrDA Filter Register */
>
> +#define ATMEL_US_CMPR          0x90    /* Comparaison Register */
> +#define ATMEL_US_FMR           0xa0    /* FIFO Mode Register */
> +#define        ATMEL_US_TXRDYM(data)   (((data) & 0x3) << 0)   /* TX Ready Mode */
> +#define        ATMEL_US_RXRDYM(data)   (((data) & 0x3) << 4)   /* RX Ready Mode */
> +#define                ATMEL_US_ONE_DATA       0x0
> +#define                ATMEL_US_TWO_DATA       0x1
> +#define                ATMEL_US_FOUR_DATA      0x2
> +#define        ATMEL_US_FRTSC          BIT(7)  /* FIFO RTS pin Control */
> +#define        ATMEL_US_TXFTHRES(thr)  (((thr) & 0x3f) << 8)   /* TX FIFO Threshold */
> +#define        ATMEL_US_RXFTHRES(thr)  (((thr) & 0x3f) << 16)  /* RX FIFO Threshold */
> +#define        ATMEL_US_RXFTHRES2(thr) (((thr) & 0x3f) << 24)  /* RX FIFO Threshold2 */
> +
> +#define ATMEL_US_FLR           0xa4    /* FIFO Level Register */
> +#define        ATMEL_US_TXFL(reg)      (((reg) >> 0) & 0x3f)   /* TX FIFO Level */
> +#define        ATMEL_US_RXFL(reg)      (((reg) >> 16) & 0x3f)  /* RX FIFO Level */
> +
> +#define ATMEL_US_FIER          0xa8    /* FIFO Interrupt Enable Register */
> +#define ATMEL_US_FIDR          0xac    /* FIFO Interrupt Disable Register */
> +#define ATMEL_US_FIMR          0xb0    /* FIFO Interrupt Mask Register */
> +#define ATMEL_US_FESR          0xb4    /* FIFO Event Status Register */
> +#define        ATMEL_US_TXFEF          BIT(0)  /* Transmit FIFO Empty Flag */
> +#define        ATMEL_US_TXFFF          BIT(1)  /* Transmit FIFO Full Flag */
> +#define        ATMEL_US_TXFTHF         BIT(2)  /* Transmit FIFO Threshold Flag */
> +#define        ATMEL_US_RXFEF          BIT(3)  /* Receive FIFO Empty Flag */
> +#define        ATMEL_US_RXFFF          BIT(4)  /* Receive FIFO Full Flag */
> +#define        ATMEL_US_RXFTHF         BIT(5)  /* Receive FIFO Threshold Flag */
> +#define        ATMEL_US_TXFPTEF        BIT(6)  /* Transmit FIFO Pointer Error Flag */
> +#define        ATMEL_US_RXFPTEF        BIT(7)  /* Receive FIFO Pointer Error Flag */
> +#define        ATMEL_US_TXFLOCK        BIT(8)  /* Transmit FIFO Lock (FESR only) */
> +#define        ATMEL_US_RXFTHF2        BIT(9)  /* Receive FIFO Threshold Flag 2 */
> +
>  #define ATMEL_US_NAME          0xf0    /* Ip Name */
>  #define ATMEL_US_VERSION       0xfc    /* Ip Version */
>
> --
> 1.8.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
