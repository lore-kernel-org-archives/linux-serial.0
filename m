Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFC3B3BE2;
	Mon,  9 Mar 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059713; cv=none; b=sk9GwOi9UYHkZWJ2V5cGBjt2ZA3zVd6q79iZ41nG4CmzKOmw4yBe1Wd1nG8XNt5eBM8yLEQWyYkf2lO4Vo5bMblnz+QavEXfa23x2T1Gh+eWcTEbvVk3j3mBR2xJCHd3k2pNAw0IYWPkMtoMGQj/PrWvFZU6roVuOQES2oLxObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059713; c=relaxed/simple;
	bh=xdrQ9evl3SuSK42buI1E06yz4B8K1xzon415vgqlOCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFPYLyj2UVVEjBaAoIOIkkBL1KaEcwSgG8eYGkwPfeT//fXlPnOwqLS13E4cU9f2xWwlVrZBtWBSbFmAjIgSDUNGo990IQgvzLPD17D8rIydqnbyvpPGVpBGJ0ZyWr65LHE7tC3S2mNC9tQGo9wqIm00eMRos7J55qsPtmyJr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvFSMCHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvFSMCHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EF1C2BC86;
	Mon,  9 Mar 2026 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059713;
	bh=xdrQ9evl3SuSK42buI1E06yz4B8K1xzon415vgqlOCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvFSMCHTxmGc0xlcmnPYHlkXlJmAjVjZDl5kO4bP8k3K1GCrYowRBgtPJOiSUK1Ia
	 Dsm4fqWJOGZYyf/hnfo5HitNMjIR9SN5MuuvS2hi7ySQNZEOx5zGTs6o1pMb+KBbQy
	 Fuaza8eAQKJenGJI32Dkkw5W6sccdPFQ8L0/jZ14iWikDv4dw+vWtEPOEd56fBuez6
	 qvXfLiupbH/kt/zT12fGnSy5+0VQ289o2essgwnY2TYgvS91SNUQsVh/z7C5OdWFGR
	 og4NTlZv0aGU4UdPk4zzpXf5OnHSyUaPFpjuEEJn29W2q4V3++jF5H5C3rYGhNoLh3
	 vpkA1tW+2qGkw==
Date: Mon, 9 Mar 2026 13:35:08 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
Message-ID: <aa6-fCGTsGW6CqXP@example.org>
References: <20260203045457.1049793-1-nico@fluxnic.net>
 <2026020851-bullhorn-glitch-0e37@gregkh>
 <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>

On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> 
> > Argh, sorry, I saw this patch series too late for this merge window.
> > I'll review it after -rc1 is out.
> 
> Too bad.
> 
> But please at least consider  this one now
> https://lkml.org/lkml/2026/1/27/1886
> and queue it for the stable tree as well.

Greg, a kindly reminder about the patchset.

-- 
Rgrds, legion

