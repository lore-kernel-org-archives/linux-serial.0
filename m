Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7F338910
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124725; cv=none; b=QlGBPgqCQ9XAuAb3kKWFxK7PYVKL9Mggdhtn6/578bMI51quWrDLGa98pqo1AHwuydVBoOBqYjTcyQlyJiPVGiij1IV4TGSNEy7byEnu4wkdX32eM9xGkMymHe89nEAAyKL8l+DHWRcvObVKHTvDJHhVrfqwNtbnuG9M5+vYxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124725; c=relaxed/simple;
	bh=K9y7+qgOIUgusqqnv2A0lIuXRIzhe19SOiZ/1cedtZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4P3zyfO5KaHLy9OQDvnZGke9j0QhaEPs9vrtJIDV3LeYsxWg9qKb02stEpshIaThZtQJfdXTve9av6oJFO89DMedZEvESfmEryUbC0VPXoEAJ0kRDOONvBaGTA1ZwuF7uWoKk0mf0r5GCpUL5MwqZsVDnQJrBVuN715h44zWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9mdM+J7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9mdM+J7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376DA1F0155A
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786124724;
	bh=OyhnxF+idjJakv4GGlOu6M8jr1I7wPOlS/SALR3zs0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f9mdM+J7MWS3rxSYZmb8Ntb5HpemFgXBtzrgLvmiufo0fNS13aqkWAPZ/knkrIyXR
	 VIny+XIoazS+Wtlhe/qDN6VtJgJROhVR4kWZM9DDwccMVdxHfWIuNctzbIvZIW5owQ
	 ksjRvnBLj5RBVbW3Lxo5sPVNpuguMjCSupqMwORjLSoUzcdGMHFnlCk0W7rpY2B1IB
	 s6YVhjxVhd+YSBeTJE+0ZYBwCHJhhM5OgfGi8tsnQGdwrcihn6zWLEwnqn0TqYP0JH
	 3vc12AuTC3vdzXcFEKGtfsAaCxGcMlA0Yi03Tdfi1h/PLp3ezXgUtxq3Ryl+c40f77
	 NyerY3Z8luhwA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aebd52488cso4160920e87.2
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 10:45:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpvkHqq8WPuRL1d2uFQiZ1GObyrN4RlvPn0Mn4tN4WY859lITUqJGUyIJUvQ5xSoNTrfVyS8TGqukfhSds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqCULWU2pSnpI5Glg2dm522bCDS7ZEc6P3YTD5LhOLPK7oc1t
	Fev3HawzkxjZ1PhrH4QOQm8PE5rdxj9UKrrUZXSqojZVCDnabDHWO1hjRjuxWusTU9EDHkayatL
	YAkywqQy8zY75MH/+TitO7bl/1rciYXA=
X-Received: by 2002:ac2:515b:0:b0:5b2:a483:a367 with SMTP id
 2adb3069b0e04-5b2f4cbfd35mr2719806e87.40.1786124722892; Fri, 07 Aug 2026
 10:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-7-6b09707c5fe9@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-7-6b09707c5fe9@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 19:45:10 +0200
X-Gmail-Original-Message-ID: <CAD++jLk0LoOJk=TXin42AL3_z_7eVVkvMnYr1S8090C6A_B+dQ@mail.gmail.com>
X-Gm-Features: AUfX_mz4THtJsHukdTGhBJPWk-nL3TQtLhDW7VNIYAXq_FOwFa7WqkqY6sFI5Ns
Message-ID: <CAD++jLk0LoOJk=TXin42AL3_z_7eVVkvMnYr1S8090C6A_B+dQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: ambarella: add Ambarella pin controller
To: longzhao@ambarella.com, Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Long,

thanks for your patch!

On Thu, Aug 6, 2026 at 11:34=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> +#define GPIO_DATA_OFFSET               0x00
> +#define GPIO_DIR_OFFSET                        0x04
> +#define GPIO_IS_OFFSET                 0x08
> +#define GPIO_IBE_OFFSET                        0x0c
> +#define GPIO_IEV_OFFSET                        0x10
> +#define GPIO_IE_OFFSET                 0x14
> +#define GPIO_AFSEL_OFFSET              0x18
> +#define GPIO_RIS_OFFSET                        0x1c
> +#define GPIO_MIS_OFFSET                        0x20
> +#define GPIO_IC_OFFSET                 0x24
> +#define GPIO_MASK_OFFSET               0x28
> +#define GPIO_ENABLE_OFFSET             0x2c

As everyone can see from a mile away this is a modified ARM PL061
primecell, see drivers/gpio/gpio-pl061.c.

I'm not very interested in having two drivers for pretty much the same
hardware in the kernel. Odds are that there will be new quirks and fixed
to one of the drivers that the other one doesn't get :/
Also the PL061 driver is pretty complex and specialized as GPIO
drivers go already. I certainly don't want to have a second copy
of that.

We need to find a way to re-use the PL061 driver with this pin
controller.

1. Modify the existing PL061 driver to use a dynamic register
  layout, i.e. make the different register locations part of some
  per-variant data:

struct vendor_data {
    u32 data_offset;
    u32 dir_offset;
...
};

Add:

struct pl061 {
    struct vendor_data *variant;
...
};

Add vendor data to the PL061 variant:

static struct vendor_data vendor_arm =3D {...};

static struct vendor_data vendor_ambarella =3D {...};

static const struct amba_id pl061_ids[] =3D {
        {
                .id     =3D 0x00041061,
                .mask   =3D 0x000fffff,
                . data =3D &vendor_arm;
        },
        {
               .id =3D /* make something up, see include/linux/amba/bus.h *=
/
               .mask =3D ....
               .data =3D &vendor_ambarella;
        },


Essentially follow the pattern from drivers/spi/spi-pl022.c.

2. Contemplate if the GPIO should be a separate entity in the
 device tree or not. If not, Linux needs to spawn the new AMBA
 device with this pin control driver using e.g.
 amba_device_alloc() and amba_device_register() etc,
 see drivers/of/platform.c

3. select GPIO_PL061 in Kconfig for this pin controller...

This is not a simple solution but it is the right one.

Yours,
Linus Walleij
