Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80A389E05
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088339; cv=none; b=tqtpN4x4xNo+gFvsbEzVzoPMYxTiMJB3XJS0GlDzryEQCeU2tt6jEAZOQ3Ph14c4i+JWG5ZbJnydRI5WF3w3vZFQjVhn4faSs2CCuO2Zp4O8aF0LTgpPQevC0T3lF3P2NNrQu6XVipZjI4lkcpzYlynpUipW7VRGc9ewBDOUyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088339; c=relaxed/simple;
	bh=6+7YwPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwF8gEgJ+3f4P1xp4gocdXRWPQ31W9zB6DKs1MFdtmK7vgoKKUC+8oPaG8czZnA1hVuUIuAxVoFfCVtJmAK2S2sbDJr5AlMDqQnZALjC+/ZcHTNi2zdj+D5qbqMjAVXd8+ZqS1tX/ks2P1pEIi17icUT/ZnPG0pUXYmZ25vdxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CguFkjds; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CguFkjds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6+7Y
	wPssrYwwbcVyy1E2zRmvrRlDS05FVVsJW9+Xl58=; b=CguFkjdsvQ8uo+wX/xEJ
	3RiokJSXD94GoXAfVLjWKz+1uejkAw7kl4/1xIpbNhEz9+k8g68TzFsoi6LLucFN
	Ndwn5b23x97IbqfUJS6Ka3H72pLXZn/70hR4VEbM5/VqqBrypDjeacVP/f3C862U
	QWEM/koX8XX8b5wCCJBbcEyGr3j/76Lp52BWBC+xXj/jZb18FDWsHby8SdFNA5AJ
	KriCM4PWx7LxDc/OHgfaqQik8Web9Ux9ddtyjZ5Nital6JoZS/EUVbsnJuy5pRGN
	wavCkHNDjeGpkkALeScB5I6OHW7dAuPRkvR3oBxySwAhM494mYq744+2PmKIpyE+
	hw==
Received: (qmail 286476 invoked from network); 22 Sep 2026 16:45:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2026 16:45:25 +0200
X-UD-Smtp-Session: l3s3148p1@0aq/ahNckKNQT+F6
Date: Tue, 22 Sep 2026 16:45:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <arKUgQKr99Ox6ZIW@shikoro>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgLEH0/VtwN7fsyT"
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>

--sgLEH0/VtwN7fsyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

I didn't look at all but at some of the drivers (Renesas ones, da905x,
STMP and a few others). Those looked good. I guess you generated the
changeset anyhow:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sgLEH0/VtwN7fsyT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqylIEACgkQFA3kzBSg
KbZBaw/9FrBesyOyyDUrnxlHP0bOF3BmqDAG1eHCb7OuWj1Wcqrh68l72s5PrP8Y
omafJO2i4E1dAJdffYG+gz4rfeaT4Kj9TJCODqKn6pB7cEFOj0Gk9Tlc1Pd3sNpo
3nNxwod06QpdI/1RpmBPR76rj+a0vaK8WM1j1zoARksJT0LK8Jrfm5d73Hoisng7
2iNk+ZkddaYmPSqgADJxlB+j3VUcWAIp4t/Q4F0c6+xJgA++OzbgOAvDLpXzi4Ae
zVzinZ552qM8vWVqf9RHbEz05NCRqlYewqsc6ZzFWcLHOcC9cE9nbgwH6qtd5qWU
LWqNdIl0WXDwSXi79NzvtqsAIXCMN814bx497Fbz4Xe4Sa3KBDkfUPv/JmmRtxcZ
BQxDPqXjxauBMrmarjBbr2fJy+6JRoJ44Fb3n3USWvZufXWhUbagITi8bfkE+ikP
6YriAOJVgsI9IQnTTUN5szRzPcFEHTM9N5qptkcwjCyWa3Z61/a2gmppmR4wwQ1l
Be/BD93oE4Y+DkKI3w3dWjyamEWcx+Hq9JYIMlemrXpGx5f2OZCIJNHFwvdyS02h
k8AE3H4VIwo7A/6UYTImr/JQAtwuUTyzcK54vyXsGAPSc1FhvXr+8zgbaR06nqgD
EfSNpsEVCbms7JBhxZphEoSYGUtYUwHE6x/Vd63n78pA5DJoRQ0=
=++bp
-----END PGP SIGNATURE-----

--sgLEH0/VtwN7fsyT--
