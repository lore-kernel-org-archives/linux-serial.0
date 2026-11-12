Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493901;
	b=qMEn53hqtl8o7smeDP1ToDQNWKhj0kcfc5iNaVzndDKXmowdedZvtWzFoBKU9JxBHDsl
	 QehDZnqCETlfliRR8tZK3GEQSLjDOCWihHxmMI2mY26rU/4qV04GVfwuupKPQDmY/oe7r
	 1tBEJ92DcbVqw/cnoOuFe/CxYk6wMVe9DiVnJcanQNdMURNvsYy5JKPU9V5S4jzwSeDRL
	 wXE1d5Mwd4vbRhyyb3MWI6HZ/fqit6bWGONtItDRqrRWsIOUFuAPKihPzKUSI0JxIuhmr
	 6L4V1O4OQwBWalg63ynkLFowuPaiL4QV1n2tWW/yeFQ9QQ1Jz+wd6VOdse5K+/gK26g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e3kGt/yU/gnOAFXbLZGIDDURedZhWnxyg27XgVGcKV0=;
	b=iQ0v8ST9ALraM2bSrqnR+/npbf0iPRW/YauKPajKMQdDopNv07DltynweDnmAzCMLBB+
	 29dzsJ/q7qMw60THPGssRXT/YuiKuSjUV/pJlnSlM2+mWQ93fgPKey+m3dgdUV8sFEHog
	 i//0XRQv3f3/mffWH+vH7D94fEguAgtHZGAU4bDc+s9k7rBqP+9UYECONkJNiurKeWqMR
	 vvRp0jjlJH8NSoE3gAjjd2WW+G5yYle0Ll/stUFEKcdVLU5EYFduVLcfXkiywlJnv0suH
	 wltqWUSAA9Ve7SYRVIGjjBE7BdXcCLaQbC8g4wsSZYlI4bcbHCes2JQM/GX1fegc+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaEJMPaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E28606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaEJMPaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A5B1F00A0A;
	Thu, 12 Nov 2026 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493900;
	bh=e3kGt/yU/gnOAFXbLZGIDDURedZhWnxyg27XgVGcKV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaEJMPaViza95aVq+l9NKvhbqs8D3ruGZ2X6BsHyF45OsPsPFBxNmKZyNBL33aFKw
	 riHC8Beht+M5fDVeqSPWL9LFWd3TDLGb3v9t4lTV4ZvMOEM9VAYrTlfZdLx0U107Z6
	 9DL0TDS1gr2F5qdHtRi5mQi1Tk6kgF/g3YEGxFbZ8CwU16D+mGThtcNmqXEymP7zpl
	 UZsAg8cxNz+3hXPZhQywVWOABBfMHt5U4dUhrRcigSuMSIHgTRaK1bU6i9TrDi+43L
	 S65IkGAlK3Yk8BZ/0Xj1xFPGmtChzC1vI4q7Pe0tv0SYiPkuPAu7wcwmNWvAuAmNVa
	 OjpmcOxcNV0jA==
Message-ID: <sashiko-outbox-211328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: core: fix use-after-free after driver module
 unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112142209.454331-1-johan@kernel.org>
References: <20261112142209.454331-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:31:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Deregistering a uart driver frees the driver uart state including the
> tty ports themselves.
>=20
> Restore the uart driver module as owner of the tty driver so that the
> uart state and resources like the tty driver name do not go away while a
> tty is still open.
>=20
> This specifically avoids use-after-free when accessing the tty port and
> crashes when accessing the tty driver name (e.g. in the tty printk
> macros) when a tty is closed after its driver module has been unloaded.
>=20
> It also makes sure that the uart state is still valid when waking up any
> waiters after releasing the final uart port reference in
> uart_port_deref().
>=20
> Note that a few drivers deregister their uart drivers also when a
> (platform) device is manually unbound through sysfs (but if you use that
> interface, you get to keep the pieces).
>=20
> Fixes: 2f16669d322e ("TTY: remove re-assignments to tty_driver members")
> Cc: stable@vger.kernel.org	# 3.4
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142209.4543=
31-1-johan@kernel.org?part=3D1

