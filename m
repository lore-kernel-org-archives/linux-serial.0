Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351E34DCCE;
	Thu,  6 Nov 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446299; cv=none; b=sWrreDxcqm+YdYejCtVfENfF7Idp+snmMVjQsJq7HzV8jglaViLyvCQ4YZg1cozRrq1yAgSpTw0XWEvkiLl7ARKbOsDel7Bi62Yr8Hd8soDEQOccDUspp2xHWUU9AZnJWa0VqwadtHQ+KBSWOVh/PQr+C8RNxUFfvNb2qk+RPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446299; c=relaxed/simple;
	bh=l9qVJOZ5jbMlAH3LDvE9KPxrjjYo4nOYuF3Luk5CWp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2oNU0Il+Nt8TZaLjOV3n3kE35g7y9htfCvOBIMrZd4FFFViUiY2jZ9EBNQetTL9rAO6bbF9AtUHLKTT/GyzXnbY7cicza44FAwzh7CTQAHmZq6y2UqyCuHyZ/fe9vBYLOsTURlARYPtxJQ1De42sS0tY6WaKEaAIL+LX9isvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B0YaNElW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B0YaNElW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 86A8140E015B;
	Thu,  6 Nov 2025 16:24:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z9-JYinDnk6q; Thu,  6 Nov 2025 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762446291; bh=eVD5EHrM3+HFooHsVS7V6Cxali4iISkxXiDgpHOnzo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0YaNElWTBrjkm6qqEZd029ZTUR3nRGK26iroN+weoldMP1nhjhBTh0eDbGkM8b3Z
	 TRjbO0uL6BBcKPRhziN+vJbemaNYjqCsNFqEgfvfOUDKO7XcrUGgnq4Pqc4K6kdOap
	 H5+4aB7xiLFVFuBhaw4Qcv2kDmn6Xp5hOtfQLAylI0OUTgKBU4PVh8/6fuAlFURosh
	 wuE6zxdM/G7+w/jV3uqR6gVDm3NIXqqIom3EeHJQr6Va6s815D+i1dAe8jYd72H7Pm
	 O8tSDW6S48F/1pXgaxp+AUGOcBzu0jeXCboowIdRvC+nEGQBiI77DNWTWOkF3v7hyv
	 S/oCC5LnkBB/UhPcojP1irK0FpwdPp2NhjTwTbJ1ZCHqnIwzc4UEsAXDzxXFZFFYSQ
	 HZF2wcuJGWOhY4aDyhfHJ7hQM3aHgIeSTEwWyW/wgkPmaUBXoALmWSYoqaFPXhWN6c
	 EqFdXlBQCtcbLlpfRhlvCx8KEZH80xLelB44XmRLkyUWTwlhrk+mpdQ9xnC+i+x+jW
	 NeEeDNnADwueYAVmwhZ5hecIQguUV9FRwIVX6Kg7DA8jY9Shc04DNbB1SRH0zmWoWo
	 Eq1y2p2+Np3ovMiLHwDZUQUuhjSys1uEDAGp78TzmQPB87hhv/WDE2JGqoihtNd2Gd
	 xEZifJDOlwgHgfYB6ffTO6WI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F0A7240E00DE;
	Thu,  6 Nov 2025 16:24:42 +0000 (UTC)
Date: Thu, 6 Nov 2025 17:24:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alex Davis <alex47794@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
 <aQzJveMYT6O3EHeK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQzJveMYT6O3EHeK@smile.fi.intel.com>

On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > So I'm seeing this with an allmodconfig build too:
			       ^^^^^^^^^^^^

> > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > depmod: ERROR: Found 2 modules in dependency cycles!
> 
> I'm surprised it took so long to people to start complaining.
> 
> So, some of those are modules? Can you share the
> 
> 	grep 8250 .config
> 
> part?

See above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
