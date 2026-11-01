Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559579;
	b=5Z1REdSzYQEMJW8N6PQMk+viYvq3oHpVYIRZ+PvgBUGLcGKFMrIUVR1BxmUR3Qe93PSC
	 aFLPnvAknzecD14aDlVILgdTQ+uiklrK37bwbcg5IIJ9LpiDYLx5n0TKLk+pkvRc71Xwb
	 dkpeVZsSLgz8FuQ8xrW5uI6AbEvu8gyZMgDFKupRfNPc2+3F4UEfCIpdTa01jGxj1nkWJ
	 i1OuIj3fEJPkK1Nw82ithJvWNTiiwm3kS1ae1CQFt2e/oxbW5MKC3mIFLDuQ1gPsEf29f
	 coQ7HqlRDSOJKg5VySOw1+aZnRanRWQOvHpXoedfLLCsfgGd8DRyS7iggTfNCf/a8jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559579;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 X-HE-Tag:X-HE-Meta;
	bh=rKS7EROUAy7n7sobIAuUF7+6WoGtzT2rcSavJ4CCIuk=;
	b=v+tCWHNeFs/3w6PbdSbnY/RLdTgGml9rgUCbxlK4yyaCgu3bEO1KRtPf4pVOkPHtRdeD
	 nf4D/WYa2ubf0Loh8xDFBtSv76bZQafy2DIOkucd4hWOKvrj+t2IK+/oDbtpC0t6KRfFD
	 Ffl7fgXdpPzAKjhgpVi1vbXW65fMbhOrpqKc0nljzcDq8gULLCpnMj1CVay7shQGvEOvz
	 19z93pYSf0OP4lPg5697bjySep9h0T5DWRMtugPsaa8tzQsXTg34eBmyHGhi9u2o/Wv1r
	 1vyYvxbnYh2N8qqsR7I7K3n4PCoY9ea9YAtNh16inopx+ISrcDP1SLTCgOXkknXBOCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D6606A334;
	Sun,  1 Nov 2026 18:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D36D6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8EC03A0A95;
	Sun,  1 Nov 2026 18:59:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id CB7186000B;
	Sun,  1 Nov 2026 18:59:25 +0000 (UTC)
Message-ID: <44db8c930587810e902dcb36b5a0718a52eb94fc.camel@perches.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe	
 <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, "biju.das.au"	 <biju.das.au@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org"	 <linux-serial@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org"	 <linux-renesas-soc@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,  "linux-coco@lists.linux.dev"	
 <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 Au Dang <au.dang.jx@renesas.com>
Date: Sun, 01 Nov 2026 10:59:24 -0800
In-Reply-To: <20261101185452.GAaueK_PzlK68DsmRz@fat_crate.local>
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
	 <20261101185452.GAaueK_PzlK68DsmRz@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Stat-Signature: j5g9rtxhq7odxsr3gt3d6798659r1mp8
X-Rspamd-Queue-Id: CB7186000B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19vCIaGkHorItTUazhptROnmHM9y+ZDxXw=
X-HE-Tag: 1793559565-30508
X-HE-Meta: U2FsdGVkX18XvreR4HU9/cED9LP6S0o8okYYC69f0b+TbxhNjW7lJ+E26iQGMtTTQ7KQNyqnwf5NpSWBV8UUuNV50fopKmNBiNSIRtQIzMIaRqXc6VtCCtE3unfuv144ILR8SMuZP76QPN3bBAzCgGTLxC6bIbAXbCivJJPE3Rv2zt7D4yniy5p6KvxbEmJXzW8uX9hGsxwIvvH3GjMF7Z0PgIgMXKgP7HvRMc0h+ntdfwt7kmAR30etnQaSWj7NH/TzbWqvDzK6/5Y1Q91qai8rJSHi48pNUaIX+LWOIDaZg2h3qA3AQh24c12kByeB

On Sun, 2026-11-01 at 10:54 -0800, Borislav Petkov wrote:
> On Sat, Oct 31, 2026 at 10:35:57PM -0700, Joe Perches wrote:
> > No.  The intent is to match typical file matching patterns.
>=20
> Are you trying to have the same matching behavior as <pathspec> of git?
>=20
> See section "pathspec" in gitglossary(7).

Not completely no.

I've no particular use in match '^:' in file patterns.

I think no maintainer would either.
