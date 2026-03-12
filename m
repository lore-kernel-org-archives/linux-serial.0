Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212736CE19;
	Thu, 12 Mar 2026 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325784; cv=none; b=hev49VB663Rb35EeD2fLhBp44suIDzTO2VWbdeJTqiH0Uj5iKBWywRPyISqLjxXQsKowr7v5Rz7jkuuKQzo2pEYy9/Lu/qY71ZC5gwnkEfU7RtF8sS3vY2xks9QF5icqsdEo9U+oAqgP7BLzWDMNSL+kgk92pGuXUbnuPvATKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325784; c=relaxed/simple;
	bh=oMIqgCJzs9AJ/+NzIpcq+znWVE/l8J8nvxcf6Rgmw7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEkDibS/+xflXRMAKKUN5cDRW+jQA361peieZrTCoX+OtgCEsK2I+fW4BdVylFRKyXX4KBoDkHVVR3vgTwS8itFJdIfj5yVHAH7GgFpRbQu7Gqf4/CyNP1kneBbEXfARODmccOIFDSvRLIJ4Ip/I84EjdDfm6TS/gLSW6agDDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnziUvDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LnziUvDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D798AC19424;
	Thu, 12 Mar 2026 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773325783;
	bh=oMIqgCJzs9AJ/+NzIpcq+znWVE/l8J8nvxcf6Rgmw7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnziUvDd8qvmry+Oq36ybmzWHXQXtfHUOo5IuiUP1U+MneRrcJgSK9XJ1yjkGF5wc
	 LN/3VK3BqKvPrrWMbPMZsRwEjxLhFIwBdV60oBOwQ/ov+DIN8GS2SlnxXLhg5cL5Z7
	 hPKSY4WhN7XOhOZEgeJNj3mQ8U5qHYSZsMUWxLEY=
Date: Thu, 12 Mar 2026 15:29:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Saponara <as@php.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] vt: Add boot param for setting default vt console
Message-ID: <2026031235-catcher-amazingly-cfed@gregkh>
References: <20260301214804.283484-1-as@php.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301214804.283484-1-as@php.net>

On Sun, Mar 01, 2026 at 04:48:04PM -0500, Adam Saponara wrote:
> Presently the default console is hard-coded to vt1.
> 
> The param allows for setting a different default. The param defaults to 0
> (vt1), preserving the current behavior. It is clamped by the constants
> `(MIN|MAX)_NR_CONSOLES`. If set `>= MIN`, `con_init` will initialize that
> vt as well (a couple extra kilobytes heap for the `vc_data` and
> `vc_screenbuf` structs).
> 
> Without this feature, users achieve the same effect with an init
> script[0][1][2][3]. This works but requires an extra `chvt(1)` which can
> race with user interaction and flicker the screen at login.

What user interaction races?  I'm loath to change this as I've not seen
any bug reports for this.  What changed to cause this issue?

And this is for the "odd" systems that want a graphical login, BUT still
want to default to the console?  That's a very odd configuration, and I
think that we should just stick with the fix that we have for those that
want to do this as adding more boot parameters that we need to support
for forever feels like a bad idea.

sorry,

greg k-h
