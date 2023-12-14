Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjorwqaM"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C674B132
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:39:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d098b87eeeso74278085ad.0
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702568387; x=1703173187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdjSPhIyB1xzNvePwzN4Lv4667HwZ9Mo32XFQbt5RU0=;
        b=CjorwqaMiPGQidFhMzoDJnRgw5CvHfMjnV0O3bnJ1c+7nfTT8pBgXYUBAx+xONuqdm
         PoEwNuy8OExz/JPKygfkdgYZqI62xgBpcHptaSsBD7UzDcOdBJ8geEagtvW2x0OisLMc
         2+6C5IWQ3kQRwZ5Ae1bxVUgZC9iqV3sAlbMg5SrmdF8sy9RU8NmZddpgmCMiFX5HGpss
         h/37tCS94e9A5xhiP6TepgZ0EDJP+pgXjAsXs0qxy9eA5LpW2jE2l0HUz2fC8wqWS8jE
         POMnLIdAjrxhbFAlj0BlUYT8iYQvMU5CVKrCpdB+osbkNAP8nswuTOepaVGcC6yfEH0M
         +ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568387; x=1703173187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdjSPhIyB1xzNvePwzN4Lv4667HwZ9Mo32XFQbt5RU0=;
        b=rBe1LIMOMKCKHEKXCnVAT0TpsCcx2FMK8XSoVe6ZQPz6+1vM+Pj1nUhz1h0uhGWN/d
         H7U9RzyCwGUxU0Y+HTHOuukJE79ro3wjOKXB51fKfM9rw4E8JSJ57X2wyb9Zek2suMs3
         jZ0k7FEEeLtZl1iAoYSuyic6JBL5LDKgMh8wG+DWJrdjk/7Vo13IeecT5t4J2PyFtXVE
         2ZYNTnpSJ8Ac21eXr2fNszNZmbEwHj3GvMn93Mky5FtgSg+yFE0ofoUrlTDqenZ6jzvH
         i7agd+JAWmp8b5u2/j9iSHpWJhBckiIwvbKMjYV3JzYpYDJFquwXZ5VwEk5ZLoUuyl8p
         raxQ==
X-Gm-Message-State: AOJu0Yx0umW1d51ypZbLx0iZ+yGE4jMYeBFkj7ek28R5imQhFhPu5rO6
	VykNQyHbEywYW7ogxc0QZD8EHl13QZU/iMIwGrNihw==
X-Google-Smtp-Source: AGHT+IGirM4+nryJ8CQwEZU0IegMIG64eLAF/7DoRqfynsZoP/h4uO2l7qynqj6arTSz3lMXlgfoKAyn+JsuJdyqzHo=
X-Received: by 2002:a17:90a:e50:b0:286:964d:c with SMTP id p16-20020a17090a0e5000b00286964d000cmr7480168pja.86.1702568387270;
 Thu, 14 Dec 2023 07:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-9-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-9-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Dec 2023 09:39:35 -0600
Message-ID: <CAPLW+4=bfcemh-dd7r9hOe0RbtC01+sNpj3ZMMfc8rMezKQfNA@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	conor+dt@kernel.org, andi.shyti@kernel.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Enable the cmu-peric0 clock controller. It feeds USI and I3c.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 9747cb3fa03a..d0b0ad70c6ba 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -339,6 +339,18 @@ ppi_cluster2: interrupt-partition-2 {
>                         };
>                 };
>
> +               cmu_peric0: clock-controller@10800000 {
> +                       compatible =3D "google,gs101-cmu-peric0";
> +                       reg =3D <0x10800000 0x4000>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&ext_24_5m>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
> +                       clock-names =3D "oscclk",
> +                                     "dout_cmu_peric0_bus",

I'd pull this line to the above line. Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +                                     "dout_cmu_peric0_ip";
> +               };
> +
>                 sysreg_peric0: syscon@10820000 {
>                         compatible =3D "google,gs101-peric0-sysreg", "sys=
con";
>                         reg =3D <0x10820000 0x10000>;
> --
> 2.43.0.472.g3155946c3a-goog
>
