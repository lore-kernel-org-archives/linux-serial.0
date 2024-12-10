Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634991BD01F;
	Tue, 10 Dec 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843866; cv=none; b=eSyzuY18jfBEiO1AFyAjdsGrZSA69iD2nnUNGBQoznHT90Hl0B/jFekeLgdWQo4/AEt6/w85zoBnz592acAJupv+ryu6YQK3nc8bBJq56UvHQL/o+Hxh+rFk2QF/6s6UedEXYpSBubZEs252Sq5d1XjfmDYMu3lplLmVXVfSrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843866; c=relaxed/simple;
	bh=SuJIrOyGFcXxLDGJ8cbHS+2PO+8WRg8j0//7WEqJlPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieyPEvjl0HstmZpwgpdZ3kWpO8S/z+YCyMgGb85i6u9zLG5TlQ5hTN0KOGs9vqYIU8M4I8YchzAcH47ZvXTdThi5xZal4wP4XbLFKF0OFvqPqrzQmd086kRk19nBJib5CHX98kupVJypn8s+2re5wu9xDGpuFwOOSRMJV7+9GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jNBtmoyW reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jNBtmoyW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD1BE40E028B;
	Tue, 10 Dec 2024 15:17:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CW1tLFe7Nb-2; Tue, 10 Dec 2024 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733843845; bh=9NTzeutq/r3ndE+cus3KlB/FLsg7STOMKSUO7w2whpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNBtmoyWnrcketINaOAOkDm8MVC4oGCcg9iEE9GlQDiHXjpJ1pCQeyjAUF/xgQ+Nb
	 ng5JFu3blQ/XC8yodu7tFgOdEJUeOLTRjwuaA4BHoQ2rkwwxsFmjWRpiyNJ23uD7/T
	 8fbCRvySK3kD85hfpdxnku7TJqiNLRzTtG4IyjOoOEVJOQreCFOQnaiJt6bIPU8I20
	 xyLRjCNUxlZh9yvHb4BUSZXZvlRnJdZif6TBtzWngvb93jR8JUTWdTun72/cIHt2Ib
	 ZnZrueTsWtfwkgVy0lkw+BqdnHmZ24osNFY7/nsnzsdIupy5YmCJlj+iXu8otb0syv
	 FKy0fg3wlTX1J8KIEHUW8tphJIlFWPM9z8d5Vgl6uro9K8c07yMbWivItjiJoonPj1
	 g+BGHpAIzWnQUJYT5k3qtrxk3v4xdVAIou1wyflgBdU4OHwDBwStUxe3fBY6JsR4Q9
	 mV1aO44eV4ohlsFDIvTmPk6/iFhc8dQzV0KpzkPaW0+A1Wj4/mpv7oauI/+AWclsdU
	 rx8uJBKSVBz6HocESlaeRDAczmrwquOKOInJ6yytceN6wJWX4zYin0hN802eeUiYyy
	 3qxLdRFldWim0HBuHvCQtNuzG01V4wGaTxAs4ZxBSh8bGZvNWKd9bpzHZbLCTp/XXB
	 onND1u4YNoVKqjSBqjDR8zEg=
Received: from zn.tnic (p200300ea971f930c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:930c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A5DF40E0288;
	Tue, 10 Dec 2024 15:17:20 +0000 (UTC)
Date: Tue, 10 Dec 2024 16:17:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial 00:06: Runtime PM usage count underflow!
Message-ID: <20241210151713.GIZ1hbeSzdnQEqei8J@fat_crate.local>
References: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
 <ca76fb23-013d-9745-188b-b519096aa784@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca76fb23-013d-9745-188b-b519096aa784@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 04:14:20PM +0200, Ilpo J=C3=A4rvinen wrote:
> I think "Runtime PM usage count underflow!" is not related to the probe=
=20
> problem you're seeing. Nonetheless, this patch might solve the underflo=
w:
>=20
> --
> [PATCH 1/1] tty: serial: 8250: Fix another runtime PM usage counter und=
erflow
>=20
> The commit f9b11229b79c ("serial: 8250: Fix PM usage_count for console
> handover") fixed one runtime PM usage counter balance problem that
> occurs because .dev is not set during univ8250 setup preventing call to
> pm_runtime_get_sync(). Later, univ8250_console_exit() will trigger the
> runtime PM usage counter underflow as .dev is already set at that time.
>=20
> Call pm_runtime_get_sync() to balance the RPM usage counter also in
> serial8250_register_8250_port() before trying to add the port.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx!

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
