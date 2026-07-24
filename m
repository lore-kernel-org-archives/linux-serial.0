Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF31390C89;
	Fri, 24 Jul 2026 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875220; cv=none; b=VwjgEgK2LAXkN4KmSFed9c5sTUPgxSCl5AOnxpPXUpzjYdgmkjmMHhmLwl2YTpWpxsCK3rdpsGSBXHcmm18U2m7pjHvYCKU0eF/jh8sZOW+w6adhNzioH4Do0OblA0GihgzlotVmi76Y5AWti8z1mDM+Se2ut/HMOMhM2Ydo+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875220; c=relaxed/simple;
	bh=rUTUs2KGbeJsUWQqn+HdNstkBpoXH0i2GnzD0Za0520=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8zRSzbXqT7QPumYoyqQASgSaFheNpFrABFEDZZwvlXlo2R+7cnyLPWoDy6lBkafwjKnCilmqsJ/SYWQYjc6mCk1vcqnK/bACJODjEp1wk43CAWL3yTaFnPl41+jKo8kZYMDr1eYoaYPqskiiU6cvoIogpqqNoHPES9VMup0bdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVaJJZTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVaJJZTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB71F000E9;
	Fri, 24 Jul 2026 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784875219;
	bh=L4SpAErSPspS4jrFPaNl/RX6dGWCCbI6bzmXbcp3+3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVaJJZTYHaLn397U5HyfQBtSwUbZBMwDylwqYB9qZxwDKmwVXUbBqyY8SDhUlJ5P1
	 QEq6QXO26YNrn7YsqTIVJRtJifexArWJSAPg9XCf+4yO54zMOsF4gDFRm/9APeA33V
	 clGSb3XZNuWQ80DnVmmvgOE0Nqvvib4MHrdpHbbkfmjI1kQC4xPgfw/aiU53rJGC9/
	 aZXEYx7qU0jzm87/JRwf4GSE9bAgi4IMEJLxYD1QS4ja+Qu/X/BqyJwkIKZ1hw/sVL
	 ECXQZg5E281Otsgybigq1ck1IzY+2XjVjJq+VBQnAf2e2gPse+i4Qet7ctleBLeDC2
	 nzDS6weJbr5Bg==
Date: Fri, 24 Jul 2026 08:40:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	William McVicker <willmcvicker@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 0/5] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
Message-ID: <20260724-raspberry-otter-of-perception-b8ef80@quoll>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <amFZCkt1EXtOjOYW@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amFZCkt1EXtOjOYW@google.com>

On Wed, Jul 22, 2026 at 04:58:02PM -0700, Brian Norris wrote:
> On Wed, Jul 22, 2026 at 10:55:51AM +0100, Peter Griffin wrote:
> > Hi folks,
> > 
> > This series adds initial basic support for Laguna (Tensor G5 SoC)
> > found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
> > 10 Pro XL) phones.
> 
> ...
> 
> >       arm64: defconfig: enable Tensor G5 SoC family
> 
> I'm not able to apply this one cleanly in my tree, although resolving
> the context conflict is trivial.
> 
> > 
> >  Documentation/devicetree/bindings/arm/google.yaml  |  48 ++-
> >  .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
> >  MAINTAINERS                                        |   1 +
> >  arch/arm64/Kconfig.platforms                       |   8 +
> >  arch/arm64/boot/dts/Makefile                       |   1 +
> >  arch/arm64/boot/dts/google/Makefile                |   6 +
> >  arch/arm64/boot/dts/google/lga-blazer.dts          |  15 +
> >  arch/arm64/boot/dts/google/lga-frankel.dts         |  16 +
> >  arch/arm64/boot/dts/google/lga-mustang.dts         |  15 +
> >  arch/arm64/boot/dts/google/lga-pixel-common.dtsi   |  23 ++
> >  arch/arm64/boot/dts/google/lga.dtsi                | 423 +++++++++++++++++++++
> >  arch/arm64/configs/defconfig                       |   1 +
> >  12 files changed, 539 insertions(+), 19 deletions(-)
> > ---
> > base-commit: 17c7841d09ee7d33557fd075562d9289b6018c90
> 
> I don't find this base commit in Linus's tree. I only found it in
> linux-next after fetching this hash directly -- it's a linux-next tag
> from 20260507? Seems like an odd old choice. Might be worth refreshing
> your base.
> 
> Apart from that and a small note on patch 4, it works for me:
> 
> Tested-by: Brian Norris <briannorris@chromium.org>

This does not apply to 60% of patches here. Really, you could just reply
to each email.

I expect incorrect tags won't be picked up.

Best regards,
Krzysztof

