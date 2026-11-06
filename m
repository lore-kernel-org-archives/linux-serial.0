Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973644;
	b=f1UGNAHKkEIF8ShVk021GaZrQvu7LPuA9xAMgxwBiENpuBZJ0fLliGHtk2YmY6hUFafX
	 i+NgBZtCp3jGMeZ3jz0ij8rlvDLGv3pfsVvAvSvW7Q2tlxnFpCDi9ymPPYI1p2mRZc3hB
	 xlRoERWRQddcXPT5ZEEJ5Ol1NU44m5jQU4MWn4ppfO/8z4W0huhfglgbkgghMU1TFYNl/
	 1QDpKV7SOmf/fGMB3/uKXIF6zK8N0dg8M3FJasBrjjh0H0890fLUTEeXsp+E8gj3uH9Cl
	 eT4YAcrVddG/wjQE0ekTAqukHhg8ONlQBZ9xNaLMGi/WhconWT6zoHi0gl4vtE24cmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973644;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9bu7YErXfbpqmLGN/a9gbyB57Uy/iMWPZ0JE3oDWOuE=;
	b=iOF+2xFpQROsvZiQoLE+pYDw4BUlddr9jpmovg3eLPgihJGCmbdKfcPbwhlyPYjaWtx5
	 DEVDl9YANyczDNpy3SQ7HlGY0a6ze5wqu5GNGcYIxGLUUF0/l6t3u3btlzwKnwoMB4Bzb
	 tqGJfn27QEdYveNb6SQCEQwaw7oDQEiRlzfcmcTgw3R3wMDjT1ixG5LNKMzSmbP7JJy0X
	 lZMYJsYgL6obkBYOeH29+ruzhoaXB+Rl3N6eU8bOV451DZkgOZi+m2K2zmQu/PIT9GrHG
	 yb/Sq2FFfohIEdOBRDaXX+tHmQsOuoxk92gkY3A0DhoiWJissApuR4H6k4Yrxi6JXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuOBZhBf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D0606EE8C;
	Fri,  6 Nov 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuOBZhBf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E8B1F0089F;
	Fri,  6 Nov 2026 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973643;
	bh=9bu7YErXfbpqmLGN/a9gbyB57Uy/iMWPZ0JE3oDWOuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZuOBZhBfp5pLe3zkg0yUfBaFnvd1E4dWKompO84fp1mwHiuMpCFKcYZMgnzOOJ7tr
	 c6Of/Xn43dN9otOXsfNaO5MvLvuynSscZVtPQM63aImmkpVvsg/4SlNAz2B2txg+Tf
	 brlnG9SwHPkeSeTnRR3xtgvzNvJvNrjKI0G2yuOM/RVoV/KsP6inceCeSimSjmvslh
	 2mWhxlmlzptWCFO5taUZKWb4uqzmg0G8UovzwDdQxx342IwtFQ/hVwWlWygrsOCiIp
	 m4ZN0svmxlOkj/VewPP0PiVUbbijv5+Y6LoVCSZiTFMGhJ4n0hLB1hUwLY5bJZ/yUb
	 B5Bugi4gDDhYA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xPKUi-00000008bfB-0wUm;
	Fri, 06 Nov 2026 15:00:40 +0100
Date: Fri, 6 Nov 2026 15:00:40 +0100
From: Johan Hovold <johan@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	luan.r@variscite.com, alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 0/3] serial: Support driver-selected TTY wakeup
 defaults
Message-ID: <au3diCrF5jPYH4Tu@hovoldconsulting.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793719239.git.stefano.r@variscite.com>

On Tue, Nov 03, 2026 at 04:51:24PM +0100, Stefano Radaelli wrote:
> The initial goal was to enable TTY wakeup by default on NXP LPUART ports
> marked with wakeup-source, without requiring a userspace write. Instead
> of keeping this entirely within fsl_lpuart, this series introduces a
> common serial core mechanism that other UART drivers can also adopt.
> 
> The new tty_wakeup_default field in struct uart_port lets a driver request
> wakeup to be enabled when its TTY device is registered. Each driver
> decides whether to use it. This series adds wakeup-source to the LPUART
> binding and makes fsl_lpuart the first user, setting the field from that
> property. Other drivers retain their existing behavior, userspace can
> still change power/wakeup, and serdev wakeup policy is unchanged.

This is a policy decision that should be left for userspace, not
individual drivers. As documented in
Documentation/driver-api/pm/devices.rst:

	The initial value in the :file:`power/wakeup` file is "disabled"
	for the majority of devices; the major exceptions are power
	buttons, keyboards, and Ethernet adapters whose WoL
	(wake-on-LAN) feature has been set up with ethtool.

So no, this doesn't look like something we want. You should continue
enabling wakeup from userspace on systems that need it instead.

Note that the "wakeup-source" devicetree attribute also describes
capability, not policy:

	Documentation/devicetree/bindings/power/wakeup-source.txt

Johan
