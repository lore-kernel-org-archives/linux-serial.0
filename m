Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98D2E764D;
	Sat, 29 Aug 2026 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005495; cv=none; b=po48DEwn1LKJVLhbRLg/N6w7YHd33W1z6tHbFkIKI0g8SeO8vkTrm43U+eUzKrpX2sz1YynRn8f1EYuSXK3Gytg1Ijx5D6TNcjtlXZgLRlizYaozyy9scBqPAPG+9VTJJDpJ2K+IpS45OOlvPizRn/9xlKJRmz2JM4cAlgM4ZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005495; c=relaxed/simple;
	bh=1Fv/jaZbPeOzJ0qNPf4zNwe2Sdhf7bhz5cI9yDu6sYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbwNmkCfugqwodl6CUE6P8lOEzJsG1tHEywzZ8DoRr6NPbjDgxT4HiDiYM2IBrj8NMg0uBBQapcw1WrzdPGRcFznjaeViSzSesSrm+QJFASLuKmIHiNAndlgXTRbbqnkGRVVVckqiEqwiUqVfl/0AsKzO1TCG0KVjTjI0SNoOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijuDMIuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijuDMIuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C291F000E9;
	Sat, 29 Aug 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788005494;
	bh=0Tt5gJS6O2/070flTphppfsHkp6LZHfoc+wM5q91AzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ijuDMIuW+wTB0Za2IYMWpWFLXat5G2MTemTok1i0dO29z2iQVHHrVpljrxidl8hP4
	 YkVoAdnK3QlofJqIm5wA5CInKcg8u+StZfqQvZBJ9aMXGGl1kuS4PV5SMy2qKnzJRE
	 TBG8l6Tifcp/AebWwiu+su+8x6mm7xnG+yN/YNOo=
Date: Sat, 29 Aug 2026 14:09:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <2026082938-spray-shimmer-9389@gregkh>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGc4y8ApYWh4Yr4@MAC.fritz.box>

On Fri, Aug 28, 2026 at 02:36:19PM +0000, Alan Mackenzie wrote:
> On Fri, Aug 28, 2026 at 08:12:16 +0200, Thomas Zimmermann wrote:
> > Hi
> 
> > Am 27.08.26 um 20:38 schrieb Alan Mackenzie:
> > > vt: Enlarge the framebuffer glyph size from 16 to 32 bits.
> 
> > > This allows:
> > >    o - More than 256/512 distinct half-width glyphs (in fact, up to 2^21).
> > >    o - Unicode code points >0xffff (outside the Basic Multilingual Plane).
> > >    o - Coloured glyphs (as before).
> 
> > But what is the use case here? We have excellent support for text and 
> > font rendering in graphical userspace for I18N and L10N.
> 
> GUIs are sub-optimal for pure text work.  A full screen terminal is
> wanted.  The current preeminent user space terminal, kmscon, appears to
> lack the refinements of many decades development of the kernel's
> console.

What is missing from kmscon that the kernel currently supports?  Why not
just make it feature-equal there, and then make these additional changes
there as well?

As others have said, we don't want to add new features to the in-kernel
console mode due to all of the reasons the patch review has shown on
this series already (i.e. complex interactions that end up making the
system broken.)  This is best all done in userspace, where a bug there
will not cause these same problems, right?

> Support for blind users exists in the kernel's console.  I don't know
> how good it is, as I don't (yet) need to use it.

But others use it, so we can't break that, and the fact that you ignored
those codepaths here makes me very worried.

> > In contrast, the kernel's text-mode support is limited and a hotbed for 
> > bugs. IMHO we shouldn't add features, but try to simplify that code base.
> 
> >From a user's point of view, the kernel's console is rock solid and
> dependable; it doesn't crash, and its interfaces don't suddenly change
> with the latest release of KDE or Gnome or whatever.

This has nothing to do with KDE or Gnome, if you have issues with those
projects, please take it up with them and contribute to them to resolve
those issues.  I know they can always use the help.

> As is clear, I think the console's limitations should be eliminated.

And the rest of us feel the kernel console's code should be eliminated
entirely, when ever possible :)

thanks,

greg k-h
