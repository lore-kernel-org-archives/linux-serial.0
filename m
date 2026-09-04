Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E121CA13;
	Fri,  4 Sep 2026 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504900; cv=none; b=jfgPsVMsNBL8Q1aIdBrl9fx6XdEp4ahBuUh/FctUJBnIiVMivRi7wJMEbGPdJiUi4nVHCF6IJQ/FhJFpDM2KLJ3cFHpTtWUmx6KWvVeJjmschPPp3cVx+tDWrFFxPiXLS6At9YVDU0uopKBQUfzVUT/4cZpdHHJ4S2pbH3h852M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504900; c=relaxed/simple;
	bh=Fgii7qFdaP5Z0L0em1noBtqT5ilUODRMwhDcfspneNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bygmwYuZNT+B4R2jBDCV/wvYTruGEr2uzvaw0rqiHKMGUBPtokd9IG5iu5qarmXheFvanGFCnRs+oy7rl1nh0EvaaW9ephD6rGGl61Wu/lwwmqGR0Qpr6SyqH0ucGsaG2ZhhgFXEPSLQX/hMRWyGRbJ2Wxc7aGSZrgDV6+92Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdgEPhan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdgEPhan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4542C1F00A3D;
	Fri,  4 Sep 2026 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504898;
	bh=iMHxqkpjsS/A0vccs1r3ClbkMOgxNajW+ln+ZwA9Yx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZdgEPhan+Mhao6La9RQ1FP58lfNEwIUL9HqOo4Dn0GWQaNcFuppSRfgWQ7TczmLg5
	 dJJCf1kZejeO3PTOsYatMU6fDtiepwBk6K0OCl9j4d0gMtIU96Y5HUk6uVHa8NDVYW
	 g2S2JSn4260QG+iaNRrgsfzUKiSrGkZcBK97lhTHHNWPbT9P2BsawhW9828173ZXQt
	 mxl+mDZ8KfMpbX/HuYmZUTWlb56BzbfVQUw5x9kuXDMWD/uzQb8PSb8pJJ1ibPanjH
	 7XAA7Y205FQeeMZNa94Q0pcgzRpj4Z4gTbm6++1J+KdvkCKE5imzmOBjEDRY/aNLyj
	 myO4hUh7YNV5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] gpio: regmap: support write_data_after_dir and
 girq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-8-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:54:57 +0000
Message-Id: <20260904065458.4542C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditional assignment to the conditionally compiled struct memb=
er `chip->irq` causes a build failure when `CONFIG_GPIOLIB_IRQCHIP` is disa=
bled.
- [High] The return value of the newly added `gpio_regmap_set()` call is ig=
nored, silently dropping I/O errors.

Pre-existing issues:
- [High] Hardcoded calls to `gpio_regmap_set()` in `gpio_regmap_direction_o=
utput()` break hardware that uses a separate `reg_clr_base`.
- [High] Missing `regmap_del_irq_chip()` in the error path of `gpio_regmap_=
register()` leads to a resource leak and potential Use-After-Free of the re=
gmap.
--

commit 52a1a780fb0893e26861b516090b05377ddeade2
Author: Long Zhao <longzhao@ambarella.com>
Subject: gpio: regmap: support write_data_after_dir and girq

Add an optional write-after-direction-output quirk for controllers that ign=
ore
data-register writes while a line is still configured as input. Also allow
drivers to pass an existing gpio_irq_chip through gpio_regmap_register().

> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 51b4d69b87403..b4b492a1765c4 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
[ ... ]
> @@ -273,7 +274,15 @@ static int gpio_regmap_direction_output(struct gpio_=
chip *chip,
> =20
>  	gpio_regmap_set(chip, offset, value);
> =20
> -	return gpio_regmap_set_direction(chip, offset, true);
> +	ret =3D gpio_regmap_set_direction(chip, offset, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Some controllers ignore data writes while the line is still an input=
. */
> +	if (gpio->write_data_after_dir)
> +		gpio_regmap_set(chip, offset, value);

[Severity: High]
This is a pre-existing issue, but this duplicates the hardcoded call to
gpio_regmap_set() instead of using chip->set(). Because hardware with a
separate reg_clr_base expects gpio_regmap_set_with_clear(), calling
gpio_regmap_set() directly fails to clear bits when configuring the line as=
 an
output with an initial value of 0.

Could this be updated to use chip->set(chip, offset, value) so that
controllers using reg_clr_base will function correctly?

[Severity: High]
Does this newly added call drop potential regmap I/O errors?

gpio_regmap_set() returns an int to indicate success or failure, but the
return value here is ignored, which could silently drop hardware communicat=
ion
failures.

> +
> +	return 0;
>  }
> =20
>  void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
[ ... ]
> @@ -390,6 +409,9 @@ struct gpio_regmap *gpio_regmap_register(const struct=
 gpio_regmap_config *config
>  	if (!gpio->reg_mask_xlate)
>  		gpio->reg_mask_xlate =3D gpio_regmap_simple_xlate;
> =20
> +	if (config->girq)
> +		chip->irq =3D *config->girq;
> +

[Severity: High]
Can this assignment cause a build failure?

The irq member of struct gpio_chip is conditionally compiled based on
CONFIG_GPIOLIB_IRQCHIP:

include/linux/gpio/driver.h:
#ifdef CONFIG_GPIOLIB_IRQCHIP
    ...
    struct gpio_irq_chip irq;
#endif

If CONFIG_GPIO_REGMAP is enabled but CONFIG_GPIOLIB_IRQCHIP is disabled, th=
is
unconditional assignment will fail to compile. Should this be wrapped in an
#ifdef guard?

[Severity: High]
This is a pre-existing issue, but does the error path in this function leak
the regmap IRQ chip and thread?

Later in gpio_regmap_register(), if gpiochip_irqchip_add_domain() fails:

    if (irq_domain) {
        ret =3D gpiochip_irqchip_add_domain(chip, irq_domain);
        if (ret)
            goto err_remove_gpiochip;
    }

The code jumps to err_remove_gpiochip, which does not call
regmap_del_irq_chip(). This leaves the IRQ thread active and referencing a
regmap that will soon be freed, potentially causing a use-after-free.

>  	ret =3D gpiochip_add_data(chip, gpio);
>  	if (ret < 0)
>  		goto err_free_bitmap_output;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D8
