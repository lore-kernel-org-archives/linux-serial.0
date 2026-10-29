Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257451;
	b=gvJ947RhoZZQg0kcBm2nWXD8nYtV1eF49CIkoP9AqYeokK09XLiU8m/cSRVri+KaDo3A
	 mb79oYS7h2/ElfGV2Qz60g5jibOoPRN0LyQgdEl3bIrZ1IUC6r2+4b2scRhjrcZbBBp04
	 uxqrKkptCp1l1SI4PGsVufDp00bXzZybiDRm9URIm5COeSoWArcY2o5s0R/M12AEvD9jl
	 +brkHdG9ozWBKssK/TtgxB27aCvGwh0o76JAakNQkCSLFXVEgBqa/ykqBzpjGHm0hFWgB
	 PrfpB1gTJLGDKr8kypCAQrcUZmj1gIBP7j83QecNOm2AJIkhHNHjwuuJS9heDvy0v3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257451;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Cs/Yvpa3144r3m5ICee2u9ZQs1e978se3Ngxr+g4f9c=;
	b=TPKpSSAqb00jVYEP5quMSJJWiHeOzpzg75DHxUjDhZPqPgiBzXBrBgstqXfQdrTeRWAK
	 o3YxlKm1wWX1ZCFCiQvIViEgn2A4Mawt8op3f7xUf7qgfoYNzSdbsa1UMoxM3tL3/qtsl
	 YLItMWFQvc69gJuOBJZHx1OxkwLKQzTcMs2fOlpqi3esB54Sb+C2mK4gAHwcZg961o3p1
	 oslJIVN8bhBGaVt1+fUK6xSmPv6ANd1aA5OIlz9WI/ycywyZlFiwcxikKs6eyfXuDtcVg
	 rlqoJQO7l3HGeQtp9uOcCGQjeaDiVoT93BzMn4+ThMLD+CqZkrzV419eX8DVoId9JnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ia4XqMLX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E873606A333;
	Thu, 29 Oct 2026 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ia4XqMLX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C71F013CB;
	Thu, 29 Oct 2026 07:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793257449;
	bh=Cs/Yvpa3144r3m5ICee2u9ZQs1e978se3Ngxr+g4f9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ia4XqMLXfi5LGfdB/7Pn+7FgmQqA7ptQ/e9mTgfAZG1Z7Laz2/dBEGmTUHL/KzLNh
	 K/5uNA/zcUcok/ogEH9E4mCa8J58DbnTNNU1vLUdirfLi7rJAHzi+xCCSg70zP1HAB
	 5+j7Gk2VdWan2aXFPdwRjDusgIGegrjaiW4j5rtU=
Date: Thu, 29 Oct 2026 08:04:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
Message-ID: <2026102930-underwire-manmade-8083@gregkh>
References: <20261029002052.54117-1-dennylin0707@gmail.com>
 <2026102957-suitable-gesture-be83@gregkh>
 <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEkeHft5gqu1Kq0saC1O0hg+ZE9AEO1tOgeXmd-g10uk2obgQ@mail.gmail.com>

On Wed, Oct 28, 2026 at 11:38:28PM -0700, Hungyu Lin wrote:
> > What real system uses HZ=128 ?
> >
> > In other words, is this a real issue at all?
> 
> AT91RM9200, for example. arch/arm/Kconfig fixes HZ to 128 when
> CONFIG_SOC_AT91RM9200 is enabled.
> 
> OpenWrt also uses HZ=128 for its at91/sam9x target; see
> target/linux/at91/sam9x/config-6.18. It publishes images for
> SAM9X60-EK and AT91SAM9G20-EK, among other boards.

Ok, and has it ever reported problems with this rounding error?  This is
very old code, changing it needs to be done only if an issue is actually
noticed as it might be relied on, right?

thanks,

greg k-h
