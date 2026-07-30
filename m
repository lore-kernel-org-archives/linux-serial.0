Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7502445AF8;
	Thu, 30 Jul 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428407; cv=none; b=kJCVxLFiBhpq+TMmwegcP1JwLT1zzRkHgvFTWwm8CMqWDwpJcmwlE0/1rwj+CgUI/ZaOoRmuA5hBgnsPkIKz3UBB5G2TDAmJDyja43RBU3Ol8k10mX5wAaRuHI5RUeyKgeVeyhvBGkKDkQz2tdcUBRr3J9zLOlZJOzbtCjn3wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428407; c=relaxed/simple;
	bh=NG/Hf9uKQiJmdoislCB0y7wGpGQwRGVVUCDKwXWtQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNHEWPiSbdOKXIDAqRqt5Qe/VNPweAfoUnfKPzISqMVK75AD1dLacXmfHfpnUoluUi2BPZxJPXnOKq/i2OeUCmtbjCznWwo0eUT4xHHs1VTEjquOO9XjM/7CKhtnp3lnik5wCS8MyvJ/ALTZy1Amo59onmDbwQDbM5DXM25SPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zvSST8bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvSST8bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A601F000E9;
	Thu, 30 Jul 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428406;
	bh=QYLU6RYr3yfEPtc/KMYVr/k2ZzhyQ8RzBCm4m1OE4s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zvSST8bdPg82qSZ8SRa5S0ItPvKCkNFYYi7/9Hh085X/cpng9dT7BeY0sr2eybj2l
	 +XTGVPLY9Hk6GSSnWltFjPGBddhCi2mchWFvw/sRVup2j/EFvjItU9KKuigfJpufha
	 3UFomj0Ci97bk2O2WzJUE1niRxJxjS+4jGv+zQBs=
Date: Thu, 30 Jul 2026 16:48:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Yangtao Li <frank.li@vivo.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] quota: remove CONFIG_PRINT_QUOTA_WARNING code
Message-ID: <2026073007-nearby-debtless-cfd6@gregkh>
References: <20260722060155.1111519-1-jirislaby@kernel.org>
 <5cxumyfngrzddts3igtfqhogyabpjf5jywabpjclimnzy5pug6@e34tyng6thbg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cxumyfngrzddts3igtfqhogyabpjf5jywabpjclimnzy5pug6@e34tyng6thbg>

On Mon, Jul 27, 2026 at 09:53:30PM +0200, Jan Kara wrote:
> On Wed 22-07-26 08:01:55, Jiri Slaby (SUSE) wrote:
> > CONFIG_PRINT_QUOTA_WARNING was marked as BROKEN in 2023 by 36d532d713db
> > ("quota: mark PRINT_QUOTA_WARNING as BROKEN").
> > 
> > The code is apparently unused and uninteresting, so remove it all, incl.
> > the abuse of TTY.
> > 
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jan Kara <jack@suse.com>
> > Cc: Yangtao Li <frank.li@vivo.com>
> 
> OK, I'm for trying this because so far nobody was complaining about the
> feature getting marked as BROKEN. Let's see how it goes...

Great!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
