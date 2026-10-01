Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8023AEF56;
	Thu,  1 Oct 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859369; cv=none; b=VOP2NkMKIoHvOPEGXuWfsZU4p6M0QchS5lF+OcTBzPuIJi/Z3kUQ4Tv6nG5FL39j728ecDitsxwS/8+m4v9gCEUTII3J6A1mz+Xeb2hG54a07NnzGUnVC5LqiDbafJe/+7ZFkfcJF/KW0y9zpMG82P0H8Q+TYXX4Da6TlVkB4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859369; c=relaxed/simple;
	bh=lr8mhxzproW+Qgv7R7SpyFbt6jvUf0jjDsRWDMaQp7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsZUPNyhiGHZOpwtGvpm7nQacH+osTWhA0q6xQ3DRJR9hOZ9SKv4rwMPkGq277q7tV7n+BoFG22sO58lUKN40F/fIeFRy0f4p8yJqnVOXzvgHb4hdwTChyB0sdH2ZblMR4Gxp2jAQ5jKVTn+OjsfksaIQd/G6yqzdpT9NeR3VFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSh6vWIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSh6vWIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99071F000FF;
	Thu,  1 Oct 2026 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859367;
	bh=R8qJWUn2+S7UJPBG1ZhM/jt62L4jpx3jXiyLqBVTUMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSh6vWIouumpWK+f+14lEyjM7ZPbL/MGuSU4k3GDwd/Iim+4pfx86lodna9KP2L6U
	 YoKnYtTUAQ6vUMkmyxp7HWFEbU5CRbXwsM+9xEIES6F6C8jsPuQHQ8Y3HM5zXDBXVK
	 j/NEtS1IG66MJAo0sHzMZdh3Pr6qrS97IiminKGuFb16Gjw5pCdqwGzNXg2kqDkItV
	 lJQumbCHNwMSivTHV+huSnOh3gOB5JtauNFkzCQsQe5NOWZrO6hey7c5m0idNTDyjv
	 D6UuAZLSqOZbz1Ab0oD9sFixb0jOoXdGV2q19/jsWI/G10YkuDSBMxTI6aGp3u0jM+
	 lXm2IrABQ/xVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/15] gpio: pl061: switch data path to gpio-regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20261001-cv75-v5-v9-11-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-11-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:56:06 +0000
Message-Id: <20261001125606.D99071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gpio: pl061: UAF due to LIFO devres cleanup ordering
- [High] gpio: pl061: Missing GPIOCHIP_IRQ_RESOURCE_HELPERS allows HW confl=
ict
- [Medium] gpio: pl061: Missing synchronize_irq() causes UAF on module unlo=
ad
--

commit 0dd970f78f76a57be040a10722f95f7c065440ed
Author: Long Zhao <longzhao@ambarella.com>

gpio: pl061: switch data path to gpio-regmap

This commit migrates the PL061 driver to use gpio-regmap for its data path,
handling the PL061 quirk where output values must be written after a direct=
ion
change. It sets up a custom irqchip and domain attached via gpio-regmap, and
modifies the interrupt handler to appropriately check regmap reads.

> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index c821a5117eede..08d45f8923c2a 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
[ ... ]
> -static const struct irq_chip pl061_irq_chip =3D {
> +static const struct irq_chip pl061_irqchip =3D {
> +	.name			=3D "pl061",
>  	.irq_ack		=3D pl061_irq_ack,
>  	.irq_mask		=3D pl061_irq_mask,
>  	.irq_unmask		=3D pl061_irq_unmask,
> @@ -322,67 +256,187 @@ static const struct irq_chip pl061_irq_chip =3D {
>  	.irq_set_wake		=3D pl061_irq_set_wake,
>  	.irq_print_chip		=3D pl061_irq_print_chip,
>  	.flags			=3D IRQCHIP_IMMUTABLE,
> -	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> -};
> +};

[Severity: High]
Does the omission of GPIOCHIP_IRQ_RESOURCE_HELPERS from this irq_chip
definition detach it from gpiolib's resource locking?

Without these helpers, gpiochip_lock_as_irq() is never called when a pin
is requested as an IRQ, so GPIOD_FLAG_USED_AS_IRQ is not set. Could this
allow userspace to accidentally reconfigure an active IRQ pin as an output,
causing hardware conflicts?

> +
> +static int pl061_irq_domain_map(struct irq_domain *d, unsigned int virq,
[ ... ]
> +static void pl061_remove_irq(void *data)
> +{
> +	struct pl061 *pl061 =3D data;
> +
> +	irq_set_chained_handler_and_data(pl061->parent_irq, NULL, NULL);

[Severity: Medium]
Is a call to synchronize_irq() needed here before proceeding?

While the chained handler is cleared, there appears to be no synchronization
with in-flight handlers. If pl061_irq_handler() is running concurrently
on another CPU, it might still be executing when we proceed.

> +
> +	for (unsigned int i =3D 0; i < pl061->data->ngpio; i++) {
> +		unsigned int virq;
> +
> +		virq =3D irq_find_mapping(pl061->irq_domain, i);
> +		if (virq)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	irq_domain_remove(pl061->irq_domain);

[Severity: Medium]
If pl061_irq_handler() is still running, could it access this freed domain
when it calls generic_handle_domain_irq(pl061->irq_domain, offset)?

> +}
[ ... ]
> +static int pl061_probe(struct amba_device *adev, const struct amba_id *i=
d)
> +{
[ ... ]
> +	config.parent =3D dev;
> +	config.regmap =3D pl061->regmap;
> +	config.ngpio =3D data->ngpio;
> +	config.reg_dat_base =3D GPIO_REGMAP_ADDR(regs->dat);
> +	config.reg_set_base =3D GPIO_REGMAP_ADDR(regs->dat);
> +	config.reg_dir_out_base =3D GPIO_REGMAP_ADDR(regs->dir);
> +	config.reg_mask_xlate =3D data->reg_mask_xlate;
> +	config.quirks =3D data->quirks;
> +	config.irq_domain =3D pl061->irq_domain;
> +	config.drvdata =3D pl061;
> +
> +	gpio_regmap =3D devm_gpio_regmap_register(dev, &config);
> +	if (IS_ERR(gpio_regmap)) {
> +		if (pl061->irq_domain)
> +			irq_domain_remove(pl061->irq_domain);
> +		return PTR_ERR(gpio_regmap);
> +	}
> +
> +	if (irq) {
> +		ret =3D devm_add_action_or_reset(dev, pl061_remove_irq, pl061);

[Severity: High]
Can this devres action registration order cause a use-after-free during
driver unbind?

Since devm_add_action_or_reset() is called after devm_gpio_regmap_register(=
),
devres will execute pl061_remove_irq() first during teardown because it uses
LIFO ordering.

This means pl061_remove_irq() will run and free pl061->irq_domain, but
the gpiochip is still registered. When gpio_regmap subsequently unregisters
the gpiochip, gpiochip_remove() will eventually call
gpiochip_free_remaining_irqs(), which will attempt to use the already-freed
irq.domain pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D11
