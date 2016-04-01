From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v2] serial: amba-pl011: complete support to ZTE uart
Date: Fri, 1 Apr 2016 17:53:19 +0800
Message-ID: <CABymUCN_Os0gxoWjfwB_8V4kEkwBqKcrCCRjH8+-gm-Xt3-tYQ@mail.gmail.com>
References: <1458717126-20814-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1458717126-20814-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-serial@vger.kernel.org

2016-03-23 15:12 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
> Complete support to ZTE uart with adding specific registers
> mask.
> We use a magic amba periphid value as pl011 device on ZTE
> does not have a periphid value in register. The magic value
> should also be feed via device tree "arm,primecell-periphid"
> property to match pl011 driver and get ZTE uart data.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 73 +++++++++++++++++++++++++++++++++--------
>  include/linux/amba/serial.h     |  4 +++
>  2 files changed, 64 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 7c198e0..696ee0c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -93,6 +93,10 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>  struct vendor_data {
>         const u16               *reg_offset;
>         unsigned int            ifls;
> +       unsigned int            fr_busy;
> +       unsigned int            fr_dsr;
> +       unsigned int            fr_cts;
> +       unsigned int            fr_ri;
>         bool                    access_32b;
>         bool                    oversampling;
>         bool                    dma_threshold;
> @@ -111,6 +115,10 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
>  static struct vendor_data vendor_arm = {
>         .reg_offset             = pl011_std_offsets,
>         .ifls                   = UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
> +       .fr_busy                = UART01x_FR_BUSY,
> +       .fr_dsr                 = UART01x_FR_DSR,
> +       .fr_cts                 = UART01x_FR_CTS,
> +       .fr_ri                  = UART011_FR_RI,
>         .oversampling           = false,
>         .dma_threshold          = false,
>         .cts_event_workaround   = false,
> @@ -121,6 +129,10 @@ static struct vendor_data vendor_arm = {
>
>  static struct vendor_data vendor_sbsa = {
>         .reg_offset             = pl011_std_offsets,
> +       .fr_busy                = UART01x_FR_BUSY,
> +       .fr_dsr                 = UART01x_FR_DSR,
> +       .fr_cts                 = UART01x_FR_CTS,
> +       .fr_ri                  = UART011_FR_RI,
>         .oversampling           = false,
>         .dma_threshold          = false,
>         .cts_event_workaround   = false,
> @@ -163,6 +175,10 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
>  static struct vendor_data vendor_st = {
>         .reg_offset             = pl011_st_offsets,
>         .ifls                   = UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
> +       .fr_busy                = UART01x_FR_BUSY,
> +       .fr_dsr                 = UART01x_FR_DSR,
> +       .fr_cts                 = UART01x_FR_CTS,
> +       .fr_ri                  = UART011_FR_RI,
>         .oversampling           = true,
>         .dma_threshold          = true,
>         .cts_event_workaround   = true,
> @@ -187,11 +203,25 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
>         [REG_DMACR] = ZX_UART011_DMACR,
>  };
>
> +static unsigned int get_fifosize_zte(struct amba_device *dev)
> +{
> +       return 16;
> +}
> +
>  static struct vendor_data vendor_zte __maybe_unused = {
>         .reg_offset             = pl011_zte_offsets,
>         .access_32b             = true,
>         .ifls                   = UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
> -       .get_fifosize           = get_fifosize_arm,
> +       .fr_busy                = ZX_UART01x_FR_BUSY,
> +       .fr_dsr                 = ZX_UART01x_FR_DSR,
> +       .fr_cts                 = ZX_UART01x_FR_CTS,
> +       .fr_ri                  = ZX_UART011_FR_RI,
> +       .oversampling           = false,
> +       .dma_threshold          = false,
> +       .cts_event_workaround   = false,
> +       .always_enabled         = false,
> +       .fixed_options          = false,
> +       .get_fifosize           = get_fifosize_zte,
>  };
>
>  /* Deals with DMA transactions */
> @@ -236,6 +266,10 @@ struct uart_amba_port {
>         unsigned int            im;             /* interrupt mask */
>         unsigned int            old_status;
>         unsigned int            fifosize;       /* vendor-specific */
> +       unsigned int            fr_busy;        /* vendor-specific */
> +       unsigned int            fr_dsr;         /* vendor-specific */
> +       unsigned int            fr_cts;         /* vendor-specific */
> +       unsigned int            fr_ri;          /* vendor-specific */
>         unsigned int            old_cr;         /* state during shutdown */
>         bool                    autorts;
>         unsigned int            fixed_baud;     /* vendor-set fixed baud rate */
> @@ -1166,7 +1200,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
>                 return;
>
>         /* Disable RX and TX DMA */
> -       while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
> +       while (pl011_read(uap, REG_FR) & uap->fr_busy)
>                 cpu_relax();
>
>         spin_lock_irq(&uap->port.lock);
> @@ -1415,11 +1449,11 @@ static void pl011_modem_status(struct uart_amba_port *uap)
>         if (delta & UART01x_FR_DCD)
>                 uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
>
> -       if (delta & UART01x_FR_DSR)
> +       if (delta & uap->fr_dsr)
>                 uap->port.icount.dsr++;
>
> -       if (delta & UART01x_FR_CTS)
> -               uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
> +       if (delta & uap->fr_cts)
> +               uart_handle_cts_change(&uap->port, status & uap->fr_cts);
>
>         wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
>  }
> @@ -1492,7 +1526,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>         struct uart_amba_port *uap =
>             container_of(port, struct uart_amba_port, port);
>         unsigned int status = pl011_read(uap, REG_FR);
> -       return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
> +       return status & (uap->fr_busy | UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
>  }
>
>  static unsigned int pl011_get_mctrl(struct uart_port *port)
> @@ -1507,9 +1541,9 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
>                 result |= tiocmbit
>
>         TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
> -       TIOCMBIT(UART01x_FR_DSR, TIOCM_DSR);
> -       TIOCMBIT(UART01x_FR_CTS, TIOCM_CTS);
> -       TIOCMBIT(UART011_FR_RI, TIOCM_RNG);
> +       TIOCMBIT(uap->fr_dsr, TIOCM_DSR);
> +       TIOCMBIT(uap->fr_cts, TIOCM_CTS);
> +       TIOCMBIT(uap->fr_ri, TIOCM_RNG);
>  #undef TIOCMBIT
>         return result;
>  }
> @@ -2086,7 +2120,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
>         return ret;
>  }
>
> -static struct uart_ops amba_pl011_pops = {
> +static const struct uart_ops amba_pl011_pops = {
>         .tx_empty       = pl011_tx_empty,
>         .set_mctrl      = pl011_set_mctrl,
>         .get_mctrl      = pl011_get_mctrl,
> @@ -2190,7 +2224,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>          *      Finally, wait for transmitter to become empty
>          *      and restore the TCR
>          */
> -       while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
> +       while (pl011_read(uap, REG_FR) & uap->fr_busy)
>                 cpu_relax();
>         if (!uap->vendor->always_enabled)
>                 pl011_write(old_cr, uap, REG_CR);
> @@ -2472,8 +2506,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>                 return PTR_ERR(uap->clk);
>
>         uap->reg_offset = vendor->reg_offset;
> -       uap->vendor = vendor;
> -       uap->fifosize = vendor->get_fifosize(dev);
> +       uap->vendor     = vendor;
> +       uap->fifosize   = vendor->get_fifosize(dev);
> +       uap->fr_busy    = vendor->fr_busy;
> +       uap->fr_dsr     = vendor->fr_dsr;
> +       uap->fr_cts     = vendor->fr_cts;
> +       uap->fr_ri      = vendor->fr_ri;
>         uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
>         uap->port.irq = dev->irq[0];
>         uap->port.ops = &amba_pl011_pops;
> @@ -2555,6 +2593,10 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>         uap->reg_offset = vendor_sbsa.reg_offset;
>         uap->vendor     = &vendor_sbsa;
>         uap->fifosize   = 32;
> +       uap->fr_busy    = vendor_sbsa.fr_busy;
> +       uap->fr_dsr     = vendor_sbsa.fr_dsr;
> +       uap->fr_cts     = vendor_sbsa.fr_cts;
> +       uap->fr_ri      = vendor_sbsa.fr_ri;
>         uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
>         uap->port.irq   = platform_get_irq(pdev, 0);
>         uap->port.ops   = &sbsa_uart_pops;
> @@ -2615,6 +2657,11 @@ static struct amba_id pl011_ids[] = {
>                 .mask   = 0x00ffffff,
>                 .data   = &vendor_st,
>         },
> +       {
> +               .id     = 0xfefefe,
> +               .mask   = 0xffffff,
> +               .data   = &vendor_zte,
> +       },
>         { 0, 0 },
>  };
>
> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
> index d76a19b..750f2ef 100644
> --- a/include/linux/amba/serial.h
> +++ b/include/linux/amba/serial.h
> @@ -103,6 +103,10 @@
>  #define UART01x_FR_DSR                 0x002
>  #define UART01x_FR_CTS                 0x001
>  #define UART01x_FR_TMSK                (UART01x_FR_TXFF + UART01x_FR_BUSY)
> +#define ZX_UART01x_FR_BUSY     0x300
> +#define ZX_UART01x_FR_DSR      0x008
> +#define ZX_UART01x_FR_CTS      0x002
> +#define ZX_UART011_FR_RI       0x001
>
>  #define UART011_CR_CTSEN       0x8000  /* CTS hardware flow control */
>  #define UART011_CR_RTSEN       0x4000  /* RTS hardware flow control */
> --
> 1.9.1
>

Russell,

Do you have any more comments with this AMBA version?

Thanks!
Jun
