Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC3FFABF
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763840; cv=none; b=irn06ixBKUK1tuCX9r6QJKDeEFStlrkfFYBNWaMM6PCRj5xF/gD9QkGgqj48eteFjkWz+55qipIu6OOMCOPW/fOu1y7+DC9GXwKaOS8nZtBWz0VFlzop3IN2WgD9SmQw1K5/I0s8xuiFV7OnGmP9FrA9bqlAUJ/PV5jSqtcTtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763840; c=relaxed/simple;
	bh=PKM5psEhq6HZ5b2AAFxUqLJNvawpGH5x1BpqHZLToaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkPL9vikCAeS0ER3NXPgvHm2JVOQDxFbHKFyO+EdZ+GtQHFiaTEJYUYTOPv7k3QepYnCPJFlEMSOJDyECRSPE5uMmhwGJrXN9bFpvodWrcBXtMdrTBIhV+bFKhr7WiIQIEDZ52UV4jG0sx0huv7cXZCISe0aTc9/FFpGUlpvlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvaDK8p6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvaDK8p6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1121F00898
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763838;
	bh=X75G81sRknseJqb68jFj/W+PfQkeYzrGsC87DcEgJZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nvaDK8p6Fwb00T8VTqDSVzM335/T+3Garv4vnlCFuNWWJNTg3aDnhVmT/GeODWZZS
	 YSUXpIvWE+4DlNr2E7C/fOCoS6LucXC4dHhsBY1nYWux5LIzJWDi3uQtGDpKLB5SrG
	 Kha8q0FNonI7i4zYyFP+tnnKUxfdK/RmhgRG59OvAGJSzFv/PN3kiR7Zo3bzoqsjHC
	 HzdncTSl535A1lkvhF5gEbdzvQLJVo6BItMh1Y81B31Ix5NcY2rro3XhIyvX2UbtJ3
	 YBD6gpTug34zF6hT8aF6/odEYkTGsbhCfLkk/Ccg3je8HYpjYblsjGKg+grv9FHpZ6
	 pa+0/62IOaVzg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba40cb7246so193967e87.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 03:23:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByD4w1MBgdGua/J3uyv0EWca9fWqW02uEEeWtUBeUASl717BjGp2QM9ZWYI0DPkCjb8GzPkAmzBglvq9Dg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSwBQnKh99/Jv2EsIdkBxx6CBazYoY1yY3lxxMYwYUROgFShR7
	u/CfD01BwlzvaIrB8WjKi9VdOH/iFMQnJovKGFe88nHr1RSv77EE2DAjE5lxo4MbD43XJ239dNo
	dsPKqExXF6mhcsZ7+bB7mDq7yPTB0y14=
X-Received: by 2002:a05:6512:2394:b0:5b8:d406:4705 with SMTP id
 2adb3069b0e04-5ba405f46f1mr361647e87.21.1790763837413; Wed, 30 Sep 2026
 03:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com> <20260930-b4-cs75xx-v1-5-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-5-4617c4463529@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 12:23:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLnCPMmpza8efzf6oud1C-DPj6yTkECcdg9A1uB90r+2Bg@mail.gmail.com>
X-Gm-Features: AclHuK9uEIgg0bTDrefSpGkScH54YNTqnVwftBwkG2jX_u5dFR_KcXW91K8sjhs
Message-ID: <CAD++jLnCPMmpza8efzf6oud1C-DPj6yTkECcdg9A1uB90r+2Bg@mail.gmail.com>
Subject: Re: [PATCH RFC 05/10] ARM: debug: Add Cortina Systems CS75xx UART0 support
To: filipp.dunsky@gmail.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Filipp,

thanks for your patch!

On Wed, Sep 30, 2026 at 9:00=E2=80=AFAM Fil Dunsky via B4 Relay
<devnull+filipp.dunsky.gmail.com@kernel.org> wrote:

> +++ b/arch/arm/include/debug/cs75xx.S
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Debugging macro include header for the Cortina Systems CS75xx UART
> + */
> +
> +#define CS75XX_UART_TXDAT              0x10
> +#define CS75XX_UART_INFO               0x18
> +#define CS75XX_UART_INFO_TX_FULL       (1 << 2)
> +#define CS75XX_UART_INFO_TX_EMPTY      (1 << 3)

I looked through the other serial drivers but this appears to actually
be unique and
not derived from some other serial port, so:

Reviewed-by: Linus Walleij <linusw@kernel.org>

Sashiko is blathering about big endian support, I think that can be
safely ignored.

Yours,
Linus Walleij
