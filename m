Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7583EA97E
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098289; cv=pass; b=vAE+sI+qdzCriA06nBkDrHaFAEJP0tKOiReEpspArH4Du1MF1rebzch2zgp4QfXNdm1F52uTLs/fe9lxryWcpwz8PtMFVerDRFLIunHes4qfu7V9wTdvupNcjA5xa/n7060fAvnlTUAZA6xPlc8cChWcEgYDJFuQNoRJaXJiX1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098289; c=relaxed/simple;
	bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7jg4JGao+BXfqrG21++Q9CLov1Uf019Sjq057qEXw9fjpSwRUyBuhxXmnDjCxEzNPKRoYfW3QZTpz1O5Ef3eJBuYAmC1rAQXjajGboutCynu1UxJ9AuI/SVDIYjFvHJ2tMxk1RTJZO28LHHzRNhM52QWzz6zemUrF9GM34NWt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2V24x4G; arc=pass smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2V24x4G"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-51bfca7f85aso3859831cf.0
        for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 20:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789098286; cv=none;
        d=google.com; s=arc-20260327;
        b=oXFb0wtGMBCJd3d99muW+QvYJ7v52cbYD9CsBR+ebQRF2xt2sT0IqLDIHOcA6VWB8u
         vmv/QeX8Y8uYvKQzqYQK4V8uGoVi6hzjpz7f64YfwmtvtVT1eTE7aSxUshj5kHZ3t+Si
         HdL5rS3CmD0jqtx5+qAPprnDhIUchBYZrAfGlEX53MHPx4PzVKs0MpA8ygCyybDrYDSB
         12oqufQOe8q3mHSphbW6cLaQA0UJWBJ/n4FCIqhNAddHk8CFZRIa0yfav8js1Mf4mABH
         wWHXvYT8kdgc57PxLpYqBGK/uGie/+keJXVVjGaKhRPQ8kQItKwJ+e60OAfhXi2N5wha
         iVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        fh=gcXAhr/GiPc6MTYwUHugQXykKHnvS3hX1vG7fD/R2/g=;
        b=NN/UCHqNF9zg/2HRlOp6dfDVcd7IflVhwj2ZN+cQoBnnPnRFdJQDwpzcBsTc6Tfovm
         Zrwfq3xP0BHmvCjuI311gpds0rY+c/R5hjj4twlQGOihJkwWrUQJlhZnwcdvFK5VgTOw
         Q02hCLwF792RHXHed2ezgxYrTPbkgQ4nYuEpcMhv+nD5KmtgSQXmn8Lm1eFvovy0CiSD
         irVVRLoOuHC3iKKxbV4/Ht14vnFl7ZK/bwv5J5VVSwVzoz8AgcHCk19O/VgcHT5oBpD9
         kb0nUfNO1ArLdzkeTHaaRXMvlwJJuERsvTj52R5/BJgpvd8/UFxI8AQ80VQ2CXquK+HY
         5Jyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098286; x=1789703086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=G2V24x4GGyCwAd8LaJ2X8PGNbql6wdGj7itobGHv+DWtilwCENd20LNJWE0FPLHB3/
         0AjlkwMCGqs9CTmfIsOad/o7305l5dxeD1ZFHVPrHnNcoEDHmmOEkUoLBmMXN0uGF9mA
         NFt62u0bdoESjLGcIpLtJ0v7+FmJRxrD/o1lT5g+LldSZZhD3Og4hV+mUCCZhqbjd2JS
         rECTuLTUzPCSAjku7N+dnRXlt7UYkl6EGUg9xcf0TT9TiheCSHMZR1kposahxXE8JxLQ
         5XMF89T6zDhqWdtlqtNhZhEm9Fss7ApuSwbHeeM2sCdkBm+3v8htMXW4iBX0va4HMp+v
         aDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098286; x=1789703086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=lV4meu9jcTNWzmqXKkpD3hrVDa8bE8/8y5FO6iIARvzBn4vow3DgGMyTSvJlKPgLKd
         vL3PPvC7L/lMQLitQKHTnCgeuU2xlF4df5i5Pz2bQxfkepT65c9hYEWxzOQ7n+qw5xbC
         M0MP5SoMQW13jth2CbpQQr1avJQVUGiX5pi5ly0VVVf/ZxDYUh44NGuI1vJwG62Pmekc
         yje9SOiNJSnrUP6tr5ELqAPNf7Y92FCLCwtDmnjiZlPpxdVLLMTZIKUL7S4AFicHoF8R
         oF2BZam3MPZZ1QJD1tAoC6lqSXSp2HhJVDI5iaRBNXPHTfwKWLed+b1TU4NUVCsHQEBL
         jhag==
X-Forwarded-Encrypted: i=1; AKwUvBwMbu+B1a8nFQ5QnQtb0DOA8hxURvk3pYuYjBi3V2iHnsJXqYeNfnnDO2iMIgz+MPkA5uh24Sb+PvOrPU8=@vger.kernel.org
X-Gm-Message-State: AFuF++m/eMXZBliQd/ReXULe3+k/bLHENlBka73H50eURrStIDJeg+Pb
	OXwxa0hfGvTUGWA7bX2Mjea57h95oVVfdOFVX/NRSUTaoMYrvQ9Ro4TZYJjCleE+pcqBPJ9M9c4
	Hgf6+a46BPlkDEWcnblT+DirgDp10W7s=
X-Gm-Gg: AYBFou1Zvr///5TBlBeh0nxYQtM5Gj2O08cToKaT5HAtJC++VOxUbEB885Eajbr2kUo
	wNMZ5pvhEqZgBd1VR9UAFVyhwmUmRVVCcSXZ1KiPULctXPe2zpJB7oAyx/GLt681HbnzYo0llAd
	hPlCLxQLsQQzb6WUGttbQ/G1p6Xp2nN7pUQweIV5vkGVobA4wI84CC5bhzz5iYPU9jak8nPp5vn
	wXnyOvGrdXYDMBNmOtZBrSYg2WW5WzkfGnVc5iMbg64sTopS274b9GIsyW0MP5hwzfHKuECKx7s
	kvj5YeufqUGzuq9zmLs8BtbisC69iJXwnJG6c4enh0+N4nUQ2j11Q2vtUDh3NyJxDrp2DukVrlG
	PjeI4qhF/DDLO3uQ+v4VnhQfnOPkHEOaZ8Req+3Gn
X-Received: by 2002:a05:622a:5987:b0:52d:918b:92e1 with SMTP id
 d75a77b69052e-530c84f326bmr40390581cf.5.1789098285727; Thu, 10 Sep 2026
 20:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-4-arnd@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 10 Sep 2026 20:44:34 -0700
X-Gm-Features: AcwNN1V1fOC0jmd_i5r-nVHD_ZWN_P0KCiZNA7MUoO0nuGcjQ9okMtkGALkOIWk
Message-ID: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
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
Content-Transfer-Encoding: quoted-printable

Hi, everyone,

On Tue, Sep 8, 2026 at 8:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> The main limitation here is the CPU bus that does not allow 16-bit
> wide data transfers and hence requires the kernel to be built with the
> -march=3Darmv3 compiler option that was discontinued in gcc-9.
>
> As gcc-8 is barely supported for compiling the kernel, this one
> will not see another LTS kernel release, so remove it now.

Because I think it's cool that the kernel still supports actual Acorn
hardware, I patched gcc 16.2 to restore ARMv3m support:
https://github.com/EthanNelson-Moore/gcc-arm-retro

This ended up being surprisingly straightforward - only a couple
hundred lines changed - and it would be even fewer lines had I not
reverted a commit that adds a use of ldrh instead of fixing it.

It is able to compile a kernel successfully (once you update the GCC
version check to check for -march=3Darmv3m support instead - I can send
my patch). I haven't tested it, but I am fairly confident that it
would run, because the assembler will reject code the compiler
generates with unsupported instructions - this is how I found the
commit I needed to revert.

I am working on a clocksource driver, which uses both timers (to
hopefully fix the awful time drift), and removes the dependency on
LEGACY_TIMER_TICK.

I also have patches for several cleanups to Risc PC-related code.

I am aware that this has no actual use case, but it was fun. No LLM
was used for any part of the work.

Ethan
