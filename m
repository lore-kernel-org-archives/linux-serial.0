Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561907;
	b=xgvonbEgcrPsPa+wVZRc7j2xSYb7KwFwHI2EuPUj1D68n4C+VJqYvyuag9YNc3x+PrBn
	 4/RbOU2lhXT1QemrbPiN9YSCA+JW9Aww/kYk5PZFhLjwd+WUKcsJ7Xp98bTsOPaea3clQ
	 hYixyC9SNXTRCOvGzOU7me0BkhextxS/qIfczMEj36pqkVORF+02fO9PQL9CMSh2kN9nW
	 IjzBBkC6tQNX1dGUAlmLl/Y7RH1VM0Aj/0qzo3OP7jT+X5nSQXXyFGNcZrzrPevZU1ImF
	 aNvCDM+dwBiwCbNqwmAiILN1Q2CpTMgmWvQ8PejSaRzghBy+sj8Az4f4cSN8Fugss5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561907;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ez6Bkf9/WC3Za/o0PdW3/MlWlWsnBJkg+tGwbJAmeGk=;
	b=KqX0jRN1dyn/ql5HZHz/Z1V4vk8tli+KG0JVAhv19zmVS/Y3btuCDQ1R1cJ3ocJKP9NS
	 7Jl8ptRsmSK0O71rXD/h5/Sw+HJu5f/aRcPrKsHSUXru9cNsVPuo/6OLuu2FETYaCPWI0
	 aQGfo8HzXWiOB/HVrFnzsfeT92jmDB+459zuGJo624FuDDTmRChOY5sjX6LwCYRFaJupi
	 YEbYAfWHyBCzyGXKvJrlUq/Psctd7tesySpu7c8WqO0/XdwRVAhTHpWrFWKKgVzjHxBqu
	 +MJ62z0/jdrkpMVB5furDl8r/JLawE6Q5BcHQmxuA2ucRbrBfN+zaOR9rQxwHmp4Ixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=i7Z2H+xT;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54017606A326;
	Sun,  1 Nov 2026 19:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54017606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=i7Z2H+xT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B27B40E03BE;
	Sun,  1 Nov 2026 19:38:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UL-MMPvpERf2; Sun,  1 Nov 2026 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793561900; bh=ez6Bkf9/WC3Za/o0PdW3/MlWlWsnBJkg+tGwbJAmeGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7Z2H+xTqyNuxqm05hjQjcp6Mq2bH7nG/iMIBCpAvzqncAwHgQyN5L6fF9VL2v9rn
	 FHw3rEroBmeuudqE+CvHXJYfiKrtIWbGCtN5KxIxP/MsNF5XJK5VY2lrdROwpdUs3n
	 QxZtD5WLD9baF7Q/AcALPFG0nVdOVo4n6GjYOequfA/DVZw85FN/wetquBBMSRMO6/
	 RtDDsz+8xtVEd+AXnNpqNShZMFrD+DGjHQumwAt6hLRrLd/uHXcojcQI6HQHew2K4p
	 VS7IAAcMR5jEviCV56y+3m2nFMzBw3M+9JcGWTXD04dnnS3I3idmBWML4Ou9n44cqZ
	 HD4XfpDnsit3CR57RDbWSJHEtxhuPFAGwIQ764gYPyO0RggXhAfLEVH5nj9IrNWd53
	 AjQl4hCU36niq0hq4AgTZgKoTj65AT6Q63LY6m3PCsDDY978fSoXhrVH+JELt5ZX7H
	 fk3csKaUk202O2lRCX/cCWS/VKh26iUNybkxjfwXDHDrErQfA+y7350puPFEvvfjBr
	 0t9vE9Oe5T6fV1ohfku62IaafN2DIBMPaRR8/CCS2PgURvGkCx10gohi0mpvvdI4vt
	 9KLPE24m3ykGum2Y0ZvNVA1qJD7dVnesVZG0uhtNErtLxU1IqFpE1kcdNfPZvwsV9w
	 jDnGJPwjIlpwRI1sF4GgfJ8U=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFAC440E0299;
	Sun,  1 Nov 2026 19:38:02 +0000 (UTC)
Date: Sun, 1 Nov 2026 11:37:59 -0800
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
Message-ID: <20261101193759.GBaueVF-1a0H8BDmZ2@fat_crate.local>
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
In-Reply-To: <44db8c930587810e902dcb36b5a0718a52eb94fc.camel@perches.com>

On Sun, Nov 01, 2026 at 10:59:24AM -0800, Joe Perches wrote:
> Not completely no.

Well, whatever you do, this needs some documentation so that it is perfectly
clear to people using patterns.

Something perhaps like this below. You probably can come up with a better
formulation - my only angle is to make this as easier and as clear to users of
the pattern stuff as possible.

diff --git a/MAINTAINERS b/MAINTAINERS
index 015cf66afb96..59bbf779958f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30,13 +30,16 @@ Descriptions of section entries and preferred order
        See Documentation/maintainer/maintainer-entry-profile.rst for details.
 	T: *SCM* tree type and location.
 	   Type is one of: git, hg, quilt, stgit, topgit
-	F: *Files* and directories wildcard patterns.
+	F: *Files* and directories wildcard patterns. The matching strategy
+	mimicks git's pathspec shell glob patterns with some exceptions.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net
 	   F:	drivers/net/*	all files in drivers/net, but not below
 	   F:	*/net/*		all files in "any top level directory"/net
 	   F:	fs/**/*foo*.c	all *foo*.c files in any subdirectory of fs
-	   One pattern per line.  Multiple F: lines acceptable.
+	   One pattern per line.  Multiple F: lines acceptable. One way to
+	   verify the pattern is using something like
+	   git ls-files -- <pattern>
 	X: *Excluded* files and directories that are NOT maintained, same
 	   rules as F:. Files exclusions are tested before file matches.
 	   Can be useful for excluding a specific subdirectory, for instance:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
