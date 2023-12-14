Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUyqbVXO"
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFE111
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:55:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c210e34088so6871335a12.2
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702569314; x=1703174114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3dEU5MDIKfW+qCgC0PdqFKd7O+g3bLPZxWTXEaaam8=;
        b=LUyqbVXObIzpamKp0fyTc+Rjv3sguhqfdpED9TmePWCZv+DQG/dqABjbEk0V9Q+uRg
         nD0pZis1uUfhbvMV5ZpUNXnIWzvwEmssJkxnzs5vknuwPWCN1CQFOmtEBppmxh4xVxS6
         KcrEUnjnK8ll51DompifLrq+hhtrACZorfqCrAFgGokXqwzz/3AkrYjEhKgdJLf8TKHD
         WNqSuGRt/DTZNcxdV6vGL5bfJKU6P5WWvmwqoz12BOSNydE17EfFC/y6fSisGB7bCKks
         uDImIVJsm27r8qyePzoYzOkSF4SS9POTHWtJC1EWaCCwdjeQhG+t67dnl1Ft3Bi+gBue
         fr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569314; x=1703174114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3dEU5MDIKfW+qCgC0PdqFKd7O+g3bLPZxWTXEaaam8=;
        b=Rdtd44Zxn3aCR05itRtgCYkE7R74Aa7JxbXq9zBO9ICO/PTU5Chzzl1zzj+bk+NSkn
         UIXulzOHvorNmSQXBA4mmzrrad6+HesC+HM2kcDqO2qQ5U7L3urzLv23W7Hv4kMCrkFB
         ++M2rte+XgSS9JjjIER6lYCBJQzkkVDMUZiGmgREVgVRExIxIEgFjydnIZNDSmG0WldD
         bIkKhNFqKbrin4p4sTL9ja7YqrB1ld0R9PNaBn0pMHNaPakl9lFe+DXcIcdqAKYIe2Jn
         qFFz15E9bjI5FHmr4Uw7ZMrRQV6S1hrtsb/xAXcC+BGg4diQQFMsYcdEWCDAbCYNX8ws
         kOZA==
X-Gm-Message-State: AOJu0YxVV3t+bN9RPMzlN+SORMaRsQgzuSOpxBWgcdKoN1/9EVBQFxkY
	n7B3e5f0oaHiLzTcHiAEFx29qrSZDiwNRSIqzyyIkw==
X-Google-Smtp-Source: AGHT+IGkTnLdOtrqyXltKJs1dUID0ysgTZE7BI1PV4SJTjovnObU8OGLzeMvBOaKswBq0xLjC9rksw67hcvGeMcAL24=
X-Received: by 2002:a17:90b:948:b0:28a:e356:459b with SMTP id
 dw8-20020a17090b094800b0028ae356459bmr2009364pjb.34.1702569314569; Thu, 14
 Dec 2023 07:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-12-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-12-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Dec 2023 09:55:03 -0600
Message-ID: <CAPLW+4nTgam4jZ+s5m5E05jWO_kfSy=fMS0Ywp3yQEEn-UESbg@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
To: Tudor Ambarus <tudor.ambarus@linaro.org>, krzysztof.kozlowski+dt@linaro.org
Cc: peter.griffin@linaro.org, robh+dt@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org, 
	alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, s.nawrocki@samsung.com, 
	tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:53=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Enable the eeprom found on the battery connector.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../boot/dts/exynos/google/gs101-oriole.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index 4a71f752200d..11b299d21c5d 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -63,6 +63,19 @@ &ext_200m {
>         clock-frequency =3D <200000000>;
>  };
>
> +&hsi2c_8 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&hsi2c8_bus>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;

Not sure if those 4 above properties belong in board's dts or in SoC's
dtsi. Krzysztof, what do you think?

Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +       status =3D "okay";
> +
> +       eeprom: eeprom@50 {
> +               compatible =3D "atmel,24c08";
> +               reg =3D <0x50>;
> +       };
> +};
> +
>  &pinctrl_far_alive {
>         key_voldown: key-voldown-pins {
>                 samsung,pins =3D "gpa7-3";
> @@ -99,6 +112,11 @@ &usi_uart {
>         status =3D "okay";
>  };
>
> +&usi8 {
> +       samsung,mode =3D <USI_V2_I2C>;
> +       status =3D "okay";
> +};
> +
>  &watchdog_cl0 {
>         timeout-sec =3D <30>;
>         status =3D "okay";
> --
> 2.43.0.472.g3155946c3a-goog
>
