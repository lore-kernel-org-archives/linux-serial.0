Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284F459AF9
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927786; cv=none; b=U0KOZETFgDfS3Ks97hdBkQ/cSwwv3UdPublJBq/D0e7BcXt09EkMFzAxj1BsPh9/ATSKXuGCs15l/GX2zB+jbRO84y6Y448amqw2rllYnN4fV0LOXqlhUT+kqATfhBgme+L+jBKF+/zP9+DfT8LvSVy9h+ewJVXqpq2GIUyud1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927786; c=relaxed/simple;
	bh=N2V8KQTGlX096rvdd/LfY/jDN1y2I+ovk0caLWjyuD4=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=kM3himjuYVD0ey8sHiIob5UjexkSMZ73bDQ4T0i7+JBltWi1O5wFAtueRQ0VKAwzq+/cn1fK+71nikthx4IXryQTHnnpA9hV6e45G7GoTg3g4Nk50VwM+xsr+JzxyjU5VrHyJF0qMa36yeNSHJSlQ0pD2bOg8wt6XRCIizouhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 81478 invoked by uid 3782); 28 Aug 2026 16:36:21 +0200
Received: from muc.de (p4fe15a47.dip0.t-ipconnect.de [79.225.90.71]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Fri, 28 Aug 2026 16:36:20 +0200
Received: (qmail 56479 invoked by uid 1000); 28 Aug 2026 14:36:19 -0000
Date: Fri, 28 Aug 2026 14:36:19 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
  dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apGc4y8ApYWh4Yr4@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

On Fri, Aug 28, 2026 at 08:12:16 +0200, Thomas Zimmermann wrote:
> Hi

> Am 27.08.26 um 20:38 schrieb Alan Mackenzie:
> > vt: Enlarge the framebuffer glyph size from 16 to 32 bits.

> > This allows:
> >    o - More than 256/512 distinct half-width glyphs (in fact, up to 2^21).
> >    o - Unicode code points >0xffff (outside the Basic Multilingual Plane).
> >    o - Coloured glyphs (as before).

> But what is the use case here? We have excellent support for text and 
> font rendering in graphical userspace for I18N and L10N.

GUIs are sub-optimal for pure text work.  A full screen terminal is
wanted.  The current preeminent user space terminal, kmscon, appears to
lack the refinements of many decades development of the kernel's
console.

Support for blind users exists in the kernel's console.  I don't know
how good it is, as I don't (yet) need to use it.

> In contrast, the kernel's text-mode support is limited and a hotbed for 
> bugs. IMHO we shouldn't add features, but try to simplify that code base.

From a user's point of view, the kernel's console is rock solid and
dependable; it doesn't crash, and its interfaces don't suddenly change
with the latest release of KDE or Gnome or whatever.

As is clear, I think the console's limitations should be eliminated.

> Best regards
> Thomas

-- 
Alan Mackenzie (Nuremberg, Germany).
