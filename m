Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389820;
	b=rUrJu7jY+vXpUHBGPDSLhZw/dKob/AH0SYFwwOQtAlQgCdOHp1kAbZzKIWeycFURUyZc
	 cYC8FpJ5f/syxlYO96or6RpVgc9V/bvDPRx78bNiN1bLzzx8XDvs1vIBcwZzP9uNoOqhI
	 rjEpkFNnWHG7K+XIuttzFN6hROjY+WfRi6f8Zm5EikZ1U42jt8tQldz2xgYdIMnRR3vID
	 ncLPOPGVcebQR5aT2qXLTu97kCfcD4+K+jXibXnW/upaxHZm/VURGlEs2M7nELNFi6fMs
	 P18xSSuUdlmhnpbFGme3i/USOMylmPRX7TZ+aQmupau4sZH/DzNjJJj9HpdkOSLtGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389820;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sEaAj7L7ItwQxArcMJg/ysXYsqtPbJ9UNO11ET+2E+g=;
	b=JMMo2i82CD4oFV/EbqgwEANG6DLK/q2qYA596cOwg1tmuNgvO8r791eIsZSlLSF6daWz
	 g/IVs84z1gxGVhx4idUA75nAoS8nxSlBBhQR+MZN1+eZXF7gAnUrhvUhAwfsQTRE9238l
	 iuVote//4Sjl7fvqMJU1z54E30Bxry+BX8saluQA82tqSiij24zK+H9PWEU12Ov5pkGyy
	 HwzHCWKGHMOWjquLb3eSBKFjHKhjxQezFx+sK141wA34Jg0Sw13eQKvBa1FeicCFRy5E2
	 YbNz49rAOGfXAHPFV04ybF3cycjc+hII5+r0m+lJoHml4LgUt9OPpjDUjGrV85HxiXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XJp6JKJy;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51A606A31E;
	Fri, 30 Oct 2026 19:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E51A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XJp6JKJy
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DCA2140E03BE;
	Fri, 30 Oct 2026 19:50:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BWhGogmD7hSx; Fri, 30 Oct 2026 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793389814; bh=sEaAj7L7ItwQxArcMJg/ysXYsqtPbJ9UNO11ET+2E+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJp6JKJyqgvz0ecw98cfcEZk49v6hdXNUj7ge7teuEu+TL25s3vUwNdmhs0OqcQsJ
	 Ej+1WU7hhZKyYZZEPXWqsbKqforvRvs6tPqDkCK3f0jeWJYELj5Z6m0c+CzyxYdnEL
	 1srqs8AqGzjlat5zA+DDfI/KA+suUXQf0yW08sSFxBcqT0YHUMNq0UKagg5ygeyP2n
	 yVZfbr7oV0O45RjO+DMMRumpJGmSPH5S2N/+rppol15KnxGr0nARD7UaAoA3vybGns
	 EFICC/6X2EUdLm/nwhK/RQHVGjqf5zys6O0UwWfPrXMl0pLSYqeeY6zLazpYmCYiAk
	 Na+COgsVUPX+dkqD6WR12vgKzc8ZgCbLVV22k/+HqeFi2xdFiTqsy/BA9mdgfOsffp
	 nvNSNG78osxwqNIHw3Edb3YoVpuaOXp6kup0cDpIA9xLDXdxxF/v0uThh7qKfbVDUW
	 Dtb0xSlHI0+O5eijPY9u5jRBi/iiHIy0O8uc82Bfkvk1/zFStKe/1NbQcoiqk1Opsm
	 nKl+vPDm173jGUP6QCN5dmCh/gidr2ozAyPNfyt1biD1DDTW5w3GnDEF/ezy3SX4HB
	 cxfb8hYkycI4AH/QMMeEGENLkmp6XD5UazcdK1eQ2Mewoo5+G6giP9oZ2sVMH4SpgK
	 Imk18ki9Gq0fUbtHjJPXIR7g=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3893140E02B7;
	Fri, 30 Oct 2026 19:49:57 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:49:53 -0700
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
Subject: Re: [PATCH] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <20261030194953.GEauT04SAhyseued3N@fat_crate.local>
References: <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <7d35e2db2da34735760a08a6f103abee075413c8.camel@perches.com>
 <20261030182031.GAauTf71ujnYNQPluW@fat_crate.local>
 <f0bbfcecd63e11fedc4a745aa357fd8c529df097.camel@perches.com>
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
In-Reply-To: <f0bbfcecd63e11fedc4a745aa357fd8c529df097.camel@perches.com>

On Fri, Oct 30, 2026 at 12:40:05PM -0700, Joe Perches wrote:
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.

Aha, ok. Will change.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
