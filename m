Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1524A3D3E;
	Tue,  6 Oct 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310886; cv=none; b=imKfqYhiDrq1Q0Y7flHUK3YCnDyKgBUtL9gMxke3jK52HhutzjmReb/h9a0t+RwIqS0J6wp/h61rb5cUF/j9VMe2GkcPSLQtCOeaYjC5SlO3akU2ANlzQh/fnoVPZYF2k7UZS6LmXhcE9XYT5b29Xq5CcZC3sDHIJxgpblIsvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310886; c=relaxed/simple;
	bh=k+Z42MPp6FaN4S4dWsfptb3LZBa1JQNlPPUqtVDmm0g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YfEWsag19bH13Uj4IK4TEYYNOfyXElu/KtAa7LXwRvKMXZlY3QFSTshgkUl0x4+1R5SVVxBBEtIxR4UxXtgyB+xeNHqVV72RSC3RQbhKOo6MSVag+h7zg8wrd2jVrHLSI0sCzFTTk4UPMxQy/sQw/jqL1NOOiZCAOeM5zNdu25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6RFynT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6RFynT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7CB1F0089B;
	Tue,  6 Oct 2026 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310885;
	bh=k+Z42MPp6FaN4S4dWsfptb3LZBa1JQNlPPUqtVDmm0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6RFynT5wsN6+SLvD133n2ykaobhl38Y9sq7gCoVePcf/jP5iEDI6tH0MNgUyxC4a
	 2DYa7ldEg9L7nI60dUULyDMJZJCBg7ELiqmWr09GY2G4HgzkusoCTcAci1h4/hRLiC
	 L/eTX81c/HwrThHONyvdCGHNiIsWq9cfCFlgAk59M/nYTqMac/vVlIW178MpCMG8i1
	 ef6i7L4WOhey9ewIhwZTIlHX8xrWdQmeXmqMakp+ht9GWeDgBf76HIDjUvMUKI1OSy
	 LrmmZ+xbUI0OigBsqplQhw78lvFFz+iAqHnG3tOM6R5hpNAo/+BOzxB78+jLlQYR7P
	 7cdFlRTzEA84g==
Message-ID: <sashiko-outbox-162335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 03/10] dt-bindings: arm: cpus: Add Cortina
 Systems CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-3-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-3-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:21:24 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D3

