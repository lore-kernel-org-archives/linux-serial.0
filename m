Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491226;
	b=0gqHEb3dAD7CcdFIzf0Efb5bd4QgxV7UoZ8DGPpgxYVsp/QJWruEnLb4wXnBdetjGl38
	 U/5YJkxymK9nxDZzWcs8tvrDQGVRWQSdzso+aY8VyRnwBSZc3Wf7soDM6sKt8TUsL96nS
	 Nod4aP5ajdy+EBL4RNGSh/5W+zpXROcgD+V9d8i2N+vbjKv4YuOzZaYci2m2CTubk1xGK
	 G6D1XshgYXvQm3jvAKcyQOvu0/MCR6YYKLyr8KEmJLsNtr/PxNK8n9r7SCfrb+LlWAK9t
	 l/v3XFY0b9YQLBUeUPIkhLYJpPlZ6yzHmMAiioG+ZHaAcMFk4tx6XiP/j11Sk09e7vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491226;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Wb27v7drwI43HShdAf729fldZ0PxtCAsw7JNqFBlX2E=;
	b=joSp0BsyvSfOasyo5WKxDsxzbs2XE+Qp/+Im26NJnY7uNUSRTp7Xp6+Ya0poiiuofl4g
	 HjQtA2DnKUHCeUsLLRgsgpOshxA7ia3viecuN1oIbIutQgx6kxQVLF9FcrNPAE0YdRZgP
	 7qVx1VfI5LXm43k2NZKiIkwuMATGblmi7tDZ+Zc67uAcOE5BjfLK4mJjrk2od7yhusOzz
	 SGw5lQ8emaSLpffeeK8ONOGwhJcWcZ8E7jK8RcGLEGaAA/6csqKgN4SKzIgWANMxXk5Ts
	 dlECRIrUxHU1SFvknONkpas/lXjxwDtyQ+x9QTOQGsr3Z9eZhgTDvm6Lxz1EAbDV3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iQcmbfAk;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B39606A31C;
	Sun,  1 Nov 2026 00:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iQcmbfAk
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8B70E40E04D0;
	Sun,  1 Nov 2026 00:00:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AV7brn4tjS-4; Sun,  1 Nov 2026 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793491219; bh=Wb27v7drwI43HShdAf729fldZ0PxtCAsw7JNqFBlX2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQcmbfAkhwkEa570o884sv5yc2/RMstGH8O+BEKBU/mLvUJGlTY6quuX4WJTFhl7T
	 np62qEIiTdnW8w4O+GG/w6zJ9QJdc19CKqOxHVgKKzvX1QgMxEdm34t+PO/fIPuqcI
	 s49Yvb/OBVNJkU8g2Iu+xSoXq270zBcKnH9KqtGSLQCptyi5+fPwjlKhvzpwqFlL59
	 7qxCflSKPFK4ArFFQmG1uLiUSYFuIg5GY263e5FiQVtxU2wti196k7/qZwGpwPhLxs
	 ITkmwJsqziSyAYzug3Uc+3QGwCDvIEsHTjG57xsSgAtCt3cTQ7TL7hal87EDrw1rXv
	 Leo06gtUUQ+/0zbjPn9iavVO0VvI4/mxXYm5CB7v9Ib4lcry26kT0gYQCBXQ9DNPor
	 7NFCL3lVS2ysJJi6bF1+9vfBL/2+wfCF1dV+4WHTCMSO7o+uF+Xs8GrFhzcLf9OrpX
	 hPSjwqh0BGVfntS6Sm0lPgJejNLWD8Hi8dllaMcUcr6FZAQKrB44HLiLogcgDRgszT
	 66bGanT2Ue7vLiFgzp87DjGHW2cj4HZgNYSWUIphdpQE3mjZTheXEIw6/G9OSsZ2D2
	 kJ5KrLDGasQ8BrarZYjMgWnBfx77BZaKlgn8UtNQKlLxNIS0RhZCTWQsJ9FJpjjbyk
	 T7fwhY+ASc1RZoSq9RBGbb+w=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01D2940E03BE;
	Sun,  1 Nov 2026 00:00:01 +0000 (UTC)
Date: Sat, 31 Oct 2026 16:59:58 -0700
From: Borislav Petkov <bp@alien8.de>
To: Joe Perches <joe@perches.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Au Dang <au.dang.jx@renesas.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <20261031235958.GDauaA_pScrsk2xYUF@fat_crate.local>
References: <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
 <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
 <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>

On Sat, Oct 31, 2026 at 03:52:50PM -0700, Joe Perches wrote:
> Please add a wildcard * at the end

I will, once the rationale is clear and documented so that people know what to
do in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
