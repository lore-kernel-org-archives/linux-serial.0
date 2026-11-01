Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562891;
	b=0QzFAnt31utbCmAD/dP+hZtNm/OEF/sabwtuYhBfcWQl+fAC/bRknQ9G4Sv0sPlSq03c
	 mqF3CKmcv2wiqNBzcD8638Q1whltuu466tW1jYx92htgvG4B/hpKTEZeljoJ6rr4Zuk1/
	 kY9qPNoPg/ZHEwyGZTlT1hxCxez/O97O8yIONdNsBZTZYED37/sfGe8DC4JhRA8/ws9qd
	 CQd6EhXIM65cJZDQzYuac1dyviSWNZOZoWLmdLQctowZPiJd8kS0sIROyng51LdvUGTBo
	 WdCuDeHYaxyWBaDxH4ZC5VS/LJ96Mfw+oAX/s4+k606XTw9glfxXWtDKxJLUB6RmjbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562891;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 X-HE-Tag:X-HE-Meta;
	bh=yn+bD+MfSSNaL0WRRiYR7sS68Mkuv6PSjtwZ+uDlVvQ=;
	b=y0S+Gksb9OBXKaH2pgPIwsAtbJLrFiCf+lcat3Bx2voMVoHXL52WG0zftD61fPyx2Fgh
	 /TJi2Fy/vI5flaL29qSTX3rv3f+ToZKBSpJTorYoVC38P0g9j+D+KffyO1ceLMJdqRavD
	 NKyADlMPDLFZtExGzYNc2ENd1yYDFqjPcAa/ruDJEaym8l10EvVHUhzWi6mhlJ1riHk/Q
	 jIrd0e5WljVmrYMdI9zZDgFvsocRI8c1tMNf1ULHIlEPTEGgGg0I0wX2+LqjHIvU+8zD7
	 HJepBGQkB1SgwfjGHzOzJkKMRoyzYyv8QDfAyQsU7x1gd+d4AzsFUsA64xsFx9YrlRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63519606A324;
	Sun,  1 Nov 2026 19:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63519606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 005D91C42EF;
	Sun,  1 Nov 2026 19:54:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 8A2322002C;
	Sun,  1 Nov 2026 19:54:43 +0000 (UTC)
Message-ID: <874236faffbe90543d69361f04628fd8047ab1b8.camel@perches.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
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
Date: Sun, 01 Nov 2026 11:54:42 -0800
In-Reply-To: <20261101193759.GBaueVF-1a0H8BDmZ2@fat_crate.local>
References: <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
	 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
	 <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
	 <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>
	 <20261031235958.GDauaA_pScrsk2xYUF@fat_crate.local>
	 <5ad69a1167fddc7caf1eb73e439765116db1ce17.camel@perches.com>
	 <20261101014710.GEauaaHoYk5TzRpGBQ@fat_crate.local>
	 <b700f0fb96b9454287850f7aa54d876b709cadb0.camel@perches.com>
	 <20261101185452.GAaueK_PzlK68DsmRz@fat_crate.local>
	 <44db8c930587810e902dcb36b5a0718a52eb94fc.camel@perches.com>
	 <20261101193759.GBaueVF-1a0H8BDmZ2@fat_crate.local>
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
X-Stat-Signature: dr6b5bqxyk3rjmrmsjza13kezyz1iwjz
X-Rspamd-Queue-Id: 8A2322002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19b0xqtFBah+z+6WoWiDndiYJCwVvlYce0=
X-HE-Tag: 1793562883-680340
X-HE-Meta: U2FsdGVkX1/QmOdKJK8oAnfrq2pd0aRCgXVEOjfEDsNe2zJxF3rPtomDiMsoCyyBsGyepKjlsctYqXHC8byHmwvttxfYo6/7sGJfURkoles9Jx1JsXoc/yTf3y7u7Cj8CuNIICUNnluKw6GAXS9H8ZgQ0L8ZddNkeXaOQCiLa2rfj0VwPnXoVmX290A7MWaiuHuCzg0SVrMPuxVySVwQVsEUJs+n0dqEzUg6fVtSSEaMKNXG3rI7aEpmtJc8J+16IbabSVh16dMHBXU4iWkyExcB64LOIeqb7jXmHdhJNbmhfZZXSGxAj6srIa5HxGBC

On Sun, 2026-11-01 at 11:37 -0800, Borislav Petkov wrote:
> On Sun, Nov 01, 2026 at 10:59:24AM -0800, Joe Perches wrote:
> > Not completely no.
>=20
> Well, whatever you do, this needs some documentation so that it is perfec=
tly
> clear to people using patterns.
>=20
> Something perhaps like this below. You probably can come up with a better
> formulation - my only angle is to make this as easier and as clear to use=
rs of
> the pattern stuff as possible.

Thanks.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -30,13 +30,16 @@ Descriptions of section entries and preferred order
>         See Documentation/maintainer/maintainer-entry-profile.rst for det=
ails.
>  	T: *SCM* tree type and location.
>  	   Type is one of: git, hg, quilt, stgit, topgit
> -	F: *Files* and directories wildcard patterns.
> +	F: *Files* and directories wildcard patterns. The matching strategy
> +	mimicks git's pathspec shell glob patterns with some exceptions.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
>  	   F:	drivers/net/*	all files in drivers/net, but not below
>  	   F:	*/net/*		all files in "any top level directory"/net
>  	   F:	fs/**/*foo*.c	all *foo*.c files in any subdirectory of fs
> -	   One pattern per line.  Multiple F: lines acceptable.
> +	   One pattern per line.  Multiple F: lines acceptable. One way to
> +	   verify the pattern is using something like
> +	   git ls-files -- <pattern>

Clarity is good.

Perhaps <pattern> needs to be '<pattern>' to avoid
command-line expansion.

I do think it was already generally understood though as
there was just one exception to the pattern match style
in the existing more than ten thousand ^[FX]: MAINTAINER
entries.
