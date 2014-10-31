From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
Date: Fri, 31 Oct 2014 09:48:47 +0100
Message-ID: <CACQ1gAhyx0z0vY9YhWP7yk6w864hdaznRmKJuws4FYRtxjAKiA@mail.gmail.com>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
 <1412960007-28159-3-git-send-email-j.uzycki@elproma.com.pl>
 <544A70F6.6080800@gmail.com> <544A756C.7000601@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:62017 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbaJaItK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Oct 2014 04:49:10 -0400
In-Reply-To: <544A756C.7000601@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Huang Shijie <shijie8@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-10-24 17:51 GMT+02:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.pl>=
:
>
> W dniu 2014-10-24 o 17:32, Richard Genoud pisze:
>
>> On 10/10/2014 18:53, Janusz Uzycki wrote:
>>>
>>> Dedicated CTS and RTS pins are unusable together with a lot of othe=
r
>>> peripherals because they share the same line. Pinctrl is limited.
>>>
>>> Moreover, the AUART controller doesn't handle DTR/DSR/DCD/RI signal=
s,
>>> so we have to control them via GPIO.
>>>
>>> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/=
RI
>>> signals.
>>>
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> ---
>>> v3 -> v4 changelog:
>>> * RTS_AT_AUART() and CTS_AT_AUART() macro defined
>>> * DMA engine disabled if RTS or CTS is GPIO line
>>> * warn if fsl,uart-has-rtscts and RTS/CTS via GPIO are mixed
>>> * CTSEN can't be enabled for hardware flow control block
>>>    if CTS is defined as GPIO line
>>> * RTSEN can be enabled for hardware flow control block
>>>    even if RTS is defined as GPIO line.
>>>    RTS pin depends on pinctrl configuration which
>>>    selects RTS output from hardware flow control block or GPIO line=
=2E
>>> * mxs_auart_settermios(): RTS_AT_AUART() and CTS_AT_AUART() used
>>> * mxs_auart_irq_handle(): CTS_AT_AUART() used
>>> * mxs_auart_init_gpios() returns true(success)/false(failure)
>>> * dev_err() message fixed in mxs_auart_probe()
>>>
>>> v2 -> v3 changelog:
>>> * mctrl_gpio_free() removed to simplify:
>>>    mctrl_gpio_free() is not necessary in mxs_auart_probe() and
>>>    mxs_auart_remove() because mctrl_gpio_init() does all
>>>    allocations with devm_* functions.
>>>    (see Documentation/serial/driver since kernel 3.16)
>>> * DMA on HW flow control comment updated, still not sure about the
>>> comment
>>> * mxs_auart_modem_status() removed from mxs_auart_get_mctrl():
>>>    mctrl_gpio_get() does not clear gpio interrupt pendings like
>>>    8250_core.c does with MSR.
>>> * mxs_auart_modem_status() moved to [3/4]
>>>    If enable_ms() is not called, uart_handle_cts_change()
>>>    shouldn't be called.
>>>
>>> ---
>>>   .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 10 ++++-
>>>   drivers/tty/serial/Kconfig           |  1 +
>>>   drivers/tty/serial/mxs-auart.c       | 50 +++++++++++++++++++---
>>>   3 files changed, 55 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart=
=2Etxt
>>> b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>>> index 59a40f1..7c408c8 100644
>>> --- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>>> +++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>>> @@ -11,8 +11,13 @@ Required properties:
>>>   - dma-names: "rx" for RX channel, "tx" for TX channel.
>>>     Optional properties:
>>> -- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
>>> +- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines
>>> +  for hardware flow control,
>>>         it also means you enable the DMA support for this UART.
>>> +- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for
>>> RTS/CTS/DTR/DSR/RI/DCD
>>> +  line respectively. It will use specified PIO instead of the peri=
pheral
>>> +  function pin for the USART feature.
>>> +  If unsure, don't specify this property.
>>>     Example:
>>>   auart0: serial@8006a000 {
>>> @@ -21,6 +26,9 @@ auart0: serial@8006a000 {
>>>         interrupts =3D <112>;
>>>         dmas =3D <&dma_apbx 8>, <&dma_apbx 9>;
>>>         dma-names =3D "rx", "tx";
>>> +       cts-gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
>>> +       dsr-gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
>>> +       dcd-gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
>>>   };
>>>     Note: Each auart port should have an alias correctly numbered i=
n
>>> "aliases"
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfi=
g
>>> index 4fe8ca1..90e8516 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1357,6 +1357,7 @@ config SERIAL_MXS_AUART
>>>         depends on ARCH_MXS
>>>         tristate "MXS AUART support"
>>>         select SERIAL_CORE
>>> +       select SERIAL_MCTRL_GPIO if GPIOLIB
>>>         help
>>>           This driver supports the MXS Application UART (AUART) por=
t.
>>>   diff --git a/drivers/tty/serial/mxs-auart.c
>>> b/drivers/tty/serial/mxs-auart.c
>>> index 2d49901..8bbcfd1 100644
>>> --- a/drivers/tty/serial/mxs-auart.c
>>> +++ b/drivers/tty/serial/mxs-auart.c
>>> @@ -42,6 +42,9 @@
>>>     #include <asm/cacheflush.h>
>>>   +#include <linux/err.h>
>>> +#include "serial_mctrl_gpio.h"
>>> +
>>>   #define MXS_AUART_PORTS 5
>>>   #define MXS_AUART_FIFO_SIZE           16
>>>   @@ -158,6 +161,8 @@ struct mxs_auart_port {
>>>         struct scatterlist rx_sgl;
>>>         struct dma_chan *rx_dma_chan;
>>>         void *rx_dma_buf;
>>> +
>>> +       struct mctrl_gpios      *gpios;
>>>   };
>>>     static struct platform_device_id mxs_auart_devtype[] =3D {
>>> @@ -405,6 +410,8 @@ static void mxs_auart_release_port(struct uart_=
port
>>> *u)
>>>     static void mxs_auart_set_mctrl(struct uart_port *u, unsigned m=
ctrl)
>>>   {
>>> +       struct mxs_auart_port *s =3D to_auart_port(u);
>>> +
>>>         u32 ctrl =3D readl(u->membase + AUART_CTRL2);
>>>         ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
>>> @@ -416,17 +423,20 @@ static void mxs_auart_set_mctrl(struct uart_p=
ort
>>> *u, unsigned mctrl)
>>>         }
>>>         writel(ctrl, u->membase + AUART_CTRL2);
>>> +
>>> +       mctrl_gpio_set(s->gpios, mctrl);
>>>   }
>>>     static u32 mxs_auart_get_mctrl(struct uart_port *u)
>>>   {
>>> +       struct mxs_auart_port *s =3D to_auart_port(u);
>>>         u32 stat =3D readl(u->membase + AUART_STAT);
>>>         u32 mctrl =3D 0;
>>>         if (stat & AUART_STAT_CTS)
>>>                 mctrl |=3D TIOCM_CTS;
>>>   -     return mctrl;
>>> +       return mctrl_gpio_get(s->gpios, &mctrl);
>>>   }
>>>     static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s);
>>> @@ -554,6 +564,10 @@ err_out:
>>>     }
>>>   +#define RTS_AT_AUART()
>>> IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,    \
>>> +                                                       UART_GPIO_R=
TS))
>>> +#define CTS_AT_AUART() IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios=
,    \
>>> +                                                       UART_GPIO_C=
TS))
>>>   static void mxs_auart_settermios(struct uart_port *u,
>>>                                  struct ktermios *termios,
>>>                                  struct ktermios *old)
>>> @@ -630,6 +644,7 @@ static void mxs_auart_settermios(struct uart_po=
rt *u,
>>>                 ctrl |=3D AUART_LINECTRL_STP2;
>>>         /* figure out the hardware flow control settings */
>>> +       ctrl2 &=3D ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
>>>         if (cflag & CRTSCTS) {
>>>                 /*
>>>                  * The DMA has a bug(see errata:2836) in mx23.
>>> @@ -644,9 +659,11 @@ static void mxs_auart_settermios(struct uart_p=
ort
>>> *u,
>>>                                 ctrl2 |=3D AUART_CTRL2_TXDMAE |
>>> AUART_CTRL2_RXDMAE
>>>                                        | AUART_CTRL2_DMAONERR;
>>>                 }
>>> -               ctrl2 |=3D AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
>>> -       } else {
>>> -               ctrl2 &=3D ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN)=
;
>>> +               /* Even if RTS is GPIO line RTSEN can be enabled be=
cause
>>> +                * the pinctrl configuration decides about RTS pin
>>> function */
>>> +               ctrl2 |=3D AUART_CTRL2_RTSEN;
>>> +               if (CTS_AT_AUART())
>>> +                       ctrl2 |=3D AUART_CTRL2_CTSEN;
>>>         }
>>>         /* set baud rate */
>>> @@ -690,7 +707,9 @@ static irqreturn_t mxs_auart_irq_handle(int irq=
, void
>>> *context)
>>>                         s->port.membase + AUART_INTR_CLR);
>>>         if (istat & AUART_INTR_CTSMIS) {
>>> -               uart_handle_cts_change(&s->port, stat & AUART_STAT_=
CTS);
>>> +               if (CTS_AT_AUART())
>>> +                       uart_handle_cts_change(&s->port,
>>> +                                       stat & AUART_STAT_CTS);
>>>                 writel(AUART_INTR_CTSMIS,
>>>                                 s->port.membase + AUART_INTR_CLR);
>>>                 istat &=3D ~AUART_INTR_CTSMIS;
>>> @@ -1014,6 +1033,23 @@ static int serial_mxs_probe_dt(struct
>>> mxs_auart_port *s,
>>>         return 0;
>>>   }
>>>   +static bool mxs_auart_init_gpios(struct mxs_auart_port *s, struc=
t
>>> device *dev)
>>> +{
>>> +       s->gpios =3D mctrl_gpio_init(dev, 0);
>>> +       if (IS_ERR_OR_NULL(s->gpios))
>>> +               return false;
>>> +
>>> +       /* Block (enabled before) DMA option if RTS or CTS is GPIO =
line
>>> */
>>
>> This is confusing, so I think some more comments won't be too much.
>> Something like:
>> /*
>>   * The DMA only work if the lines CTS/RTS are handled by the contro=
ller
>>   * cf. 8418e67d9523 serial: mxs: enable the DMA only when the RTS/C=
TS is
>> valid
>>   * So, If the CTS/RTS lines are controlled via GPIO the MXS_AUART_R=
TSCTS
>> bit should be
>>   * cleaned to indicate that the RTS/CTS lines are not handled by th=
e
>> controller.
>>   */
>> (If I understood correctly what is done here.)
>
>
> This is not clear in the driver. If hardware RTS/CTS (non-gpio) is no=
t
> defined in DT
> only DMA is not used. It is still possible to use hardware RTS/CTS li=
nes
> if you set hw-flowcontrol in termios. So it is also possible to mix h=
ardware
> RTS/CTS
> and gpio RTS/CTS. In mixed or gpio case the code blocks/disables DMA.
> I know my comment is not clear but the reason is in the earlier code.
> Can you propose better solution?
Maybe Huang Shijie knows more on this DMA vs RTS/CTS incompatibility.
[added Huang Shijie in Cc ]

> After review and small fixes requested new version is required for a
> patchset
> or rather patch resend?
It's better to resend the whole patchset (after giving some time for
Huang Shijie to give its thoughts )

>
> kind regards
> Janusz
>
>
>>> +       if (!RTS_AT_AUART() || !CTS_AT_AUART()) {
>>> +               if (test_bit(MXS_AUART_RTSCTS, &s->flags))
>>> +                       dev_warn(dev,
>>> +                                "DMA and flow control via gpio may=
 cause
>>> some problems. DMA disabled!\n");
>>> +               clear_bit(MXS_AUART_RTSCTS, &s->flags);
>>> +       }
>>> +
>>> +       return true;
>>> +}
>>> +
>>>   static int mxs_auart_probe(struct platform_device *pdev)
>>>   {
>>>         const struct of_device_id *of_id =3D
>>> @@ -1069,6 +1105,10 @@ static int mxs_auart_probe(struct platform_d=
evice
>>> *pdev)
>>>         platform_set_drvdata(pdev, s);
>>>   +     if (!mxs_auart_init_gpios(s, &pdev->dev))
>>> +               dev_err(&pdev->dev,
>>> +                       "Failed to initialize GPIOs. The serial por=
t may
>>> not work as expected\n");
>>> +
>>>         auart_port[s->port.line] =3D s;
>>>         mxs_auart_reset(&s->port);
>>>
>> Reviewed-by: Richard Genoud <richard.genoud@gmail.com>
>
>



--=20
for me, ck means con kolivas and not calvin klein... does it mean I'm a=
 geek ?
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
