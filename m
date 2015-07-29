From: Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
Subject: Re: [PATCH v4 4/5] tty/serial: at91: add support to FIFOs
Date: Wed, 29 Jul 2015 17:34:21 +0200
Message-ID: <20150729153421.GA669@samfundet.no>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com>
 <4d8e90ad2cbb0d020dae4a4806ffc8864b5b22b6.1435842688.git.cyrille.pitchen@atmel.com>
 <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw@mail.gmail.com>
 <55B8ECC7.6010304@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B8ECC7.6010304-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ijc+devicetree <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Around Wed 29 Jul 2015 17:09:59 +0200 or thereabout, Nicolas Ferre wrot=
e:
> Le 29/07/2015 16:51, Andy Shevchenko a =E9crit :
>> On Thu, Jul 2, 2015 at 4:18 PM, Cyrille Pitchen
>> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>> Depending on the hardware, TX and RX FIFOs may be available. The RX
>>> FIFO can avoid receive overruns, especially when DMA transfers are
>>> not used to read data from the Receive Holding Register. For heavy
>>> system load, The CPU is likely not be able to fetch data fast enoug=
h
>>> from the RHR.
>>=20
>> This patch broke avr32 console (as seen in today's linux-next) on AT=
NGW100.
>> Reverting helps. I'm pretty sure the issue is in 8 bit vs. 32 bit I/=
O access.

Highly likely, you can not do I/O read/write in 8-bit operations on AVR=
32,
only 32-bit operations are supported. If you do 8-bit or 16-bit operati=
ons
you will read and write garbage data.

> I would like that we don't revert the patch.
> We'll try to blindly find the cause for this issue.
>=20
>> # uname -a
>> Linux buildroot 4.2.0-rc4-next-20150729+ #97 Wed Jul 29 17:50:11 EES=
T
>> 2015 avr32 GNU/Linux
>>=20
>> Do you, guys, have that board (NGW100) or it's officially unsupporte=
d?
>=20
> Sorry but we don't have AVR32-based board in our office. Hans-Christi=
an
> kindly helps us fixing the issues that we find and we tend to rely on
> the community for this architecture support...
>=20
>> If the latter is the case I would really appreciate if you remove th=
e
>> support from the kernel side.
>=20
> I won't decide for its removal. Only the maintainers with feedback fr=
om
> the user base can.

I still use my board every now and then, and there are that odd request=
 every
now and then.

>>> In addition, the RX FIFO can supersede the DMA/PDC to control the R=
TS
>>> line when the Hardware Handshaking mode is enabled. Two thresholds
>>> are to be set for that purpose:
>>> - When the number of data in the RX FIFO crosses and becomes lower
>>>   than or equal to the low threshold, the RTS line is set to low
>>>   level: the remote peer is requested to send data.
>>> - When the number of data in the RX FIFO crosses and becomes greate=
r
>>>   than or equal to the high threshold, the RTS line is set to high
>>>   level: the remote peer should stop sending new data.
>>> - low threshold <=3D high threshold
>>> Once these two thresholds are set properly, this new feature is
>>> enabled by setting the FIFO RTS Control bit of the FIFO Mode Regist=
er.
>>>
>>> FIFOs also introduce a new multiple data mode: the USART works eith=
er
>>> in multiple data mode or in single data (legacy) mode.
>>>
>>> If MODE9 bit is set into the Mode Register or if USMODE is set to
>>> either LIN_MASTER, LIN_SLAVE or LON_MODE, FIFOs operate in single
>>> data mode. Otherwise, they operate in multiple data mode.
>>>
>>> In this new multiple data mode, accesses to the Receive Holding
>>> Register or Transmit Holding Register slightly change.
>>>
>>> Since this driver implements neither the 9bit data feature (MODE9 b=
it
>>> set into the Mode Register) nor LIN modes, the USART works in
>>> multiple data mode whenever FIFOs are available and enabled. We als=
o
>>> assume that data are 8bit wide.
>>>
>>> In single data mode, 32bit access CAN be used to read a single data
>>> from RHR or write a single data into THR.
>>> However in multiple data mode, a 32bit access to RHR now allows us =
to
>>> read four consecutive data from RX FIFO. Also a 32bit access to THR
>>> now allows to write four consecutive data into TX FIFO. So we MUST
>>> use 8bit access whenever only one data have to be read/written at a
>>> time.

Hmm, does AVR32 even have this feature?

>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/tty/serial/atmel_serial.c | 100 ++++++++++++++++++++++++++=
+++++++++---
>>>  include/linux/atmel_serial.h      |  36 ++++++++++++++
>>>  2 files changed, 130 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial=
/atmel_serial.c
>>> index e7c337de31d1..87de21f0c7a3 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -56,6 +56,15 @@
>>>  /* Revisit: We should calculate this based on the actual port sett=
ings */
>>>  #define PDC_RX_TIMEOUT         (3 * 10)                /* 3 bytes =
*/
>>>
>>> +/* The minium number of data FIFOs should be able to contain */
>>> +#define ATMEL_MIN_FIFO_SIZE    8
>>> +/*
>>> + * These two offsets are substracted from the RX FIFO size to defi=
ne the RTS
>>> + * high and low thresholds
>>> + */
>>> +#define ATMEL_RTS_HIGH_OFFSET  16
>>> +#define ATMEL_RTS_LOW_OFFSET   20
>>> +
>>>  #if defined(CONFIG_SERIAL_ATMEL_CONSOLE) && defined(CONFIG_MAGIC_S=
YSRQ)
>>>  #define SUPPORT_SYSRQ
>>>  #endif
>>> @@ -141,6 +150,9 @@ struct atmel_uart_port {
>>>         struct mctrl_gpios      *gpios;
>>>         int                     gpio_irq[UART_GPIO_MAX];
>>>         unsigned int            tx_done_mask;
>>> +       u32                     fifo_size;
>>> +       u32                     rts_high;
>>> +       u32                     rts_low;
>>>         bool                    ms_irq_enabled;
>>>         bool                    is_usart;       /* usart or uart */
>>>         struct timer_list       uart_timer;     /* uart timer */
>>> @@ -191,6 +203,16 @@ static inline void atmel_uart_writel(struct ua=
rt_port *port, u32 reg, u32 value)
>>>         __raw_writel(value, port->membase + reg);
>>>  }
>>>
>>> +static inline u8 atmel_uart_readb(struct uart_port *port, u32 reg)
>>> +{
>>> +       return __raw_readb(port->membase + reg);
>>> +}
>>> +
>>> +static inline void atmel_uart_writeb(struct uart_port *port, u32 r=
eg, u8 value)
>>> +{
>>> +       __raw_writeb(value, port->membase + reg);
>>> +}
>>> +

These functions will not fly on AVR32. I would even assume some AT91 de=
vices
would struggle with this. IIRC the internal bus architecture is similar=
=2E

>>>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>>>  static bool atmel_use_pdc_rx(struct uart_port *port)
>>>  {
>>> @@ -635,7 +657,7 @@ static void atmel_rx_chars(struct uart_port *po=
rt)
>>>
>>>         status =3D atmel_uart_readl(port, ATMEL_US_CSR);
>>>         while (status & ATMEL_US_RXRDY) {
>>> -               ch =3D atmel_uart_readl(port, ATMEL_US_RHR);
>>> +               ch =3D atmel_uart_readb(port, ATMEL_US_RHR);
>>>
>>>                 /*
>>>                  * note that the error handling code is
>>> @@ -686,7 +708,7 @@ static void atmel_tx_chars(struct uart_port *po=
rt)
>>>
>>>         if (port->x_char &&
>>>             (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_=
done_mask)) {
>>> -               atmel_uart_writel(port, ATMEL_US_THR, port->x_char)=
;
>>> +               atmel_uart_writeb(port, ATMEL_US_THR, port->x_char)=
;
>>>                 port->icount.tx++;
>>>                 port->x_char =3D 0;
>>>         }
>>> @@ -695,7 +717,7 @@ static void atmel_tx_chars(struct uart_port *po=
rt)
>>>
>>>         while (atmel_uart_readl(port, ATMEL_US_CSR) &
>>>                atmel_port->tx_done_mask) {
>>> -               atmel_uart_writel(port, ATMEL_US_THR, xmit->buf[xmi=
t->tail]);
>>> +               atmel_uart_writeb(port, ATMEL_US_THR, xmit->buf[xmi=
t->tail]);
>>>                 xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE -=
 1);
>>>                 port->icount.tx++;
>>>                 if (uart_circ_empty(xmit))
>>> @@ -1796,6 +1818,29 @@ static int atmel_startup(struct uart_port *p=
ort)
>>>                         atmel_set_ops(port);
>>>         }
>>>
>>> +       /*
>>> +        * Enable FIFO when available
>>> +        */
>>> +       if (atmel_port->fifo_size) {
>>> +               unsigned int txrdym =3D ATMEL_US_ONE_DATA;
>>> +               unsigned int rxrdym =3D ATMEL_US_ONE_DATA;
>>> +               unsigned int fmr;
>>> +
>>> +               atmel_uart_writel(port, ATMEL_US_CR,
>>> +                                 ATMEL_US_FIFOEN |
>>> +                                 ATMEL_US_RXFCLR |
>>> +                                 ATMEL_US_TXFLCLR);
>>> +
>>> +               fmr =3D ATMEL_US_TXRDYM(txrdym) | ATMEL_US_RXRDYM(r=
xrdym);
>>> +               if (atmel_port->rts_high &&
>>> +                   atmel_port->rts_low)
>>> +                       fmr |=3D  ATMEL_US_FRTSC |
>>> +                               ATMEL_US_RXFTHRES(atmel_port->rts_h=
igh) |
>>> +                               ATMEL_US_RXFTHRES2(atmel_port->rts_=
low);
>>> +
>>> +               atmel_uart_writel(port, ATMEL_US_FMR, fmr);
>>> +       }
>>> +
>>>         /* Save current CSR for comparison in atmel_tasklet_func() =
*/
>>>         atmel_port->irq_status_prev =3D atmel_get_lines_status(port=
);
>>>         atmel_port->irq_status =3D atmel_port->irq_status_prev;
>>> @@ -2213,7 +2258,7 @@ static int atmel_poll_get_char(struct uart_po=
rt *port)
>>>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_RX=
RDY))
>>>                 cpu_relax();
>>>
>>> -       return atmel_uart_readl(port, ATMEL_US_RHR);
>>> +       return atmel_uart_readb(port, ATMEL_US_RHR);
>>>  }
>>>
>>>  static void atmel_poll_put_char(struct uart_port *port, unsigned c=
har ch)
>>> @@ -2221,7 +2266,7 @@ static void atmel_poll_put_char(struct uart_p=
ort *port, unsigned char ch)
>>>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TX=
RDY))
>>>                 cpu_relax();
>>>
>>> -       atmel_uart_writel(port, ATMEL_US_THR, ch);
>>> +       atmel_uart_writeb(port, ATMEL_US_THR, ch);
>>>  }
>>>  #endif
>>>
>>> @@ -2328,7 +2373,7 @@ static void atmel_console_putchar(struct uart=
_port *port, int ch)
>>>  {
>>>         while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TX=
RDY))
>>>                 cpu_relax();
>>> -       atmel_uart_writel(port, ATMEL_US_THR, ch);
>>> +       atmel_uart_writeb(port, ATMEL_US_THR, ch);
>>>  }
>>>
>>>  /*
>>> @@ -2603,6 +2648,48 @@ static int atmel_init_gpios(struct atmel_uar=
t_port *p, struct device *dev)
>>>         return 0;
>>>  }
>>>
>>> +static void atmel_serial_probe_fifos(struct atmel_uart_port *port,
>>> +                                    struct platform_device *pdev)
>>> +{
>>> +       port->fifo_size =3D 0;
>>> +       port->rts_low =3D 0;
>>> +       port->rts_high =3D 0;
>>> +
>>> +       if (of_property_read_u32(pdev->dev.of_node,
>>> +                                "atmel,fifo-size",
>>> +                                &port->fifo_size))
>>> +               return;
>>> +
>>> +       if (!port->fifo_size)
>>> +               return;
>>> +
>>> +       if (port->fifo_size < ATMEL_MIN_FIFO_SIZE) {
>>> +               port->fifo_size =3D 0;
>>> +               dev_err(&pdev->dev, "Invalid FIFO size\n");
>>> +               return;
>>> +       }
>>> +
>>> +       /*
>>> +        * 0 <=3D rts_low <=3D rts_high <=3D fifo_size
>>> +        * Once their CTS line asserted by the remote peer, some x8=
6 UARTs tend
>>> +        * to flush their internal TX FIFO, commonly up to 16 data,=
 before
>>> +        * actually stopping to send new data. So we try to set the=
 RTS High
>>> +        * Threshold to a reasonably high value respecting this 16 =
data
>>> +        * empirical rule when possible.
>>> +        */
>>> +       port->rts_high =3D max_t(int, port->fifo_size >> 1,
>>> +                              port->fifo_size - ATMEL_RTS_HIGH_OFF=
SET);
>>> +       port->rts_low  =3D max_t(int, port->fifo_size >> 2,
>>> +                              port->fifo_size - ATMEL_RTS_LOW_OFFS=
ET);
>>> +
>>> +       dev_info(&pdev->dev, "Using FIFO (%u data)\n",
>>> +                port->fifo_size);
>>> +       dev_dbg(&pdev->dev, "RTS High Threshold : %2u data\n",
>>> +               port->rts_high);
>>> +       dev_dbg(&pdev->dev, "RTS Low Threshold  : %2u data\n",
>>> +               port->rts_low);
>>> +}
>>> +
>>>  static int atmel_serial_probe(struct platform_device *pdev)
>>>  {
>>>         struct atmel_uart_port *port;
>>> @@ -2639,6 +2726,7 @@ static int atmel_serial_probe(struct platform=
_device *pdev)
>>>         port =3D &atmel_ports[ret];
>>>         port->backup_imr =3D 0;
>>>         port->uart.line =3D ret;
>>> +       atmel_serial_probe_fifos(port, pdev);
>>>
>>>         spin_lock_init(&port->lock_suspended);
>>>
>>> diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_ser=
ial.h
>>> index c384c21d65f0..ee696d7e8a43 100644
>>> --- a/include/linux/atmel_serial.h
>>> +++ b/include/linux/atmel_serial.h
>>> @@ -35,6 +35,11 @@
>>>  #define        ATMEL_US_DTRDIS         BIT(17) /* Data Terminal Re=
ady Disable */
>>>  #define        ATMEL_US_RTSEN          BIT(18) /* Request To Send =
Enable */
>>>  #define        ATMEL_US_RTSDIS         BIT(19) /* Request To Send =
Disable */
>>> +#define        ATMEL_US_TXFCLR         BIT(24) /* Transmit FIFO Cl=
ear */
>>> +#define        ATMEL_US_RXFCLR         BIT(25) /* Receive FIFO Cle=
ar */
>>> +#define        ATMEL_US_TXFLCLR        BIT(26) /* Transmit FIFO Lo=
ck Clear */
>>> +#define        ATMEL_US_FIFOEN         BIT(30) /* FIFO enable */
>>> +#define        ATMEL_US_FIFODIS        BIT(31) /* FIFO disable */
>>>
>>>  #define ATMEL_US_MR            0x04    /* Mode Register */
>>>  #define        ATMEL_US_USMODE         GENMASK(3, 0)   /* Mode of =
the USART */
>>> @@ -124,6 +129,37 @@
>>>  #define ATMEL_US_NER           0x44    /* Number of Errors Registe=
r */
>>>  #define ATMEL_US_IF            0x4c    /* IrDA Filter Register */
>>>
>>> +#define ATMEL_US_CMPR          0x90    /* Comparaison Register */
>>> +#define ATMEL_US_FMR           0xa0    /* FIFO Mode Register */
>>> +#define        ATMEL_US_TXRDYM(data)   (((data) & 0x3) << 0)   /* =
TX Ready Mode */
>>> +#define        ATMEL_US_RXRDYM(data)   (((data) & 0x3) << 4)   /* =
RX Ready Mode */
>>> +#define                ATMEL_US_ONE_DATA       0x0
>>> +#define                ATMEL_US_TWO_DATA       0x1
>>> +#define                ATMEL_US_FOUR_DATA      0x2
>>> +#define        ATMEL_US_FRTSC          BIT(7)  /* FIFO RTS pin Con=
trol */
>>> +#define        ATMEL_US_TXFTHRES(thr)  (((thr) & 0x3f) << 8)   /* =
TX FIFO Threshold */
>>> +#define        ATMEL_US_RXFTHRES(thr)  (((thr) & 0x3f) << 16)  /* =
RX FIFO Threshold */
>>> +#define        ATMEL_US_RXFTHRES2(thr) (((thr) & 0x3f) << 24)  /* =
RX FIFO Threshold2 */
>>> +
>>> +#define ATMEL_US_FLR           0xa4    /* FIFO Level Register */
>>> +#define        ATMEL_US_TXFL(reg)      (((reg) >> 0) & 0x3f)   /* =
TX FIFO Level */
>>> +#define        ATMEL_US_RXFL(reg)      (((reg) >> 16) & 0x3f)  /* =
RX FIFO Level */
>>> +
>>> +#define ATMEL_US_FIER          0xa8    /* FIFO Interrupt Enable Re=
gister */
>>> +#define ATMEL_US_FIDR          0xac    /* FIFO Interrupt Disable R=
egister */
>>> +#define ATMEL_US_FIMR          0xb0    /* FIFO Interrupt Mask Regi=
ster */
>>> +#define ATMEL_US_FESR          0xb4    /* FIFO Event Status Regist=
er */
>>> +#define        ATMEL_US_TXFEF          BIT(0)  /* Transmit FIFO Em=
pty Flag */
>>> +#define        ATMEL_US_TXFFF          BIT(1)  /* Transmit FIFO Fu=
ll Flag */
>>> +#define        ATMEL_US_TXFTHF         BIT(2)  /* Transmit FIFO Th=
reshold Flag */
>>> +#define        ATMEL_US_RXFEF          BIT(3)  /* Receive FIFO Emp=
ty Flag */
>>> +#define        ATMEL_US_RXFFF          BIT(4)  /* Receive FIFO Ful=
l Flag */
>>> +#define        ATMEL_US_RXFTHF         BIT(5)  /* Receive FIFO Thr=
eshold Flag */
>>> +#define        ATMEL_US_TXFPTEF        BIT(6)  /* Transmit FIFO Po=
inter Error Flag */
>>> +#define        ATMEL_US_RXFPTEF        BIT(7)  /* Receive FIFO Poi=
nter Error Flag */
>>> +#define        ATMEL_US_TXFLOCK        BIT(8)  /* Transmit FIFO Lo=
ck (FESR only) */
>>> +#define        ATMEL_US_RXFTHF2        BIT(9)  /* Receive FIFO Thr=
eshold Flag 2 */
>>> +
>>>  #define ATMEL_US_NAME          0xf0    /* Ip Name */
>>>  #define ATMEL_US_VERSION       0xfc    /* Ip Version */
>>>
>>> --
>>> 1.8.2.2
>>>
--=20
mvh
Hans-Christian Egtvedt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
