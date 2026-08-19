Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0763D5C31
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125642; cv=none; b=Ufc8rxKdvcA6jR2J2dysh/+qQch2jPhxAFpbqQxeAahCUQykjIlhkMB63AHgVWToR3Js9ukmOMjWvuEwJYkGENgG9jAQdH65HO6OS8IM6/Ezhx38tzizfZB//nSQKKDASL3Sub3bHaP0Jz3JHlqQk29uQYsGqi0h7ZajU+l/VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125642; c=relaxed/simple;
	bh=CME2svg5ClAUnJKPj2PXGWwyQELSDleWLCO85/xq6ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnKMwypsWrm4j4eC7atIfrufmHdUYwrwMBjfNhwslujssdfMSHZLWUGgUc9K8I9N4UQW64s/WyvCQwIZfEArnlBG4wijJLnkYX++DVqrRLnZ73I+Pex8UVmxFh/zb7QOtdiAV96HTHVJLKuLLByF0T7nCQ8qanMvsxm1d9qpM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4xJGj9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4xJGj9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D991F00ACA
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787125641;
	bh=FFro0CShRsSHLGgbO4zij6styDLmEifSQxQUeqQE0X0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H4xJGj9/2X+lT/uWhbxXcdPQuM7Bg0MQpuq1YyZ+1rRUji8sJaogN48P6A9i+WlXF
	 CmbN9ufpRZKvfQ6RHrNVHDKf0ZUKH6lMmKJw7oDStcMGXAGn0aBMXq+s1NsNvDrWZ9
	 Oljf1DDTrJg9pk8S9WLkII1kgG/vYLtKZ48tKvOA/csRJYfBhVTo3A/9r/PbZzmg2Y
	 efCuanDt6OZrg0W5f9MhLFvQOGXAzTCWx6lZGlWvr/aX4xkhoq2VnwxEh4XhAolNfu
	 FDozd1jLinL5SbFvKPd574wZbePTihcoFq2hrYBE+GJwIDlRCEPwDIKZy8j3XzgW1Z
	 XePiEDb7g8E4Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso824422e87.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 00:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpzkW/IUfOX9JR5qm/0rL3J9gK3cx/17IR9IRqElIlQ3tfP0QPyjnhrW9WRj2tQjs8+/0MUqi6kKK8BM+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy02B8cblRLqkFDbNhoUjZgtZOTzw3kFacAC5l2HRuC6LokaZl
	IIAXg//2vzmnnb5QfdvQBDqeEtLflNR5EctSB3ngIeg5SPyu5ItpqpAQhlp6iIbx4MWu/CeOIJG
	BXU9zX1UuLo3XegoKhrCtjCGjrL+yFxI=
X-Received: by 2002:a05:6512:3b9c:b0:5b4:5c5f:2aed with SMTP id
 2adb3069b0e04-5b478bafeedmr801963e87.9.1787125640383; Wed, 19 Aug 2026
 00:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com> <20260818-cv75-v5-v5-5-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-5-7bbb12f0360f@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 09:47:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLngqGzethEG5Hx+oAPzZoV6rvWNGXYaycFFkDz_dXFz=g@mail.gmail.com>
X-Gm-Features: AcwNN1Xd6vVOI9stCj2gRpLkQqCARgCDR2Ns_rmI0pVH0qFiDI8kQzTDIQYC_Ck
Message-ID: <CAD++jLngqGzethEG5Hx+oAPzZoV6rvWNGXYaycFFkDz_dXFz=g@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] dt-bindings: gpio: pl061: add Ambarella CV75 variant
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Masney <bmasney@redhat.com>, Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	Long Zhao <zl020895@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 12:32=E2=80=AFPM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> +      properties:
> +        arm,primecell-periphid:
> +          const: 0x00000061

The 0x41 in ARMs PeriphID is actually the JEDEC JEP106
implementer ID (8 bits).

So you should ideally set this to whatever the hardware engineers
should have used, had they paid attention to detail.
If your company has a contact point at JEDEC they should
know which implementer ID to use for Ambarella designs.

Since Ambarella is evidently a member of JEDEC your
representative should be able to simply request a JEP106
implementer ID and give it to you if there is not one assigned
already, but I know it can be hard
sometimes to find the right person inside the company
but I think it'd be worth going the extra mile here, say that
this guy from the kernel community persists.

Yours,
Linus Walleij
