Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465038;
	b=phVyTkzmX0sg+wOlSy82pVUp/gxC6ro1mXUnvd2pGGkb3RgpuVV75a/LXuB2CQ6ZdlIx
	 apEH7pZRHL4oVccZ7yP4vUXCCoLx3Yhd0AOdC3+xuYT0otqQDXdAJCL/qK3VOZTQw4E2C
	 QtFoEthGf4ewBAln1GNVUmmdnNhxUqaazVHcZC/XlleDYU7fsnFyBXrj5RI7Hl8I5nyiV
	 Iila2BXHHnpfKTwPDKVX7OGK4lya4lOsSIZphV9SsaOVtkoNuu4VTEbuNKTeh//Q4i4kF
	 VbJmbB7VHjH2zoOZZuDUMqXtSXsDvTNlpjT0bAFgL4B5Lf6BoLGQmgt3vhU+8mUgdAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465038;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 X-HE-Tag:X-HE-Meta;
	bh=2qB20Z5OO2PNW4tv0VUCGMSLze3zUhNo7SG7JE4xwdA=;
	b=Y7r1BFy/Pz6RkXOliCoYkNOxWagUYdAawfluPm6olEPYBkNC+tRPb/BB5HF8NpmcT9K5
	 jleFiLTg8pRTCtDZ0nnI47ajgNVf80dX8b9Cccum6ZiFlOpb3bsep1+eWMRyYxB7jJpOg
	 G0WgQCfu+djOKg5l8CcyYZaufIkX6g9RMvTfQHnUffdf9yYnUHglGDSHyBdRZCnZCO0K1
	 9xb2CmYfVHSL13mI0CehhkxmZ/MY5HwPG+JPpZGm/9GROUilNRXXuA8q3N20Tg2cK2Diy
	 2qCl7VSZ/deG9qBMXYOZOb2jPEmImrmryIczyiBbY/JYZOG6HX5U1b2BkrZfd3+ozxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C1606A31C;
	Sat, 31 Oct 2026 16:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D18C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 42C19409E2;
	Sat, 31 Oct 2026 16:43:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 8D14E30;
	Sat, 31 Oct 2026 16:43:45 +0000 (UTC)
Message-ID: <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>, Kiryl Shutsemau <kas@kernel.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Biju Das
 <biju.das.jz@bp.renesas.com>,  "biju.das.au" <biju.das.au@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org"	 <linux-serial@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org"	 <linux-renesas-soc@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,  "linux-coco@lists.linux.dev"	
 <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 Au Dang <au.dang.jx@renesas.com>
Date: Sat, 31 Oct 2026 09:43:44 -0700
In-Reply-To: <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
	 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
	 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
	 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
	 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
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
X-Stat-Signature: cz19ooi49e8kna7me5cxdfeognint4ao
X-Rspamd-Queue-Id: 8D14E30
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+aPwco/IotqFsTCHguuiIZ71NEMlq/oig=
X-HE-Tag: 1793465025-286637
X-HE-Meta: U2FsdGVkX1+7oQJ8xZbPzF3WUzJtxPMOp4ITyHXTuBqjUwjvWCL8pBnLSLvJ6P0zSuLxo6wFO7RN6RtWjz0Dd3+Fp0tsyGSgSYJQm7LqbZsSbe7+icfF7JAurJ13t8RbUmVfWj9blGLVueeiSOt3v9FUAPxaFjtPpztPj6aySPsRhOfbpZ1wPEpAMCR6Cm4JTzr38J0YNJO32IGcvTDTp7k+TjjpoORr4BqcJYvhG2oto0Cp9TRmqNrU0yqH1w+F8tcRm5C91rM/OCOcwGT7GAZ37awfxD2pryYnFYjKs1KCnJ5mYfL3hXLHEt9C92e5kuLNELHnFkXZP0MgVhpC/ORI5IckZIpVH/+vjzgGJQbwIjmbPDcTmA==

On Fri, 2026-10-30 at 20:01 -0700, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>=20
> A K: is a content regex file pattern which matches any text in a patch
> so if a commit message contains "tdx" as in
>=20
>   has_tdxe_auto_clear
>=20
> for example, see
>=20
>   https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesa=
s.com
>=20
> get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
> obviously is a completely unrelated patch.

It's not an error in get_maintainer.pl
and V2: no changelog


> So switch the x86 TDX patterns to files and directories (F:) wildcard
> type patterns and group them by path, for less false positives.
>=20
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20261027055750.GBauA9XlPykc1c1Xhv@fat_cra=
te.local

nack.  Bad file pattern below


> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -30347,8 +30347,11 @@ L:	linux-coco@lists.linux.dev
>  L:	kvm@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> -N:	tdx
> -K:	\b(tdx)
> +F:	arch/x86/**/*tdx*
> +F:	Documentation/**/*tdx*
> +F:	drivers/virt/coco/tdx*/
> +F:	include/uapi/linux/tdx

No file match.  Probably should be:

F:	include/uapi/linux/tdx*

but as far as I can see there's only a single file there.

F:	include/uapi/linux/tdx-guest.h

> +F:	tools/testing/selftests/tdx/
> =20
>  X86 VDSO
>  M:	Andy Lutomirski <luto@kernel.org>
> --=20
> 2.53.0
>=20
