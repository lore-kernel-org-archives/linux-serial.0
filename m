From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] staging: evict abandoned 68360serial.c driver from 3.4
Date: Wed, 28 Mar 2012 09:31:10 +0200
Message-ID: <CAMuHMdXrVeQqJUAwE2si-pzd6OA7kNykzovwUqxjXaPAuEnqVA@mail.gmail.com>
References: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51764 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2C1HbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Mar 2012 03:31:12 -0400
Received: by wibhq7 with SMTP id hq7so658259wib.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Mar 2012 00:31:10 -0700 (PDT)
In-Reply-To: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Ungerer <gerg@snapgear.com>

CC added.
m68k and m68knommu got merged, but Greg still handles the nommu
and coldfire parts.

On Wed, Mar 28, 2012 at 01:07, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> commit 3a0db7215c88077b61a673215756ec4a0dc0c7a5
>
> =C2=A0 =C2=A0"TTY: serial, move 68360 driver to staging"
>
> did so because the driver had remained broken since 2008. =C2=A0It al=
so
> added this text to the TODO file:
>
> =C2=A0 "If no one steps up to adopt any of these drivers, they will
> =C2=A0 =C2=A0be removed in the 3.4 release."
>
> A quick search on the internet doesn't reveal anyone actively
> trying to update/fix this driver, so follow through on the above
> and remove it from the pending 3.4 release.
>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>
> [ commit 3a0db72 was present in v3.2 in case people were wondering.
> =C2=A0Geert - I know you'd said "uClinux" wrt. 3a0db72, but I left yo=
u
> =C2=A0on the CC since the CONFIG_M68360 dependency comes from m68k. ]
>
> =C2=A0drivers/staging/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 -
> =C2=A0drivers/staging/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A01 -
> =C2=A0drivers/staging/serial/68360serial.c | 2979 -------------------=
---------------
> =C2=A0drivers/staging/serial/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16=
 -
> =C2=A0drivers/staging/serial/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A01 -
> =C2=A0drivers/staging/serial/TODO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A06 -
> =C2=A06 files changed, 0 insertions(+), 3005 deletions(-)
> =C2=A0delete mode 100644 drivers/staging/serial/68360serial.c
> =C2=A0delete mode 100644 drivers/staging/serial/Kconfig
> =C2=A0delete mode 100644 drivers/staging/serial/Makefile
> =C2=A0delete mode 100644 drivers/staging/serial/TODO
>
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 97d412d..4c99b4c 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -24,8 +24,6 @@ menuconfig STAGING
>
> =C2=A0if STAGING
>
> -source "drivers/staging/serial/Kconfig"
> -
> =C2=A0source "drivers/staging/et131x/Kconfig"
>
> =C2=A0source "drivers/staging/slicoss/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index ffe7d44..74662ce 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -3,7 +3,6 @@
> =C2=A0# fix for build system bug...
> =C2=A0obj-$(CONFIG_STAGING) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D st=
aging.o
>
> -obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D serial/
> =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D media/
> =C2=A0obj-$(CONFIG_ET131X) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D et=
131x/
> =C2=A0obj-$(CONFIG_SLICOSS) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D sl=
icoss/
> diff --git a/drivers/staging/serial/68360serial.c b/drivers/staging/s=
erial/68360serial.c
> deleted file mode 100644
> index daf0b1d..0000000
> diff --git a/drivers/staging/serial/Kconfig b/drivers/staging/serial/=
Kconfig
> deleted file mode 100644
> index 9489688..0000000
> diff --git a/drivers/staging/serial/Makefile b/drivers/staging/serial=
/Makefile
> deleted file mode 100644
> index 37a6a0b..0000000
> diff --git a/drivers/staging/serial/TODO b/drivers/staging/serial/TOD=
O
> deleted file mode 100644
> index a19cda8..0000000

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
