Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051151B194
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909538; cv=none; b=sP35ZU+Gd6CiHaMavIJLDPauTHkJ+g2AqPvvYzdQMcDO/cJqbQ4B+/zbjPcYp7Xb+9/G8X+BNcKQtxOHKQZnB4EnczswW1/cbyc8tLnhXDh38ksbbv9g9zyMTGGlZkw6sB5TWZBLPtwX72qOVWf4AiS4nBMDTfzuQj9OUN1Y1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909538; c=relaxed/simple;
	bh=aoc8nug3Q5d4idvy+yC0Mx43dQ2bXsa5/t1xC0cav2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMnYHnIHoKX5H06AyYS2nBX4iSxoAhd9q69dflVPHzUNEbYokgrfEt//9tdTDe6jgCG88rQ+TlF95kWNsRV9eYB9ZK+M+DXqpy9pq+pciq8/0cxiT17ymxU9cIuO2Q+ILtxjKOFFcy5wxSGtxOQmi2PX2YFn8GebTTLKPt42aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIXr0/Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIXr0/Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FEA1F008A6
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909536;
	bh=aoc8nug3Q5d4idvy+yC0Mx43dQ2bXsa5/t1xC0cav2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EIXr0/NqPFBPFbx1LaDsMXlKsGpxcyH5MhiMvJJEZ0hq0e0/HC3jK3AP1NrWRjgJ0
	 9d+nW7mdbCZJFLBgvbC5gEY/xtmIeMTs8CfOlk1pibY1P/VXzO6VDvkSex+a/sQXwN
	 JnsYAeNzc+oKZ6PMto84QQDBwMXAHAxm5+0qr302BxdESzqlPu72UGNyXChQ4ZYlW7
	 TBEzkfcGSCutzCxu3ePjH/mnwPyN0Z2BazHlesETGhJDeapcn82BQpOxKPnbkJzAYZ
	 54GU+w60CWQYtSjOWvzvxPPDu7y+qTe8EdOGslq1DfkZhUdWbgDnzizxDKE5xj+M/q
	 q9MeRX/XD/Ewg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcb3726952so1440947e87.3
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 09:38:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBGIwk2SRJpOW6dBKA4BdThJg5gD5eyu21/Wce84PI6cx2Ty648aLBRp2rTurKmnrLbvv3KDwGOvYnHss=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZYJo/QT+DKrj4Zjo5vbz+z+439s2nfmjCGXrZJ4YOZyAxYOyk
	mm/S2Qk0/Zagt2AEuBlchn43Qz6QeLdWe9vbg6xxP9iIcLsPdrqIz5l4ixZwp7qWFos5x6/6r+s
	0/4kPG/cbXxS34phU2pyd4vT4bL1CA3c=
X-Received: by 2002:ac2:4e0c:0:b0:5ba:3b49:1ed4 with SMTP id
 2adb3069b0e04-5bcde8be31dmr4294291e87.44.1791909534950; Tue, 13 Oct 2026
 09:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com> <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org> <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
 <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org> <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
 <56dc6c05-7fd6-43de-bc62-c353ae1dbcc3@kernel.org> <54b55ad7.9d3a.1a135b09587.Coremail.zl020895@163.com>
In-Reply-To: <54b55ad7.9d3a.1a135b09587.Coremail.zl020895@163.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 13 Oct 2026 18:38:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLmrQwAT1Sb8HGgoM8x48rN9-pPT2RB1GE18h5YA7c4CwQ@mail.gmail.com>
X-Gm-Features: AclHuK-C40htUqR0sQkUyvXzKiDDbUaAdB38TRfKZGEWECC-r-8bfyITN0j8-AE
Message-ID: <CAD++jLmrQwAT1Sb8HGgoM8x48rN9-pPT2RB1GE18h5YA7c4CwQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
To: zl020895 <zl020895@163.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:36=E2=80=AFPM zl020895 <zl020895@163.com> wrote:

> Would this work?: I send a standalone
> "dt-bindings: vendor-prefixes: add Ambarella" patch to Rob with only
> the two lines in vendor-prefixes.yaml, and drop that hunk from the
> SoC series. Once the prefix is in linux-next, the vendor-prefix
> warnings should be fixed. The remaining example matches, such as
> ambarella,drive-strength-syscon, still need the separate
> GPIO/UART/pinctrl bindings.

That works for me and solves my problem so go ahead.

Yours,
Linus Walleij
