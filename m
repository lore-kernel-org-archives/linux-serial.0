From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 52/79] TTY: serial, move 68360 driver to staging
Date: Wed, 26 Oct 2011 14:27:30 +0200
Message-ID: <CAMuHMdXO2QkjuG9zBjR+HO6hYphgxLUH59kjTkFLZU+4Z8jR-Q@mail.gmail.com>
References: <20111026114236.GA22180@kroah.com>
	<1319631204-23262-1-git-send-email-gregkh@suse.de>
	<1319631204-23262-52-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38917 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866Ab1JZM1b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:27:31 -0400
Received: by iaby12 with SMTP id y12so1674142iab.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 05:27:30 -0700 (PDT)
In-Reply-To: <1319631204-23262-52-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Greg Ungerer <gerg@uclinux.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>

m68knommu =3D> Greg

On Wed, Oct 26, 2011 at 14:12, Greg Kroah-Hartman <gregkh@suse.de> wrot=
e:
> From: Jiri Slaby <jslaby@suse.cz>
>
> This driver has been broken at least since 2008. At that time,
> a88487c79b (Fix compile errors in SGI console drivers) broke this
> driver completely.
>
> And since nobody noticed for the past 3 years, move it into staging. =
I
> think this will rot there and we will throw it away completely after
> some time. Or maybe someone will volunteer to fix it ;).
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> =C2=A0drivers/staging/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 ++
> =C2=A0drivers/staging/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0drivers/{tty =3D> staging}/serial/68360serial.c | =C2=A0 =C2=A0=
0
> =C2=A0drivers/staging/serial/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 16 ++++++++++++++++
> =C2=A0drivers/staging/serial/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/staging/serial/TODO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 ++++++
> =C2=A0drivers/tty/serial/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 17 -----------------
> =C2=A0drivers/tty/serial/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 -
> =C2=A08 files changed, 26 insertions(+), 18 deletions(-)
> =C2=A0rename drivers/{tty =3D> staging}/serial/68360serial.c (100%)
> =C2=A0create mode 100644 drivers/staging/serial/Kconfig
> =C2=A0create mode 100644 drivers/staging/serial/Makefile
> =C2=A0create mode 100644 drivers/staging/serial/TODO
>
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 06c9081..bd3d1cc 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -24,6 +24,8 @@ menuconfig STAGING
>
> =C2=A0if STAGING
>
> +source "drivers/staging/serial/Kconfig"
> +
> =C2=A0source "drivers/staging/et131x/Kconfig"
>
> =C2=A0source "drivers/staging/slicoss/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index f3c5e33..d480a94 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -3,6 +3,7 @@
> =C2=A0# fix for build system bug...
> =C2=A0obj-$(CONFIG_STAGING) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D st=
aging.o
>
> +obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D serial/
> =C2=A0obj-$(CONFIG_ET131X) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D et=
131x/
> =C2=A0obj-$(CONFIG_SLICOSS) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D sl=
icoss/
> =C2=A0obj-$(CONFIG_VIDEO_GO7007) =C2=A0 =C2=A0 +=3D go7007/
> diff --git a/drivers/tty/serial/68360serial.c b/drivers/staging/seria=
l/68360serial.c
> similarity index 100%
> rename from drivers/tty/serial/68360serial.c
> rename to drivers/staging/serial/68360serial.c
> diff --git a/drivers/staging/serial/Kconfig b/drivers/staging/serial/=
Kconfig
> new file mode 100644
> index 0000000..9489688
> --- /dev/null
> +++ b/drivers/staging/serial/Kconfig
> @@ -0,0 +1,16 @@
> +config SERIAL_68360_SMC
> + =C2=A0 =C2=A0 =C2=A0 bool "68360 SMC uart support"
> + =C2=A0 =C2=A0 =C2=A0 depends on M68360
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver supports the SMC serial por=
ts of the Motorola 68360 CPU.
> +
> +config SERIAL_68360_SCC
> + =C2=A0 =C2=A0 =C2=A0 bool "68360 SCC uart support"
> + =C2=A0 =C2=A0 =C2=A0 depends on M68360
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver supports the SCC serial por=
ts of the Motorola 68360 CPU.
> +
> +config SERIAL_68360
> + =C2=A0 =C2=A0 =C2=A0 bool
> + =C2=A0 =C2=A0 =C2=A0 depends on SERIAL_68360_SMC || SERIAL_68360_SC=
C
> + =C2=A0 =C2=A0 =C2=A0 default y
> diff --git a/drivers/staging/serial/Makefile b/drivers/staging/serial=
/Makefile
> new file mode 100644
> index 0000000..37a6a0b
> --- /dev/null
> +++ b/drivers/staging/serial/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_SERIAL_68360) +=3D 68360serial.o
> diff --git a/drivers/staging/serial/TODO b/drivers/staging/serial/TOD=
O
> new file mode 100644
> index 0000000..a19cda8
> --- /dev/null
> +++ b/drivers/staging/serial/TODO
> @@ -0,0 +1,6 @@
> +These are a few serial drivers that either do not build, or do not w=
ork if they
> +do build, or if they seem to work, are for obsolete hardware, or are=
 full of
> +unfixable races and no one uses them anymore.
> +
> +If no one steps up to adopt any of these drivers, they will be remov=
ed
> +in the 3.4 release.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 8ee3a66..5f479da 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1042,23 +1042,6 @@ config SERIAL_MCF_CONSOLE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable a ColdFire internal serial p=
ort to be the system console.
>
> -config SERIAL_68360_SMC
> - =C2=A0 =C2=A0 =C2=A0 bool "68360 SMC uart support"
> - =C2=A0 =C2=A0 =C2=A0 depends on M68360
> - =C2=A0 =C2=A0 =C2=A0 help
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver supports the SMC serial por=
ts of the Motorola 68360 CPU.
> -
> -config SERIAL_68360_SCC
> - =C2=A0 =C2=A0 =C2=A0 bool "68360 SCC uart support"
> - =C2=A0 =C2=A0 =C2=A0 depends on M68360
> - =C2=A0 =C2=A0 =C2=A0 help
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver supports the SCC serial por=
ts of the Motorola 68360 CPU.
> -
> -config SERIAL_68360
> - =C2=A0 =C2=A0 =C2=A0 bool
> - =C2=A0 =C2=A0 =C2=A0 depends on SERIAL_68360_SMC || SERIAL_68360_SC=
C
> - =C2=A0 =C2=A0 =C2=A0 default y
> -
> =C2=A0config SERIAL_PMACZILOG
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Mac or PowerMac z85c30 ESCC supp=
ort"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on (M68K && MAC) || (PPC_OF && PPC=
_PMAC)
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> index 7b59958..e10cf5b 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -50,7 +50,6 @@ obj-$(CONFIG_SERIAL_MAX3107_AAVA) +=3D max3107-aava=
=2Eo
> =C2=A0obj-$(CONFIG_SERIAL_IP22_ZILOG) +=3D ip22zilog.o
> =C2=A0obj-$(CONFIG_SERIAL_MUX) +=3D mux.o
> =C2=A0obj-$(CONFIG_SERIAL_68328) +=3D 68328serial.o
> -obj-$(CONFIG_SERIAL_68360) +=3D 68360serial.o
> =C2=A0obj-$(CONFIG_SERIAL_MCF) +=3D mcf.o
> =C2=A0obj-$(CONFIG_SERIAL_PMACZILOG) +=3D pmac_zilog.o
> =C2=A0obj-$(CONFIG_SERIAL_DZ) +=3D dz.o
> --
> 1.7.7
>
>



--=20
Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
