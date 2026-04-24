Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73D35B642
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014414; cv=none; b=pq1lV/HFA/RcjxGGt3/dVgCeYDKwOtxXJf3FssOB2Fa+0Xt+pc8elnAqsrZEHxtFJPMbB5FhrwJiQ1dbu3LpSXc+EOVLhvk/4/OTkpAszfRFpvE6IUebEtU7yNYgjThyHsTu5i6wz7DetLd4UqorN9C9UgiygZ/jD+QQz6jYMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014414; c=relaxed/simple;
	bh=rFXSKMwR0XlgLDLIyJxwMfmA1neLi9/CshGkcjxghfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s80TMtWwoEIxKqp/HOX9vII9j5rWXtzs4lbIT+RM/6kHtFTheS1F+/zT5fUwt/sI/afX6+Pu7EusQVW4sVp2y5IMTBIez+wEC/TQ3td0mEat6cyUuzymeT1faeqCIXaqbA/+rkZ4rAA7PXF6S2aQsN9KcWH3F4nuC2YE7K1McMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRAym1ws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRAym1ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDD7C2BCB7
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777014414;
	bh=rFXSKMwR0XlgLDLIyJxwMfmA1neLi9/CshGkcjxghfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JRAym1wsAl/ksV3GSU7FPEfP1Jlii2RQfYmQAQpIqvnyQ0b2/ud8dA6XDXU7sU9hR
	 mskPbdKpicBfTouQfGQC8DOwbnJP9neDM/BJgsiSaL/OOvof54mTzGuY26AXVYVZcY
	 sJXPWWdwgfK7aBVwEz9iJZk8GbIQN1hApTCVA87+w1r+Jga7pM89jaTgVbmBqkGNdG
	 +njQmz6sYg+6CHan3Y9yvRpG1T+a+f2qPDYU0173BTfBzD2oJkS+g0TnC2nh0JHQxl
	 2vT8YJ6JWUc0k+Bvz1UuJHcRKpkzA/7NLA47GFftZBCbXGofuD2Ynd5HyAf47zAMpy
	 Se/2heNSjA2Rw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e68e4389cso79166451fa.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 00:06:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+My7YJmtWpmiaHK7Z1A3US9+Oz9CmBb0uoLfEE3GmkIB8ZIVuts1qT4W+kkbaEUvoHtAo4Uyjn/gyIvYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1cfIQoOPoDTwFS46IDVbxxFUigqKewjlX8GBM4gGUNc+eukq
	9tmLMwFCR4/Jn3tOD+dXkCE/lxrK3bWx0lRmXby8zzq8OtfNUND3FBL1e+q055RKXFWzdOO6Zdq
	M2InITvAyziyZ0G+Lsx7c/eh4vPBBiYQ=
X-Received: by 2002:a05:6512:a92:b0:5a2:a851:b00 with SMTP id
 2adb3069b0e04-5a4172c0fb6mr9394355e87.3.1777014412658; Fri, 24 Apr 2026
 00:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-send-v5-0-ace038e63515@gmail.com> <20260421-send-v5-1-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-1-ace038e63515@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 09:06:41 +0200
X-Gmail-Original-Message-ID: <CAD++jL=am0f+sgBSFYQCdcFOvFWgPETn_pSgVdzETJ3_yUNqgw@mail.gmail.com>
X-Gm-Features: AQROBzAkXXHaECougTpR5Akx1BQv74bjgEPuXg2NkWEW6SVAF8JXYWHStj24kKk
Message-ID: <CAD++jL=am0f+sgBSFYQCdcFOvFWgPETn_pSgVdzETJ3_yUNqgw@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] ARM: zte: Add zx297520v3 platform support
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

On Tue, Apr 21, 2026 at 10:24=E2=80=AFPM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> This SoC is used in low end LTE-to-WiFi routers, for example some D-Link
> DWR 932 revisions, ZTE K10, ZLT S10 4G, but also models that are branded
> and sold by ISPs themselves. They are widespread in Africa, China,
> Russia and Eastern Europe.
>
> This SoC is a relative of the zx296702 and zx296718 that had some
> upstream support until commit 89d4f98ae90d ("ARM: remove zte zx
> platform"). My eventual goal is to enable OpenWRT to run on these
> devices.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

Didn't I review this already? I don't remember, anyway:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
