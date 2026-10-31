Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478497;
	b=gzqTvSw6mGVF+ldkwPg4ZrkULDH6666iT0nhFTwqKDij4mPCnsXCnpM9IN/fep8xQdZb
	 nyAHg+MTwuSVSyoW/g/dhA8dEkE/lnA2pbp000TCqQoP4DRtzxmEvhZCrYEaeacW3pZlJ
	 Ft+6Wpibmsa7WflfB0I6H+gpDNYdqgZSVQuoPmVnvHzc0xglC1xXAI9TvGGGQIVP490vK
	 N/1vxfldeEkUSzNH7IS59B3B6uVBSe9Hq8xb/SMeZ6UNn9Z0LBSF8Ykejk9EnMti/j/y1
	 exQcrlK6ZycQ34eStxNT7lkHwct+DN2nlfH6ZA+4FnOCmTaKEg+Ca7aM0wpxIxegrgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478497;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iREJnj1dRudypne7M94cfs97N8m2yOo1WUEkEn9vXIQ=;
	b=hwjcqoOJ6bcYsrl1hcwCnFf+EsbPJeqyaF7iOmb6y4x0YVwvYV99/JUiCcN7P3bjDwqm
	 DzQ+GuBnQwhenuIDc4suMbF/hK/KeWCNNz4QwCQEPcCrNo/ZCI2s+oJuoVptKTBYwHbMY
	 1o+LvgLn0gUJxYui5YjlnxkhP2TgIAEZyGmj5CzJLaHn3/jFgpiAOH7453aEPigUIBgKU
	 lMYk+JOtJVsbY4VBoxbvCF3IjRWEvbd2IV399+rgFNR0LzMuNQ3bVZaMFBQ57lCYLSatX
	 52qomN3P2AVvJ5xm0tLNoXw/LnyEIBSLaiyABY+vqQWwaChhgD1gdc9RQsxtsSR36SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=GfwnDjGs;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E3606A31D;
	Sat, 31 Oct 2026 20:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=GfwnDjGs
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BAFAD40E02B7;
	Sat, 31 Oct 2026 20:28:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d0DInQcl9Vsc; Sat, 31 Oct 2026 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793478482; bh=iREJnj1dRudypne7M94cfs97N8m2yOo1WUEkEn9vXIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfwnDjGsTTSvrYvL9jD5KoRtqPnFWR7pNmGeUe1LQ8+mKgzDwoPvY5MGnwWyx8jue
	 DHbOegJ/qfwq6V1M6jF651IJGrylE/eIFPk/7hM926G4MfH0CrWvfMpTgrNAWHKM93
	 OH/SFBACY7wFCyoPDFLdsAwWDUg7aXGUTrJ5eXcPjJVfn1fX7smbieNQ1lrvJoZA0J
	 gq4oxz/olxQGhln696QmLr58NQeUDs2JfM7ayKSx+2/9wnKGD4pjDNOScY4q5Nobak
	 2JQ0NdgHgYXL5TlBWnqhi6uDE4LFN4mi6i3BeNWSQ3/Id66O7RWWGaZK6zhf7+DUoj
	 XaTQFh8CJ0GRgfLXLEqaqZBPZE1jOeSynmMtJ86cYwYY0LwdqklC1llpUiqEuB48bC
	 xXS+rh3HJ8GYjepifmhRA4Ho3z5efricr9IBpxl1Aw1H1Ge93mvuizIdOMH1XzvS/O
	 9W7Pgj2qEYwqnsZKJX9xUDckGeYfGZdl5QSQwGRfiaDw+TRKuDmoZ7bKbJjXod2Fz0
	 71ZMb4UsA9DnAiSo+xAAAuqdddBXxnhCN5uNdnRkA7jtbTvqJwP/sHVatcBm3MVLYm
	 s/JtuuL4ZJoqugV64RoQl0ZTujkiXuyR9n3kl3wPYOl3VPzanfZwF11aRQqwyZmPZz
	 AU2r622K6p4eTzOd0O6imPCY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E677640E016C;
	Sat, 31 Oct 2026 20:27:44 +0000 (UTC)
Date: Sat, 31 Oct 2026 13:27:41 -0700
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
Message-ID: <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
References: <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
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
In-Reply-To: <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>

On Sat, Oct 31, 2026 at 09:43:44AM -0700, Joe Perches wrote:
> It's not an error in get_maintainer.pl

I'm open to suggestions.

> > +F:	include/uapi/linux/tdx
> 
> No file match.

Works:

./scripts/get_maintainer.pl -f include/uapi/linux/tdx-guest.h
Kiryl Shutsemau <kas@kernel.org> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Rick Edgecombe <rick.p.edgecombe@intel.com> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Dave Hansen <dave.hansen@linux.intel.com> (reviewer:X86 TRUST DOMAIN EXTENSIONS (TDX))
x86@kernel.org (open list:X86 TRUST DOMAIN EXTENSIONS (TDX))
...

because it is enough to match the beginning of the string:

$ perl -we 'print "match\n" if "include/uapi/linux/tdx-guest.h" =~ m@^include/uapi/linux/tdx@'
match

> F:	include/uapi/linux/tdx*
> 
> but as far as I can see there's only a single file there.

The idea is to cover everything that starts with "tdx" in that path when new
headers are added without the need to touch the file pattern.

$ touch include/uapi/linux/tdx-host.h
$ ./scripts/get_maintainer.pl -f include/uapi/linux/tdx-host.h 
./scripts/get_maintainer.pl: file 'include/uapi/linux/tdx-host.h' not found in version control 
Kiryl Shutsemau <kas@kernel.org> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Rick Edgecombe <rick.p.edgecombe@intel.com> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Dave Hansen <dave.hansen@linux.intel.com> (reviewer:X86 TRUST DOMAIN EXTENSIONS (TDX))
x86@kernel.org (open list:X86 TRUST DOMAIN EXTENSIONS (TDX))
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
