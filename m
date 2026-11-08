Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145438;
	b=VeG0oiwkb+hFQo/xSJbExjCV+tZPyrGda0+Ga2lVop6XBMkndLUb9s4VxJd013wXnv+O
	 dWiEds0HunhVEdrxHPs++TvKvlzxA5KHjudsfEwygboM5fF4diyjsaVvGFL6mLXHBRESx
	 OtRRdy1hObKLTZqjPhOI8HMc5meLzs+uaEH/IP2iPpLis+m5SsXF3inRtCN4foPdInF5c
	 kWKL0iAWXG656afFSPL8DSMZP6F75EMHS2SPG5U55oYYcCeCwmo/d3zAViCJKQRyBukS1
	 xYUecmZPNvw/fY97KPIhRycMK5oVN8PqnnkGwpaBe4lZRmLgvPAmiKpe7coYGon68kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145438;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pDQUKcI7F5NsVDOo8X0ORq4VCkYvjz4tg9TFFQsurIA=;
	b=pwJdAtSkRB+ctHww8Li6VMQi3jiZOvqdSACQ+HaTyywITVturXyd3hY+XC9Sbt5J2Z9b
	 RQEkRn8VqsCK4hD0d0CaeAZsJ8em3HHu7WTd+qfB3g4lq/oFZwevro8ASMZZpsJnyuT79
	 9WfhNtIayT7BUjz0Fm/A7XUF516Tweyj+NcIXMLrNVtFpImsCpTqf/IpxE2YoSaCkDWJk
	 W2TeJ8vMdxfNIA4gboMVFY6uGQc3CndwmzMe3jLoOSsvXGhbJ7d4WW+wV1XLBc9+Ccovs
	 aTIdDGww+xu62Q7CzxPHmqaODyI12BjVZiFk9SrnHSJxIIjmr3cbw74ptSEMs955ZBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vb9p12b3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13C606A334;
	Sun,  8 Nov 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vb9p12b3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F07C1F008A3;
	Sun,  8 Nov 2026 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794145437;
	bh=pDQUKcI7F5NsVDOo8X0ORq4VCkYvjz4tg9TFFQsurIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vb9p12b3VCH9fUelVcEqnHeeM8ceP7629w6YfwowK1ISoFZ3rKZkrtycjj/PSoSQF
	 K21D6vPCCHuAzAzhF+yuVMUbQEBxqYzLvpGp5U1R0IBEnbmmW5at8XUYMQxvAuCvCp
	 UBMlw+LGL+3GnPe9qqrfR+6p0nrrgPqV1GJj4HlI=
Date: Sun, 8 Nov 2026 08:43:54 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Bramwel Barack <bramwelbarack89@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: n_null: remove legacy BUG_ON() from module
 initialization
Message-ID: <2026110809-phonics-freeway-6452@gregkh>
References: <20261108125031.33753-1-bramwelbarack89@gmail.com>
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
In-Reply-To: <20261108125031.33753-1-bramwelbarack89@gmail.com>

On Sun, Nov 08, 2026 at 03:50:31PM +0300, Bramwel Barack wrote:
> The use of BUG_ON() in module initialization paths is heavily deprecated
> as it triggers a kernel panic and crashes the entire system for non-fatal
> registration failures. If tty_register_ldisc() fails (e.g., if the slot
> is already occupied), it should be handled gracefully.
> 
> Modernize the initialization path by capturing the return value of
> tty_register_ldisc(), logging a clean error message via pr_err(), and
> propagating the error code back up to the module loader.

Nice try, but no, this isn't going to work at all.  Please test this by
actually testing if this code path can ever fail.  (hint, look in the
mailing list archives...)

Why did you decide to make this change if you can't ever hit it?

thanks,


greg k-h
