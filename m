Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380620;
	b=uB6gh6lFNgcUhQ35CMCYTAPv4fOAnyE4yAm6YL4khV/L6Ca0W/mVTnIx6QzQgQq9Xzm6
	 P3pjdkMGW3Y8Xw1cLUutsrpGOGkxNzEcwAdqDvjlYydrmjhF13nR7qM+oa1rHzWShl53V
	 etRIACtqKCMetUjE683jfNqOEgZkxOgTpbC8TnQsxJWN4dKHpHEOBp4oAEHftl2Z6qkoK
	 otqRJmJ3d+w6AS1OU9n+bTqvFI83LAC4f8Z7VOkYBtvyyE0pFWhKrgs80iehkUxTPBhs0
	 MFJQ+uxjF4Sw++5MWa5k64+UfdgNrwhhT1RmbUUmbIv8tU/pKdNNSu66PuNVe/P9JzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380620;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=hkrbI/7Icqi4A+n7xQWulE5DKqlNgCOaz5tB/xPXPRk=;
	b=lq2+1Dnbr1EmX4jtT5rPex4Fox/QRT6F19Y2EsWpLNtJrjutwvKUNs6kEhHLv9MBXF9D
	 jmUiRyz9DLO9GE8Cfs3QKnwj/xhylw7fznmWdTRpX3tbNheUmOKyqoHo9sbGfM1zBM3w1
	 T6SweeuYhn2+UuipNKG2VKEGlIB9ZsMzwv1vCnv1J2v7QpeZzIha9mbpoI3yuMzrU5Og0
	 ITgmxCsWSk41X0eQO+U4JuIt2KltFl8mJjlXH2iJfJ2zgVbHtyI8y9KnTxmgHzxJkXChc
	 ZrJAhVrscX2z0bIixAlqUPAQpIGvGI1FdKqTuUmjjVGewA6ZmFIiedvBx81X1m8fDRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811C606A31E;
	Fri, 30 Oct 2026 17:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1811C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CF6521607CA;
	Fri, 30 Oct 2026 17:16:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 0EB4720031;
	Fri, 30 Oct 2026 17:16:46 +0000 (UTC)
Message-ID: <7d35e2db2da34735760a08a6f103abee075413c8.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Intel TDX kernel file patterns
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
Date: Fri, 30 Oct 2026 10:16:46 -0700
In-Reply-To: <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0EB4720031
X-Stat-Signature: 355uszp4b874xt5k4jfwnd61nizhx8nt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1VFI5iFtQ5fVPchIaoUiOydJ7/W7U9SE=
X-HE-Tag: 1793380606-166191
X-HE-Meta: U2FsdGVkX1/JLOzcWlRRVGy+z/l1v0NVMgP3b3/4JjdcmnYQvrXmVBkyQsTaYUIU4iJup8x648Bx6ixqrd4t/TDEknzmTorLp03QpWu+nbHj3w3gtQvQZFmBq9uv8CknfXfhQAGoHThTBZzFaRds6rkhrvkGoTD2tDAD+JAxRYne2DY143kjKH/T1Apq6is7B14LSB+Q4z8zcSuV5ie3yxQ3rBSsXuTOn4O/i/sCMEHrTupdOBEkz1vdAg6AFS5vLMJ10OuRPSEHBxMkrkQMmBK22fM4TwTljTju92aeq+2yN1Lcmv9MgnVl8u5Xd47HGcl/DxdQ9Mgr0DjpxOQfZnwRz5diN5/p93XmEzEkcZDAoEJB0bAPUq0xV+QeSn26arUY3qnp/G5Sjzqj+E9O6g==

On Thu, 2026-10-29 at 19:33 -0700, Borislav Petkov wrote:
> ```
> From: "Borislav Petkov (AMD)" <[bp@alien8.de](mailto:bp@alien8.de)>
> Date: Thu, 29 Oct 2026 19:25:27 -0700
>=20
> A K: is a content regex file pattern which matches any text in a patch
> so if a commit message contains "TDx" as in
>=20
>   the TDxE (Transmit Data Empty) flag
>=20
> for example, see
>=20
>   [https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.renes=
as.com](https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.re=
nesas.com)
>=20
> get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
> obviously is a completely unrelated patch.
>=20
> The same happens when someone uses it to check
>=20
>   drivers/power/reset/tdx-ec-poweroff.c
>=20
> patches.
>=20
> So switch the x86 TDX patterns to files and directories (N:) type
> patterns and group them by path, for less false positives.

It's probably better to use F: and not N:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a162e9bcab1..6aaeb7df83c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -30347,8 +30347,11 @@ L:	[linux-coco@lists.linux.dev](mailto:linux-coc=
o@lists.linux.dev)
>  L:	[kvm@vger.kernel.org](mailto:kvm@vger.kernel.org)
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> -N:	tdx
> -K:	\b(tdx)
> +N:	arch/x86/.*tdx

F:	arch/x86/**/*tdx*

> +N:	Documentation/.*tdx

F:	Documentation/**/*tdx*

> +N:	drivers/virt/coco/.*tdx

F:	drivers/virt/coco/tdx*/

> +N:	include/uapi/linux/.*tdx

F:	include/uapi/linux/tdx-guest.h

> +N:	tools/testing/selftests/tdx

F:	tools/testing/selftests/tdx/
