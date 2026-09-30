Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5A5476EE
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790115; cv=none; b=Fp+RV5aKBfE9rvfXMcYLod434cc7wKunHW+gIvomD6kIXaE4Pw+NSeXMfbew4Pfrbu/R73l8S6pgBsposP3oM9Tt3FuOO+g7mhgPZcbtOqL/fue815Kr2wP6JFgBX7DlRz5U52A40VyE0XaKxtI6qH4Ga6cFvUFIkXOmVX1fd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790115; c=relaxed/simple;
	bh=Uyr1RpyXlIyY6KkPKPkDm96tH+iJzRR1ZQPzNIGJgZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVFYVrFOqXUxXbMfq7sjGQ1bvdSB4L+qrcUy3OgzeVycDSfPsEDzfSuYARAM/D0HPw94RKuS+Mdy9LykXtIbanUM7oi2+tT1gz+G7/k0PvyC8QdtuKWaqrM9JoTW1nNeflowErvDVIivp0zeafqd7qig3NtHh7TauEdfDnheXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=CmYZV/2M; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CmYZV/2M"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 104EF240101
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 19:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790790111;
	bh=I+uTcAW8u8uHMkPAau7RErYoiCyAQlm8Ewbm3HbHyss=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=CmYZV/2MG0WEhi4+1luKeVDiorswRV4sI4kW0+LOacqDp05BpZUDHT4tQ03EZEY/b
	 LfYoebei5s8XgKE3mv50PN7l4Jka1nIk3tRJY6mFYY/zY4k4E8HizdTkYfKkM24AKc
	 8mylbRzaXtwfS5syPBOiH++bWERVmcUkBxpfaiKWDxk4k0GUtIB+4IKg+Z65iRZBSU
	 gKLnuWxNuNpWg9p39HMJUlTNcJbDLtZ4ELqs403KIia1gsszTUfCnS9YWnKo+inN27
	 DKYh1yKPBuWmveM+sb4/zsCZd2NaModSDOD3Cj4Y7IV0dA/rJcAB7aoVeVt25iO/QF
	 0JSORhQWKn41w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hw2RG0mpLz6tsb;
	Wed, 30 Sep 2026 19:41:46 +0200 (CEST)
Message-ID: <6fa1d763b656ea9f212584cd20485a9314941f93.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
From: Markus Probst <markus.probst@posteo.de>
To: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Eric Biggers	
 <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes	
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"	
 <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Jiri Slaby	
 <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Date: Wed, 30 Sep 2026 17:41:49 +0000
In-Reply-To: <20260930-rust_serdev_probe_refactor-v3-2-d1b6e77135e0@posteo.de>
References: 
	<20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
	 <20260930-rust_serdev_probe_refactor-v3-2-d1b6e77135e0@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-dy6088XJdc08HjE7tRiN"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-dy6088XJdc08HjE7tRiN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 17:32 +0000, Markus Probst wrote:
> These functions will be used to simply the serdev rust abstraction. It
> also contributes to the fixing of 2 race conditions in the serdev rust
> abstraction.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/tty/serdev/core.c           | 44 +++++++++++++++++++++++++++++++=
+++++-
>  drivers/tty/serdev/serdev-ttyport.c | 33 ++++++++++++++++++++++++++++
>  include/linux/serdev.h              |  6 +++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 77e8e1d4d2a6..af1470e33620 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -191,6 +191,45 @@ void serdev_device_close(struct serdev_device *serde=
v)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_close);
> =20
> +/**
> + * serdev_device_pause_rx() - pause data receive
> + * @serdev:	serdev device
> + *
> + * Pause calls to receive_buf.
> + *
> + * Note that if a call to receive_buf is currently executed, the functio=
n will
> + * sleep until it has finished.
> + */
> +void serdev_device_pause_rx(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl =3D serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->pause_rx)
> +		return;
> +
> +	ctrl->ops->pause_rx(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_pause_rx);
> +
> +/**
> + * serdev_device_resume_rx() - resume data receive
> + * @serdev:	serdev device
> + *
> + * Resume calls to receive_buf.
> + *
> + * This can be called even if not paused to ensure data receive is activ=
e.
> + */
> +void serdev_device_resume_rx(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl =3D serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->resume_rx)
> +		return;
> +
> +	ctrl->ops->resume_rx(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_resume_rx);
> +
>  static void devm_serdev_device_close(void *serdev)
>  {
>  	serdev_device_close(serdev);
> @@ -402,6 +441,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
>  static int serdev_drv_probe(struct device *dev)
>  {
>  	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(dev=
->driver);
> +	struct serdev_device *sdev =3D to_serdev_device(dev);
>  	int ret;
> =20
>  	ret =3D dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> @@ -409,7 +449,9 @@ static int serdev_drv_probe(struct device *dev)
>  	if (ret)
>  		return ret;
> =20
> -	return sdrv->probe(to_serdev_device(dev));
> +	serdev_device_resume_rx(sdev);
> +
> +	return sdrv->probe(sdev);
>  }
> =20
>  static void serdev_drv_remove(struct device *dev)
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index c11908f5e1ce..2bed0e54202a 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -7,8 +7,10 @@
>  #include <linux/tty.h>
>  #include <linux/tty_driver.h>
>  #include <linux/poll.h>
> +#include "../tty.h"
> =20
>  #define SERPORT_ACTIVE		1
> +#define SERPORT_PAUSE_RX	2
> =20
>  struct serport {
>  	struct tty_port *port;
> @@ -35,6 +37,9 @@ static size_t ttyport_receive_buf(struct tty_port *port=
, const u8 *cp,
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
> +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> +		return 0;
> +
>  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);
> =20
>  	dev_WARN_ONCE(&ctrl->dev, ret > count,
> @@ -177,6 +182,32 @@ static bool ttyport_close(struct serdev_controller *=
ctrl)
>  	return true;
>  }
> =20
> +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +
> +	guard(mutex)(&serport->lock);
> +
> +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_flush_work(tty->port);
I just realised this could result in a deadlock.

Since the mutex already prevents calling of
`serdev_controller_receive_buf`, it is safe to completely remove this
section (if statement + `tty_buffer_flush_work`).

Thanks
- Markus Probst

> +}
> +
> +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +
> +	guard(mutex)(&serport->lock);
> +
> +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_buffer_restart_work(tty->port);
> +}
> +
>  static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl,=
 unsigned int speed)
>  {
>  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> @@ -281,6 +312,8 @@ static const struct serdev_controller_ops ctrl_ops =
=3D {
>  	.get_tiocm =3D ttyport_get_tiocm,
>  	.set_tiocm =3D ttyport_set_tiocm,
>  	.break_ctl =3D ttyport_break_ctl,
> +	.pause_rx =3D ttyport_pause_rx,
> +	.resume_rx =3D ttyport_resume_rx,
>  };
> =20
>  struct device *serdev_tty_port_register(struct tty_port *port,
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 0f4e81c0950d..02773554e759 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -89,6 +89,8 @@ struct serdev_controller_ops {
>  	int (*get_tiocm)(struct serdev_controller *);
>  	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int=
);
>  	int (*break_ctl)(struct serdev_controller *ctrl, unsigned int break_sta=
te);
> +	void (*pause_rx)(struct serdev_controller *ctrl);
> +	void (*resume_rx)(struct serdev_controller *ctrl);
>  };
> =20
>  /**
> @@ -194,6 +196,8 @@ static inline size_t serdev_controller_receive_buf(st=
ruct serdev_controller *ctr
>  int serdev_device_open(struct serdev_device *);
>  void serdev_device_close(struct serdev_device *);
>  int devm_serdev_device_open(struct device *, struct serdev_device *);
> +void serdev_device_pause_rx(struct serdev_device *serdev);
> +void serdev_device_resume_rx(struct serdev_device *serdev);
>  unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned=
 int);
>  void serdev_device_set_flow_control(struct serdev_device *, bool);
>  int serdev_device_write_buf(struct serdev_device *, const u8 *, size_t);
> @@ -233,6 +237,8 @@ static inline int serdev_device_open(struct serdev_de=
vice *sdev)
>  	return -ENODEV;
>  }
>  static inline void serdev_device_close(struct serdev_device *sdev) {}
> +static inline void serdev_device_pause_rx(struct serdev_device *serdev) =
{}
> +static inline void serdev_device_resume_rx(struct serdev_device *serdev)=
 {}
>  static inline unsigned int serdev_device_set_baudrate(struct serdev_devi=
ce *sdev, unsigned int baudrate)
>  {
>  	return 0;

--=-dy6088XJdc08HjE7tRiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmq9SdkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSdSsP/1aadVwJQNPm0NLQiSDA
rumkbifsSrW/sUOr3yEhnrdWRcx55sto8VmWjGBDbvVsm0mRTGgRZfzuMTdEVoA0
ngS1cQpcxiritOEnTZ3xjljAddE4AM04TD4PYnC3hyZGLbNP8eKOA1/Ew7iTEwUY
NppQt0vYzdOvemHiskIZJZE2mCppRYPa9xJvlIg19e1YTESx5WTjKpxP5IQR6Fr7
Q+rlWH4220ByPs8Xy9sqFToh/C6NZ18YpF7ezwODURGBvmmrkzL88raIspxmGP5E
/RTxvZEiOfm1Qi8TmKbCK/sR50ZLO7253lWOI+3fyM0WTsCDyMpwzMaujg7mIwjo
6GK/SoAw3gtw/RoFTEQi5uNC4FRRI3FMMgO3T2t6FI0O5bFIzvTypvSS83WzJMgR
9llH79DCpw6hJJICtdIULfvaYM5MrVNQ/RrKgG/0J5vwBRRTHC0PNKNxZJnaN/Xb
yKIiKz7/3w9oGGf2cfH9h6leLpHzKHBhKXuNu2vu+wgB12uHnFzrlatvgwzQVuoC
v4v4eHAQqX64u9fawTmZWpz17ikH38L1CXqGvGzeo7wnTEdjcUo/v5373wa5iiU2
PxZnSbj09cjtpJpoOROMb2xMTdrRAZrxec6MvGVZcoylvK3loYYHw0lKBhHCjmgv
RUg07VB0KB7ED28LoM02XRUb
=8CHL
-----END PGP SIGNATURE-----

--=-dy6088XJdc08HjE7tRiN--
