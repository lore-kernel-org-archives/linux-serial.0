Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685587;
	b=eVMIDDSwPf+NJeDIIJSaE23lRX/Tq97wdWsYdzCSh9HjFQBgfH6vndhI1VZB92qtMZvm
	 DRjAYOaAgt8+Pd87iLqJ3jrdO0HyDG6bzQiWfWxq2/UkVKUJ8gY8/kzBjTuMVf7wUXz6u
	 fhNW01kNV1+OdAeJ4Wo4Rs9ppy7DQYUE0v9T/Jk4Y1BAlZby6UGWXbBMmPiBWCHtYgN0b
	 sT5WWB9XAxiXbqs5t9ESm0jwMLxoyZoxM+Gq3iUTsASNSeD/BjXPwsInGHAsvJFxxBRRf
	 VCOgtW9h913OC5rSP4HitoCYLzdqTvP0GRk672nrZSg2zM7MAWMTcB76vGz1hLdlwrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6VnMjKMpiGmEsV8NW8gW+gz8xbXvE1RU25n4brd4kQ4=;
	b=lKqyCtIdlViG0LmmH9lRwgNJz3BtMfo7B7t4q/gARapwF50VN4Po7ETdY/bMLP4fVB1g
	 n94S5sLrgKhdj3TIjDl1YeFSCY9DhbHRpWA1Z7qi/FfOhn/nPOIBj2/HfZIOf6s3HRdu5
	 SU8xegheCzTJ0GDa0fb8BlYsP2V7qgfOg0WoN/T19sF+QnajKMb7qYi0tLVwG0gbknzp0
	 W++hH9jBZatTfOo/850DwGG+gkNWYTxAE+HDE41ujVmUcx1yWOXTxy4yqNQ7tWJFcV8yN
	 0ZZOa4z1APNI/vC82rur2VA2RK5FloL/s+2zARmR9FGgOO82LyVsnH6aGR5OLqiJt4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abW1Dmhq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81432606A32A;
	Thu, 22 Oct 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abW1Dmhq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3BE1F031E0;
	Thu, 22 Oct 2026 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685587;
	bh=6VnMjKMpiGmEsV8NW8gW+gz8xbXvE1RU25n4brd4kQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abW1Dmhq2xsBULwQDhBd1LdemPxkwVrgHelPVvVRGy5ySZR7J8nSQF6ueI1q1Rl/d
	 1GCxiSK06osVl5hmzZM7c+2uJxmzpU0Zm2rnvutG2doRP5MykbjPGBWCUZbxzPFsM7
	 ebyeaCM91yqvb75d1NmFUWPDMa98dV9RlqJNt1SqRlQt9wwKMrrL5494tb2UpsxA2w
	 H85IFbgjtheCvoIB/c2HrxYCujNbjkh5lDXLss1Jer1hgDbT+22ZXoUq2JDPsm51D5
	 LVKldllN1otU4dV61eqP4tcSjuU2Y7ukb5F/j/t/2ArCQocPnMhe29slwUx5HjVr3N
	 0lMT9E1r3QQ/w==
Message-ID: <sashiko-outbox-181773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/27] gpio: rockchip: Add RK3572 GPIO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-9-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-9-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] gpio: rockchip: inverted factor of 2 in rockchip_gpio_set_deboun=
ce()
--

commit 779e47c3ede057555631e4f8433e01c234d3e7e3
Author: Cunhao Lu <1579567540@qq.com>

gpio: rockchip: Add RK3572 GPIO support

This commit adds support for the rk3572 gpio controller (version 2.7),
including handling four parent interrupts per bank and querying firmware
for interrupt-group pin masks via smccc.

> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 77b239a9a601e..35894a68b5446 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c

[ ... ]

> @@ -209,12 +212,27 @@ static int rockchip_gpio_set_debounce(struct gpio_c=
hip *gc,
>  	if (bank->gpio_type =3D=3D GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
>  		div_debounce_support =3D true;
>  		freq =3D clk_get_rate(bank->db_clk);
> -		max_debounce =3D (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
> -		if (debounce > max_debounce)
> -			return -EINVAL;
> =20
> -		div =3D debounce * freq;
> -		div_reg =3D DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
> +		if (of_device_is_compatible(bank->of_node, "rockchip,rk3572-gpio-bank"=
)) {
> +			if (!freq)
> +				return -EINVAL;
> +
> +			div =3D (u64)(GENMASK(23, 0) + 1) * USEC_PER_SEC;
> +			max_debounce =3D div_u64(div, 2 * freq);
> +			if (debounce > max_debounce)
> +				return -EINVAL;
> +
> +			div =3D (u64)debounce * freq * 2;
> +			div_reg =3D DIV_ROUND_CLOSEST_ULL(div, USEC_PER_SEC);
> +			div_reg =3D div_reg ? div_reg - 1 : 0;
> +		} else {
> +			max_debounce =3D (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
> +			if (debounce > max_debounce)
> +				return -EINVAL;
> +
> +			div =3D debounce * freq;
> +			div_reg =3D DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
> +		}

[Severity: Medium]
Is the factor of 2 inverted in the new "rockchip,rk3572-gpio-bank" branch of
rockchip_gpio_set_debounce()?

In the existing v2 debounce calculation in the else branch, each step of the
24-bit debounce clock divider divides db_clk by 2 * (div_reg + 1), giving a
period of 2 * (div_reg + 1) / freq seconds:

	max_debounce =3D (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
	...
	div =3D debounce * freq;
	div_reg =3D DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;

In the new branch for "rockchip,rk3572-gpio-bank", max_debounce divides by
2 * freq instead of multiplying by 2 (making max_debounce 4x smaller), and
div_reg multiplies debounce * freq by 2 instead of dividing by
2 * USEC_PER_SEC (making the programmed divider 4x larger, which can also
truncate the 24-bit divider for larger debounce values and implies a
half-cycle resolution of 1 / (2 * freq) at div_reg =3D=3D 0). The commit me=
ssage
also does not mention a different hardware debounce divider formula for this
variant.

Note that in the existing else branch, the reason div_reg underflows when
db_clk is slow (such as 32.768 kHz) is that rockchip_gpio_set_config() pass=
es
true (1 us) as the debounce argument:

drivers/gpio/gpio-rockchip.c:rockchip_gpio_set_config() {
	switch (param) {
	case PIN_CONFIG_INPUT_DEBOUNCE:
		rockchip_gpio_set_debounce(gc, offset, true);

causing DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) to evaluate to 0 before
subtracting 1 (while (GENMASK(23, 0) + 1) * 2 * 1000000 also overflows a
32-bit unsigned long, and the register update below in
rockchip_gpio_set_debounce() uses raw readl() and writel() on
reg->dbclk_div_con instead of rockchip_gpio_readl() and
rockchip_gpio_writel()).

Should the 64-bit calculation and the div_reg ? div_reg - 1 : 0 clamp keep
the non-inverted 2 * (div_reg + 1) divider formula?

>  	} else {
>  		div_debounce_support =3D false;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D9
