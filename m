Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E172F12C8
	for <linux-serial@vger.kernel.org>; Fri, 31 Oct 2025 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878178; cv=none; b=e6LMUvV/i9T7k94TgKHIZjsrFk4VNkrP3+yPyWYoE/U22RgsxjAINiCSuDbIDZniO++t5hVpWFVShG7V1llz9lsiKbM5si9c2v7jWg0wY5V/ytEGjKdXWaPEoT3Km0LporyDhRcspVvuJ2ACMqjT1E+DvRTv8tP23I+w0MJN4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878178; c=relaxed/simple;
	bh=lSACWfI3S8dhYvaK8l/2vpCI4pZHQwmLaguJg4fzQpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCTckMq5+1T2xaf7aDuHyLIqF3/6kpv575ZQg76GfEAbmbnWARwxYLzen2IIEDhXztknmf0MkJReVmUtsXNx5qrD7aXh+hBNsCbBQD/JE+9m52WhD3nLJQSGZWIreXWAbZiemzsPT1dbgyI2KJ3trG6IHK00BguUX5Pt4p8WqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb0svkBj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb0svkBj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d5b756284so440494966b.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761878172; x=1762482972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8trR7+AtP7mv9r/Um2GS1F57AjZCSL0ikSu0/0WyT8=;
        b=kb0svkBjDt5HYrYoHK7PMT/uf5c96sflWjD9Z0ZzP/XQbS4nsgYGunODMeJK16Fp7Y
         WbrFYOF5AUtixWEkCa0cEfPTmZ/9vc+a8v3JmbtAt8tF4u+JhaWjMAyH+zsj4ZouLXlE
         PghtTsIQALQ9x3usHjBZGTGRpy0hmQ7UxOHhUHVf3U2CltCeIlx84hyfSM71weFLwUf0
         poDu9dZuTMFl1YSuVS3bbZjEL3x9PugtX6+Yd+wa+FjpIY/Mexp+fu5iKTkQU4xrM1dz
         Y+1o+pUIX3FStiQsJxud6EeqN8Z+wAMqUB0tEqWaZ615aVJOrXe/a/TyTrkjvKKDFQoO
         Q4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878172; x=1762482972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8trR7+AtP7mv9r/Um2GS1F57AjZCSL0ikSu0/0WyT8=;
        b=TLnFbnvRBaDGzkp78EMvwFQb9NeOr7KdAWen7IP6SvIAIioUIqtxxXqD3weU6GiYKQ
         8w/1Ktusr216HxhU8G/eV6oZmPAwnyjCbku+xLkuYXGUvlQjKgJxkxhHGry9P+uY5Iwg
         Ey4rgAc7XwMrWDG2tOWV/Gt8a+WPmym8dHmpe+kzrp2IChallddEj9ryvLxJYXRNkgR+
         F1BnNkyBk55a5iXH3HX/Djiegri8+gmecz0o1RuyrYIg+E3oMa+fp9CRI2cfJ7fbM4dp
         uJiaIGJr9scgT+/5udgGCFwdi2pqtn4EpfiGGZzmxc4TZ7xb6Y6zAD0LPBK2oBmgnOuE
         rR7g==
X-Forwarded-Encrypted: i=1; AJvYcCVTZDSBmJPjssIItFc9AI4wHudbLeyGwnUS2dvpUd33s1wZDQ2Fds1KMYi7PsHW0mDgLk9fJnzwhErvX1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXECMqzKZl7wWHT4a9fUrNlXV5pd6bp1VN9qLI73SmgmCyLDc
	BQwqRcVP3H1vIURbnlUnOdGNKjs9KlHW0B4nZkTkpcotu0aVFa6Dl8BYuCyYqH/2gsslZUfjNR6
	7zFwtyRk2ECdx3bJgN+VQ9qE+WEJt4enpsbklu8E=
X-Gm-Gg: ASbGncsGW9Xn/h7Pfj7UT4OhsCP26NpDKmbXz9fXU0Z7KfCuhvFeXYX+mvWnNAYzhPO
	iFzKB22V4qi4kS+eyIeIqpyqXJFn3kYFy/0aX+BDyX8ZaTko/4g4KHoUfxf+Dpk3Ak3BmJNBa4i
	KF6EG2lLkbLTA5LhMiXSw1V3q4T8j/RDZNwsQ1yy8NU/lesodMZi9EimUeeAt2uKnqsekDu3UqY
	KB9xY+mHQreiNl1NSMMJpstHCN6JHsl5KV4gzLm0v9ilX6r9e2XZJMTSn993f0=
X-Google-Smtp-Source: AGHT+IE+QLngqICAiEM+HUlJSvYq7nmL6/S09wht7nQiv3vb9PSNrUzcz3aNHw6Y3wMnN6BNrB7N6VhS5gFSPbGsAV0=
X-Received: by 2002:a17:907:1c0c:b0:b70:5aa6:1535 with SMTP id
 a640c23a62f3a-b7070137d1cmr210756466b.18.1761878172320; Thu, 30 Oct 2025
 19:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760166651.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1760166651.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 31 Oct 2025 10:36:00 +0800
X-Gm-Features: AWmQ_bltMKgxSSuK-0uSHoLq-bcM53GzFTfW7hnwT-5zIuS1qRI4O4sc53kyhU8
Message-ID: <CAMpQs4L4A5pPG0pAKiua_2q3rBQB3WETBjc8iG8mbz5U1tWR7g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] uart: Introduce uart driver for the Loongson family
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Hi all:

Gentle ping.
Any comments about this patchset ?

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

--
Thanks.
Binbin
