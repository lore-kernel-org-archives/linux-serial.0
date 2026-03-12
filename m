Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4723F1653;
	Thu, 12 Mar 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331006; cv=none; b=TOo8t0Vj7TRPIxKffEgdz2uilsdSdQPxn8BJtCNs19eLk8a5ph22LQ+ce3CNq5DDXhHs3ZxPCIh3czAQ2QIEBWUzbbWBDQAohx3JuD2//rMOFr26/aXstuiaiOiTWB1+Yeck7Hq9dEbtipXVObc71XK6T/43Nk+zmh9EAZz7P6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331006; c=relaxed/simple;
	bh=1nIZ4wx15CoErCR6uUMXhO0XVTxo7ZzBQx9Fj7dR484=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaPRqHhBzAcrBi5axqm0+D3JpqzKpNrrp6SybD1+WOACWXKex7uAY1St4XH+Jg3R0rpf5P7oLfrWsI7We0+GUMmBSUbWDlw92SC1mY/kJHF2JlwPc2N0MVijJvChUFjeOY/nNb27tmP82i3BisasVA6kMUalkK4TqD6KZw2ZKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbkJvL4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbkJvL4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5E5C4CEF7;
	Thu, 12 Mar 2026 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773331006;
	bh=1nIZ4wx15CoErCR6uUMXhO0XVTxo7ZzBQx9Fj7dR484=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbkJvL4uKg1R1RBE/V7CP9U+Pn5+4o6VhXNCxCt6U34HPXZNmR7MzsGF5eJL1qs6y
	 tBwXdnbC8jwjVgMRXWcDm0YcBNCwJHmrjcaXrIkEfh70Vdkh18k3uKRvjbZhZUxRdO
	 PmmadHc+t8oRmU8rgWKvDoo4jDUeiepLS4TCFypI=
Date: Thu, 12 Mar 2026 16:56:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: vt/keyboard: Hoist and reuse variable in
 vt_do_kdgkb_ioctl
Message-ID: <2026031236-diminish-dugout-8283@gregkh>
References: <20260302153255.6278-2-thorsten.blum@linux.dev>
 <2026031255-rudder-amusable-1d10@gregkh>
 <6AD2F599-396F-42B5-B918-DC5A2CB7B64B@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AD2F599-396F-42B5-B918-DC5A2CB7B64B@linux.dev>

On Thu, Mar 12, 2026 at 04:30:00PM +0100, Thorsten Blum wrote:
> On 12. Mar 2026, at 15:18, Greg Kroah-Hartman wrote:
> > On Mon, Mar 02, 2026 at 04:32:52PM +0100, Thorsten Blum wrote:
> >> Hoist 'len' and use it in both cases.
> > 
> > Why?  And what is "both cases"?
> 
> To reuse 'len' in both switch cases (KDGKBSENT and KDSKBSENT) instead of
> defining 'len = sizeof(user_kdgkb->kb_string)' in KDGKBSENT and inlining
> sizeof(user_kdgkb->kb_string) in KDSKBSENT.

As the sizeof() turns into a static number, the code is a bit simpler
as-is, right?

And there's no real need to change this for the sake of changing it that
I can see.

> >> +		/*
> >> +		 * Ownership transfer: vt_kdskbsent() returns a pointer
> >> +		 * that must be freed (new buffer, old buffer, or NULL).
> >> +		 */
> >> 		kbs = vt_kdskbsent(kbs, kb_func);
> > 
> > That's fine, but what does it have to do with len?
> 
> It's unrelated to 'len' and just a drive-by change while I was at it.

Which, by default, makes this patch impossible to accept :(

thanks,

greg k-h
