Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcKxEqDW"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85321198D
	for <linux-serial@vger.kernel.org>; Fri,  8 Dec 2023 06:27:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4254cde7506so13175131cf.0
        for <linux-serial@vger.kernel.org>; Fri, 08 Dec 2023 06:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702045675; x=1702650475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6tktGOmflBDjrD9owZW8jUp+CHgDfz/rbbtd4HS0Vg=;
        b=AcKxEqDWB30LUoTaGIxcjeHFnrqK0ABDkGOsbov3A8vTm7Yu0yQN4qekM/aJ3VZCTE
         nLWAGgtMYfDRmp7PU6nIwXuMxNejq7Hfg7LcbWjUXy9v3SnN4oeh6MsrFkxMTFiEQOup
         AL5QxcW08YlnSsJo9Px8vfcIcnigzDTGsCNdxrw5PzVjlcO4IC+LdDs63y+Wnb59j7jP
         FrEGejWh+Ywqw9qu/8UU5G62cN6+Sm+jDrU+LIEBik8tIDucfg7YXChDmYlaJKN1fYsZ
         D1E0HKOOQfN+giKLigY/J6X7KozqnbF7hwSR1JgDKI+RjdRr6OnGCJezZ5X6xFIlxUeb
         Wjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045675; x=1702650475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6tktGOmflBDjrD9owZW8jUp+CHgDfz/rbbtd4HS0Vg=;
        b=TvldMi78qNM7hHRROgQ5GT+i6O7A2h4EMyLsnvulUHA1vJFO+OI1einU/j5Idt/Oqm
         pgfXCbfPCCqszUS2Grv/AitxoXQw+PqCKGNYbANUAvmwnB9Wm+lLnHELtC027iJaMWnP
         5tx/KjiW/4Ka0ou6UPvEdm/NYmv4XZldSljQgWjhj1SEHxp0X0ndEkg50A0rU7B6u3I0
         0c67ek/dNZCAfNeyfx9CuDz7Ngpidnj3Zha7D93MH0q1LlqbbDPNpHQZH+TNhI9tPYIn
         U9tbTCZVUbu20mX42ni1eZ+u2gJwm/kMm0Yu/QDo/2gMyR75JGeKVSCPiIKYlu3J0tOi
         NIvw==
X-Gm-Message-State: AOJu0YwZRup3ijQsolgtfu7hrNHDMgtdM/+yABdl1QPrdEIhHk0nbKHu
	tS5kgyhD4WhBOu8yTQykA9i6c4AAZEHKsXGyiKT96A==
X-Google-Smtp-Source: AGHT+IGbiA6FsS80GfwV+c82tNjaevxVqMuJe5EJncnQTyRiVvDHSd4AgX2BqsQb6YkJ2YjyEjuCQy/avC/S0mz+amg=
X-Received: by 2002:ad4:5695:0:b0:67a:a721:e150 with SMTP id
 bd21-20020ad45695000000b0067aa721e150mr16777qvb.125.1702045675625; Fri, 08
 Dec 2023 06:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
 <20231201160925.3136868-13-peter.griffin@linaro.org> <20bf05b9d9ccc5c11ef17500ac7a97c46dd46a9a.camel@linaro.org>
In-Reply-To: <20bf05b9d9ccc5c11ef17500ac7a97c46dd46a9a.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 8 Dec 2023 14:27:44 +0000
Message-ID: <CADrjBPr_sv29Dc3F-4wVvH_N+qU6509kvHqkyZG==Q1RRpi5gA@mail.gmail.com>
Subject: Re: [PATCH v5 12/20] clk: samsung: clk-gs101: Add cmu_top, cmu_misc
 and cmu_apm support
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, semen.protsenko@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review

On Mon, 4 Dec 2023 at 17:51, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Fri, 2023-12-01 at 16:09 +0000, Peter Griffin wrote:
> > cmu_top is the top level clock management unit which contains PLLs, mux=
es,
> > dividers and gates that feed the other clock management units.
> >
> > cmu_misc clocks IPs such as Watchdog and cmu_apm clocks ips part of the
> > APM module.
> >
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Tested-by: Will McVicker <willmcvicker@google.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/clk/samsung/Makefile    |    1 +
> >  drivers/clk/samsung/clk-gs101.c | 2495 +++++++++++++++++++++++++++++++
> >  2 files changed, 2496 insertions(+)
> >  create mode 100644 drivers/clk/samsung/clk-gs101.c
> >
> > diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefil=
e
> > index ebbeacabe88f..3056944a5a54 100644
> > --- a/drivers/clk/samsung/Makefile
> > +++ b/drivers/clk/samsung/Makefile
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)       +=3D clk-=
exynos7.o
> >  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)        +=3D clk-exynos7885.o
> >  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)        +=3D clk-exynos850.o
> >  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)        +=3D clk-exynosautov9.o
> > +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)        +=3D clk-gs101.o
> >  obj-$(CONFIG_S3C64XX_COMMON_CLK)     +=3D clk-s3c64xx.o
> >  obj-$(CONFIG_S5PV210_COMMON_CLK)     +=3D clk-s5pv210.o clk-s5pv210-au=
dss.o
> >  obj-$(CONFIG_TESLA_FSD_COMMON_CLK)   +=3D clk-fsd.o
> > diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-=
gs101.c
> > new file mode 100644
> > index 000000000000..6bd233a7ab63
> > --- /dev/null
> > +++ b/drivers/clk/samsung/clk-gs101.c
> > @@ -0,0 +1,2495 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 Linaro Ltd.
> > + * Author: Peter Griffin <peter.griffin@linaro.org>
> > + *
> > + * Common Clock Framework support for GS101.
> > + */
> > [...]
> > +
> > +/* List of parent clocks for Muxes in CMU_TOP: for CMU_HSI0 */
> > +PNAME(mout_cmu_hsi0_usb31drd_p)      =3D { "oscclk", "dout_shared2_div=
2" };
> > +
> > +PNAME(mout_cmu_hsi0_bus_p)   =3D { "dout_shared0_div4", "dout_shared1_=
div4",
> > +                                 "dout_shared2_div2", "dout_shared3_di=
v2",
> > +                                 "fout_spare_pll" };
>
> This should also be updated....
>
> > [...]
> > +     MUX(CLK_MOUT_HSI0_BUS, "mout_cmu_hsi0_bus", mout_cmu_hsi0_bus_p,
> > +         CLK_CON_MUX_MUX_CLKCMU_HSI0_BUS, 0, 3),
>
> ...because we have 8 possibilities now.

Interesting, unfortunately there is some discrepancy between the
documentation again :( All the cmu_top clock parents were authored
using the cmu_diagrams which only shows the 5 parents listed above.
Checking the mux register definition it lists 5-7 as being oscclk
5=3Dosclk
6=3Dosclk
7=3Doscclk

Downstream clock implementation lists these oscclk 5-7 as well, so I
guess we should add them...sigh

> (I didn't check the other parents, but you mentioned you updated field wi=
dths
> in other registers, too, so maybe need to double check the parent strings=
 as well)

Yes I will go through and re-check these parent names again.

Peter
