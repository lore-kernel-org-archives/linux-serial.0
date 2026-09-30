Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653349B1E2
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765901; cv=none; b=mlPjx6nVkwgwF11dbaMDD416a1rMHmigIhEAAr3XiqDbJ9IHCDj8fymKvj5llGx/T4PhxsUvlbMSrI+J2PDWBWqgngHU3IFa1RbCfbi5qbzxpzGw38UzHXRtcfSmt4e8gCXe1kGpeVszK5rK9BP1oxYlxtyA6bQpqu4o6yb2gI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765901; c=relaxed/simple;
	bh=HeKGdzLU69O+ht9kbtWpEwDIRN8ghLkwCH+cdsIjxI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi2gmIzDkj2S8PExqAewOI/NMuaU8l8nj9DLKImPCO1ATjuvwKrLnmzvzzTF4mzKLKY6c5toUc0F8A52f6DlJTncNqcKjdUgnx9T6LGgFC+rDTB5gf7TbE9dY3kOpLMs7LPQAAqWM92oZDaXTUllk8wvoDb6yuYT7N5md9FW+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHHWv3/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHHWv3/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE85C1F0089D
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765891;
	bh=HeKGdzLU69O+ht9kbtWpEwDIRN8ghLkwCH+cdsIjxI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aHHWv3/e178Jqr0rII6QPV0nGBLTsgtyaBUunqajL5gZ701UOmTost9HSZ1zPVgHK
	 ss9UxAoBdmnNCjo+57n4x2ebsj7fFvxlFrZvLyGd7YeePDT6L8sdfA6SJQu7kMkI6g
	 5z1UVduBF9bHnoa4qclG2DpQNGikwFtdVNXSzlut0QZBtUofnPk4wtt/vy5TB6JHGJ
	 guAKSblDm4O1kmdgYDR2p9kN44ivlt4S1fiCykde9jD5ds7Az4UCwfQysxUExzfChV
	 2uB+E1JBbryZPPnrWuykoEB0KKJZdfPst+nuZ0V1UkM1Du9lLQ8hRM5aGFLD5VKQjR
	 mFD7H5hFpsjmw==
Received: by mail-lr2-f22.google.com with SMTP id 38308e7fff4ca-3a65fd1534aso28528641fa.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 03:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxdW3WBEXdetg/1rs4WT9FFG/ZvL5iTNsXJEYTOxPKuoAie04LKBJ6IHOmIBlHwI/yssGTjHtojkDFD6sA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOn0PaSDC/roOSkdX+nD3gqg4UF7ztvFW9d3GXaDKiru+B0e4A
	9gyct+d9Vucz3V/28w+fmWYeovxhGT3RnLoisfE2MZgLwuqlWijpbgfWjPkoTbMiAJeEnz2FW9x
	XiZltOqd+xKVVwlS9xEVA6YHUf3lNPoA=
X-Received: by 2002:a05:651c:a383:10b0:3a3:74b7:fc03 with SMTP id
 38308e7fff4ca-3a77920847emr2626851fa.15.1790765890554; Wed, 30 Sep 2026
 03:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com> <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 12:57:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
X-Gm-Features: AclHuK-sa81U-5SW9SmnkIIIMk800EhJv2_agNorbcDVKJfOoCfwnayZ96qbERY
Message-ID: <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
Subject: Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
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

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>
> Add a driver for the UARTs of the Cortina Systems CS75xx (Goldengate G2)
> SoCs. The block has transmit and receive FIFOs with full/empty status,
> a 24-bit baud rate divider clocked from the peripheral (APB) clock, a
> receive sampling point register and one interrupt line per port with
> per-cause enable and write-one-to-clear status registers.
>
> The driver is a rewrite of the vendor driver shipped with the Linux
> 2.6.36 and 4.9 based vendor kernels, using the current serial core API
> (uart_port_tx(), port lock helpers, deferred sysrq handling) and devm
> resource management. It supports the system console and earlycon.
> Hardware flow control is not supported.
>
> The ports are named ttyCS so that the driver can coexist with the 8250
> driver in multiplatform kernels, and PORT_GENERIC is used rather than
> allocating a new port type.
>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Look at this in your Linux tree:
git log -p b61c8bf4694b5115766849378dcb8787ff54e65e

This is essentially a resurrection of that driver. It was deleted again
because it was merged prematurely. Cortina never came back to revise
the driver. (People run out of steam. Such things happen.)

Anyways, clearly this driver is not just for CS75xx so name it
cortina-uart.c simply, and update symbols accordingly. Kconfig
should be SERIAL_CORTINA etc.

Maybe
even the DT compatible should be something more generic.

Yours,
Linus Walleij
