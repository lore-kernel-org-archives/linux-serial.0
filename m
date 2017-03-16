From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Date: Thu, 16 Mar 2017 16:18:52 +0100
Message-ID: <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
References: <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de> <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de> <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
 <20170306085842.yijkfpqi3adcedmm@pengutronix.de> <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de> <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 6, 2017 at 11:02 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 06, 2017 at 10:53:27AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 6, 2017 at 10:30 AM, Uwe Kleine-K=C3=B6nig

>> > I wouldn't want to code this in each driver (something like:
>> >
>> >         if (IS_ENABLED(GPIOLIB) || device_is_instantiated_by_dt(dev) |=
| device_is_instantiated_by_acpi(dev))
>> >                 gpios =3D mctrl_gpio_init(...);
>> >         else
>> >                 gpios =3D NULL;
>> >
>> > ). Putting this into GPIOLIB is the right approach, and so this is
>> > another argument for HALFGPIOLIB. This would fix mctrl_gpio_init en
>> > passant.
>>
>> Do we have platforms where DT=3Dy || ACPI=3Dy, but GPIOLIB=3Dn?
>> Ah, x86 ;-)
>
> Yeah, and I think rm -r arch/x86 won't be acceptable :-) I assume you
> can also configure some arm or powerpc systems without GPIOLIB.
>
>> Anyway, for sh-sci.c, platforms either have DT and GPIOLIB, or they do n=
ot
>> need mctrl-gpio.
>
> So we're in agreement now that HALFGPIOLIB is the way to go?
> Linus, what do you think?

OK modem lines over GPIO.

So the problem is that GPIOLIB is needed (obviously) for mctrl_gpio_init() =
to
work properly, and then there are some stubs in
drivers/tty/serial/serial_mctrl_gpio.h
for !GPIOLIB.

And this whole discussion is all about that !GPIOLIB case really,
whether DT, ACPI, SFI or board files machine data is used doesn't
really matter.

We're talking about:

> git grep mctrl_gpio_init
drivers/tty/serial/atmel_serial.c:      atmel_port->gpios =3D
mctrl_gpio_init(&atmel_port->uart, 0);
drivers/tty/serial/clps711x.c:  s->gpios =3D
mctrl_gpio_init_noauto(&pdev->dev, 0);
drivers/tty/serial/etraxfs-uart.c:      up->gpios =3D
mctrl_gpio_init_noauto(&pdev->dev, 0);
drivers/tty/serial/imx.c:       sport->gpios =3D mctrl_gpio_init(&sport->po=
rt, 0);
drivers/tty/serial/mxs-auart.c: s->gpios =3D mctrl_gpio_init_noauto(dev, 0)=
;
drivers/tty/serial/sh-sci.c:    sciport->gpios =3D
mctrl_gpio_init(&sciport->port, 0);

Atmel, ARM, ETRAX, ARM, ARM, Super-H, all have GPIOLIB.
Right now no x86, correct?

They actually all even do things like this in Kconfig:

config SERIAL_ATMEL
(...)
        select SERIAL_MCTRL_GPIO if GPIOLIB

What stops us from removing all the stubs in
drivers/tty/serial/serial_mctrl_gpio.h
and just make SERIAL_MCTRL_GPIO depends on GPIOLIB?

>From 2ecc70acc510784d953add707f2a5acfebe484c2 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Mar 2017 16:18:21 +0100
Subject: [PATCH] stab at mctrl

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/Kconfig             |  1 +
 drivers/tty/serial/serial_mctrl_gpio.h | 55 ------------------------------=
----
 2 files changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6117ac8da48f..39833d009c18 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1681,5 +1681,6 @@ endmenu

 config SERIAL_MCTRL_GPIO
     tristate
+    depends on GPIOLIB

 endif # TTY
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
b/drivers/tty/serial/serial_mctrl_gpio.h
index fa000bcff217..ba8f8e531d56 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -40,8 +40,6 @@ enum mctrl_gpio_idx {
  */
 struct mctrl_gpios;

-#ifdef CONFIG_GPIOLIB
-
 /*
  * Set state of the modem control output lines via GPIOs.
  */
@@ -101,57 +99,4 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
  */
 void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);

-#else /* GPIOLIB */
-
-static inline
-void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
-{
-}
-
-static inline
-unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl=
)
-{
-    return *mctrl;
-}
-
-static inline unsigned int
-mctrl_gpio_get_outputs(struct mctrl_gpios *gpios, unsigned int *mctrl)
-{
-    return *mctrl;
-}
-
-static inline
-struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
-                      enum mctrl_gpio_idx gidx)
-{
-    return ERR_PTR(-ENOSYS);
-}
-
-static inline
-struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int i=
dx)
-{
-    return ERR_PTR(-ENOSYS);
-}
-
-static inline
-struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev,
unsigned int idx)
-{
-    return ERR_PTR(-ENOSYS);
-}
-
-static inline
-void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
-{
-}
-
-static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
-{
-}
-
-static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
-{
-}
-
-#endif /* GPIOLIB */
-
 #endif
--=20
2.9.3


Yours,
Linus Walleij
