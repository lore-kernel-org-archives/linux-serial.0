Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F14F4D0B
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061096; cv=none; b=rC9MIDPYwFtDPIZO0FLYKpYWIgK25bs69JyU3wR3FKXvkBTem5sxo2Lgg1ob3dR8AAC0NSjV0fF9m5ykiHRU+ImL8wqk1OzH773Kmx3Y5FdgwxZHapgZYf0vmzJPqH5JdizjrS5UO0hq/Bae5ZY05YTAx1/xhD4z1HN404UrBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061096; c=relaxed/simple;
	bh=1DQEnJFVllHwbW40pTjtz3mCOVWOR/ZxQR6GILf0wtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZHiV/TiRoRPeMbcv0p1KzDPphFRdzv3UXF7aABS8T0MiaWyLAYeywMdYWJQw3RsyhH3M+kTS3vQ1UJlmaV2U4Gc2z009utpPLBGKNRiHgoagRIWX18na3CjIMcso2N4CP+vzBL5kvMhfxF6gwT4kImGvSJrzD6dIbfrYnHPgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNsaA6B7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNsaA6B7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2204F1F008A0
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790061093;
	bh=1DQEnJFVllHwbW40pTjtz3mCOVWOR/ZxQR6GILf0wtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fNsaA6B7GRuwLvYuXQcayIRY4asybossgKMwLKRABuip02ua4A61yZWh4iesmCjft
	 aaILkaPVfCUJUMa/KErN+dLjURjqguFpeVphaLeXZFaz4jzdbmv4d53daBHoydx06w
	 XNtxbIB1HX0DTUiHgSkcYGIkYa8qwi96lFVVH+qz8KHECYPCRdSQgdl4dFweRhRmBH
	 D2KIxl9rUkSjg9kbWqnkChinhE6PVPhb7EiW6jdf6LLY3IP3XYlJPRZXykjzhZqkeG
	 jF7MgmoYvKj9R/a5zdIJ5WInRhvW5kqpbFwxeiDMXkxqDJA7zquY9XCeD9KEJXD4OG
	 w0EVOxdf+oo8A==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1e419so1451024e87.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:11:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwhuV/fTwgSlpRcuP7zSt0uAqzRhvMGhiNKWK50TqEf+7Mv7+IS41w66tjbI9Mbylz36wGbQEtwpdJ+pUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mTiDe2A6OkN45WCGOYE2+N9Pm/3uR6+3TncdbFjJcPY1Pcq+/r
	ejicvtj01HB5yXmeGPkIFzXVZIOmSP3KTIwe5l7t7sNqFWDPNRvo3saYf8JjfXwvDJCn7Nja1CW
	XFDS8ETjxQhQ6lcBcneudpys6bqT2dr0=
X-Received: by 2002:a05:6512:669a:20b0:5b7:5cbb:661a with SMTP id
 2adb3069b0e04-5b8d28a2bd4mr380020e87.0.1790061091499; Tue, 22 Sep 2026
 00:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com> <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 22 Sep 2026 09:11:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLnUVOAtq-h_qDdWpEhZFZehFKo4qqgcTHD9zDQTdF4yhg@mail.gmail.com>
X-Gm-Features: AclHuK8Ptv8BXFdyCOuHHolcneppaQqVWDApnFcw2pV5vhsl1672OQ5Dk_LeJfk
Message-ID: <CAD++jLnUVOAtq-h_qDdWpEhZFZehFKo4qqgcTHD9zDQTdF4yhg@mail.gmail.com>
Subject: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
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
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Long,

On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Document the CV75 pin controller binding using generic function and
> groups properties for pinmux configuration.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Is this something I should just apply to the pinctrl tree?

Same question about the driver.

I'm not sure you'll get all of the Ambarella in for v7.4 anyway
so what about putting some pieces in place to begin with?

Yours,
Linus Walleij
