Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67484039;
	Sat,  8 Nov 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608762; cv=none; b=LT6f/6yLh3+gP0+3uIlhHg9seHnVchd4o7ZxGJ3tacX7tGBARy1UsSCwAsr9mZ/FMI4KibESqsWPfbuDRAahfoT6UKe0gkw80U8a1rmLEXPIFSUXTmpXSFK6PHq/2wLXUjWCbvFpb+W5B/P7B03zfos8KXpMvGNmSCDSWzSKEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608762; c=relaxed/simple;
	bh=jULOBHcBKdQ101ANL3pu1iQUP3x4PyG+JFmTLsy3Q+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV7FHszjQcqKuOVYtLvnE+oWGWhOJwKTjIxi4XZf/9zKjLeui1fVm71KlGme+2b959/gafsu3Ob0oB1HR8Fn+mznK2ue4AQeiehN3t1ET7xxaJwtTVnAD3pRv6EJKITY+uEDQpbbdwjdpJksyA8pokG+sx2StiLc74PLSeZnstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dco72LzC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dco72LzC"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D8E340E019D;
	Sat,  8 Nov 2025 13:32:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8a4Wosj-JkJd; Sat,  8 Nov 2025 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762608747; bh=OHgEKXJeP53sdR7rnpRrpCr4xOf+yN3/wkJbPvpO6E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dco72LzCBJ66X6QElDjHkm2xOFkVrNhcK3pkqVdpxS53QALB+SKeO/ezZMI65PL1Y
	 xm+94qkGitYEqVl8j1aNdLDCQgaIknpMT04uTIKd1qAesvkm6RE+ENzb+O0PXvY6Tg
	 5ekAr397DnlphXaLtAyCH9KZtkFmrYBrac0Pkb0Hda7WrOg2IdZgSvx5FgGctKgx7M
	 U/CyaSVVnAjg7II0iuvTG5ACuCJSnpykQ/cVip87T/eRIG8MWmQow3ZjlfU++f/qTZ
	 v/z3qtIUZAiT+CcPTwj/yowjQjnQ15IYfyP22+hZKIJPHNm2oLRPjbsYTC0iCFL2gY
	 fFQNBXXkesB/Kvy9na8x7dAH2pSY5/CRIWz4T/ytAel7NstRIq9O83S4R1eHUK8JT/
	 gh/7H3PMrETqV6ArB6F0wkBNAV9DLXFOfCMvvgFFL1CFfn2pAH4Sb/DIIs4yxs/07+
	 +5PmuHexHGY7g0YPOKpGiOpJ2BpLqwK+dzLrakUj3LIrrYyop/TzmQB/uzXgVp6u2r
	 dI8UBUsqYxQiOHXHvd3iJXNgSu2EnfRKSnM5tZRQE0l7pU/Zqlo2cwxas6s5oY8Xae
	 o9UvV9rCZQBPIJlTYbTjSMCBdUFinFlL4Ya0IaUj1U0BFwBxdqI1dwytXLmohA7Lo2
	 pL5LOwEtwnWRKnpIA1V8H6Jg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DFDF940E015A;
	Sat,  8 Nov 2025 13:32:17 +0000 (UTC)
Date: Sat, 8 Nov 2025 14:32:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Alex Davis <alex47794@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <20251108133211.GAaQ9GWwVXkwY1wn9I@fat_crate.local>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
 <aQzJveMYT6O3EHeK@smile.fi.intel.com>
 <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
 <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
 <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
 <82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>

On Fri, Nov 07, 2025 at 07:20:26AM +0100, Jiri Slaby wrote:
> If the reporters could give it a shot and mark this by Tested-by, it would
> be great...

I'd love to but I can't reproduce it again, for the life of me!

I've rebuilt a bunch of kernels on the same machine but nada. It simply won't
trigger again.

Damn.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
