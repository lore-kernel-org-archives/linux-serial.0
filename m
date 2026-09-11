Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969E265CA8
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137512; cv=pass; b=gDyWYQ8qg4juxKwmTAm4fuzb/M5tDoq4Ek7RuLdV00CdaJLqHUIaTrF3467cl+J3xCXjKA1NTbtynp80GAlcWJpDnnLf0Ga0Ujk+Is6kKTAHX9UbHRSnUkjGkxZZ4y28H+tW40iiM9GFRYAJuC1ytIWaye44QbAI6hxExNxDmLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137512; c=relaxed/simple;
	bh=XLpKjuu4srfrU1du6/lAaUzD7jl948KYiIqSg/FlWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxxbOXhKnNsgmDpapNxCO3K4u9vaWW2yfDgind/SacaOt+0RcR/E1a0wOYpILJev+ouoBYVzh2dPvH55xMokPgzcFfaMhNlsFjEjdVZIWFzSINi3dE4CZCXjXRfoi8pgJnLkbXmK6GnSDThxKHb05WIZsrxJtKq29HFskkryM+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HB8Y+RT4; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HB8Y+RT4"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8588583a7c3so9079347b3.2
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 07:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137507; cv=none;
        d=google.com; s=arc-20260327;
        b=PBvJbQ45sW4IVSG6TAyPPUYA0cqhMKrE1SoUVUdVEPzTAqAx9xH1w7q/BBcbOwdQNh
         kxpUiPQDWUW6FBYfbxxo9hsUnGylkWlt/G4jKNzByckEt1Z5zgQuMLRH490K3QaHZdVh
         6jbtCXtoSQ1/lCKzQloib+ewerb8jgGTwXEpQsWJGXT6tk2yEVAigGLcNGNA3b2jRLzV
         JXAAnIBFBMWNtUQ9UZzQyWDi/4QCWPczv0I7dGD84JTq48axA6rAA8wwrrT8TN5oMvU6
         BcmdmHWR2m5MNnNEg3xJK1hjW4h32WD0EvJyrepggfL0lCvRo+eACfroAlb/WoeSzZhu
         0TIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        fh=lgYAbjbE9uNC8yiCg2xI34ShYrNgfhEw3BK4FcBfzZA=;
        b=EjBO14n7NeKC5q5GIVEyMZaF6p3EmJh3KnSRDFhyqMUin7ANX3yvghMPPqFW2mgMHa
         e1bkz9HruTlfq3YLeidlPx0glzdXKVILay1wi+r8I6fEvuXWW4f3LaWKbMgq3qZw+upX
         +Ay5uh53DhC72HBIdYLz1zTybIlbZWNbmelXjGRE2dHWR79QO6aYdfE0b4vN29eiTmye
         tJtsufuiposQe2sH0sP/fsYDsqGvmS4Ioqa7xY9HcHt/Gx8C4zdz9vscMziOz/eCtJug
         R1t+fiSD20FNXcY3ru8pLGG3ojPkuC4bTANxe5/tAATGdJ3RgnOP/KxCfVexKijbExhK
         RS5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789137507; x=1789742307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=HB8Y+RT4TRPooM8mqpi8DeLFRTPVsBx9aCjZB/tdFSV51HaKr7YUqtjHQkphkOVbT6
         uuwIWKH3SAN0TzGoi7GXFe0YJRT5iKtXrRz5k8GxzTLnZPeidsaT8lGynlHxy7GjzZ9r
         wzrI72QggorLaBikBSbsEG1noEYrmgMFuOan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137507; x=1789742307;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=AtlGwSPKvotw+KjlUMSPE102cRSoJjkFb2OuPaIXwrVS9ii6VmRtCyOXlO7OGqKEmH
         uTEa6xR9c/hF16+T56n11D/ove0lD9cENlT8FQxlq5UFjZ+6ccQQRVkarAXFAvNJyhVh
         JRianPz2d6n32b6vSc/uUhBmNnxti9TgSI+xjlL8wEg0Tl+90X9PB4B89IChIY/JPwWq
         M7Sgf9OuOhXZWoulOrVS8OB+tpR0TxPz7n+3oaxQLph3sQ2cLrEjTvYT6QouKbZod8Q9
         kj/H4scWSp9oeWddy2JzAkC2EIC3qN2siGwdv57HWmD5hnnXIOVcS3QmfxyI7A6Lg6IC
         AHNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3v0GGWli6f0PLWpOkVkJm/Nk29C1UDZxh1kgUtAAVC6CcivqLu2r+vNDBY1zLjHHTb4zrEy9hByNrtRM=@vger.kernel.org
X-Gm-Message-State: AFuF++mcXEIPbzCQ7eF4mhM4x9UkGe0lyLVo8hVpXUEK6Ux8rqy4mxiR
	3v9vPI8YZ3L0frjwKE7MH8puVGn025M225l6f3Tu3c2M/LUMfnySUHQb6NKcWsf9+O1dFEFBY7Q
	yzNdCwNobVWMBxWgQqpqw/6tw2I1pPyWVyC3fnuIkYg==
X-Gm-Gg: AYBFou0z4oEzhYV9B1w4DV8G9Ok8f2UqcVHAOvOzSZkzNUWfEinIom70OvKI4EDnahb
	1A/1tACuljHu4atFPnrqagm44wFev7Bydh0vVqgzXBzHjKHmeZ71RF18p0ZNZWp2xBAdFEJ8j+h
	sdtplbdP7LFLiAv1vKaX4Gv3GZ/HKhuSZJxpa8YiCIUdQappvO5EYnNiIeVAiEBBJnR+tJaJ8WY
	HR89+S1nySoK0bFRBXznlw0gtaldWYdMrxe7E+2l/Q6/EwR4ek9BNSDKpQFzhn1ZHtptuqHQqoE
	f8vlSrh83Zb92MuBMhrr8e0NJO+D13WG7CgL3qIGA+hQvDZoLZHGexGD+seKGB7G
X-Received: by 2002:a05:690c:399:b0:873:5bb2:6c10 with SMTP id
 00721157ae682-884b7316b4dmr14810657b3.58.1789137507274; Fri, 11 Sep 2026
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
In-Reply-To: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 11 Sep 2026 23:38:14 +0900
X-Gm-Features: AcwNN1V8w1uOymS_yob5PvYfeWzm1NprI6fjxQoUm4Mlo3gyAoZUnypuVT5lDl8
Message-ID: <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Linus Walleij <linusw@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

On Fri, 11 Sept 2026 at 18:11, Linus Walleij <linusw@kernel.org> wrote:
> - One camp that are enthusiast like yourself. That kind of people
>   are running the show inside arch/m68k on Amigas and Ataris.

I have SMP working on m68k (dual 68040, real hardware) among other
oddities. I think some people would get a kick out of seeing it but
also I think some people would also ask why we can't just delete
everything that isn't arm64/amd64/riscv. I'm putting off sending
patches like that to avoid everything getting deleted. :)

Cheers,

Daniel
