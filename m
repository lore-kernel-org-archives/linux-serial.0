Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDBC493648;
	Thu,  1 Oct 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859336; cv=none; b=WgIc9cJhHpzIMoEgg3V8AmKqBlvkvuQhInG/hB8y2x+mS23SwS2h9K2TQfLFpd5DFX9H7AU1BrQF1GgHfBplnH8NcdE19zBRkC6GuxJipMfgAEtMl30M7MRXFOvz0LvgeM2vJzfOZR8kD0MpCVemkbOq7tsKYPms2wWObI9j7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859336; c=relaxed/simple;
	bh=o5JKjLjTsTVT6IJH0VVCken8M/g9qZ+pbetUHT/F8PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIaorZPiZ3ZIdJm49OqiHQfc2qxkSehxf7OPbZmYxExMKJQShpN8NSQZUE4Ozc4armenq2LgvJ8i5Mv4HVmlYJaHOXDwyvDYHSNOs9a44SFm8rSJb+9imq4av7zunKzx4ReergopkHVEO10qdGQZfIp+T0+eLhExbww5omKJuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9+waxcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9+waxcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01BA1F000FF;
	Thu,  1 Oct 2026 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859335;
	bh=btn/N0JDwap4s2cW5sFQ1L4RQBJ7RKG8OfKE0MGyaRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9+waxcEfFzOby5W4m9g61S//vITdOkZVYP7EdVPUpugfz0mSYQiSFsYe0QLIUnP1
	 Piu21vnsQaK8Ugev+3/NSvinFUfziYYT+SjozwL8GnIZzgvQJSyasUlCzC0z4UlRCF
	 rIaoVun22kVo0oTzmFkDWZ8S/dHjhKFMyrLK0pzyXf/E/vVf6DCLhCPtVSAbyulefZ
	 Mi/P74e5+tWiPrBL0WjrEAeiI8X3NYvLw80FdpnFAXJTKgzkn9u+C1g0k/d6hjNHuv
	 2x6raarKtNAM6LkSNGMNUwAtzlv8sM2SZMdfkq0WmiBuYfV0QiWBY3nedmGB4BnjAy
	 6JvVi+AvlioIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/15] gpio: pl061: add Ambarella register-layout
 variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: conor+dt@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-12-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-12-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:55:34 +0000
Message-Id: <20261001125534.D01BA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpio: pl061: output state corruption via RMW on Ambarella data reg=
ister
--

commit b4f961be1d109a1753acf06716b7c68488ad35bd
Author: Long Zhao <longzhao@ambarella.com>

    gpio: pl061: add Ambarella register-layout variant
   =20
    Add a 32-bit, 32-line layout with DAT/DIR/IS/IBE/IEV/IE/MIS/IC plus
    MASK and ENABLE. Probe unmasks the bank and enables the controller.
    IRQ type changes also clear the pending bit. This derivative does not
    need write-after-direction or system suspend save/restore.

> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 08d45f8923c2a..bbb9eeeb074aa 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c

[ ... ]

> @@ -318,6 +330,18 @@ static bool pl061_arm_volatile_reg(struct device *de=
v, unsigned int reg)
>  	}
>  }
> =20
> +static bool pl061_ambarella_volatile_reg(struct device *dev, unsigned in=
t reg)
> +{
> +	switch (reg) {
> +	case AMBARELLA_DAT:
> +	case AMBARELLA_MIS:
> +	case AMBARELLA_IC:
> +		return true;

[Severity: High]
Does marking AMBARELLA_DAT as volatile expose the driver to data corruption
during read-modify-write operations?

Because AMBARELLA_DAT is marked volatile and .cache_type is omitted below
in pl061_ambarella_regmap_config (defaulting to REGCACHE_NONE), RMW
operations on AMBARELLA_DAT (like via gpio_set_value) will bypass the cache.

Since this is a full 32-bit width register, a RMW operation reads the
physical state of all 32 pins and writes it back. This could overwrite the
output flip-flops of all other pins with their current physical state
instead of their driven values.

Unlike the ARM variant which leverages address-based masking to safely set
individual bits, it looks like Ambarella relies on a single 32-bit register
and would strictly require regmap caching (e.g., REGCACHE_FLAT) to perform
safe RMW operations.

> +	default:
> +		return false;
> +	}
> +}
> +
>  static const struct regmap_config pl061_arm_regmap_config =3D {
>  	.reg_bits =3D 16,
>  	.val_bits =3D 8,

[ ... ]

This is a pre-existing issue, but I noticed a potential interrupt storm due
to the incorrect hardware initialization order in pl061_probe():

drivers/gpio/gpio-pl061.c:pl061_probe() {
    ...
	if (regs->enable) {
		ret =3D regmap_write(pl061->regmap, regs->enable, ~0U);
		if (ret)
			return ret;
	}
	if (regs->mask) {
		ret =3D regmap_write(pl061->regmap, regs->mask, ~0U);
		if (ret)
			return ret;
	}

	/*
	 * irq_chip support
	 */
	regmap_write(pl061->regmap, regs->ie, 0); /* disable irqs */
    ...
}

[Severity: Medium]
Can this sequence trigger an interrupt storm that permanently disables the
parent IRQ line?

The hardware controller is unmasked and enabled globally (via regs->enable
and regs->mask) before its local interrupts are masked (regs->ie =3D 0). If
the bootloader or kexec leaves the device with pending interrupts and IE
set, enabling the controller immediately asserts the IRQ line before the
driver has registered the chained handler.


This is also a pre-existing issue, but I noticed a potential use-after-free
of the irq_domain on driver teardown in pl061_probe():

drivers/gpio/gpio-pl061.c:pl061_probe() {
    ...
	gpio_regmap =3D devm_gpio_regmap_register(dev, &config);
	if (IS_ERR(gpio_regmap)) {
    ...

	if (irq) {
		ret =3D devm_add_action_or_reset(dev, pl061_remove_irq, pl061);
		if (ret)
			return ret;

		irq_set_chained_handler_and_data(irq, pl061_irq_handler, pl061);
	}
    ...
}

[Severity: High]
Does registering the IRQ teardown action after registering the gpio_regmap
cause a use-after-free?

During driver unbind or probe failure, devm actions execute in LIFO order.
Because devm_add_action_or_reset(dev, pl061_remove_irq) is called after
devm_gpio_regmap_register(), the pl061_remove_irq action executes first and
frees pl061->irq_domain.

Subsequently, devm_gpio_regmap_unregister calls gpiochip_remove(), which
iterates over active IRQs and calls gpiod_to_irq(), dereferencing the
already-freed domain. This could be reached by holding a GPIO line event FD
open from userspace while unbinding the driver via sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D12
