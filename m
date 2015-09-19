From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
Date: Sat, 19 Sep 2015 14:47:54 +0800
Message-ID: <CABymUCO+DyEkrktQ5Q8fGwyJ2di9bXV4-Wqtk1-Ruf0jRb7XZw@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <20150918135954.GH21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150918135954.GH21084@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2015-09-18 21:59 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> I guess I need to pick up maintanence of this driver again and stop it
> turning into the stinking pile of dogpoo that people are trying to make
> it... I don't have time this week to do that, nor next week though.
>
Welcome back to maintain this driver and your comments on CODE is also welcome.

Jun

> On Fri, Sep 18, 2015 at 02:50:26PM +0100, Andre Przywara wrote:
>> Hi Jun,
>>
>> On 31/07/15 08:49, Jun Nie wrote:
>> > Support ZTE uart with some registers differing offset.
>> > Probe as platform device for not AMBA IP ID is
>> > available on ZTE uart.
>> >
>> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> > ---
>> >  drivers/tty/serial/Kconfig      |   4 +-
>> >  drivers/tty/serial/amba-pl011.c | 195 +++++++++++++++++++++++++++++++++++++---
>> >  include/linux/amba/serial.h     |  14 +++
>> >  3 files changed, 197 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> > index 15b4079..2103765 100644
>> > --- a/drivers/tty/serial/Kconfig
>> > +++ b/drivers/tty/serial/Kconfig
>> > @@ -47,12 +47,12 @@ config SERIAL_AMBA_PL010_CONSOLE
>> >
>> >  config SERIAL_AMBA_PL011
>> >         tristate "ARM AMBA PL011 serial port support"
>> > -       depends on ARM_AMBA
>> > +       depends on ARM_AMBA || SOC_ZX296702
>> >         select SERIAL_CORE
>> >         help
>> >           This selects the ARM(R) AMBA(R) PrimeCell PL011 UART.  If you have
>> >           an Integrator/PP2, Integrator/CP or Versatile platform, say Y or M
>> > -         here.
>> > +         here. Say Y or M if you have SOC_ZX296702.
>> >
>> >           If unsure, say N.
>> >
>> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> > index 017443d..2af09ab 100644
>> > --- a/drivers/tty/serial/amba-pl011.c
>> > +++ b/drivers/tty/serial/amba-pl011.c
>> > @@ -74,6 +74,10 @@
>> >  /* There is by now at least one vendor with differing details, so handle it */
>> >  struct vendor_data {
>> >         unsigned int            ifls;
>> > +       unsigned int            fr_busy;
>> > +       unsigned int            fr_dsr;
>> > +       unsigned int            fr_cts;
>> > +       unsigned int            fr_ri;
>> >         unsigned int            lcrh_tx;
>> >         unsigned int            lcrh_rx;
>> >         u16                     *reg_lut;
>> > @@ -127,6 +131,7 @@ static u16 arm_reg[] = {
>> >         [REG_DMACR]             = UART011_DMACR,
>> >  };
>> >
>> > +#ifdef CONFIG_ARM_AMBA
>>
>> Maybe I missed that discussion (reading mailing list archives on the web
>> is just horrible!), but why do we have all these #ifdefs here?
>> The actual design of that driver extension is meant to fold well into
>> the driver, with the changes only coming into effect if the DT node is
>> found. To me it looks like we could even have a PL011 instance and a ZTE
>> UART instance in operation at the same time.
>>
>> So can't we get rid of those silly #ifdef CONFIG_ARM_AMBAs at least, and
>> CONFIG_SOC_ZX296702 as well?
>>
>> >  static unsigned int get_fifosize_arm(struct amba_device *dev)
>> >  {
>> >         return amba_rev(dev) < 3 ? 16 : 32;
>> > @@ -134,6 +139,10 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
>> >
>> >  static struct vendor_data vendor_arm = {
>> >         .ifls                   = UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
>> > +       .fr_busy                = UART01x_FR_BUSY,
>> > +       .fr_dsr                 = UART01x_FR_DSR,
>> > +       .fr_cts                 = UART01x_FR_CTS,
>> > +       .fr_ri                  = UART011_FR_RI,
>> >         .lcrh_tx                = REG_LCRH,
>> >         .lcrh_rx                = REG_LCRH,
>> >         .reg_lut                = arm_reg,
>> > @@ -144,8 +153,13 @@ static struct vendor_data vendor_arm = {
>> >         .fixed_options          = false,
>> >         .get_fifosize           = get_fifosize_arm,
>> >  };
>> > +#endif
>> >
>> >  static struct vendor_data vendor_sbsa = {
>> > +       .fr_busy                = UART01x_FR_BUSY,
>> > +       .fr_dsr                 = UART01x_FR_DSR,
>> > +       .fr_cts                 = UART01x_FR_CTS,
>> > +       .fr_ri                  = UART011_FR_RI,
>> >         .reg_lut                = arm_reg,
>> >         .oversampling           = false,
>> >         .dma_threshold          = false,
>> > @@ -154,6 +168,7 @@ static struct vendor_data vendor_sbsa = {
>> >         .fixed_options          = true,
>> >  };
>> >
>> > +#ifdef CONFIG_ARM_AMBA
>> >  static u16 st_reg[] = {
>> >         [REG_DR]                = UART01x_DR,
>> >         [REG_RSR]               = UART01x_RSR,
>> > @@ -180,6 +195,10 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
>> >
>> >  static struct vendor_data vendor_st = {
>> >         .ifls                   = UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
>> > +       .fr_busy                = UART01x_FR_BUSY,
>> > +       .fr_dsr                 = UART01x_FR_DSR,
>> > +       .fr_cts                 = UART01x_FR_CTS,
>> > +       .fr_ri                  = UART011_FR_RI,
>> >         .lcrh_tx                = REG_LCRH,
>> >         .lcrh_rx                = REG_ST_LCRH_RX,
>> >         .reg_lut                = st_reg,
>> > @@ -190,6 +209,43 @@ static struct vendor_data vendor_st = {
>> >         .fixed_options          = false,
>> >         .get_fifosize           = get_fifosize_st,
>> >  };
>> > +#endif
>> > +
>> > +#ifdef CONFIG_SOC_ZX296702
>>
>> As said above, I doubt the usefulness of this bracketing.
>> But even if there are arguments in favour for that, shouldn't it be
>> CONFIG_ARCH_ZX instead? Or is this UART just a mishap which happened to
>> that very particular SoC and it will not show again in any other
>> silicon?
>>
>> Cheers,
>> Andre.
>>
>> > +static u16 zte_reg[] = {
>> > +       [REG_DR]                = ZX_UART01x_DR,
>> > +       [REG_RSR]               = UART01x_RSR,
>> > +       [REG_ST_DMAWM]          = ST_UART011_DMAWM,
>> > +       [REG_FR]                = ZX_UART01x_FR,
>> > +       [REG_ST_LCRH_RX]        = ST_UART011_LCRH_RX,
>> > +       [REG_ILPR]              = UART01x_ILPR,
>> > +       [REG_IBRD]              = UART011_IBRD,
>> > +       [REG_FBRD]              = UART011_FBRD,
>> > +       [REG_LCRH]              = ZX_UART011_LCRH_TX,
>> > +       [REG_CR]                = ZX_UART011_CR,
>> > +       [REG_IFLS]              = ZX_UART011_IFLS,
>> > +       [REG_IMSC]              = ZX_UART011_IMSC,
>> > +       [REG_RIS]               = ZX_UART011_RIS,
>> > +       [REG_MIS]               = ZX_UART011_MIS,
>> > +       [REG_ICR]               = ZX_UART011_ICR,
>> > +       [REG_DMACR]             = ZX_UART011_DMACR,
>> > +};
>> > +
>> > +static struct vendor_data vendor_zte = {
>> > +       .ifls                   = UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
>> > +       .fr_busy                = ZX_UART01x_FR_BUSY,
>> > +       .fr_dsr                 = ZX_UART01x_FR_DSR,
>> > +       .fr_cts                 = ZX_UART01x_FR_CTS,
>> > +       .fr_ri                  = ZX_UART011_FR_RI,
>> > +       .lcrh_tx                = REG_LCRH,
>> > +       .lcrh_rx                = REG_ST_LCRH_RX,
>> > +       .reg_lut                = zte_reg,
>> > +       .oversampling           = false,
>> > +       .dma_threshold          = false,
>> > +       .cts_event_workaround   = false,
>> > +       .fixed_options          = false,
>> > +};
>> > +#endif
>> >
>> >  /* Deals with DMA transactions */
>> >
>> > @@ -233,6 +289,10 @@ struct uart_amba_port {
>> >         unsigned int            im;             /* interrupt mask */
>> >         unsigned int            old_status;
>> >         unsigned int            fifosize;       /* vendor-specific */
>> > +       unsigned int            fr_busy;        /* vendor-specific */
>> > +       unsigned int            fr_dsr;         /* vendor-specific */
>> > +       unsigned int            fr_cts;         /* vendor-specific */
>> > +       unsigned int            fr_ri;          /* vendor-specific */
>> >         unsigned int            lcrh_tx;        /* vendor-specific */
>> >         unsigned int            lcrh_rx;        /* vendor-specific */
>> >         unsigned int            old_cr;         /* state during shutdown */
>> > @@ -1163,7 +1223,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
>> >                 return;
>> >
>> >         /* Disable RX and TX DMA */
>> > -       while (pl011_readw(uap, REG_FR) & UART01x_FR_BUSY)
>> > +       while (pl011_readw(uap, REG_FR) & uap->fr_busy)
>> >                 barrier();
>> >
>> >         spin_lock_irq(&uap->port.lock);
>> > @@ -1412,11 +1472,11 @@ static void pl011_modem_status(struct uart_amba_port *uap)
>> >         if (delta & UART01x_FR_DCD)
>> >                 uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
>> >
>> > -       if (delta & UART01x_FR_DSR)
>> > +       if (delta & uap->fr_dsr)
>> >                 uap->port.icount.dsr++;
>> >
>> > -       if (delta & UART01x_FR_CTS)
>> > -               uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
>> > +       if (delta & uap->fr_cts)
>> > +               uart_handle_cts_change(&uap->port, status & uap->fr_cts);
>> >
>> >         wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
>> >  }
>> > @@ -1487,7 +1547,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>> >         struct uart_amba_port *uap =
>> >             container_of(port, struct uart_amba_port, port);
>> >         unsigned int status = pl011_readw(uap, REG_FR);
>> > -       return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
>> > +       return status & (uap->fr_busy|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
>> >  }
>> >
>> >  static unsigned int pl011_get_mctrl(struct uart_port *port)
>> > @@ -1502,9 +1562,9 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
>> >                 result |= tiocmbit
>> >
>> >         TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
>> > -       TIOCMBIT(UART01x_FR_DSR, TIOCM_DSR);
>> > -       TIOCMBIT(UART01x_FR_CTS, TIOCM_CTS);
>> > -       TIOCMBIT(UART011_FR_RI, TIOCM_RNG);
>> > +       TIOCMBIT(uap->fr_dsr, TIOCM_DSR);
>> > +       TIOCMBIT(uap->fr_cts, TIOCM_CTS);
>> > +       TIOCMBIT(uap->fr_ri, TIOCM_RNG);
>> >  #undef TIOCMBIT
>> >         return result;
>> >  }
>> > @@ -1720,8 +1780,7 @@ static int pl011_startup(struct uart_port *port)
>> >         /*
>> >          * initialise the old status of the modem signals
>> >          */
>> > -       uap->old_status = pl011_readw(uap, REG_FR) &
>> > -                       UART01x_FR_MODEM_ANY;
>> > +       uap->old_status = pl011_readw(uap, REG_FR) & UART01x_FR_MODEM_ANY;
>> >
>> >         /* Startup DMA */
>> >         pl011_dma_startup(uap);
>> > @@ -1800,7 +1859,7 @@ static void pl011_disable_interrupts(struct uart_amba_port *uap)
>> >         /* mask all interrupts and clear all pending ones */
>> >         uap->im = 0;
>> >         pl011_writew(uap, uap->im, REG_IMSC);
>> > -       pl011_writew(0xffff, REG_ICR);
>> > +       pl011_writew(uap, 0xffff, REG_ICR);
>> >
>> >         spin_unlock_irq(&uap->port.lock);
>> >  }
>> > @@ -2178,7 +2237,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>> >          */
>> >         do {
>> >                 status = pl011_readw(uap, REG_FR);
>> > -       } while (status & UART01x_FR_BUSY);
>> > +       } while (status & uap->fr_busy);
>> >         if (!uap->vendor->always_enabled)
>> >                 pl011_writew(uap, old_cr, REG_CR);
>> >
>> > @@ -2295,7 +2354,7 @@ static void pl011_putc(struct uart_port *port, int c)
>> >         while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>> >                 ;
>> >         pl011_writeb(uap, c, REG_DR);
>> > -       while (pl011_readw(uap, REG_FR) & UART01x_FR_BUSY)
>> > +       while (pl011_readw(uap, REG_FR) & uap->fr_busy)
>> >                 ;
>> >  }
>> >
>> > @@ -2441,6 +2500,7 @@ static int pl011_register_port(struct uart_amba_port *uap)
>> >         return ret;
>> >  }
>> >
>> > +#ifdef CONFIG_ARM_AMBA
>> >  static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>> >  {
>> >         struct uart_amba_port *uap;
>> > @@ -2464,6 +2524,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>> >         uap->reg_lut = vendor->reg_lut;
>> >         uap->lcrh_rx = vendor->lcrh_rx;
>> >         uap->lcrh_tx = vendor->lcrh_tx;
>> > +       uap->fr_busy = vendor->fr_busy;
>> > +       uap->fr_dsr = vendor->fr_dsr;
>> > +       uap->fr_cts = vendor->fr_cts;
>> > +       uap->fr_ri = vendor->fr_ri;
>> >         uap->fifosize = vendor->get_fifosize(dev);
>> >         uap->port.irq = dev->irq[0];
>> >         uap->port.ops = &amba_pl011_pops;
>> > @@ -2487,6 +2551,67 @@ static int pl011_remove(struct amba_device *dev)
>> >         pl011_unregister_port(uap);
>> >         return 0;
>> >  }
>> > +#endif
>> > +
>> > +#ifdef CONFIG_SOC_ZX296702
>> > +static int zx_uart_probe(struct platform_device *pdev)
>> > +{
>> > +       struct uart_amba_port *uap;
>> > +       struct vendor_data *vendor = &vendor_zte;
>> > +       struct resource *res;
>> > +       int portnr, ret;
>> > +
>> > +       portnr = pl011_find_free_port();
>> > +       if (portnr < 0)
>> > +               return portnr;
>> > +
>> > +       uap = devm_kzalloc(&pdev->dev, sizeof(struct uart_amba_port),
>> > +                       GFP_KERNEL);
>> > +       if (!uap) {
>> > +               ret = -ENOMEM;
>> > +               goto out;
>> > +       }
>> > +
>> > +       uap->clk = devm_clk_get(&pdev->dev, NULL);
>> > +       if (IS_ERR(uap->clk)) {
>> > +               ret = PTR_ERR(uap->clk);
>> > +               goto out;
>> > +       }
>> > +
>> > +       uap->vendor     = vendor;
>> > +       uap->reg_lut    = vendor->reg_lut;
>> > +       uap->lcrh_rx    = vendor->lcrh_rx;
>> > +       uap->lcrh_tx    = vendor->lcrh_tx;
>> > +       uap->fr_busy    = vendor->fr_busy;
>> > +       uap->fr_dsr     = vendor->fr_dsr;
>> > +       uap->fr_cts     = vendor->fr_cts;
>> > +       uap->fr_ri      = vendor->fr_ri;
>> > +       uap->fifosize   = 16;
>> > +       uap->port.irq   = platform_get_irq(pdev, 0);
>> > +       uap->port.ops   = &amba_pl011_pops;
>> > +
>> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > +
>> > +       ret = pl011_setup_port(&pdev->dev, uap, res, portnr);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       platform_set_drvdata(pdev, uap);
>> > +
>> > +       return pl011_register_port(uap);
>> > +out:
>> > +       return ret;
>> > +}
>> > +
>> > +static int zx_uart_remove(struct platform_device *pdev)
>> > +{
>> > +       struct uart_amba_port *uap = platform_get_drvdata(pdev);
>> > +
>> > +       uart_remove_one_port(&amba_reg, &uap->port);
>> > +       pl011_unregister_port(uap);
>> > +       return 0;
>> > +}
>> > +#endif
>> >
>> >  #ifdef CONFIG_PM_SLEEP
>> >  static int pl011_suspend(struct device *dev)
>> > @@ -2544,6 +2669,10 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>> >
>> >         uap->vendor     = &vendor_sbsa;
>> >         uap->reg_lut    = vendor_sbsa.reg_lut;
>> > +       uap->fr_busy    = vendor_sbsa.fr_busy;
>> > +       uap->fr_dsr     = vendor_sbsa.fr_dsr;
>> > +       uap->fr_cts     = vendor_sbsa.fr_cts;
>> > +       uap->fr_ri      = vendor_sbsa.fr_ri;
>> >         uap->fifosize   = 32;
>> >         uap->port.irq   = platform_get_irq(pdev, 0);
>> >         uap->port.ops   = &sbsa_uart_pops;
>> > @@ -2593,6 +2722,7 @@ static struct platform_driver arm_sbsa_uart_platform_driver = {
>> >         },
>> >  };
>> >
>> > +#ifdef CONFIG_ARM_AMBA
>> >  static struct amba_id pl011_ids[] = {
>> >         {
>> >                 .id     = 0x00041011,
>> > @@ -2618,20 +2748,57 @@ static struct amba_driver pl011_driver = {
>> >         .probe          = pl011_probe,
>> >         .remove         = pl011_remove,
>> >  };
>> > +#endif
>> > +
>> > +#ifdef CONFIG_SOC_ZX296702
>> > +static const struct of_device_id zx_uart_dt_ids[] = {
>> > +       { .compatible = "zte,zx296702-uart", },
>> > +       { /* sentinel */ }
>> > +};
>> > +MODULE_DEVICE_TABLE(of, zx_uart_dt_ids);
>> > +
>> > +static struct platform_driver zx_uart_driver = {
>> > +       .driver = {
>> > +               .name   = "zx-uart",
>> > +               .owner  = THIS_MODULE,
>> > +               .pm     = &pl011_dev_pm_ops,
>> > +               .of_match_table = zx_uart_dt_ids,
>> > +       },
>> > +       .probe          = zx_uart_probe,
>> > +       .remove         = zx_uart_remove,
>> > +};
>> > +#endif
>> > +
>> >
>> >  static int __init pl011_init(void)
>> >  {
>> > +       int ret;
>> >         printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
>> >
>> >         if (platform_driver_register(&arm_sbsa_uart_platform_driver))
>> >                 pr_warn("could not register SBSA UART platform driver\n");
>> > -       return amba_driver_register(&pl011_driver);
>> > +
>> > +#ifdef CONFIG_SOC_ZX296702
>> > +       ret = platform_driver_register(&zx_uart_driver);
>> > +       if (ret)
>> > +               pr_warn("could not register ZX UART platform driver\n");
>> > +#endif
>> > +
>> > +#ifdef CONFIG_ARM_AMBA
>> > +       ret = amba_driver_register(&pl011_driver);
>> > +#endif
>> > +       return ret;
>> >  }
>> >
>> >  static void __exit pl011_exit(void)
>> >  {
>> >         platform_driver_unregister(&arm_sbsa_uart_platform_driver);
>> > +#ifdef CONFIG_SOC_ZX296702
>> > +       platform_driver_unregister(&zx_uart_driver);
>> > +#endif
>> > +#ifdef CONFIG_ARM_AMBA
>> >         amba_driver_unregister(&pl011_driver);
>> > +#endif
>> >  }
>> >
>> >  /*
>> > diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
>> > index 0ddb5c0..6a0a89e 100644
>> > --- a/include/linux/amba/serial.h
>> > +++ b/include/linux/amba/serial.h
>> > @@ -33,12 +33,14 @@
>> >  #define UART01x_DR             0x00    /* Data read or written from the interface. */
>> >  #define UART01x_RSR            0x04    /* Receive status register (Read). */
>> >  #define UART01x_ECR            0x04    /* Error clear register (Write). */
>> > +#define ZX_UART01x_DR          0x04    /* Data read or written from the interface. */
>> >  #define UART010_LCRH           0x08    /* Line control register, high byte. */
>> >  #define ST_UART011_DMAWM       0x08    /* DMA watermark configure register. */
>> >  #define UART010_LCRM           0x0C    /* Line control register, middle byte. */
>> >  #define ST_UART011_TIMEOUT     0x0C    /* Timeout period register. */
>> >  #define UART010_LCRL           0x10    /* Line control register, low byte. */
>> >  #define UART010_CR             0x14    /* Control register. */
>> > +#define ZX_UART01x_FR          0x14    /* Flag register (Read only). */
>> >  #define UART01x_FR             0x18    /* Flag register (Read only). */
>> >  #define UART010_IIR            0x1C    /* Interrupt identification register (Read). */
>> >  #define UART010_ICR            0x1C    /* Interrupt clear register (Write). */
>> > @@ -49,13 +51,21 @@
>> >  #define UART011_LCRH           0x2c    /* Line control register. */
>> >  #define ST_UART011_LCRH_TX     0x2c    /* Tx Line control register. */
>> >  #define UART011_CR             0x30    /* Control register. */
>> > +#define ZX_UART011_LCRH_TX     0x30    /* Tx Line control register. */
>> >  #define UART011_IFLS           0x34    /* Interrupt fifo level select. */
>> > +#define ZX_UART011_CR          0x34    /* Control register. */
>> > +#define ZX_UART011_IFLS                0x38    /* Interrupt fifo level select. */
>> >  #define UART011_IMSC           0x38    /* Interrupt mask. */
>> >  #define UART011_RIS            0x3c    /* Raw interrupt status. */
>> >  #define UART011_MIS            0x40    /* Masked interrupt status. */
>> > +#define ZX_UART011_IMSC                0x40    /* Interrupt mask. */
>> >  #define UART011_ICR            0x44    /* Interrupt clear register. */
>> > +#define ZX_UART011_RIS         0x44    /* Raw interrupt status. */
>> >  #define UART011_DMACR          0x48    /* DMA control register. */
>> > +#define ZX_UART011_MIS         0x48    /* Masked interrupt status. */
>> > +#define ZX_UART011_ICR         0x4c    /* Interrupt clear register. */
>> >  #define ST_UART011_XFCR                0x50    /* XON/XOFF control register. */
>> > +#define ZX_UART011_DMACR       0x50    /* DMA control register. */
>> >  #define ST_UART011_XON1                0x54    /* XON1 register. */
>> >  #define ST_UART011_XON2                0x58    /* XON2 register. */
>> >  #define ST_UART011_XOFF1       0x5C    /* XON1 register. */
>> > @@ -75,15 +85,19 @@
>> >  #define UART01x_RSR_PE                 0x02
>> >  #define UART01x_RSR_FE                 0x01
>> >
>> > +#define ZX_UART01x_FR_BUSY     0x300
>> >  #define UART011_FR_RI          0x100
>> >  #define UART011_FR_TXFE                0x080
>> >  #define UART011_FR_RXFF                0x040
>> >  #define UART01x_FR_TXFF                0x020
>> >  #define UART01x_FR_RXFE                0x010
>> >  #define UART01x_FR_BUSY                0x008
>> > +#define ZX_UART01x_FR_DSR       0x008
>> >  #define UART01x_FR_DCD                 0x004
>> >  #define UART01x_FR_DSR                 0x002
>> > +#define ZX_UART01x_FR_CTS      0x002
>> >  #define UART01x_FR_CTS                 0x001
>> > +#define ZX_UART011_FR_RI       0x001
>> >  #define UART01x_FR_TMSK                (UART01x_FR_TXFF + UART01x_FR_BUSY)
>> >
>> >  #define UART011_CR_CTSEN       0x8000  /* CTS hardware flow control */
>> > --
>> > 1.9.1
>> >
>
> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
