Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E5202C5D;
	Tue, 17 Jun 2025 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160527; cv=none; b=dEnlp2G0xzXRHaIIQGmnC0zY+94QNpCZuZTrQ/c7LG8IlgGLCDjwcrcN2Rb+nwXg60JHK5OGYQo0WHR8J1gcMICPiHmPOEb2WgkkovfQOEc7r/K6BjP4EWiS/fQlg/jNY8ABoeNnTYcKi0morpG9eSOC7q9OaUN/t1UhvsNM8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160527; c=relaxed/simple;
	bh=lOwm9sI0KP7rL93Un/JNFyYB8Kf8ajV3HnbE+/qfiBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3VvFfeojGvNYPQfR27RMdCfJbo8khrOqrFdWUsy3Lso3WquiuMyKpLOOGcyOdlPi0IXZAXAa6jmNQtmr7odpYxa7z2w9m3VCIu/NX02jsCXVvQyVD7NjXOZ73RXYwlUpEiDEmNdi0b/d2g3dig/dIQhiJaoXTtDtZ+n9PNjA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v68wUDbK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v68wUDbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F436C4CEE3;
	Tue, 17 Jun 2025 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750160526;
	bh=lOwm9sI0KP7rL93Un/JNFyYB8Kf8ajV3HnbE+/qfiBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v68wUDbK/b7Wqos24oKH/hgR/Q5WDrEmQ4KRbOHAfqO7y9ASMzzVY6e9415zEmuL3
	 GD+Sx7+9vsPaGTDoVxlQ60j67veVmpRY6PO2KEJWXSfMMn4Ck5bERJDdC806VchCi+
	 uPiqFqnQ+31VCqlPvFsvVdU/n7vQ0FVSdrDfLy6o=
Date: Tue, 17 Jun 2025 13:42:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/33] serial: 8250: drop DEBUG_AUTOCONF() macro
Message-ID: <2025061733-pushy-croon-08da@gregkh>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-30-jirislaby@kernel.org>
 <alpine.DEB.2.21.2506171216090.37405@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2506171216090.37405@angie.orcam.me.uk>

On Tue, Jun 17, 2025 at 12:32:48PM +0100, Maciej W. Rozycki wrote:
> On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:
> 
> > DEBUG_AUTOCONF() is always disabled (by "#if 0"), so one would need to
> > recompile the kernel to use it. And even if they did, they would find
> > out it is broken anyway:
> >   error: variable 'scratch' is used uninitialized whenever 'if' condition is false
> 
>  This is removing useful debugging aids.

How can it be "useful" if it's broken and no one has ever reported that?

>  The issue with compilation is related to commit 3398cc4f2b15 ("serial: 
> 8250: Add IIR FIFOs enabled field properly"), which removed the assignment 
> of IIR to `scratch' (although a path did exist before it that bypassed the 
> assignment anyway), and can be trivially fixed by bringing the assignment 
> back and moving the debug statement next to it.

So it's been broken for over 2 years and no one has asked for it to be
fixed?

>  I agree that "#if 0" isn't very useful as it requires patching the source 
> to activate; changing it to "#ifdef DEBUG" would make more sense nowadays.

No, dynamic debugging is the proper solution, not build-time stuff.  If
you really need/want this, add it back in that way, not this old-style
"let's rebuild the whole kernel" type of thing.  This isn't the 1990's
anymore :)

thanks,

greg k-h
