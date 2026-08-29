Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5823394A
	for <linux-serial@vger.kernel.org>; Sat, 29 Aug 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788010445; cv=none; b=WEQQL+2Krkjr57BmgU+PIQx+rJGy2twLKvfd+IPz4kDxxJnwUPfwuR0tKbEOm2gorqF/GKv1n8bSdHr/1qwbv29C7JFN+V44LSQLL+nmoJkSGtpQD6nGmcZpBhl8+d3K1bxazDotNtUYSG0taq/5rlO6TnbULN1IaEYxeyG9DYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788010445; c=relaxed/simple;
	bh=zLNmLkYC2mNWrkptxq6WVDe0r3Meoeeu7Y9ulURv8EU=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=rdtdbr2YLJ1jehS8AeXfUEyswejWo1r85zUn4YGHHKz6f09gt7FYoonXjueMg+3rFMnRVDox8+bucB3RvHunjYDBwCyi6k3pyIA2EdFtGshtOOxWbZqB1Id4W/4rnyNEf0EoKBXfTVjwAZ1/udrBJShmX5sXXdZ+G4At+rj1hhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 94739 invoked by uid 3782); 29 Aug 2026 15:34:01 +0200
Received: from muc.de (p4fe15d93.dip0.t-ipconnect.de [79.225.93.147]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sat, 29 Aug 2026 15:34:00 +0200
Received: (qmail 56993 invoked by uid 1000); 29 Aug 2026 13:33:59 -0000
Date: Sat, 29 Aug 2026 13:33:59 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Message-ID: <apLfx9oqYaa36oyn@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCGKUotSUZLvngV@MAC.fritz.box>
 <2026082934-irrigate-tastiness-c4ff@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082934-irrigate-tastiness-c4ff@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

On Sat, Aug 29, 2026 at 14:11:00 +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 27, 2026 at 06:47:05PM +0000, Alan Mackenzie wrote:

> > vt: 32b glyph: 3. replace scr_readw/writew by scr_readg/writeg, etc.

> I don't understand these lines in your patches, where are they from and
> what are they for?

scr_readg and scr_writeg read and write an entire glyph, regardless of
whether that glyph is 16-bit or 32-bit.  The latter is determined by the
setting of CONFIG_FB_GLYPH_21BIT.

This is the main complication in these patches; having to cope with both
sizes of glyph, for backward compatibility, rather than just switching
to 32-bit glyphs.

> thanks,

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
