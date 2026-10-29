Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267644;
	b=Es0T2PEasxedGLB4jdpIKR65EYVIrp9jNnZt+R9mOloJxm6Nnd67bAZD5EhQc4vs+BnO
	 Ot59zBAZLG1rJ7wSEowTKR0h4q59BriMNO3GfAuLw+aP9GC1Lrc29wlXw5LAdN5kaHHcQ
	 m+tlwdDNMdPrsEcvr0QOcSmmuSj89EDleOz2UBEIKhlEvWqwX7VcdtcMSGY/P/E3nP36Z
	 eUsRGqTnBbKzHejLxbSflAaHs92CNHXjMpv3nd27K7SicKKYTOMmIHAy0UJ+e0dtR1g6/
	 foy+7Rgmf0lYABWigXidqSYLJZ08SPacUTWfHi8NF3YT7jJXNBojWx7y3vCbGjoPAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267644;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OkdQNpqFK74AqsoSuQLpJuuXQ3xGNg7YSqinWqkNxfE=;
	b=bQRAX8RcW2srGW+bpShP1RajvrsxZdlvUidxvBRoHJWQJLj5IvoEVcP0aYEd0xc+yddm
	 vwB3MCOYp1WAJ1DakHrc0EFkWXiibvVP664sp0iTwvgeW9+/aR5Mlrk+cvB2Nlg2++R2y
	 dbkCadJcZe3r++86vYT55blBGMxk7Lm+nBsvxStaYMyETAFcu/T6CW4rESqqhvC8hgWSH
	 U8fNfIcDMOGG/RHYwu5OhcD0ZfVdMUd/MlMDyZ50BCAQj/KTODPLc5YTzGkV8SC+yYUH3
	 itZb/2NrqAFsLpem+bOraURMHev2SuUcUox24K02uUGo9/KOczO1sQBpnOXQobni8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqm7qclk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37B606A326
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqm7qclk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FE41F031ED
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267643;
	bh=OkdQNpqFK74AqsoSuQLpJuuXQ3xGNg7YSqinWqkNxfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wqm7qclkHoXKlMjWa8va4QemdTTs530yYwgHgelW2lqoy48S4AkXyDe5U3Y5twfR1
	 41N1sTVcB2cFotlHA1yCpSndHjSIEvBwht/V+xdFUj+ydF7xPTS/7Trd9htv1NDEq1
	 9X87+x4yTw+q5jXcTyRgZWCeYWZzmm7d5oLYj9wYii1hZ39cIJDwM94l+38HfyiaPQ
	 KAGxRTX7ZJlLsaA1KKXPihtpuBYglVh6ynYs2e7fMn+wgGeMMqdmHWM1V7JpoSVFyw
	 MFe0kHOS0d+PRrM+epXoh400M4s+6u+Z8L34VtGpfrFyhwP+3vC2Yw3Xp7K3RNpNsf
	 TZ8UZWTg/9hnw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1959298e87.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 02:54:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7KJiVXyVYNii1Z7lgYl2eIfkSvAGqYtBslV2KL2K488edCGUdCnPCR1x+v75OfG+ZlMP+ho2XOhY4FKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY9zDOvcCVTVJg5/LNs1MIv+SvMzagII6YkX9hYjWm00de9jvY
	x7geP6OCY7QsvI65kZmFo7za9fDefBlW6RilUKmDstSFodAwvoczYJTD1juB3ASff+hDToMC+PU
	sQsGCYtT+L/qLd1fN4YWUxRSivs9HMz0=
X-Received: by 2002:a05:6512:39c5:b0:5bf:cabe:23b6 with SMTP id
 2adb3069b0e04-5bfcad8adb2mr1930089e87.33.1793267642415; Thu, 29 Oct 2026
 02:54:02 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn> <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>
In-Reply-To: <20261027-a210-scmi-v1-7-74d58ce85bd8@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 29 Oct 2026 10:53:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLkwe+Vby4swUC85buxPMjm0=ZVZXY2+UfeMStemfh3fGA@mail.gmail.com>
X-Gm-Features: AclHuK-EdA1h9oU-ad6g7JzfaGvAyb9JuROsLdwvHKxOHcdM6tjvaL_X7Nax-1E
Message-ID: <CAD++jLkwe+Vby4swUC85buxPMjm0=ZVZXY2+UfeMStemfh3fGA@mail.gmail.com>
Subject: Re: [PATCH RFC 07/18] pinctrl: zhihe: add A210 support
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Han,

thanks for your patch!

On Tue, Oct 27, 2026 at 4:38=E2=80=AFPM Han Gao via B4 Relay
<devnull+gaohan.iscas.ac.cn@kernel.org> wrote:

>  drivers/pinctrl/pinctrl-a210.c | 1212 ++++++++++++++++++++++++++++++++++=
++++++

Can you please name this pinctrl-zhihe-a210.c

> +config PINCTRL_A210

And this symbol PINCTRL_ZHIHE_A210

> +       tristate "Pinctrl driver for the ZhiHe A210 SoC"
> +       depends on 64BIT

Why?

> +       depends on OF && (ARCH_ZHIHE || COMPILE_TEST)

Isn't this enough of constraints?

> +       select GENERIC_PINMUX_FUNCTIONS
> +       select GENERIC_PINCONF
> +       select PINMUX

Nice use of generic helpers!

> +struct a210_pinctrl;

Why this forward declaration? since...

> +enum a210_pinctrl_type {
> +       A210_PADCTRL_AON,
> +       A210_PADCTRL_0,
> +       A210_PADCTRL_1,
> +       A210_PADCTRL_2,
> +};
> +
> +struct a210_pad_group {
> +       const char *name;
> +       const struct pinctrl_pin_desc *pins;
> +       unsigned int npins;
> +       unsigned int offset_mux;
> +       unsigned int mask_mux;
> +       unsigned int offset_cfg;
> +       unsigned int mask_cfg;
> +       enum a210_pinctrl_type type;
> +};

... it anyway isn't used before we get here.

> +struct a210_pinctrl {
> +       struct pinctrl_desc desc;
> +       raw_spinlock_t lock; /* serialize register access */
> +       void __iomem *base;
> +       struct clk *clk;
> +       bool clk_enabled;
> +       unsigned int offset_mux;
> +       unsigned int mask_mux;
> +       unsigned int offset_cfg;
> +       unsigned int mask_cfg;
> +       enum a210_pinctrl_type type;
> +       struct pinctrl_dev *pctl;
> +#ifdef CONFIG_PM_SLEEP
> +       struct a210_register_state cfg_state[A210_MAX_CFG_REGS];
> +       struct a210_register_state mux_state[A210_MAX_MUX_REGS];
> +#endif
> +};
> +
> +static void __iomem *a210_padcfg(struct a210_pinctrl *pp, unsigned int p=
in)
> +{
> +       int width =3D hweight32(pp->mask_cfg);
> +
> +       return pp->base + pp->offset_cfg + 4 * (pin * width / 32);

Explain in a comment in the code exactly what is going on here, why 4*
why /32 why hweight32 etc. People can't parse this.

> +static unsigned int a210_padcfg_shift(struct a210_pinctrl *pp, unsigned =
int pin)
> +{
> +       int width =3D hweight32(pp->mask_cfg);
> +
> +       return width * (pin & (32 / width - 1));

Dito.

> +static void __iomem *a210_muxcfg(struct a210_pinctrl *pp, unsigned int p=
in)
> +{
> +       int width =3D hweight32(pp->mask_mux);
> +
> +       return pp->base + pp->offset_mux + 4 * (pin * width / 32);

Here is is fine to reference earlier explanation.


> +static unsigned int a210_muxcfg_shift(struct a210_pinctrl *pp, unsigned =
int pin)
> +{
> +       int width =3D hweight32(pp->mask_mux);
> +
> +       if (pp->type =3D=3D A210_PADCTRL_2)
> +               return 0;
> +
> +       return width * (pin & (32 / width - 1));

Here is is fine to reference earlier explanation.

> +enum a210_muxtype {
> +       A210_MUX_____,

I've seen this *______ stuff in other drivers, I guess it's something
with making things readable, just explain it to me please.

> +static const struct pinctrl_pin_desc a210_group0_pins[] =3D {
> +       A210_PAD(0, OSC_CLK_IN, ____, ____, ____, ____, ____, ____, ____,=
 ____, A210_PAD_NO_PADCFG),

I guess for this to mean "no pad here for this setting" or something.

> +static const u8 a210_drive_strength_in_ma[16] =3D {
> +       1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25,
> +};
> +
> +static int a210_drive_strength_from_ma(u32 arg)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(a210_drive_strength_in_ma); i++)
> +               if (arg =3D=3D a210_drive_strength_in_ma[i])
> +                       return i;

Don't you want some fuzzing here?

arg <=3D a210_drive_strength_in_ma[i]? So you get 5 if you list 4.

Default to 25 if > 25? Or no maybe that should indeed fail...

> +static int a210_padcfg_rmw(struct a210_pinctrl *pp, unsigned int pin, u3=
2 mask, u32 value)
> +{
> +       void __iomem *padcfg =3D a210_padcfg(pp, pin);
> +       unsigned int shift =3D a210_padcfg_shift(pp, pin);
> +       u32 tmp;
> +
> +       mask <<=3D shift;
> +       value <<=3D shift;

That's pretty straight forward and easy to read, thanks!

> +
> +       scoped_guard(raw_spinlock_irqsave, &pp->lock) {
> +               tmp =3D readl_relaxed(padcfg);
> +               tmp =3D (tmp & ~mask) | value;
> +               writel_relaxed(tmp, padcfg);
> +#ifdef CONFIG_PM_SLEEP
> +               pp->cfg_state[pin * hweight32(pp->mask_cfg) / 32].mask |=
=3D mask;

What's going on here and why? Add a comment explaining it.

> +static int a210_sdio_pinconf_get(struct a210_pinctrl *pp, unsigned int p=
in,
> +                                unsigned long *config)
> +{
> +       enum pin_config_param param =3D pinconf_to_config_param(*config);
> +       u32 value =3D readl_relaxed(a210_padcfg(pp, pin)) & A210_SDIO_BIA=
S;
> +
> +       switch (param) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +               if (value)
> +                       return -EINVAL;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +               if (value !=3D A210_SDIO_PULL_UP)
> +                       return -EINVAL;
> +               break;
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               if (value !=3D A210_SDIO_PULL_DOWN)
> +                       return -EINVAL;
> +               break;
> +       default:
> +               return -ENOTSUPP;
> +       }
> +
> +       *config =3D pinconf_to_config_packed(param, param !=3D PIN_CONFIG=
_BIAS_DISABLE);

Explain why *config is set like this in a comment.

> +static int a210_sdio_pinconf_set(struct a210_pinctrl *pp, unsigned int p=
in,
> +                                unsigned long *configs, unsigned int num=
_configs)

This is pretty straight forward to read though.

> +static int a210_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pi=
n, unsigned long *config)

So is this.

Review cut short due to time problems, will review next version!

Yours,
Linus Walleij
