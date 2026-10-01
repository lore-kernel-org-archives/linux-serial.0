Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B663B8105
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838357; cv=none; b=G3/q5/PbLWQvIeZELJLBTdZ6MI8AVIaPdXlrcy2BttC9Ou9d9MPVmNnh6X2MHLXKD1i4+6aoNP8QG1xPuViSpGkxHZiui+XCcIoXOi2ae17nwqtz7+RCmCBL+v8tWSQW15GgRjvr5QEDDRfocOY940odf4//ZgJLCOxnMGD09aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838357; c=relaxed/simple;
	bh=zJQFLPwEiB2U+G0jhY28xaZPlMUuMdHQiQDqXqwoFSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPNKJVGHBpjRW68mQjwkff6vRs3asDTP/uvyb2yLyCY5uo7Oe5zORCuIoInXw2/93DPGgvOEGdlOkfgqTu4nZcmnWKmJ/vNB2MthdMa0Qld2XpfRtTitrC4sdT1B/6YxyfkfowMwh7G+Z9gLDXLHXTJnF6J8Ul4j1vs3wI9sOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBDOsQBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBDOsQBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD871F008BC
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838347;
	bh=zJQFLPwEiB2U+G0jhY28xaZPlMUuMdHQiQDqXqwoFSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gBDOsQBNJzpUqY1/sE5r+FuZvteuFCYvlS/9aAq7t8Pei0ivGYP2oPomogViHdaKJ
	 bCeOvk3/JGRtmOVbC3SbRB9TU+Jq2aNlGGb4/U5kBTj1kvYnrOhG5DY830irFuMbS3
	 FEJr2chISl/g5Irl2U457T92b+dOnuyjfxCMSQL2RvIqvnmf/M9rHNMoBnimfqFcZc
	 hpHgHQUS4HICZbjGfFC+nKlcwS2G3gPC70wkshrLqfEOgBX+WshIkWhekkbwk7kbmX
	 f8PzlmeHjbKxhm5InWuKNsk9Dyg5BAlOIdE91fJtyhYyIkKHwxbMU2OsIUh/VN8CH1
	 09VIak7FpLPog==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so2209647e87.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 00:05:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxyD950uOWBvLZfovRGiUBG2cLc+Fo+0MoJMsmEXrr/wsclxuo4QCfB1yJcI4h4AgAaVoklH5e/Uf0avls=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqh/O9/3U1aOCyLB7icLT6RENqTHj4OccPNxs69wcZc0ftsNds
	gmdUaylGAotArXKH9FvqzK74iWzNH3Edhp5XhNOtMNB8WdbPJx6wQeibB6zTffx4156OfWWdXNa
	CJFlamUUmHNhK2Zb9MZLNJuv3eFkxow8=
X-Received: by 2002:a05:651c:556:b0:3a6:566a:5cb2 with SMTP id
 38308e7fff4ca-3a77920046cmr10708401fa.29.1790838346608; Thu, 01 Oct 2026
 00:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com> <20260921-cv75-v5-v8-15-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-15-282ff5d98dda@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 09:05:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLkUuLeBFGPPToPN9sG6r7ZMT0Mh7YdWVr1enRr524go7g@mail.gmail.com>
X-Gm-Features: AclHuK9FiDhUvTmGZLlpW2ckpJiMt5-YDu8gbt1OvSW8Kjgx3ohyRLoc8rSCwAc
Message-ID: <CAD++jLkUuLeBFGPPToPN9sG6r7ZMT0Mh7YdWVr1enRr524go7g@mail.gmail.com>
Subject: Re: [PATCH v8 15/18] pinctrl: ambarella: add CV75 pin controller
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
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
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add an Ambarella pinmux-only pinctrl driver with CV75 function/group
> tables. GPIO is handled by the PL061 driver.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

This patch 15/18 applied to the pinctrl tree.

It's on an immutable branch along with the bindings, so other
trees can pull it in if necessary. But I don't think it's necessary
because it looks like only run-time dependencies.

Yours,
Linus Walleij
