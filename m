Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487184;
	b=mnP7tz9txW9iAEtZz3EiL/F73ua1hmsU5+ZJj3X7g7HUl5Htt0YQr8/shrgcs1H1YET0
	 JgUkliqRdV9j/r+dEiSgVCDwcxsyKC0Yum/hyVmaNreSmNyKXDJ7VXzhapoB8YcF4U0vP
	 2tirKiCSELrK2PHfZLpstKc6/Jeax+rDHyj/MosEOxbKqo5hsPGKQLlwvDprHZcvdq1Q1
	 TO5NHOHnnoXu6Uwgl7VoQVWBiYvnM9j8kiRBCBx98dL3bwj0qDgTneck2+1CYQr+xv26s
	 KWOnrk4JoDzMWuOuByUlUJS1C8rsVQb1fNjJ4byhmLSUHqC0xGfou6+dZNcixrUPPvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487184;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=7rj8u/UvoPl33grk+9GADLsAX2hYAohNEc54RJVP14k=;
	b=X6mYzstMe9LtMGgBs25nPmX+VONN2n+KLTfE6wUSJXnxfM+m3TSSMiu3pzeOyShcrSvg
	 wUhnBjlok2PfXXyjr+/lj4qgNbn99ytHdO05aPhT38hFz9z4XqqzdxchcIW7V3+tbhgxN
	 375nuWNUuyYTX4Z0Gx2cTTFcNF5b8mpWyW5S/ZEn6/+bZRe1QhAl6YQyh6mbkGkzxk+2f
	 fIR8ddrA0QfEXQ+6BOjJxl9UHbkjRaev+oQ9fMG86qpjwz1t/A6Mu+BU+A4q7yxyGQoCp
	 w0aNwkxXGD7pVmCbBjG3od94PQzWLdD4x/+Q+iW74G0U4EywtumTqU+AWWThblmFhOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB2606A31D;
	Sat, 31 Oct 2026 22:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AB2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 092091C4326;
	Sat, 31 Oct 2026 22:52:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 8290A8000F;
	Sat, 31 Oct 2026 22:52:51 +0000 (UTC)
Message-ID: <94f0ab99b5c9072ce7c026672f704b2987db427f.camel@perches.com>
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
Date: Sat, 31 Oct 2026 15:52:50 -0700
In-Reply-To: <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
References: 
	<TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
	 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
	 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
	 <35ba539820e1782bde038df98d3b49295eb7cd3a.camel@perches.com>
	 <20261031202741.GAauZPPfNDpQLSmIZD@fat_crate.local>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8290A8000F
X-Stat-Signature: wrphe1g58doyr98fgezuwqmu1atgin9d
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+qb3BuH9YjR22czeDdTdd93jOWsEqBurQ=
X-HE-Tag: 1793487171-147821
X-HE-Meta: U2FsdGVkX19VSC24XAmKXD+FFUbKxT+lVME26wksYovRKHagZcnzja7HIjX8HCLIQvKUOGUz973oMsRB3NQMJ/+IG2Gs7tGk0IiJzrJwSka+SUMt616a/ldJ287W1ZLbyuCjSn9i0EIEtq5tZZRUeWXfRosx+pyyGDZYu03mExqtF9FOUYloFdyw7dUmxwBTeLHfSrO6CjbplVF6BgmdDGKL60yrefSFXVK1PK8CLNYXF0uulO6qyCE4s8lEGQqGTmOlAgzv2MPR2PCfb8AvKNZyW464VZRHUCorB2BAjU6JFGw0ENIMC/0bzWO3cc2S0bIAijzGzJNcdwrcqyfDb94LzbQ5aDEGh4Bvaf3sxV1obqbGCS7ORw==

On Sat, 2026-10-31 at 13:27 -0700, Borislav Petkov wrote:
> On Sat, Oct 31, 2026 at 09:43:44AM -0700, Joe Perches wrote:
> > It's not an error in get_maintainer.pl
>=20
> I'm open to suggestions.

Overly broad K: pattern match in MAINTAINERS

> > > +F:	include/uapi/linux/tdx
> >=20
> > No file match.
>=20
> Works:
>=20
> ./scripts/get_maintainer.pl -f include/uapi/linux/tdx-guest.h
> Kiryl Shutsemau <kas@kernel.org> (maintainer:X86 TRUST DOMAIN EXTENSIONS =
(TDX))
> Rick Edgecombe <rick.p.edgecombe@intel.com> (maintainer:X86 TRUST DOMAIN =
EXTENSIONS (TDX))
> Dave Hansen <dave.hansen@linux.intel.com> (reviewer:X86 TRUST DOMAIN EXTE=
NSIONS (TDX))
> x86@kernel.org (open list:X86 TRUST DOMAIN EXTENSIONS (TDX))

Hmm, that's likely a defect in get_maintainer.pl
in sub file_match_pattern:

      sub file_match_pattern {
          my ($file, $pattern) =3D @_;
          if (substr($pattern, -1) eq "/") {
      	if ($file =3D~ m@^$pattern@) {
      	    return 1;
      	}
          } else {
      	if ($file =3D~ m@^$pattern@) {
      ----->				^ here - likely needs a $
      	    my $s1 =3D ($file =3D~ tr@/@@);
      	    my $s2 =3D ($pattern =3D~ tr@/@@);
      	    if ($s1 =3D=3D $s2 || $pattern =3D~ /\(\?:/) {
      		return 1;
      	    }
      	}
          }
          return 0;
      }
     =20
> ...
>=20
> because it is enough to match the beginning of the string:
>=20
> $ perl -we 'print "match\n" if "include/uapi/linux/tdx-guest.h" =3D~ m@^i=
nclude/uapi/linux/tdx@'
> match
>=20
> > F:	include/uapi/linux/tdx*
> >=20
> > but as far as I can see there's only a single file there.

Please add a wildcard * at the end

I'll check the rest of the MAINTAINERS file.
