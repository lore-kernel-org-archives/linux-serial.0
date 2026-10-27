Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134479;
	b=4+49/4dTyahHh/zhujFZfOSSTEBX7GY/B7vVQarQ12YblKut4QmUjzC4T9JwtGBvb2Cg
	 dX+y7EJsO/c5CcfQcchbM0mkqzav/aiAiNDJvCQZx8agQWJYD90KoPcBX6vbsCS9KKfZO
	 xscpTjZLxxyErfQNZ3edjqwvCgrRVRyPS5mSBpjAvKM49q9EcwbSTAY6qvR2MJQFCRMv8
	 DBcX60Ar4AcPE70XY6IUdSXhhlPrIQGD3DRJAmfbLrUxxqss9S734QfIU0pUQKCVxSoHr
	 340vHnLiABVlyQ6fq/C5dk4GMpEh2eGq6KGLKfFLkLXHTET7qujdd959GGZN4CFsRlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134479;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Jv6Xm4QeDgQX1/yKjenrXElUfoDNp2BHW9+LkfSflZ4=;
	b=KUMsSp9iS3AMYgoqzK/3Ioky5egsHl9sy9Qls0a+YVHGP296bm83MY7D15F0HY+hTVrU
	 02xjciGG45uPzFOo9uV9f/RliMMIu+9vCz7+tvJFlDFy6bKWEd2LU2oCkovfnMa8YF3hp
	 1PesTPILH/xntCxzzat+bz7j9FZj51UUP1ky3fT7XcZI1NrirRdPJZlHPderWRYa+2poX
	 YicFOyJVX8ZRUOqQyy9jtjW4mZIhKkpgLRJUh7f5J5x6Bu7kAdyYoa+dxbyLdPPLoa31/
	 h98o3GJ754BAplbOp1ukFlIGMnJKNmEW9wzxO0QcwCfclgWhf4BX1p37Xzr3VAOXlaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iQKFrDh1;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CF606A31A;
	Tue, 27 Oct 2026 20:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iQKFrDh1
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA91640E040C;
	Tue, 27 Oct 2026 20:54:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9Y0mcD_3xooN; Tue, 27 Oct 2026 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793134471; bh=Jv6Xm4QeDgQX1/yKjenrXElUfoDNp2BHW9+LkfSflZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQKFrDh10savfSi4autfYbAYUJBPgj99iPq05z/PLbkfPRI4132/EPDth0qM7+ged
	 xUvLEsJHhxRj1uccvxBoqIi99obdCZwohAVNH2ONqyYKbMq4zc/C3vLsfZJxVScWOP
	 T9yoyRgpajizThFIHSvqQEAB16Uqp3qe1YboMI/vXMF3A4HI9I0FH1ksZnTDEN9rSS
	 2t/zti62tyjM69RskgGV5QjbeBqWsMOaqKKj834H2kDjHNAdUKV9Iumc0j6tyBEnHZ
	 bw+gE/RWqC4xsHQBnijKehBawmLhtIiirnvtBWvSTuZgovoUoJLLIGyDMU6G0KvJ0E
	 fFTO+gSikcIZzmMlGNb/57O7u0l6wK5YNmZQBvRAqAS3/rRIM/jm7r938CrwSiS9+I
	 wcATOdPfb9iynzvF9SAEC082qt4ZSyYqwogKp/Db6fjoL1ZHrPn3KQdQzSSaM5HoJu
	 UhPBZcTg6e+F0Xc00EGQKR5KSuoDQ+KJKg1iJI4ihURWZJ0v2NIIw38g1SNQIxLFry
	 YJZDwSUjgw0rTotnzfT03wZGLnZo/tJYL0QQF96dM66LMiwQDz/igQYTqdmVErWc4D
	 x5tjw3Y0DjBxgZIju4i0XXr4VKGbYwgIxSKqIHwPoDDZfWnSM554JkcGuCcL1pYF2h
	 8X8eQI+GMiwdM6+MqUENuxaY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74C3F40E016C;
	Tue, 27 Oct 2026 20:54:14 +0000 (UTC)
Date: Tue, 27 Oct 2026 13:54:11 -0700
From: Borislav Petkov <bp@alien8.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
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
Subject: Re: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Message-ID: <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
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
In-Reply-To: <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>

On Tue, Oct 27, 2026 at 10:34:24AM +0100, Krzysztof Kozlowski wrote:
> Indeed that's x86 fault, so I don't get why Borislav complains.

Really, you don't?!

Looks like your mbox can take more mail then :)

> They added such pattern, so get_maintainers indeed reports it when run on
> the patches (not with -f):
> 
> 	Keyword:\b(tdx)

Probably because all those folks here haven't been bitten by the imprecise
regex issue:

https://lore.kernel.org/all/97e322a3-0526-414d-a288-835d11ee2b1a@intel.com

and I think they have but they probably didn't realize that this pattern thing
matches commit message text too.

The below fixes this particular case but I can already see it is not enough so
I think this pattern needs tightening and actually splitting it into several
patterns for easier matching.

Probably something with a path separator in it:

*./tdx(-[a-zA-Z]+/.*

and so on.

Yah, I was going to add them to Cc but the faulty pattern added them already.

Pfff.

---
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b0d9a28bc85..e727db70a2f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30228,7 +30228,7 @@ L:      kvm@vger.kernel.org
 S:     Supported
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
 N:     tdx
-K:     \b(tdx)
+K:     \b(tdx)\W
 
 X86 VDSO
 M:     Andy Lutomirski <luto@kernel.org>


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
