Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649012;
	b=zixaYNZZg+chDaweWPsZiehVeXuERI1cXNRNteqBfVpF+GZBFS6pzydIbZwMczzI3gh9
	 u2aUYRPDvEDKsGSPRcr1irdvcQFK/ZFNGli63LF8siDD6K15le8zl9jlKkr9Tnm+3GpaL
	 VyGTntWi46oOGZqOKZQgizMKKiFLLY48PJUr/kRL8oltxq8LmaMb8l3bULKaeAtnerGkt
	 qXs6g2Sm1XyOviNzH9nXhtWttsUT+5e3vWSIfDPLrlZ+/ZgSp5QYnMl+1f+TMeKz6Dy8W
	 0UgW4x/CLvYCDZ955NUIkIWSPNG2wV/gBnPkbTstKzOSLGBCIgZJyNpstSPXjwyaEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649012;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6b+t4DLaXsTbBo3v4wTWOzTtPpjmGsh78Ivlm5MgXBA=;
	b=UPVZg8A75OuZvzgjkTzDZpfQ22y/BHMOmLh8A0Pcx21yvbJiaSMvvTRtLiYYAkASYJjE
	 nwJHw0p+F4ChcoItv+cYXBzPMQHd6INkUICvxHUMyDlI00q4DtLpDlFqIAu82WOfjtwR0
	 QTGxSiOfIHtCN4YvKx/qP3yUQFDvg2zdoy7I4PeniJZT+8RsJqEsNgpgSHWy4ue5jWFpo
	 FXZSrvBE0jxnIkpZAjkiniYHDeGGZmGcAWNJx3zAe7VVM3Psfyw+XoZiRpQ/GN2Edws8M
	 FsQxWFyX2wsSs5ZZFQkVRDU2qD0QkoLv7MBNk6s4VF9xg4XtKSHaYIFbGt434FJK4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Q4c7HHZx;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0047606A329;
	Mon,  2 Nov 2026 19:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0047606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Q4c7HHZx
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A03FE40E02B7;
	Mon,  2 Nov 2026 19:50:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K2LTiNWHYnAL; Mon,  2 Nov 2026 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793649004; bh=6b+t4DLaXsTbBo3v4wTWOzTtPpjmGsh78Ivlm5MgXBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4c7HHZxNNyjLdj82SDdH90ubdZp2j335bULS93wJJeuc8Q3YM5EDCRGeyAW4ZcQZ
	 0F+5FLADLQWtkDZNFizrJgq4o3Oj0kKJwxSa0JyTG1UKCkWLDlQ7HXxfLMpvKExu8s
	 HdSvoOnEkWX6qSLuEGDVM7hC91vfxd7dinOWArxb7xF4LPi49xqYjv9xdktjno1z3U
	 o2DmFUpy0pyi9zBZ2g1oaoTqDZBsoHjopl3l1RxxRA9UXVNnOISmC1Cn64xI3KhkaA
	 tGOcUb5kYmPWNbfCIbfnonkZCqQS6ZfLQ/TBv/ZQqstw6slVEZRrB9hnO/1cENHMxT
	 fOE8lFReNL72vwB4rYzgbhpZbSgKC22y6unZqzst3rWgHEnmGHk9SprG5cxgwE09oZ
	 lcldiouakI+xn1Q7ey3dkzLeDsjGNjXeF8E7l4KeKB/IO+XbpvMHPuvryUe6kOKfdB
	 8gCJ8mlHUwlXOx1+BKOV0BroyXMYIY0RcQOesV7DOogkneghldDF9edF4eFXDJeNc9
	 atGQOkRTRMrgaun31vAtpki2NVpfvpIqi1fsO8U6aSguE2r8TY9PftQEmMA7kaAG3Z
	 i1QLQQKkrrVLucWTNs4uiBpYL0JYkk9ZVKRurGotoCIoWHKXIWZErt2d9MK9dNixiN
	 A/JO1WzVrAkw3jQ4uNmVZq2k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 307D540E016C;
	Mon,  2 Nov 2026 19:49:47 +0000 (UTC)
Date: Mon, 2 Nov 2026 11:49:43 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>,
	"au.dang.jx@renesas.com" <au.dang.jx@renesas.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"biju.das.au@gmail.com" <biju.das.au@gmail.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <20261102194943.GEaujpV134C7Wgx0Nj@fat_crate.local>
References: <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
 <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>
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
In-Reply-To: <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>

On Mon, Nov 02, 2026 at 07:38:07PM +0000, Edgecombe, Rick P wrote:
> > +F:	arch/x86/**/*tdx*
> > +F:	Documentation/**/*tdx*
> > +F:	drivers/virt/coco/tdx*/
> > +F:	include/uapi/linux/tdx
> > +F:	tools/testing/selftests/tdx/
> 
> This drops arch/x86/kvm/vmx/tdx.c.

./scripts/get_maintainer.pl -f arch/x86/kvm/vmx/tdx.c
Sean Christopherson <seanjc@google.com> (maintainer:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86))
Paolo Bonzini <pbonzini@redhat.com> (maintainer:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86))
Kiryl Shutsemau <kas@kernel.org> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Rick Edgecombe <rick.p.edgecombe@intel.com> (maintainer:X86 TRUST DOMAIN EXTENSIONS (TDX))
Dave Hansen <dave.hansen@linux.intel.com> (reviewer:X86 TRUST DOMAIN EXTENSIONS (TDX))
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
