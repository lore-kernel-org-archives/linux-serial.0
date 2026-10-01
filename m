Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906584A68BC
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883429; cv=none; b=JFskUCriEA7NSh/cHI3U4vmWtNE10u6g3WERsyyMgrru/Gny6B2Eb6e8/LgmFAfQOv99qfiMSfFDyK2ejSZLjyApKinbYTHoeiNOWbROKWl+se0lz79x1dviupeagcGkergLUTMAYeNiDRn+OIlKI9myOHwmpHq3MGmWsDXR+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883429; c=relaxed/simple;
	bh=qvwz9H5czi1T2bET1rcGtlq0MACGNFWYAMQiSkHpdX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzbfNS9MvJE9cN/UVhQAPMt9PrMtjc8PGpExoyBfsc9/Lw2pahpX/dvLSSKenuA2/ZLd+kuHvFQ9Ea/4iTBPPYFgsnyTYeEiLkmUaEQg7dl5rWeSFBa5kr/dKg3otfLOIo2WRqdv1mqxmPQtQURHtr4seFH78PxkdO8unnCY1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYEkWZSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYEkWZSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ECA1F00899
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790883425;
	bh=qvwz9H5czi1T2bET1rcGtlq0MACGNFWYAMQiSkHpdX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OYEkWZSGIPm9u5E7vvPyKgWBtWXoYDM0EGPIKCETLZ8/uJTQU6+6fMwQSj1CEDMG9
	 FEEP8B3Z/9kj0+e2SotAzqmeMPnIBCHDFQOFg0xrbc0jJCUxSPgWEOcUbRie4b8j5c
	 9RR+PHZ9l26jsi2i043ZuZn3uXED1Mm6U72f7Wijc09/6J0y8vHBHdIG+USOiIeFYj
	 WC2zyQWU2k7Jb9PHARWTCN6M6FeE34OaK28p/Q8j2R9egjckrpBv7vM0mfRN6kDiDO
	 yqsl0jruXuftKkvxc23FjyHcIjhLyHLPY+6FKwA1j8tONQgQTIt7IgO9/dMkXJJsOc
	 PxPefttg9aAyw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5bb5d3229d1so108652e87.0
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 12:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByAo1AOzKoVukMiwXA9QgfMYKFnqvmoFqDZxLd2j4T68S8glCqM5oOpMYhbJ8GQVK75chhY4R9TkeJs1T0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhdBK3Kzla7JpYZjY8QxUHxpRklLiRIQEhd3Wx2/rqHLrgB7uy
	YgzLLO4qXeZu6ReMShIzazrejuVRFbDNvXvlD8S4E0Uj6XzHRVU8ly8ilgeksbjeU8C/+0Ou4Bu
	mrDG0qXo9Z+QfLG1tob8XdFTDVKftcb4=
X-Received: by 2002:a05:6512:3a8e:b0:5ba:3db3:66d6 with SMTP id
 2adb3069b0e04-5bb9bc3baeemr71428e87.38.1790883423882; Thu, 01 Oct 2026
 12:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-4-486cc289a4b8@ambarella.com> <20261001-attempt-savior-5d4a0eed4320@spud>
In-Reply-To: <20261001-attempt-savior-5d4a0eed4320@spud>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 21:36:50 +0200
X-Gmail-Original-Message-ID: <CAD++jL=tsETOFvC-AdethTdrGtet5neVanj3KyyB4EtEOpJ_Gg@mail.gmail.com>
X-Gm-Features: AclHuK8gO_d9ZPMvc-1W1f079XpNQoWfhmnQkIh3LHrwFtzhfvV51TArzhkyp58
Message-ID: <CAD++jL=tsETOFvC-AdethTdrGtet5neVanj3KyyB4EtEOpJ_Gg@mail.gmail.com>
Subject: Re: [PATCH v9 04/15] dt-bindings: gpio: pl061: add Ambarella CV75 variant
To: Conor Dooley <conor@kernel.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:23=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
> On Thu, Oct 01, 2026 at 08:40:53PM +0800, Long Zhao via B4 Relay wrote:
> > From: Long Zhao <longzhao@ambarella.com>
> >
> > The CV75 GPIO banks sit on the AMBA PrimeCell bus but are not
> > register-compatible with the ARM PL061. Each bank is 32-bit and 32
> > lines, with extra mask/enable registers, so arm,pl061 must not be used
> > as a fallback compatible.
>
> What has this got in common with the pl061 beyond using the PrimeCell
> bus? Current reason for putting them together is a bit tenuous to me.

It was determined in early review that this is very clearly a modified
PL061 block. The basic registers are even named the same.
https://lore.kernel.org/linux-arm-kernel/CAD++jLk0LoOJk=3DTXin42AL3_z_7eVVk=
vMnYr1S8090C6A_B+dQ@mail.gmail.com/

PL061 is different and quirky and could not use gpio-mmio, while
with these changes to gpio-regmap it can handle its pecularities
and use a library which is a good thing on its own.

Yours,
Linus Walleij
