Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA143CEF3
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788782; cv=none; b=YYIRgVPi484a81unq+PPAoIoR1K0+xkVTSLTL3HroQ0oNiUBTqake5KuCpjwurWSsk7KBK/WhtdwHciU5WEuY4atoLe5lyjen18fXsCvk1LXU+MhbykCDlec9o1Ug/HxWUOZD0JQcTdKaAtuB8dnUeaNgCmxwwNG/ClsXURK9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788782; c=relaxed/simple;
	bh=5Or7TLUPFjMr+wK/HbcxUvax7JxHwIuJv5EQuNkgXqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvDZSjeLy5j8wIDFTUmMh8qOxm8grGQEiwSoFdtuHqQ7yjwPWC7FgemaSeS30iV/TTogAin4H0r8DSScX9LdKeHKGMn5a+IlGXR95lctcUuKArHFGVoxPB3BxNqSNWj4w0OmkEVFfnRIgmsgJTZx02lnPyd3jchRu+SV5/j9n1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTGyQ5kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTGyQ5kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB1A1F0089C
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 07:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788781;
	bh=5Or7TLUPFjMr+wK/HbcxUvax7JxHwIuJv5EQuNkgXqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fTGyQ5krnt3K4KWTWK4hLtJ/elOPo9RESlojr5vWuuz5w790N2V2y1OAJAARJ/bGl
	 Txgkjtj9O3ajJqQX8BdReV7OZVl2jRUiHbUSvH/Hwz62fNVKeXgAqyNbQ7A+nHTZDB
	 cY8iDuCbPoIITXS1NgGkaBdVlq8jfvIb3J1lX9bjBuZorfOIiegkGv7MSGvvXCTMcc
	 QBhBn8gdHLQkz1R+AGzjTl2nne7lSljP0chstwuUjW/N0cSBwdAK0lbp2xg+vpG7BJ
	 69spnMWqt8ksZiSwy/4MJukY/TAgPon9IT5volsKgrLa306GaKymqyEQWeg6fqxAYf
	 7B2CJZaBYzdDQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so10823431fa.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 00:06:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydtyXGAlUq+zCyb528iipfOCbm8JC5GohA9FRqKZKkKqkiCuITPfUDKvuJGzxO4qeUAejT1viyoidDzOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG8Y/JidmMhlO5icpJwOEcDbb7T2NY9KGLY5470sTb8rmWNPqc
	C15feZK2qnJHiTFZ3sgfPTsTLfj8SANGLtP9c/jAC41Wy4DfLS6ymf8kzeUImL8dUwXhaGl1p98
	TBx8wvCz9ewY0No+BeSzHsyXv9hE5VWI=
X-Received: by 2002:a05:651c:4206:b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a9c5366e70mr19126061fa.19.1791788780083; Mon, 12 Oct 2026
 00:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com> <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org>
In-Reply-To: <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 12 Oct 2026 09:06:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
X-Gm-Features: AclHuK82cVgFxHKCaa4i6hk2Uz8RXgvi0_EuZ5dlLOwXcpR-STCWez8_fKxlZx4
Message-ID: <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 8:17=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On 01/10/2026 09:03, Linus Walleij wrote:

> > On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
> > <devnull+longzhao.ambarella.com@kernel.org> wrote:
> >
> >> From: Long Zhao <longzhao@ambarella.com>
> >>
> >> Document the CV75 pin controller binding using generic function and
> >> groups properties for pinmux configuration.
> >>
> >> Reviewed-by: Linus Walleij <linusw@kernel.org>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com=
>
> >> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> >
> > This patch 4/18 applied to the pinctrl tree.
>
> There is a dependency, you cannot take this patch alone.

Oops, but is it a DTS dependency so if none of the other patches go in thro=
ugh
this merge window it'd still be OK right?

I think the other patches are still being reviewed and we are at -rc7 so..

Yours,
Linus Walleij
