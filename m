Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4A4BE448
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152212; cv=none; b=XPoBdBrdp12HWHKJY3cnrcDlwOuHZT/XRVYfGhmAWD0IyOmqD4LRwRvmhTu8Ip9x8TOEKjRroRkdiGIxWufk8xT2EaMz5McE+2JT2aGKjeztlYtX8/MheTvxDbPz4w8Rg+iS1qwt2S4lsXG3dXvfdvpofigI3qhN8t7tbEChv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152212; c=relaxed/simple;
	bh=Vo/Zbo4FmIJeIV5z2fixRdEtyG30qlGNFYOjHoNYkqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZKMGn8CJGWsFLhVG6wiQos1BwbeR/bZkzeim6yf6pA5nFzlrPlG1/luCISk1QByAuD4jK+yN+1IO2wR5KofpRDR0eUNdkGtkYfkGOIW5cYBB70RA2Jq95gnxlCtYOfHxRo23gOC4lh6OKI9Xnkj1MDmtNVc2secpn4G49cxcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkmGIJbB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkmGIJbB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so95775f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152201; x=1789757001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMRrWkwvFIDZfKdDi5vmlHb7sgj26/s86919xqFCGg=;
        b=hkmGIJbBp4EQG8Uj6bpqrQLLIx6687IoycAymJGV+AQbiulxMddwk/XjuxgBdaOgRh
         vjlGnpEswovnh80F9t8tbcEwpHnU7ilhSJSoW0LTmXGNZMYdKZcQBLvAHXrDgJBDeok7
         ZqmJfVVT1Y2C7Yk7vcFHuRPXWxQ6+IWNvElRuinPE86yblBvn8Wnq2azuUCCa5QWd3bf
         qK4b/vMq22GGwsDShePmi7WSgExb5FsepmNmXsf5rbELNjDZ37OVZnFrpjXxcBMNVauO
         btSHH3MjcKO15Zq7kM/kfsFWwG6wlO9FmPwkucU75k99FIABnvOlg7eQK01Vvw9l03n6
         F2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152201; x=1789757001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMRrWkwvFIDZfKdDi5vmlHb7sgj26/s86919xqFCGg=;
        b=kaoNkCxiuoMVQCFQwEXTgc2wRdEzxEkoKcTYtyKYADzBM+qJcHAZ12PCiASC4xi1US
         +CV04eDQvUkAmzzcdlWLmlJYJirn55OXPysep5l96y7Yxgw83yHCZI9cB67fQ5AyCuAL
         7v1clxEEE/5NRD7xvlPV+WlHkG0LPuUcqqcA5zmVtSoWjmVt/oNdMje+QswG0zqJizQD
         I+5dQl5WwPRR/6uccrWBjS0qDAOrCYGBzMOJA2pTFNCj2yjWPudegAliBgJ2QWvwZ42K
         pXlFqEbZjsfU6R0scZ53+VpBoocZWZiicXsDsHg3S4uheOl9Rs3QXGjjdw7zWC6eWfuJ
         KZ0A==
X-Forwarded-Encrypted: i=1; AKwUvBxtZses51mWB1cc8DapkA+dK2CeHd8KROe5r1uMkV00kg/6Li4xlcpEKRwM0u6XnUgk/qkfOBXND5LLzCI=@vger.kernel.org
X-Gm-Message-State: AFuF++kMyuvX7ce9xrER7X2WIme2jGVCiWVA2T4pRMYuwsvjG5kXpLbU
	Ke0inXgaY0iLlJwHlzIzHclohzGluuDppjP1+GmcTTlptlUii8CGariE
X-Gm-Gg: AYBFou396GB1+eXtNE15xsL5Wq3Jswbfp+dsYPrs9K7t5UI/Sf+0V+YelG+RQXwiOr/
	wgwjdv/Pj6JXs+R4t/U4uVKGeCo7rk7HjhKMflqGU5fyJV6y60cd8rYkcAJ2qF394yAMD80Ujlt
	dYSM9b0ptOvpg9nd3N8OW1QdnPo80RsDdUtMDGSDtqGAcwvr8ZcoTgW3zm3qZNLw6PxshEt2dpH
	hOjJq92tt8ho1gt9+E2/FaF7K1fTzQFLQpoKnIgbf+h+teHIDqMSRAH87P4kF8didYJJMlEAP+l
	zoKb2oFym/KIGjwjauNRxXJEsVHovPgvf27OLDbDLY1A7/RL/rbznkksfcAcw9XR9I5ns/CiVn3
	cZWPQP+m0AE+1Zg3pK+tujoWMBecwhizYu1vjHz+L84YZcqWczVsucg2bqq7Y/m4x/LGVAHSurn
	sL+k4HUdJ4vft9fBXW5vmU8m2ns+weoKuLXFZ6qQb5xxNVWTmt5Ec+6iMKv9VbRPmzjiaNCZ5Hr
	FxJ6wddO6CjKnbzys+h4cOdw5Xw4u4d70s4SL94wTFL7noNDS9TlTaTuljXwn6VNXKtruQNgG6P
	9U9va1iEq06yUe2VRWj7ps0WHAsyoJ07Sd7UpNxw+T/3ERAYSA==
X-Received: by 2002:a05:6000:4605:b0:485:ac39:36ef with SMTP id ffacd0b85a97d-486eb1d3781mr14290458f8f.5.1789152200719;
        Fri, 11 Sep 2026 11:43:20 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm5446009f8f.8.2026.09.11.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:43:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:42:46 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-omap@vger.kernel.org, Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, 
	Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Message-ID: <aqRI3N5FPX1dpIlk@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>

On Thu, Sep 10, 2026 at 08:44:34PM +0100, Ethan Nelson-Moore wrote:
> 
> Because I think it's cool that the kernel still supports actual Acorn
> hardware, I patched gcc 16.2 to restore ARMv3m support:
> https://github.com/EthanNelson-Moore/gcc-arm-retro
> 

Nice.

I've made a RiscPC emulator in the browser using QEMU and WASM. It boots
Linux kernels and currently emulates a StrongARM RiscPC:

https://github.com/kmehltretter82/risc_pc_linux_emu

I used LLMs a lot while building it.

Your GCC work looks useful for this. I will look at building the RiscPC
Linux kernel with it, and at emulating the original ARMv3 CPU too.

Thanks,
Karl
