Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D349B207
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995947; cv=none; b=dg0zMq679ImJIjAB240NZFkT1DQ0ER7pYSPq48aRud2ghK7TPUKyYZBW1GYqDblKRexBKsvAHc+YC4If44+ViDHADfXbcjhxoqfvs2s3awoQaVtSbBsiGZathW2DZd6NigbpTOnrZpMGwvHyVr8McQD3XfCfY+Az+R228caLUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995947; c=relaxed/simple;
	bh=eqL1+pxbQbl2lD+yMbd0BnhFooll2P4VKDlpZNXroxA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElZrko4Ck/TZMlDyXvx/AHSt2OjJ5u6zWsU4xoUnzYix+yppIn+KzmAvpZhxqOampf4XFYMy8shLwOMrAUeoqNzGmDCkitsAVhcGJnnHZ3ZVaUSuZBhwH4v4/Le2tJa4o6uJN1t86OaX5IPjNDJ4zmiB1gCD9IAIGXIhPjCzR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GytY8D3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GytY8D3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85F21F0089D
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789995945;
	bh=eqL1+pxbQbl2lD+yMbd0BnhFooll2P4VKDlpZNXroxA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=GytY8D3g9KdWyEtZtKTjUOE80hf8ad6hTWTO7J8PIUu0jHamYH88cX4PcpnIU4nuX
	 Fb8JSRH3Z0LaZ3h+Pgb3AsvbFcuues6Bk5RIOba2lut9pliLRttQMlHxKmbOKAH2Yb
	 Nh31eBZsWGEI2G7idQAW6xUecITXNq9iS7i2sMvQYIN8j20/cjTTq0TQ6EdLNUZCxP
	 brZjpAm9BYFp8WBMt10OoutEA4CgYr68ypEaveyMCAvHgvpTrPjaxrgg+a+wjsUKDl
	 ZZdNaF8bHTM+FswX6m4wAozccXVphUzMTrQ9GpTxAviLX5rpXaGuogEyWTAZoGR6sv
	 p4hlu95urNk3Q==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a612404718so13331641fa.2
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 06:05:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx8Hj9rmvdoC3f4lqMZo+eH5eTg8MwQU0YmsBK43lxYYsIidyEytfu82do45r48WAG86oCw3MaiMXVqg6I=@vger.kernel.org
X-Gm-Message-State: AFuF++lld04yM72SsKxDU0y6AfErRIIalPVXv2Z3Z4Y1EdFcwH3TB2xZ
	w/LyBet4j1rPcdnjOY9CEwZ4KAKkB9qLXRjed+6VH6uSbl8E+qI5TCTnbbRaeBaew2PSLCdgoYQ
	UPiN555V3al05gTQMzmkjDTg+BGPAwteRFBSRXrI5qQ==
X-Received: by 2002:a05:651c:b13:b0:3a5:fb20:4e63 with SMTP id
 38308e7fff4ca-3a5fbf54e10mr22033851fa.17.1789995943840; Mon, 21 Sep 2026
 06:05:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 09:05:42 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 09:05:42 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <3e3a7197.9e4e.1a0c3e88117.Coremail.zl020895@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-9-282ff5d98dda@ambarella.com> <CAMRc=Mf7dtxvxBUF1fOuKw0mxdhCYPj=J4ckySPZUvcZ7a6cbQ@mail.gmail.com>
 <3e3a7197.9e4e.1a0c3e88117.Coremail.zl020895@163.com>
Date: Mon, 21 Sep 2026 09:05:42 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfSSHuPxOrP95aW5HXXE74f5X-yjr-KNavz_=tU__H33w@mail.gmail.com>
X-Gm-Features: AcwNN1XpPns_pQlHseY9Ez4-fOhLH2UhBc-jukWmFLjbznkNpQwaq4oL4Cj_puk
Message-ID: <CAMRc=MfSSHuPxOrP95aW5HXXE74f5X-yjr-KNavz_=tU__H33w@mail.gmail.com>
Subject: Re: Re:Re: [PATCH v8 09/18] gpiolib: regmap: add gpio_regmap_get_chip()
To: zl020895 <zl020895@163.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, longzhao@ambarella.com, 
	Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Linus Walleij <linusw@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Lee Jones <lee@kernel.org>, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sep 2026 14:19:49 +0200, zl020895 <zl020895@163.com> said:
> Hi Bart,
>
> Done, sent as a follow-up:
> https://lore.kernel.org/all/20260921-gpio-doc-followup-v1-1-618738124f4c@ambarella.com/
>

No, don't send follow-ups before anything is picked up. Also: Michael Walle,
who's the maintainer for gpio-regmap was not Cc'ed on this so I'll wait for his
Ack or change requests.

Bart
