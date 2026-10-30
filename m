Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389220;
	b=uo7eZhaTCGyopknbFtnhLuAziDPzHfFEST5mAo/rGVV0VpiaVtQcAWNGYy+X5GF2HgCG
	 gzSMu71so+RwH/0fFy3kwWGI13IP2Kj4M2xXseWzyfa4tjA4jfbaorOxeqgDRIEuy7L7z
	 vxmeCTZ5L+9nsEDD/SvwbIF3rHZkt+SbzKbfT8Fv56807J4o6pHgxmXMOpSRtOyMvvXv2
	 DU+jMAhoWYLOUVct6BMMari2Ebehf6WUGiVSLeo1W4ckFNG+BuxtBk7BuXWAvlumFWh0s
	 68o0DjaX46xg8vJogMXINq0vaUxMNzIhKVg9JcCCYFJnFYrqAnRvYlTANf/XGEGJDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389220;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=tB3wDibpkEIsc1D1uRR5wCOBeM1B+5vNvLuHqpwTlCA=;
	b=Tkjqu9WF39ganH5PsNrQ0IepfSFhPrdj56Oir0ixSYQjHNQ1ui8A/Swf8NNLKtAZHnei
	 2roCaS/K0T8XI469ixJokFyUlCDQtcM1ef370pVhk2iuCesylJWmsLRxN83MSb/qaUsHV
	 QDLajNQqOIzLHKeovy39sBIlUD4VV3XecQXmjFdEvpa49GIsi/gsw84Ueblj9iHXTvry4
	 O5aS03+vaSljkhE36pg64N3eAm1RIky6eiUT/hRcqpV0fqL4LGFfVWHBavUoLlw05t3Dz
	 l0TvfNHETR47wdTB4lL+WHRkgUPAfBvLp/tJGxr0myTuqNgEbzXdjuNAIfyDc+5sEtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52B606A31A;
	Fri, 30 Oct 2026 19:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D52B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A094BA8586;
	Fri, 30 Oct 2026 19:40:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id D04412000F;
	Fri, 30 Oct 2026 19:40:06 +0000 (UTC)
Message-ID: <f0bbfcecd63e11fedc4a745aa357fd8c529df097.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Intel TDX kernel file patterns
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
Date: Fri, 30 Oct 2026 12:40:05 -0700
In-Reply-To: <20261030182031.GAauTf71ujnYNQPluW@fat_crate.local>
References: <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
	 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
	 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
	 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <7d35e2db2da34735760a08a6f103abee075413c8.camel@perches.com>
	 <20261030182031.GAauTf71ujnYNQPluW@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D04412000F
X-Stat-Signature: wkcp5ff7qj9ftg3f5hfh8x3ibujhqfgd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18MClqx0jSvr36hEcX/6cU4hJ/gcfU5s1s=
X-HE-Tag: 1793389206-130397
X-HE-Meta: U2FsdGVkX1+bis/K6Jvejfrw3OxHiUz+/eHYnGFdduYgMGW84zDkju7YEB2ispdporcrRtwLuBMUWaJJSr5WG2JFmt7Kl2xftjhbrrvKKGpPan1w9dEeVAhOEuB9LLRQrRlJGBVcpHPnB6tXwSSdxf7ICDDEFHONn3jrjIPVdiQlcie0Wqw7tkcpYtoibfn+b43zNZiyfh/8cOsu5hDdtcwKVnvchcBH3SU9s3Dm0gqw1L0TuvoLDIjp4stCLYs7J2jcnp9M2712pYYETSsa2vWHqFe89wksKpxG2k2fYz0ymeiBBie2D1mCkZ9DLSC2

On Fri, 2026-10-30 at 11:20 -0700, Borislav Petkov wrote:
> On Fri, Oct 30, 2026 at 10:16:46AM -0700, Joe Perches wrote:
> It's probably better to use F: and not N:
>=20
> The reason being?

From MAINTAINERS:

	F: *Files* and directories wildcard patterns.
	   A trailing slash includes all files and subdirectory files.
	   F:	drivers/net/	all files in and below drivers/net
	   F:	drivers/net/*	all files in drivers/net, but not below
	   F:	*/net/*		all files in "any top level directory"/net
	   F:	fs/**/*foo*.c	all *foo*.c files in any subdirectory of fs
	   One pattern per line.  Multiple F: lines acceptable.
	X: *Excluded* files and directories that are NOT maintained, same
	   rules as F:. Files exclusions are tested before file matches.
	   Can be useful for excluding a specific subdirectory, for instance:
	   F:	net/
	   X:	net/ipv6/
	   matches all files in and below net excluding net/ipv6/
	N: Files and directories *Regex* patterns.
	   N:	[^a-z]tegra	all files whose path contains tegra
	                        (not including files like integrator)
	   One pattern per line.  Multiple N: lines acceptable.
	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.
