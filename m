Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAC338F40
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625457; cv=none; b=kFvFHo4WbK4gLppTyWwHW1LO1D275wW4vrlIO6Z2AdsTpLn7ZsEKMA87Vh+/2HST1ng13HkNG/TV5ox3EFsN9M6Ev9+fFlbrCdFQ5lhylteEL12JPWddkJPA9SgjdFJZvE4hSfCueO/jJY6eCJuZ6b2T9LTyixmJpHRucXc6zFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625457; c=relaxed/simple;
	bh=FNw601tSkcAEuhJUw9W236YO6iyb0UxKEFxOZOtylLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+YhQxX0VNNVly+Hcs1uri0HPhSq+9HdaaLknSh5/oXbH9bxjJv33l/AcL591mKZwzVTidqQhwmuCA+fxgA4dlWzg1OESPoCEGw6y2gmnnKJkPGN65zEpRrpFjbCY1iEVp9OAoxe1JKwUzJ+WfHgvUl3poR278fQcRM7EXek+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh7nhnZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh7nhnZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B6BC116D0
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760625456;
	bh=FNw601tSkcAEuhJUw9W236YO6iyb0UxKEFxOZOtylLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uh7nhnZThtfuYDbqCJNVXtGoMKVVRH0v/YgriYUU+5fp/LYUM0M1AjClXInk9pi4A
	 pl3t3r3tPDp0/TdYt9tW90RuuOrblPNQxauqznc2YDPxFYuTsQoz69HAT5v/PG7l0f
	 dFWyz7Cm/O1J49O/HMC2gJm2i1C4SBcLQ3QVbWnxRau7GgwO69NwoDdm+whMTfvJ5K
	 jNHDzKpMGO+fYCXHJMvAdlbinL/4ZCLbZAERtCrcV2Z2hgwd+8gnLrUZd/K9StTubo
	 I3usEmCzp9ywAOHiz7xHZt9Nomtc+o30bfKaDa79ZmNyvamrSWE3Es5dXHo639vKP8
	 OCrKcG9Iwj3fg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso145720466b.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 07:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf5kDC0ATI3sjvsH3LqzCXStdKzqMnVOG3TOvK+CWjgQAbgq6Aes+0cHdeE+b/BT8X5FNAYJOKttBlp+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbWYdouwk8mBN4hPqLo+6OKJL9R0sUsg5ya3C4ri9aEMEcbmt
	k2wUYy0jY6YBUBkEGWQvyRlEHSQrk3V4w6BjoDL4IXLdQs8jGWFLf67FFs6tFUw1d/rkSnr9uX4
	i0li7t8mVHO+B3hvRz5YoTAUXK9fp7ys=
X-Google-Smtp-Source: AGHT+IG0ywE38qe1ENDXS6u3JHDGPjzDQZZLkGyNDcryofRnJQz0Z8bE0XrELkisaxKu7avDW61HeGooFtWv8Wlr0SU=
X-Received: by 2002:a17:907:984:b0:b47:c1d9:51c9 with SMTP id
 a640c23a62f3a-b6475010821mr14267266b.62.1760625455371; Thu, 16 Oct 2025
 07:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760166651.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1760166651.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 16 Oct 2025 22:37:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4P4DjVdqyg-oUA-7O-gX0Lk2tC5cdLoLHRO9oo504Okg@mail.gmail.com>
X-Gm-Features: AS18NWA5nrSHoDhQ7jzXQbNtsaFQ5Csb6rapQyMX80yExJetCx1NRkg22Y3c-nw
Message-ID: <CAAhV-H4P4DjVdqyg-oUA-7O-gX0Lk2tC5cdLoLHRO9oo504Okg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] uart: Introduce uart driver for the Loongson family
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Sat, Oct 11, 2025 at 3:17=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> For various reasons, I will be taking over from Haowei and continuing to
> push forward with this patch set. Thanks to Haowei for his efforts so
> far.
>
> This patchset introduce a generic UART framework driver for Loongson fami=
ly.
> It can be found on Loongson3 series cpus, Loongson-2K series cpus and Loo=
ngson
> LS7A bridge chips.
>
> Thanks.
>
> ------
> V6:
> Patch-1:
>  - Add Conor's Acked-by tag, thanks.
>
> Patch-2:
>  - Add more missing #include;
>  - Convert mcr_invert/msr_invert from int to u8;
>  - Split serial_fixup() on a preceding line;
>  - Add macro definition to avoid magic numbers, such as
>    LOONGSON_QUOT_FRAC_MASK;
>  - Rework the relevant data structures, where `loongson_uart_ddata`
>    represents the Soc's driver_data;
>  - Drop `PORT_LOONGSON` and use PORT_16550A instead.
>  - devm_platform_get_and_ioremap_resource() instead of platform_get_resou=
rce();
>  - Use uart_read_port_properties() and parse the clock attributes;
>  - Use switch-case instead of if-else in serial_fixup().
>
> Link to V5:
> https://lore.kernel.org/all/cover.1758676290.git.zhoubinbin@loongson.cn/
>
> V5:
> Patch-1:
>  - Since the Loongson UART is NS8250A-compatible, simply add ls2k* compat=
ible to 8250.yaml.
>
> DTS{i} tested by `make dtbs_check W=3D1`
>
> Link to V4:
> https://lore.kernel.org/all/cover.1757318368.git.zhoubinbin@loongson.cn/
>
> V4:
> Patch-1:
>   - Rename binding name from loongson,uart.yaml to
>     loongson,ls2k0500-uart.yaml;
>   - Drop ls7a compatible;
>   - According to the manual, ls3a and ls2k uart are the same, so merge th=
eir
>     compatible.
>
> Patch-2:
>   - Format code;
>   - Add the LOONGSON_UART_DLF macro definition to avoid magic numbers;
>   - Simplify the code, merge flags and quirks, and remove struct
>     loongson_uart_config;
>   - Use DEFINE_SIMPLE_DEV_PM_OPS;
>   - Drop loongson,ls7a-uart compatible.
>
> Patch-3:
>   - Add ls2k* compatible string, and ns16550a as the fallback
>     compatible.
>
> Link to V3:
> https://lore.kernel.org/all/20240826024705.55474-1-zhenghaowei@loongson.c=
n/
>
> Binbin Zhou (3):
>   dt-bindings: serial: 8250: Add Loongson uart compatible
>   serial: 8250: Add Loongson uart driver support
>   LoongArch: dts: Add uart new compatible string
>
>  .../devicetree/bindings/serial/8250.yaml      |  14 ++
>  arch/loongarch/boot/dts/loongson-2k0500.dtsi  |   2 +-
>  arch/loongarch/boot/dts/loongson-2k1000.dtsi  |   2 +-
>  arch/loongarch/boot/dts/loongson-2k2000.dtsi  |   2 +-
>  drivers/tty/serial/8250/8250_loongson.c       | 238 ++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig               |  10 +
>  drivers/tty/serial/8250/Makefile              |   1 +
>  7 files changed, 266 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/tty/serial/8250/8250_loongson.c
>
>
> base-commit: 0d97f2067c166eb495771fede9f7b73999c67f66
> --
> 2.47.3
>
