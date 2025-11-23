Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6974C14;
	Sun, 23 Nov 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763936848; cv=none; b=jdY8qyMhwntQen4u7AZSbAHcZ7INTllxVN49UotZ4dAZ8QHRLiJ1Bdk2GW29KP9lpEJ0ZuOiGU8oWN9r7l+agFolK0HdlbeFJeGc1xKTbq9GlDlkax6M077m/9JsAnVDWhZqjkwBLloBkmDizxzJrHq+y1glWJIngF6ijzRW4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763936848; c=relaxed/simple;
	bh=quDPOJ1bxIEUTCsg+6JgowNESYD93x73iDlGuTIuswM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXC1jZPunAcoLJBRYj6X6oUxiqJIJ/rj02ETs9BfLPQJsW6u8Fq+H43yTxsSmxaGxqlqsPQDA0tg/gnpUGGHUfuWsXwy6b8AOJ3h+KWJixk/Ppqput3IlcamDOlrhagcndJLwR6ndkWGNQI3p5SDxgIJ2QxFupLM7r8Co+7pSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=eZctvz/A; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="eZctvz/A"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 953B51C00AB; Sun, 23 Nov 2025 23:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1763936843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xAznBhU7b6p8zrOxLbtkgNtB3cV8Rju+4Nj3dJJodo=;
	b=eZctvz/AuXpRgwETlv1Z76brt46sfWxyZhJzJJYhqbkkreqWfOEmZbhoFcyVgHOka59Cq9
	khR5WEhVnzLBx/wPiaxlkz9oI2vkUApME9IEhexQqCfe8IFDTerizsPYYCji2GnTplKXqw
	XrwAHnIJkkD0x55zUhov5YKJb4YpzDQ=
Date: Sun, 23 Nov 2025 23:27:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Douglas Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Drew Fustini <fustini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH 0/4] arm64: google: Introduce frankel, blazer, and
 mustang boards
Message-ID: <aSOKS35/huSWd/RW@duo.ucw.cz>
References: <20251111192422.4180216-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YeGGzS8kR2qSk1N0"
Content-Disposition: inline
In-Reply-To: <20251111192422.4180216-1-dianders@chromium.org>


--YeGGzS8kR2qSk1N0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds barebones device trees for Pixel 10 (frankel), Pixel
> 10 Pro (blazer), and Pixel 10 Pro XL (mustang). With a yet-unreleased
> bootloader these can boot to a UART command prompt from an initramfs.

Well, booting to full system with working cameras would be nicer, but
this is good start. Do you plan / do you have resources for full
support in some reasonable timeframe?=20

Please cc phone-devel@vger with phone related patches.

And... thanks! :-).

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--YeGGzS8kR2qSk1N0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSOKSwAKCRAw5/Bqldv6
8sPoAJ9cO3b8E0fHRQKhJnNaeZSI9nez0QCcDEiBnY8VsCk6Oi+ran/TdVPmbIw=
=DqOt
-----END PGP SIGNATURE-----

--YeGGzS8kR2qSk1N0--
