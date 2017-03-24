From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Fri, 24 Mar 2017 09:00:06 +0100
Message-ID: <20170324080006.tbhyqlgk35xybsna@pengutronix.de>
References: <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
 <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws> <20170323154441.GA9460@dtor-ws>
 <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
 <20170323195804.GA2502@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170323195804.GA2502@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Dmitry,

On Thu, Mar 23, 2017 at 12:58:04PM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 23, 2017 at 08:10:20PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Mar 23, 2017 at 08:44:41AM -0700, Dmitry Torokhov wrote:
> > > On Thu, Mar 23, 2017 at 07:43:25AM -0700, Dmitry Torokhov wrote:
> > > > On Thu, Mar 23, 2017 at 02:41:53PM +0100, Linus Walleij wrote:
> > > > > On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K=F6nig
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > =

> > > > > > Maybe we can make gpiod_get_optional look like this:
> > > > > >
> > > > > >         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENA=
BLED(GPIOLIB))
> > > > > >                 return NULL;
> > > > > >         else
> > > > > >                 return -ENOSYS;
> > > > > >
> > > > > > I don't know how isnt_a_acpi_device looks like, probably it inv=
olves
> > > > > > CONFIG_ACPI and/or dev->acpi_node.
> > > > > >
> > > > > > This should be safe and still comfortable for legacy platforms,=
 isn't it?
> > > > > =

> > > > > I like the looks of this.
> > > > > =

> > > > > Can we revert Dmitry's patch and apply something like this instea=
d?
> > > > > =

> > > > > Dmitry, how do you feel about this?
> > > > =

> > > > I frankly do not see the point. It still makes driver code more com=
plex
> > =

> > Note that this code is in the gpio header, and not in driver code. So
> > the driver just does
> > =

> > 	gpiod =3D gpiod_get_optional(...)
> > 	if (IS_ERR(gpiod))
> > 		return PTR_ERR(gpiod);
> > =

> > (as it is supposed to do now). I think that's nice.
> =

> Except that it breaks if !CONFIG_GPIOLIB which is legitimate config in
> many cases. Can I have a DT platform or ACPI platform that does not
> expose any GPIOs for kernel to control and thus want to disable GPIOLIB?
> I can't see why not.
> =

> > =

> > > > for no good reason. I also think that not having optional GPIO is n=
ot an
> > > > error, so returning value from error space is not correct. NULL is =
value
> > > > from another space altogether.
> > =

> > It seems you didn't understand my concern.
> =

> Likewise.

OK, lets agree that we don't agree then. You think that if someone
disabled GPIOLIB it should be safe to assume that there is no GPIO, I
think that's wrong.

Still I think it should be possible that we agree on my suggestion to
return NULL in some cases only. Here is a prototype (not even compile
tested without GPIOLIB):


------->8--------
From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] gpiod: let get_optional return NULL in some cases with GPI=
OLIB disabled

People disagree if gpiod_get_optional should return NULL or
ERR_PTR(-ENOSYS) if GPIOLIB is disabled. The argument for NULL is that
the person who decided to disable GPIOLIB is assumed to know that there
is no GPIO. The reason to stick to ERR_PTR(-ENOSYS) is that it might
introduce hard to debug problems if that decision is wrong.

So this patch introduces a compromise and let gpiod_get_optional (and
its variants) return NULL if the device in question cannot have an
associated GPIO because it is neither instantiated by a device tree nor
by ACPI.

This should handle most cases that are argued about.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/gpio/consumer.h | 55 ++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fb0fde686cb1..0ca29889290d 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -161,20 +161,48 @@ gpiod_get_index(struct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
 =

-static inline struct gpio_desc *__must_check
-gpiod_get_optional(struct device *dev, const char *con_id,
-		   enum gpiod_flags flags)
+static inline bool __gpiod_no_optional_possible(struct device *dev)
 {
-	return ERR_PTR(-ENOSYS);
+	/*
+	 * gpiod_get_optional et al can only provide a GPIO if at least one of
+	 * the backends for specifing a GPIO is available. These are device
+	 * tree, ACPI and gpiolib's lookup tables. The latter isn't available if
+	 * GPIOLIB is disabled (which is the case here).
+	 * So if the provided device is unrelated to device tree and ACPI, we
+	 * can be sure that there is no optional GPIO and let gpiod_get_optional
+	 * safely return NULL.
+	 * Otherwise there is still a chance that there is no GPIO but we cannot
+	 * be sure without having to enable a part of GPIOLIB (i.e. the lookup
+	 * part). So lets play safe and return an error. (Though there are also
+	 * arguments that returning NULL then would be beneficial.)
+	 */
+
+	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
+		return false;
+
+	if (IS_ENABLED(CONFIG_ACPI) && dev && ACPI_COMPANION(dev))
+		return false;
+
+	return true;
 }
 =

 static inline struct gpio_desc *__must_check
 gpiod_get_index_optional(struct device *dev, const char *con_id,
 			 unsigned int index, enum gpiod_flags flags)
 {
+	if (__gpiod_no_optional_possible(dev))
+		return NULL;
+
 	return ERR_PTR(-ENOSYS);
 }
 =

+static inline struct gpio_desc *__must_check
+gpiod_get_optional(struct device *dev, const char *con_id,
+		   enum gpiod_flags flags)
+{
+	return gpiod_get_index_optional(dev, con_id, 0, flags);
+}
+
 static inline struct gpio_descs *__must_check
 gpiod_get_array(struct device *dev, const char *con_id,
 		enum gpiod_flags flags)
@@ -186,6 +214,9 @@ static inline struct gpio_descs *__must_check
 gpiod_get_array_optional(struct device *dev, const char *con_id,
 			 enum gpiod_flags flags)
 {
+	if (__gpiod_no_optional_possible(dev))
+		return NULL;
+
 	return ERR_PTR(-ENOSYS);
 }
 =

@@ -223,17 +254,20 @@ devm_gpiod_get_index(struct device *dev,
 }
 =

 static inline struct gpio_desc *__must_check
-devm_gpiod_get_optional(struct device *dev, const char *con_id,
-			  enum gpiod_flags flags)
+devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
+			      unsigned int index, enum gpiod_flags flags)
 {
+	if (__gpiod_no_optional_possible(dev))
+		return NULL;
+
 	return ERR_PTR(-ENOSYS);
 }
 =

 static inline struct gpio_desc *__must_check
-devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
-				unsigned int index, enum gpiod_flags flags)
+devm_gpiod_get_optional(struct device *dev, const char *con_id,
+			enum gpiod_flags flags)
 {
-	return ERR_PTR(-ENOSYS);
+	return devm_gpiod_get_index_optional(dev, con_id, 0, flags);
 }
 =

 static inline struct gpio_descs *__must_check
@@ -247,6 +281,9 @@ static inline struct gpio_descs *__must_check
 devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
 			      enum gpiod_flags flags)
 {
+	if (__gpiod_no_optional_possible(dev))
+		return NULL;
+
 	return ERR_PTR(-ENOSYS);
 }
 =


Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
