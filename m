Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C312BE644
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561962; cv=none; b=qPrjUatJZaEtFJ5Ny7vZj1B050NU4pNPZc1cTRk1z4Idv4fDTXd/GF32X9QLEHkvBQCrbgARkC9WsFImcEDpaQomyRyWXuXF/NI8PskQZkVFIdqjNn4vUoYFI0VVE9ivQQa3mjJwmwxsLofvc2gj4jPTHvx65slODAb/w04UsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561962; c=relaxed/simple;
	bh=N6PrZC21iwen1B31Vi2jxyoGAz00i3RnJHUvEeJPYKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bn1OGINShck79I0DLfzsNVY3H+8e1zb+S/P7LiMlnVrhqBwfg06RTvknokGC3WNd0Vjxd72IgdOrEux1a1tyUkvZg0cVgTWyM0rGJUwVcp067aA8P4bOPsB1Ba8kI19lVcdK12eIIa6F/1E5+c4upoWCVZpuJM8mSrz7h+pVk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d70iELOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d70iELOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3E1F01566
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561959;
	bh=N6PrZC21iwen1B31Vi2jxyoGAz00i3RnJHUvEeJPYKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d70iELOPejhaBBj5+6MW44oGn0aWXKRbgAohwfHSsU/NLiIvY/fHQDlN6hkNCQojh
	 KhsDrUKRNEtpUBfA4wXzCclmbNO5nsV0ItTAAd+M7utWhgIOTI88JJVCdlEfYcfHrZ
	 Sp+cvzGDdyzy5G5Ds/uDrCbuGDYAm4vbC6ahg99HB8cJlTwyoMUzwGszByY5/+7QWO
	 hGA+wKRDNsUhZmdcUspY3bXo33TZP7b4J95yD78zG9+PN2BrODGzpSpap7cLoFk2oZ
	 xdMdKxA+P3VuuxMZkwX/X0dNbrCd4U0OrHFZtaKhN8khrcIWsGPUbucNxAh4IFP59x
	 lI2oMGKWEi3Rw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aec201b582so1861024e87.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 15:45:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsPRnbauM7noWc5QG3TmFVGIyj190hVk87d52os/u0ciCXMGPvJiAYMVQtSWWCTP5JXqk+LvWcBik1cG4=@vger.kernel.org
X-Gm-Message-State: AFuF++nu6i2Q9MtYA9pbhcnxwDl1V2tgUC2zRqUAtjig+nA98zqijdTN
	tPf6CjhiaJXeQXUMKjI71vLMQFjG7w9+hmPQeVFYhRTZPPQ1j+F1sKR/TxNKh3uyFHbSfkZrNWZ
	CJB9ovJbEXGypCu68IGvq3+qPkXneJJo=
X-Received: by 2002:a05:6512:a84:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b616f2f892mr1623528e87.16.1788561958599; Fri, 04 Sep 2026
 15:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-13-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-13-e918514cb3b1@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:45:46 +0200
X-Gmail-Original-Message-ID: <CAD++jL=tVwQPPCFCc=J6gxBt4VvSJKWKvbAeSRSybfXjvpcdPQ@mail.gmail.com>
X-Gm-Features: AcwNN1WvpRED5iixL57tKxLT16byEdBDfHJOlSmTYR0bXv5jc6tVAgVJ2Y214Ck
Message-ID: <CAD++jL=tVwQPPCFCc=J6gxBt4VvSJKWKvbAeSRSybfXjvpcdPQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] MAINTAINERS: add ARM/AMBARELLA SoC support
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:39=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add a maintainer entry covering Ambarella CV75 bindings, DTS and
> related drivers.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
