Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E552D23A6
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261290; cv=none; b=tYTF1C54Dz0lrFATSZ68LuwOqHzTmrcQ+hEqwGKD+H30r7kD0icoypvfG0JfFJb1LWsGDQuy40bZgLkY0hcdAsQ+7aSToVYhMiT6khtF+bjg93+joqUJ2gI3iSEeW/MMU0kilBMHtrAGU4JGXqlYiDqVIpFJfg5l4sgtegQFzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261290; c=relaxed/simple;
	bh=MFnA0HVS04xJQTa/xvZgCrUb3vCVJC4U3BZpZ+TL+Og=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=RhMP2Fu0Nu+S21SPtRFEqMLqD2/QC/8x5gHC7YiKCcieKOKI0Fr9ptybalrfp63rJDLKjb4BVmOiBcIib3foWqTt4iXFNqnM5Nm1l8Sdx7A6WzrEkKJ+N7AMP45wIXvmjphdzmVlfNug2VkWTMw0/ZpHSeMJOe5X0l+kIvKGc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 81118 invoked by uid 3782); 1 Sep 2026 13:14:45 +0200
Received: from muc.de (p4fe15c70.dip0.t-ipconnect.de [79.225.92.112]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Tue, 01 Sep 2026 13:14:44 +0200
Received: (qmail 6890 invoked by uid 1000); 1 Sep 2026 11:14:43 -0000
Date: Tue, 1 Sep 2026 11:14:43 +0000
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
Message-ID: <apazo2RIHiEAtpNN@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box>
 <2026082938-spray-shimmer-9389@gregkh>
 <apLvO-8YJmQG7T0Z@MAC.fritz.box>
 <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
 <apWTg6mNZrdBm2-D@MAC.fritz.box>
 <ae1ae01a-677e-4c51-bf9a-ebe7b2e91e4f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1ae01a-677e-4c51-bf9a-ebe7b2e91e4f@gmx.de>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

On Mon, Aug 31, 2026 at 19:21:30 +0200, Helge Deller wrote:
> On 8/31/26 16:45, Alan Mackenzie wrote:
> > On Mon, Aug 31, 2026 at 08:20:10 +0200, Thomas Zimmermann wrote:
> >> Am 29.08.26 um 16:39 schrieb Alan Mackenzie:

[ .... ]

> > I've been using the console for around 28 years, now.  I don't recall it
> > crashing at all.  My current font and keyboard files are in exactly the
> > same form as they were 28 years ago.  These formats are stable and
> > dependable.

> >> I've spend the last years working on related code (fbcon) and it
> >> mostly feels dated and unmaintained. Our prime implementation (again
> >> fbcon) has been de-facto unmaintained for years.  We recently had
> >> contributors who are pushing the ioctls semantics and found bugs in
> >> fbcon for a number of corner cases.

[ .... ]

> >> FTR I'm not at all interested in eliminating the kernel's console.

> > Other people, in particular Greg KH, have said this is the current aim.
> > I'm worried for myself.  It is far from clear that there is a suitable
> > replacement for the kernel's console, and its elimination could easily
> > happen without that replacement.  I suppose I could always (laboriously)
> > maintain the console for myself personally.  Or there's always the BSDs.
> > I just don't know what I'd do.

> Alan, I really appreciate your efforts to enhance the kernel console code!
> And I'm not interested to eliminate the kernel console either.

> >> But there are must-have features and nice-to-have features. IMHO for
> >> the kernel console i18n really belongs in the later category.

> > It's 2026, four decades after VGA was the latest thing, and Unicode
> > support is merely a nice-to-have?

> No. IMHO Unicode support would be great.

Thank you, indeed!  That's cheering to hear.

> Thanks!
> Helge

-- 
Alan Mackenzie (Nuremberg, Germany).
