Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873418;
	b=DMqu/IgnsmxDNCYSl4Kidb7Q1T0H/KAy+YLns7kE7Lmfkjp8aREb+1TxWKob3uBdCAS0
	 2OREGfe9SRFkIKv3h+bi3QESPvxKWNLhED0TeysshgLVaI3rKeeliTOT0esk5b15qVWF+
	 u4L4ujs2leQA8kOWiK9VEPt75CQwFKP0aoONUeer2MAlAz8nS4oou84wQacmIEYO45FGE
	 TbV54LGzEewm/TTwOJafFeVG0uUuDPXjka6jera6DqDJk6m6XGFm4VpO/omJMwDX2lx1h
	 /evkfbxbUjB6Hq39dcvEkEL0KqVuU3AN0qFRK80+x/dt1L+idRMJKJ+QU5hrczrXkDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rEfUXbeBt82Siwv6JyXvsrWScGSIwkJjyVyY+CGDfMQ=;
	b=g+cDJSTHWlvR/QdV/j928TR0PCjfIrWg121SfQqdaM9HkN5ZMDFeDcHwQVrrYi06xpx0
	 G8XZAeecheHg/5gd4SorYPrnVdwqT0+zFUhVS5wAgDix+QKq16wTcy8Pf7AIIMzGNNlBi
	 v469KxfgG8HOBKybXy8JkhZp5eciohpBAAInwbTvREiuy+EnUAORxUQjN5tjKMJI7dAcg
	 RGGEHy8XeabAjHTIr+tG+wozecbfu4UoO7ImVjZhhDIpZMaVAhtxS1qustcf6DFq+faO/
	 18kbOxAlEGvzBU8lUJck5TardB0C0WowfWEjOUYQYS+XGkSfToXXCFVCPr7IryfHTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7U7vQUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA340606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7U7vQUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617221F01825;
	Sat, 24 Oct 2026 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792873417;
	bh=rEfUXbeBt82Siwv6JyXvsrWScGSIwkJjyVyY+CGDfMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7U7vQUphKTQGu6F7e0MHRaqag70RMp4BEPtJbtcpbBzrzR4ZHql50gotkifhkHgN
	 8Jnm/uS75T4DdY9tIVq82ZzGDQs4CbFziHJ/RFwizTfx1UZE4E/jCUzHLJ0hHmLvcL
	 Lo5EOiCX7HW1xm8VaTq64bs5f6OG0eOkuqeEik6u6FmKdiM+rxQzwfGWiIOIFv7eDU
	 2bjtyO/EHryWQR+K/OJuipFPKY6FF/2dBU6tgL37QIrmJ3J9a0Kbr+QRCkAIcXc/QH
	 T3L0jJXbdZWy1bUy9wlTjIBljPf7oCO5BQbloacrpo3oaubIV8Q+qW+y1A+xXwv3DL
	 qRn2JyQXJaDiA==
Message-ID: <sashiko-outbox-183869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: clear RX trigger callbacks when removing
 a port
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
References: <20261024-submit-serial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 20:23:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_unregister_port() removes the device supplied by a driver and
> normally re-registers the persistent slot as an unknown legacy port. The
> slot retains its RX trigger callbacks and sysfs attribute group, so the
> replacement rx_trig_bytes attribute can still call the removed driver's
> code. Unloading that driver leaves the callbacks pointing into freed
> module text.
>=20
> Clear both callbacks after uart_remove_one_port() has drained the old
> sysfs users and before registering the fallback port. Its RX trigger
> attribute then uses the generic handlers, which reject a port without
> FIFO capabilities.
>=20
> Also copy the callbacks unconditionally during registration. A replacement
> port without custom handlers must use the generic implementation instead
> of inheriting callbacks from the previous owner of the slot.
>=20
> Fixes: 8a6c543cf8b3 ("serial: 8250: allow UART drivers to override rx_tri=
g_bytes handling")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-rxtrig-lifetime-v1-v1-1-731b78d5003d@gmail.com?part=3D1

