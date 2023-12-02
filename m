Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKWht4e5"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB710F3
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 18:28:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso10834885ad.0
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701484092; x=1702088892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76O+RH8qZeRuRBc1mT4uLTZ6BfSO4LNymM/dQ6nxNw0=;
        b=yKWht4e5yaJE+X0VoshDNHA2ZFevnp7O1QNMpBtDzUZyVIHC7MifoYl5qzKcgU8i97
         PfUnfOU87kh9E6lJ96SZYO35wgOpSl3mwxq60MHEMROkI9mbNsDEQiwVZaVay4Vi8Ml+
         69KvmqssN9uacMwIpY9GNKtWJPZ0Kxw4GyXQGk8Tr3QamVymarg5C7NYa5eR6g4ZvBIu
         bL7anQUkkGuVQlKDRefyvD+Vzr9mRUvXHYxlzC7SWpoubsu/twlM9sYoi5HV+DkAvTQ8
         CcKE6owz/F7gh+9bj5xIRTS6Ypm8U7SSf83B1C7jaCn4nxCdrj7v97hb5wmWLWeC7qee
         j3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701484092; x=1702088892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76O+RH8qZeRuRBc1mT4uLTZ6BfSO4LNymM/dQ6nxNw0=;
        b=NoNyz39rpoj2iowCxa6MNP+TKIL3piKsuRc/GYBitxPX2/OUQgv5pDYwy4XCdN9XIK
         EqMzQZpPcPj/YyZR5oA6Pf7tkAbXlsL3x4fZ4X74shSc/H+UANQFS/kaCvwdGQRB5VWW
         RualZf7KdpH20Sq7deAqec73j2pcVNhLmJQJ/qSQEZKCPuARI+wO+rPzR5uXjffpOhC+
         gBkfHmko/il/Av7IrmXfty7nM9x1IbfBHauMgV7cPP0wcYDGB3yK1w13rPvDu3tJNu++
         7+9OHmKiC01YPvE5AtuJWuvFC5mMclx2yzBMoEzTkuD77HXlSUjWFPLjVWyFED06AGMS
         eGOw==
X-Gm-Message-State: AOJu0YywiVepXi6XQyHR4V726wIDkQpIFdf2izjWAAf3yYI6dSOYtdj5
	V2BDTQXPBKc2j/GF+9JVLEptNU096OuxedA7xM5dKg==
X-Google-Smtp-Source: AGHT+IG1dE3nOssFf65P5OHRfkzUuH2N8dYYyAJ+WlkyZbyjQVISgvPG3LWKb2DVruVskMVXo7/YNmnqp8LpAD6HLwQ=
X-Received: by 2002:a17:903:41c1:b0:1ca:7f91:aa5d with SMTP id
 u1-20020a17090341c100b001ca7f91aa5dmr660536ple.16.1701484092499; Fri, 01 Dec
 2023 18:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org> <20231201160925.3136868-20-peter.griffin@linaro.org>
In-Reply-To: <20231201160925.3136868-20-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Dec 2023 20:28:01 -0600
Message-ID: <CAPLW+4mOmQM+Hy-kUKn9onU25-ycgj4CWfAK+-vZVH+yw=FhtQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] arm64: dts: exynos: google: Add initial
 Oriole/pixel 6 board support
To: Peter Griffin <peter.griffin@linaro.org>
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

On Fri, Dec 1, 2023 at 10:11=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> Add initial board support for the Pixel 6 phone code named Oriole. This
> has been tested with a minimal busybox initramfs and boots to a shell.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/Makefile           |   2 +
>  arch/arm64/boot/dts/exynos/google/Makefile    |   4 +
>  .../boot/dts/exynos/google/gs101-oriole.dts   | 105 ++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/google/Makefile
>  create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
>
> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/ex=
ynos/Makefile
> index 6e4ba69268e5..44c24a8ad9e1 100644
> --- a/arch/arm64/boot/dts/exynos/Makefile
> +++ b/arch/arm64/boot/dts/exynos/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y +=3D google
> +
>  dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
>         exynos5433-tm2.dtb              \
>         exynos5433-tm2e.dtb             \
> diff --git a/arch/arm64/boot/dts/exynos/google/Makefile b/arch/arm64/boot=
/dts/exynos/google/Makefile
> new file mode 100644
> index 000000000000..0a6d5e1fe4ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/google/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
> +       gs101-oriole.dtb \
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> new file mode 100644
> index 000000000000..6abd00fa337e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Oriole Device Tree
> + *
> + * Copyright 2021-2023 Google,LLC

Space after comma. Maybe also make this line consistent for all added
files. Checking existing files, it's usually spelled "Copyright (C)
<years>, Google LLC."

Btw, I forgot to mention in my review for PATCH #18: please double
check the commit message, there are some issues with punctuation
there.

> + * Copyright 2023 Linaro Ltd - <peter.griffin@linaro.org>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "gs101-pinctrl.h"
> +#include "gs101.dtsi"
> +
> +/ {
> +       model =3D "Oriole";
> +       compatible =3D "google,gs101-oriole", "google,gs101";
> +
> +       aliases {
> +               serial0 =3D &serial_0;
> +       };
> +
> +       chosen {
> +               /* Bootloader expects bootargs specified otherwise it cra=
shes */

Just wanted to say: I think you are doing a great job with this
platform, and I can only imagine how hard it can be when you can't
actually tinker with the bootloader source code. But I do appreciate
that you was able to minimize stuff like earlycon, ect, etc :) And
this one actually LGTM.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +               bootargs =3D "";
> +               stdout-path =3D &serial_0;
> +       };
> +
> +       gpio-keys {
> +               compatible =3D "gpio-keys";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&key_voldown>, <&key_volup>, <&key_power>;
> +
> +               button-vol-down {
> +                       label =3D "KEY_VOLUMEDOWN";
> +                       linux,code =3D <KEY_VOLUMEDOWN>;
> +                       gpios =3D <&gpa7 3 GPIO_ACTIVE_LOW>;
> +                       wakeup-source;
> +               };
> +
> +               button-vol-up {
> +                       label =3D "KEY_VOLUMEUP";
> +                       linux,code =3D <KEY_VOLUMEUP>;
> +                       gpios =3D <&gpa8 1 GPIO_ACTIVE_LOW>;
> +                       wakeup-source;
> +               };
> +
> +               button-power {
> +                       label =3D "KEY_POWER";
> +                       linux,code =3D <KEY_POWER>;
> +                       gpios =3D <&gpa10 1 GPIO_ACTIVE_LOW>;
> +                       wakeup-source;
> +               };
> +       };
> +};
> +
> +&ext_24_5m {
> +       clock-frequency =3D <24576000>;
> +};
> +
> +&ext_200m {
> +       clock-frequency =3D <200000000>;
> +};
> +
> +&pinctrl_far_alive {
> +       key_voldown: key-voldown-pins {
> +               samsung,pins =3D "gpa7-3";
> +               samsung,pin-function =3D <GS101_PIN_FUNC_EINT>;
> +               samsung,pin-pud =3D <GS101_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> +       };
> +
> +       key_volup: key-volup-pins {
> +               samsung,pins =3D "gpa8-1";
> +               samsung,pin-function =3D <GS101_PIN_FUNC_EINT>;
> +               samsung,pin-pud =3D <GS101_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> +       };
> +};
> +
> +&pinctrl_gpio_alive {
> +       key_power: key-power-pins {
> +               samsung,pins =3D "gpa10-1";
> +               samsung,pin-function =3D <GS101_PIN_FUNC_EINT>;
> +               samsung,pin-pud =3D <GS101_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <GS101_PIN_DRV_2_5_MA>;
> +       };
> +};
> +
> +&serial_0 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart0_bus>;
> +};
> +
> +&usi_uart {
> +       status =3D "okay";
> +       samsung,clkreq-on; /* needed for UART mode */
> +};
> +
> +&watchdog_cl0 {
> +       timeout-sec =3D <30>;
> +       status =3D "okay";
> +};
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
