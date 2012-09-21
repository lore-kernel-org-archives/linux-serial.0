From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
Date: Fri, 21 Sep 2012 12:39:18 +0300
Message-ID: <20120921093917.GD15626@arwen.pp.htv.fi>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1TEzet-00077v-VD-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 10:36:27AM +0100, Russell King wrote:
> Move the PXA2xx/IXP4xx UDC header file into linux/platform_data as it
> only contains a driver platform data structure.
>=20
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

after fixing Eric's comment:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/include/asm/mach/udc_pxa2xx.h   |   26 ------------------------=
--
>  arch/arm/mach-ixp4xx/include/mach/udc.h  |    2 +-
>  arch/arm/mach-pxa/include/mach/udc.h     |    2 +-
>  drivers/usb/gadget/pxa25x_udc.c          |    4 +---
>  include/linux/platform_data/pxa2xx_udc.h |   27 ++++++++++++++++++++++++=
+++
>  5 files changed, 30 insertions(+), 31 deletions(-)
>  delete mode 100644 arch/arm/include/asm/mach/udc_pxa2xx.h
>  create mode 100644 include/linux/platform_data/pxa2xx_udc.h
>=20
> diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/as=
m/mach/udc_pxa2xx.h
> deleted file mode 100644
> index ea297ac..0000000
> --- a/arch/arm/include/asm/mach/udc_pxa2xx.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * arch/arm/include/asm/mach/udc_pxa2xx.h
> - *
> - * This supports machine-specific differences in how the PXA2xx
> - * USB Device Controller (UDC) is wired.
> - *
> - * It is set in linux/arch/arm/mach-pxa/<machine>.c or in
> - * linux/arch/mach-ixp4xx/<machine>.c and used in
> - * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
> - */
> -
> -struct pxa2xx_udc_mach_info {
> -        int  (*udc_is_connected)(void);		/* do we see host? */
> -        void (*udc_command)(int cmd);
> -#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
> -#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
> -
> -	/* Boards following the design guidelines in the developer's manual,
> -	 * with on-chip GPIOs not Lubbock's weird hardware, can have a sane
> -	 * VBUS IRQ and omit the methods above.  Store the GPIO number
> -	 * here.  Note that sometimes the signals go through inverters...
> -	 */
> -	bool	gpio_pullup_inverted;
> -	int	gpio_pullup;			/* high =3D=3D pullup activated */
> -};
> -
> diff --git a/arch/arm/mach-ixp4xx/include/mach/udc.h b/arch/arm/mach-ixp4=
xx/include/mach/udc.h
> index 80d6da2..b47cc0d 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/udc.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/udc.h
> @@ -2,7 +2,7 @@
>   * arch/arm/mach-ixp4xx/include/mach/udc.h
>   *
>   */
> -#include <asm/mach/udc_pxa2xx.h>
> +#include <linux/platform_data_pxa2xx_udc.h>
> =20
>  extern void ixp4xx_set_udc_info(struct pxa2xx_udc_mach_info *info);
> =20
> diff --git a/arch/arm/mach-pxa/include/mach/udc.h b/arch/arm/mach-pxa/inc=
lude/mach/udc.h
> index 2f82332..9a827e3 100644
> --- a/arch/arm/mach-pxa/include/mach/udc.h
> +++ b/arch/arm/mach-pxa/include/mach/udc.h
> @@ -2,7 +2,7 @@
>   * arch/arm/mach-pxa/include/mach/udc.h
>   *
>   */
> -#include <asm/mach/udc_pxa2xx.h>
> +#include <linux/platform_data/pxa2xx_udc.h>
> =20
>  extern void pxa_set_udc_info(struct pxa2xx_udc_mach_info *info);
> =20
> diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_=
udc.c
> index 907ad3e..06e498d 100644
> --- a/drivers/usb/gadget/pxa25x_udc.c
> +++ b/drivers/usb/gadget/pxa25x_udc.c
> @@ -29,6 +29,7 @@
>  #include <linux/list.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm.h>
> +#include <linux/platform_data/pxa2xx_udc.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/irq.h>
> @@ -60,9 +61,6 @@
>  #include <mach/lubbock.h>
>  #endif
> =20
> -#include <asm/mach/udc_pxa2xx.h>
> -
> -
>  /*
>   * This driver handles the USB Device Controller (UDC) in Intel's PXA 25x
>   * series processors.  The UDC for the IXP 4xx series is very similar.
> diff --git a/include/linux/platform_data/pxa2xx_udc.h b/include/linux/pla=
tform_data/pxa2xx_udc.h
> new file mode 100644
> index 0000000..c6c5e98
> --- /dev/null
> +++ b/include/linux/platform_data/pxa2xx_udc.h
> @@ -0,0 +1,27 @@
> +/*
> + * This supports machine-specific differences in how the PXA2xx
> + * USB Device Controller (UDC) is wired.
> + *
> + * It is set in linux/arch/arm/mach-pxa/<machine>.c or in
> + * linux/arch/mach-ixp4xx/<machine>.c and used in
> + * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
> + */
> +#ifndef PXA2XX_UDC_H
> +#define PXA2XX_UDC_H
> +
> +struct pxa2xx_udc_mach_info {
> +        int  (*udc_is_connected)(void);		/* do we see host? */
> +        void (*udc_command)(int cmd);
> +#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
> +#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
> +
> +	/* Boards following the design guidelines in the developer's manual,
> +	 * with on-chip GPIOs not Lubbock's weird hardware, can have a sane
> +	 * VBUS IRQ and omit the methods above.  Store the GPIO number
> +	 * here.  Note that sometimes the signals go through inverters...
> +	 */
> +	bool	gpio_pullup_inverted;
> +	int	gpio_pullup;			/* high =3D=3D pullup activated */
> +};
> +
> +#endif
> --=20
> 1.7.4.4
>=20

--=20
balbi

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXDXFAAoJEIaOsuA1yqREEM8QALNl5+xMVJSGRFdyERiZy46i
cjfaSZSZnlVf5E08pOFyv60gXLWRk0XgxWqO8q35/LyhZvmDhp6MnfJwTnMLfOxt
cKYUgfZU9cS/VOlWXsQIPdPVE1qPVQuyv2WhDoud04m9iPU7kHkVwR3RY91nmAAJ
LDZiOgilMQC/cm/y0iiw7Th/ke05v9X4+hfzcYhajKTYEyP2x9nrblJWFEkkCHOq
DovZXGSkUpRM2CQUHTYihaVhzANOS9PXVZfM6csZeSW/2SwFfg5jBoRwXZMpPmpP
wiglqKUWGS6ykU+0diQ+RQbVPbsxn+eT2If5hrcnYg12qp7tSxfbgSR+wcmvm8xL
1BLB/hpV+8WDkao+0bMwiknKDnHApOjIyRKip7NnLReV7fLXmo4me0OnTqhTLMuf
x93gKSO6qmLWdxtJ7P2YIygMkXZcVa5adj1bXSRDdQC6W7wSxqe/YFHNKq+CVYp/
k/D1Wpfs82tqZB3DNJ4cgNLOF1vfvX38lwojtjjDSQ+ARdrdc+lG5vuzVyTluG37
Z6d7+onckPO7+zgLRbs7BxpzWlTv3cpiHLDkiV/ovb/pNdrWBQsWIOAIsMHchjnt
tg6W/CrVpwpZQBWpaBkXeI8V0NKBkiW6tHZa4OJHsfolAzm9T5cGcqOa/9Qf7XoB
CJ01O+brjSFhUgzM7K/y
=/M/z
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
