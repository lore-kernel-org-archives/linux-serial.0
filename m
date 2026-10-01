Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FF361DA8
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886404; cv=none; b=TVGUZYPo4yn4LeF7DHYKME8MSlxgnNmK55wSf4UerTUsQSptZkZ7kfEHTuTgVwOSU2qbpjmCspD3jQ5cCOFUdBwCxn7UF2OeHGCCosWTyh1VrxCV+IE3w9D549ygsjhz/b38YLzbeqvCysoXZojBWPhsP56aBUj1v9eCxx4vTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886404; c=relaxed/simple;
	bh=TDzyHBnvN6Az74PoI0viABsOFItZGrFL39Cl60uyHr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVRT37HgVxBQbG46BPgXW/XfEFMfX+HfbU+imbm48Zd12bmD+HA0ANWzhbS+BY0nlSay7hpFUeX8HRQJpfUYJfGFpX4M84vp1Al+aJE8eXpgHbM7ax5F/BZUry5Hw778E+jg2EIWU3a5jrGpyXZXAO7nCKfJqwRJ2TDhQkVYVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSQa0Q1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSQa0Q1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF91F00893
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790886402;
	bh=cuZLwo8L/Pz3tHEl/pgaDbc4NC6C8bTc4OVbV4XoCzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lSQa0Q1Tmp6AnEKgZnzPKAv/nZxq4L0eN0mmIfFPzFE5VKiKhEGw64PZ7Kest0yXV
	 RzLDkDkLeYWVXbGEQfwzqJqjYVVNGGYhRgrR4HUFdg4s+OAustLvpWFzE92VIwrb0/
	 9ZvmBbLQfjnX+M7swxzFDVVEoTPUkJDTYRC8dlpLkW7wTbrvs35hfgqRrt1jOTyFJd
	 oyENsUwCm/haQNacO7s9VBgPOEqYf5dFgNjh3hFEAW74RIKj7XbxuV330RPHQVL+El
	 +Ngt2IDbG2nLQoLI4gAr4xzgufiAHYXlwgqjBnar7jYmCiPqHE3X/YbOX++L6davvF
	 fiRa2L2zsx+rQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so34848601fa.1
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 13:26:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUTtrdppOl5AUjfHxSutag9UU0sgeJfWNA4rZSUxGZa/JX1V2dhUUhJjqGlrDkD7oU8lCt6Vs0Q483AHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx3rp/QInFKrKMl3SKRvlmZUd4WxrB5nLPFdk6Mj0FFgMbvcwi
	Z5SZNrbdCYj6Gg7wZ60/OiNkcGN8PRoOFjvkAaJJC2YVni8X2oxdmYR7+b4IfCCF9s4rhpT3D/C
	oI/YYf+E+JJQZh39T55lSJqk/0TouSLI=
X-Received: by 2002:a05:651c:982:b0:3a7:83fb:a2f4 with SMTP id
 38308e7fff4ca-3a783fba4b6mr9981301fa.15.1790886401618; Thu, 01 Oct 2026
 13:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-3-745eaca28b1a@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 22:26:27 +0200
X-Gmail-Original-Message-ID: <CAD++jLkCXt2jPps1+X3gmT-+o_ST59GOT1Huhqx70NK1RDCExQ@mail.gmail.com>
X-Gm-Features: AclHuK-u9udZl77wTM7_r_7heAhhugb-sGNthmiZZXg0N5M_CZnxPf-YeiEWQxc
Message-ID: <CAD++jLkCXt2jPps1+X3gmT-+o_ST59GOT1Huhqx70NK1RDCExQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
	RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
	William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-serial@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:05=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:

> From: Douglas Anderson <dianders@chromium.org>
>
> Add initial device trees for frankel (Pixel 10), blazer (Pixel 10
> Pro) and mustang (Pixel 10 Pro XL). These device trees are enough to
> boot to a serial prompt using an initramfs.
>
> Currently only Laguna B0 silicon found in mass production phones is
> officially supported. Further revisions such as A0 silicon and EVT
> devices maybe added in the future if they are useful. As of today,
> these device trees boot fine on EVT devices with A0 silicon.
>
> A few things can be noted about these device trees:
>
> 1. They purposely choose to use the full 64-bit address and size cells
>    for the root node and the `soc@0` node. Although I haven't tested
>    the need for this, I presume the arguments made in
>    commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
>    and size cells for soc") would apply here.
> 2. Though it looks as if the UART is never enabled, the bootloader
>    knows to enable the UART when the console is turned on. Baud rate
>    is configurable in the bootloader so is never hardcoded in the
>    device tree.
>
> Changes by Peter Griffin:
>  - Remove dtbo overlay approach and add individual board dts
>  - Update to lga-pixel-common naming like gs101-pixel-common
>  - Reorder nodes alpha-numerically by the node name
>  - Add ramoops reserved-memory (tested with console=3Dpstore)
>  - Add reserved-memory for bootloader & gsa logs
>  - Add reserved-memory for Android BootLoader ABL (used on Watchdog
>    reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
>  - Add osc 38.4Mhz fixed-clock
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Co-developed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

I think I reviewed an older version of this yesterday or
this morning.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
