Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817B3E1213
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974806; cv=none; b=sh52mYXt5YFavitFQdlndDfiVPjM5Bs27kZMLCsYRmE6GOTB7gxfV+QllZZk1Q4rNgtrjCIwDJlJwwItysnXlj5J9DPZgrfaC1JZgjZdKu1aHawszeWY0USZT/FrIJD7899oB/3oKtqZsYdaNg9+wHWqfOKAog/E1bwX2qC16s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974806; c=relaxed/simple;
	bh=saiAoSq0Gjw4nVSv3lJIbi7mZbCEiUFubkklHZ6p6UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgvyMP5jPfPnAyBaUq+HeFvWQCxLyMCilmAmWNeZZFWrqvv3jI/XPf9BT+BW7Iq7tEJm8KmtVsYrCoO2yRe4JXvqmQpb61t8xUmNM3VLig0mzjJ+jUv+VL4whb9jOapqGqK5sFHkAUxl73oHKjhkbCZtnUQmcbCOlsgbC19Xoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFkqNMfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFkqNMfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF3C2BCC9
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974806;
	bh=saiAoSq0Gjw4nVSv3lJIbi7mZbCEiUFubkklHZ6p6UU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tFkqNMfKJt7Q7XONP/ZHfpv5V9+vnr/gtXNIn3ijNpCHDU1BoQiALetWJSt+PmgoS
	 BBlwwgPBnV78TtaJ+qqsAWJKwy04QPBJA7QgkL/YCiCCJmhmXsUMSvQROJgCTk9K72
	 LYLjeDL1f2ZcOtEecI6GzZ8O6zCTjFBwRHGdvn2D9E4/oieDtY8CGp2nuukUFWHL+R
	 Rjumx4xYqOtsQgaslMgTG4/ycuwRE3YzrV0FqhDjssIDQ72Weuuu02Y+IG7diGD6l4
	 SlDWqIxoESZZKTuqqpnwzyEzXhczNwyfeuSBgznwvsv2LGbvIddoalPj75rgpWWe2T
	 0tvUDQj+4WKlw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7d984096so56815481fa.2
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 02:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GzSMxQrhuwMq8xyKhXgGzm2IX41W12qH16yM62UtomQ+OV7LavDSXwXlqALVVAB+MZQiz7YXcMx3OYKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFapHvU7iTiPH6HcfeSZjwdMZCJGJwezLfiTxX9R8ryULhcO8
	jy24xceJiBwTSlPQGi6FbmtU1iK3Gr9b9SLROPtZX8iM5iHC9WpEkSQOiaWkj/DEPwgDV+u++Rl
	C7MMVOAFWjaNc+VqLdZVFS9LXOUHeMek=
X-Received: by 2002:a2e:be8e:0:b0:38e:a8ef:b61 with SMTP id
 38308e7fff4ca-3937857c3bamr54490251fa.29.1777974805235; Tue, 05 May 2026
 02:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-send-v7-0-b432e00d2db8@gmail.com> <20260429-send-v7-5-b432e00d2db8@gmail.com>
In-Reply-To: <20260429-send-v7-5-b432e00d2db8@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 11:53:12 +0200
X-Gmail-Original-Message-ID: <CAD++jL=PzwbKFvLDX_b-UvQtd83qfb+Kaeg1Oibo5mzRaFjR3Q@mail.gmail.com>
X-Gm-Features: AVHnY4KMDuCZ2LITDqNfqa9EPfYGc-qnLM8XOIgJiicE6urZJdWk9Rb4jm-mXt0
Message-ID: <CAD++jL=PzwbKFvLDX_b-UvQtd83qfb+Kaeg1Oibo5mzRaFjR3Q@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] ARM: dts: zte: Add D-Link DWR-932M support
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, soc@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 9:14=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> This adds base DT definition for zx297520v3 and one board that consumes i=
t.
>
> The stock kernel does not use the armv7 timer, but it seems to work
> fine. The board has other board-specific timers that would need a driver
> and I see no reason to bother with them since the arm standard timer
> works.
>
> The caveat is the non-standard GIC setup needed to handle the timer's
> level-low PPI. This is the responsibility of the boot loader and
> documented in Documentation/arch/arm/zte/zx297520v3.rst.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
