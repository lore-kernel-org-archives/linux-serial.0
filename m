Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559320;
	b=Eb1O2tEGX92vYThCtn2LPE/AsptTubf/yyLpb6jVqipvIOJrWUnkgO/Ca0GFIsbouY6G
	 MQ24owyBqlEOx0lNrHbX+lURcBfkuALs6Gz8KIxIhVRlkZfuEkt3s3E8eXzl7sHsncJVJ
	 +THUn3RCfS+5A8aEbwMipfU/Ttfer56TdkSm627iHMX4hRh/wDf2g5EnAM3zkzrUJLifI
	 +Bnoz12MTu9AEwfz15fgiZLAMruqlAoipLWo9J1eJ/5j0GPYYioFOrG6gk+nKTAV0SooP
	 qVH+1Rt6B/nyU1gs7ClxBRVK+65fjCM0Gg0aCXNz9Lr7wLBYcsvFirB1PScWIKd0pQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559320;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ScgBFQ2sEKk0TgN1KH7zHW+IlMrnPfyRl1r/gf8Y950=;
	b=y5WkavqLu0n+EWiBCOJToa8usdc4pM6hEaqp9WxZMauD0lkcO8msPWXNlrQR6R+iDXkX
	 yFa5zoY16OrfW1lHwhmWMtNDBZQUqpsQpD1ckWC7zTpSK18xNWknMXxRJ3Yb4rzcluZYU
	 qrmLon+Xqdy1bSkqQPFZVKrF2E8n3Pq+N2JpEcjRJ1sdd0cqtyAj86I/Zm9M13LFW5DBl
	 mW/AhWV0x2lOtXj0vYvzMxrbbdzkXeJ/PxLQaElnIEOvmEzcEETQLa3r3zR9pVI4vOFzx
	 LYk/w9YD8/DtNSYIGX1eXBilpZCfv9xPAmTOW4Ptz0gzoATOOFylrypRXFJHlr8i5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Fd0sAu6A;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD11606A325;
	Sun,  1 Nov 2026 18:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD11606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Fd0sAu6A
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AFD240E02B7;
	Sun,  1 Nov 2026 18:55:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GiwTy8Y-tnlr; Sun,  1 Nov 2026 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793559313; bh=ScgBFQ2sEKk0TgN1KH7zHW+IlMrnPfyRl1r/gf8Y950=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fd0sAu6Ag4L25Z3n/tp+oZ0Oac5dsyFgG6/NxLjkeA6Hzya3ScsIvwtPeIgOkyvAe
	 dAZqcKKMvvewmJwsUX9PmE8HDgp1v290YCz5YzIMwPKOya/2OezBUlX/vL08wMTAhZ
	 smETM8r1nrReNHkKK1+ODUsC3kQpvQnmaTqgRWmj995ROUril0Qzv7wiuY/qhdJIGn
	 CDp+niWzh/rNEZUpzvu5XZe2rN0UfgOLoLU9xrzDOF57Zh3s3WrT7sleTwN/9ej3io
	 WjeH8gzPwzAQp65KGWXh8eEgstVlwRBjZQ3TvqB0OVv337WVcokar1aWvKLULj7MM0
	 5DAPQaI7v/rTyZ4zY74brkZ5sJQ15/UoCS+6rFg8k8+uCrTDeruN8SpXgaXC6aH4y6
	 apg9cq7Na4RBP6jBszvo5GoIoH8zGkFO5xKPccEFVlne7i909/jMsnPtT9mDoEJPiX
	 gGwPHcf2RBLShleWSk9R7qoURpZScNWjx/uqNDL4dDEtx9J5kcwcPfZqTORV9eqMgt
	 tuANnMrgGsdSM8uwZlCjH6YNiqBUVrzenplMPpNfxpfvUiIsE7hpJ4ZUJwl+sG3YID
	 YX/tDo/AV63BxCAIVV9as/lGxxH1mCa0q64r5dRfcOCDcPL1bnvE2I/oq2l5sNBM85
	 tRBEFODZx1DB4hWnVwGyArZw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55AA740E0298;
	Sun,  1 Nov 2026 18:54:55 +0000 (UTC)
Date: Sun, 1 Nov 2026 10:54:52 -0800
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
Message-ID: <20261101185452.GAaueK_PzlK68DsmRz@fat_crate.local>
References: <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
 <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
 <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>
 <20261031235958.GDauaA_pScrsk2xYUF@fat_crate.local>
 <5ad69a1167fddc7caf1eb73e439765116db1ce17.camel@perches.com>
 <20261101014710.GEauaaHoYk5TzRpGBQ@fat_crate.local>
 <b700f0fb96b9454287850f7aa54d876b709cadb0.camel@perches.com>
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
In-Reply-To: <b700f0fb96b9454287850f7aa54d876b709cadb0.camel@perches.com>

On Sat, Oct 31, 2026 at 10:35:57PM -0700, Joe Perches wrote:
> No.  The intent is to match typical file matching patterns.

Are you trying to have the same matching behavior as <pathspec> of git?

See section "pathspec" in gitglossary(7).

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
