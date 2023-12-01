Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UibRQBdQ"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268A1704
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 04:01:30 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58d9a4e9464so988984eaf.0
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701432090; x=1702036890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqr2nx7EOHUR5Y4hfhQw728v568+AKwyIx25pZkKlds=;
        b=UibRQBdQNvd1oR1O5Us5sSBXMi7kXxb15mRL57gzg9qMcTn1h9hm2jHpZpkgM0szr9
         TaKE9ee0XcnKjyMd2eCyx+s1TOP2WWZB4E61wNIih1AZ+/lz8eNxz7/hAgIYTzs0vYvZ
         PhI48ibAmXVLqbV5r7nw3ttYL4G7FkFJBAUT843kc9xaxOg/8CzKm7TgMqE7AihTVtDX
         C5VxCA5pzGGRwheTpkyTr2KlWy2YoyohVe0b6p8TofjEyAmzh925/Lknyj7JFsR77Vuk
         UvC/wJKPb38+AjhMolwPUdLG53V1fs7z+oxSLZdk2MJzRdBUSG27ur5LTcCuspePatbn
         Vrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432090; x=1702036890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqr2nx7EOHUR5Y4hfhQw728v568+AKwyIx25pZkKlds=;
        b=oh9EFJVk7FPvTVx1jYdSztlNHTU+wqu9t4Mj1Yx9BEmaCEELdyyDoJhaoPTiXtBVe3
         hPYLUvHJZ0uY1FPTE7PRz9JukylvupmAXBibXS77LiLXow3Y8D8USjR8S1elbOE2BLrL
         Aijdst2LRiZKPaXe3KFeNwC+xqZM83ZjJ25Dr8bFK9X+d/vYrTyy0s/SKg0SXIfon6dg
         NLeJQY9IDAq3nBDmA+V2D94qpxADSGLJdibPF41vnRa1lX3FHYBbaQ5dLA7asgIZwZYh
         lsEOZk7qQb5hIID4pRV5Z8/LvsLRqHAKU/PxNI3tEpTYgHaZ7ie3TuSw6AIHI+miRY1b
         wC9A==
X-Gm-Message-State: AOJu0YzOxQoWD8WrF+ZEmohlZ4eD9K0ezCzL4RarHCKuYmpp1B/O3Shb
	uitvHy8mItjkLyS8C7hb4T89R6hhZ0R/iZDtRg/S3g==
X-Google-Smtp-Source: AGHT+IEaVymyT4zngunznKYVd+LC7Ualf/L3X9ECNL23Q0+vmG0MBNBYVzrxhh9Wp1sn8PZeKLWznfrlwVe1KoQ8knI=
X-Received: by 2002:a05:6358:e90:b0:16e:4162:2ae5 with SMTP id
 16-20020a0563580e9000b0016e41622ae5mr11320311rwg.8.1701432089401; Fri, 01 Dec
 2023 04:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120212037.911774-1-peter.griffin@linaro.org>
 <20231120212037.911774-19-peter.griffin@linaro.org> <CAPLW+4k=M1q1thr2RXG4fGkvD51H7NxS1A3Ck+Up7W1nTcUPcw@mail.gmail.com>
In-Reply-To: <CAPLW+4k=M1q1thr2RXG4fGkvD51H7NxS1A3Ck+Up7W1nTcUPcw@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 1 Dec 2023 12:01:16 +0000
Message-ID: <CADrjBPoimnYhB3t5wSCKMTr8MbkDCVXvRmtsGzXrjZCW_7fF5A@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] arm64: dts: exynos: google: Add initial
 Oriole/pixel 6 board support
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Tue, 21 Nov 2023 at 18:39, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Mon, Nov 20, 2023 at 3:21=E2=80=AFPM Peter Griffin <peter.griffin@lina=
ro.org> wrote:
> >
> > Add initial board support for the Pixel 6 phone code named Oriole. This
> > has been tested with a minimal busybox initramfs and boots to a shell.

Will fix it in v5.

Peter
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm64/boot/dts/exynos/Makefile           |  2 +
> >  arch/arm64/boot/dts/exynos/google/Makefile    |  4 +
> >  .../boot/dts/exynos/google/gs101-oriole.dts   | 79 +++++++++++++++++++
> >  3 files changed, 85 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/exynos/google/Makefile
> >  create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> >
> > diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/=
exynos/Makefile
> > index 6e4ba69268e5..44c24a8ad9e1 100644
> > --- a/arch/arm64/boot/dts/exynos/Makefile
> > +++ b/arch/arm64/boot/dts/exynos/Makefile
> > @@ -1,4 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +subdir-y +=3D google
> > +
> >  dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
> >         exynos5433-tm2.dtb              \
> >         exynos5433-tm2e.dtb             \
> > diff --git a/arch/arm64/boot/dts/exynos/google/Makefile b/arch/arm64/bo=
ot/dts/exynos/google/Makefile
> > new file mode 100644
> > index 000000000000..0a6d5e1fe4ee
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/google/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
> > +       gs101-oriole.dtb \
> > diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/=
arm64/boot/dts/exynos/google/gs101-oriole.dts
> > new file mode 100644
> > index 000000000000..111665490840
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Oriole Device Tree
> > + *
> > + * Copyright 2021-2023 Google,LLC
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
>
> Now that the dts is being built as a dtb (not dtbo), I don' think this
> /plugin/ bit is needed here?
>
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include "gs101-pinctrl.h"
> > +#include "gs101.dtsi"
> > +
> > +/ {
> > +       model =3D "Oriole";
> > +       compatible =3D "google,gs101-oriole", "google,gs101";
> > +
> > +       chosen {
> > +               bootargs =3D "earlycon=3Dexynos4210,mmio32,0x10A00000 c=
onsole=3DttySAC0";
> > +       };
> > +
> > +       gpio-keys {
> > +               compatible =3D "gpio-keys";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&key_voldown>, <&key_volup>, <&key_power=
>;
> > +
> > +               button-vol-down {
> > +                       label =3D "KEY_VOLUMEDOWN";
> > +                       linux,code =3D <KEY_VOLUMEDOWN>;
> > +                       gpios =3D <&gpa7 3 GPIO_ACTIVE_LOW>;
> > +                       wakeup-source;
> > +               };
> > +
> > +               button-vol-up {
> > +                       label =3D "KEY_VOLUMEUP";
> > +                       linux,code =3D <KEY_VOLUMEUP>;
> > +                       gpios =3D <&gpa8 1 GPIO_ACTIVE_LOW>;
> > +                       wakeup-source;
> > +               };
> > +
> > +               button-power {
> > +                       label =3D "KEY_POWER";
> > +                       linux,code =3D <KEY_POWER>;
> > +                       gpios =3D <&gpa10 1 GPIO_ACTIVE_LOW>;
> > +                       wakeup-source;
> > +               };
> > +       };
> > +};
> > +
> > +&pinctrl_1 {
> > +       key_voldown: key-voldown-pins {
> > +               samsung,pins =3D "gpa7-3";
> > +               samsung,pin-function =3D <0xf>;
> > +               samsung,pin-pud =3D <0>;
> > +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> > +       };
> > +
> > +       key_volup: key-volup-pins {
> > +               samsung,pins =3D "gpa8-1";
> > +               samsung,pin-function =3D <0xf>;
> > +               samsung,pin-pud =3D <0>;
> > +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> > +       };
> > +};
> > +
> > +&pinctrl_0 {
> > +       key_power: key-power-pins {
> > +               samsung,pins =3D "gpa10-1";
> > +               samsung,pin-function =3D <0xf>;
> > +               samsung,pin-pud =3D <0>;
> > +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> > +       };
> > +};
> > +
> > +&watchdog_cl0 {
> > +       timeout-sec =3D <30>;
> > +};
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
