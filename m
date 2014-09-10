From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: randconfig build error with next-20140909, in
 drivers/tty/serial/serial_mctrl_gpio.c
Date: Wed, 10 Sep 2014 10:05:58 +0200
Message-ID: <20140910080558.GB14260@distanz.ch>
References: <CA+r1ZhjCZBWjkxjoJz=PO-YZg6LbghQV75tGnpiSOrHM9CaygA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+r1ZhjCZBWjkxjoJz=PO-YZg6LbghQV75tGnpiSOrHM9CaygA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2014-09-10 at 00:32:25 +0200, Jim Davis <jim.epost@gmail.com> wrote:
> Building with the attached random configuration file,
>=20
> drivers/tty/serial/serial_mctrl_gpio.c:44:6: error: redefinition of
> =E2=80=98mctrl_gpio_set=E2=80=99
>  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>       ^
> In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
> drivers/tty/serial/serial_mctrl_gpio.h:80:6: note: previous definitio=
n
> of =E2=80=98mctrl_gpio_set=E2=80=99 was here
>  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
>       ^
> drivers/tty/serial/serial_mctrl_gpio.c:59:19: error: redefinition of
> =E2=80=98mctrl_gpio_to_gpiod=E2=80=99
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                    ^
> In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
> drivers/tty/serial/serial_mctrl_gpio.h:91:19: note: previous
> definition of =E2=80=98mctrl_gpio_to_gpiod=E2=80=99 was here
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                    ^
> drivers/tty/serial/serial_mctrl_gpio.c:69:14: error: redefinition of
> =E2=80=98mctrl_gpio_get=E2=80=99
>  unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int =
*mctrl)
>               ^
> In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
> drivers/tty/serial/serial_mctrl_gpio.h:85:14: note: previous
> definition of =E2=80=98mctrl_gpio_get=E2=80=99 was here
>  unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int =
*mctrl)
>               ^
> drivers/tty/serial/serial_mctrl_gpio.c:93:21: error: redefinition of
> =E2=80=98mctrl_gpio_init=E2=80=99
>  struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int=
 idx)
>                      ^
> In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
> drivers/tty/serial/serial_mctrl_gpio.h:98:21: note: previous
> definition of =E2=80=98mctrl_gpio_init=E2=80=99 was here
>  struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int=
 idx)
>                      ^
> drivers/tty/serial/serial_mctrl_gpio.c:131:6: error: redefinition of
> =E2=80=98mctrl_gpio_free=E2=80=99
>  void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>       ^
> In file included from drivers/tty/serial/serial_mctrl_gpio.c:23:0:
> drivers/tty/serial/serial_mctrl_gpio.h:104:6: note: previous
> definition of =E2=80=98mctrl_gpio_free=E2=80=99 was here
>  void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>       ^
>   CC [M]  drivers/net/wireless/ti/wl1251/io.o
> make[3]: *** [drivers/tty/serial/serial_mctrl_gpio.o] Error 1

The problem seems to be that if GPIOLIB is not selected, the noop
functions from serial_mctrl_gpio.h are pulled in, but
serial_mctrl_gpio.c is still compiled. Since all drivers that include
serial_mctrl_gpio.h also depend on SERIAL_MCTRL_GPIO I'd suggest adding
a "select GPIOLIB" to config SERIAL_MCTRL_GPIO and removing the
noop functions alltogether, see patch below:

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8079f52..5f1ea62 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1575,5 +1575,6 @@ endmenu
=20
 config SERIAL_MCTRL_GPIO
 	tristate
+	select GPIOLIB
=20
 endif # TTY
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/seria=
l/serial_mctrl_gpio.h
index 400ba04..5e4c96a 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -40,8 +40,6 @@ enum mctrl_gpio_idx {
  */
 struct mctrl_gpios;
=20
-#ifdef CONFIG_GPIOLIB
-
 /*
  * Set state of the modem control output lines via GPIOs.
  */
@@ -74,37 +72,4 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *d=
ev, unsigned int idx);
  */
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
=20
-#else /* GPIOLIB */
-
-static inline
-void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
-{
-}
-
-static inline
-unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *m=
ctrl)
-{
-	return *mctrl;
-}
-
-static inline
-struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
-				      enum mctrl_gpio_idx gidx)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline
-struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int i=
dx)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline
-void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
-{
-}
-
-#endif /* GPIOLIB */
-
 #endif
