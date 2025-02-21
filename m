Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245B1D6DB9
	for <linux-serial@vger.kernel.org>; Fri, 21 Feb 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152607; cv=none; b=H0slUu5gfDMyzsTeTthiIbLzhFlm/aVE1RP508h7Dn+w2VFymcPRw9c7ZgJfSl19jWnYq2PcPeLk7KCX8m0Y7u9qg92QIt0dl+I/GR9+cubCFUXoYAQv5x8s8M/+ng1szYAsYuUX6maQn/OhLDbiIXsCNRdBHXhuHh/XO8EVUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152607; c=relaxed/simple;
	bh=v9xyPB/meOZ45ufUSYgKAbTdXembKjykwzoD6Xf4SBk=;
	h=Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From; b=QsZjba6l3gAZmvp2ee1aA654f4FRBHWnfF4Sr1j1uIM8dZ5EQJe3kCF5OMInc7d5Qm2nHdT9Q+hOUz5QLhYzFjCdOzVt8sFwDPvcfdysaQuiefuUv/bc/rNJIu/Lo+PIi3efgzfKyVAsYo4fLpcT9sf6WjQtGJUaskGjDakL6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 45572 invoked by uid 3782); 21 Feb 2025 16:36:00 +0100
Received: from muc.de (pd953a28a.dip0.t-ipconnect.de [217.83.162.138]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Fri, 21 Feb 2025 16:36:00 +0100
Received: (qmail 22279 invoked by uid 1000); 21 Feb 2025 15:35:59 -0000
Date: Fri, 21 Feb 2025 15:35:59 +0000
To: Jiri Slaby <jirislaby@kernel.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: More than 256/512 glyphs on the Liinux console
Message-ID: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de


Dear Linux Maintainers,

The Linux console is currently restricted to 256/512 glyphs, the VGA
standard from the 1980s.  I would like that restriction to be lifted, and
believe that many other console users would agree.

I have a proof-of-concept/works-for-me implementation which does just
this.  With a test font of 810 glyphs, my console can display many (?all)
Latin character variants, and also Greek and Cyrillic characters,
together with others.

The strategy of my implementation is to use 32 bits for each character
cell in the video buffer rather than VGA's 16.  The coding of the
foreground and background colours remains unchanged in 8 bits, and the
glyph number takes up the remaining 24 bits.  This is sufficient to hold
a complete Unicode font (if such existed).  So, for example, a white '!'
on a black background (glyph 33), currently coded as 0x0721, becomes
0x07000021.  drivers/tty/vt/consolemap.c has been enhanced to handle the
full Unicode range.  Full width characters and right-to-left scripts
remain unhandled.

The code, although "fully working", is still at an early stage of
development.  It does not yet conform with Linux standards - for example,
there are too many #ifdefs in the .c files, and there's "clever" code
which needs replacing.  It also hasn't been built for or tested on
anything but my amd64 machine.

The main source files which have been changed are:
      drivers/tty/vt/consolemap.c
      drivers/tty/vt/selection.c
      drivers/tty/vt/vc_screen.c
      drivers/tty/vt/vt.c
      drivers/tty/vt/vt_ioctl.c

      drivers/video/fbdev/Kconfig
      drivers/video/fbdev/core/bitblit.c
      drivers/video/fbdev/core/fbcon.c
      drivers/video/fbdev/core/fbcon.h
      
      include/linux/console_struct.h
      include/linux/consolemap.h
      include/linux/selection.h
      include/linux/vt_buffer.h
      include/linux/vt_kern.h
      include/uapi/linux/kd.h

, with minor amendments to:

      drivers/accessibility/Kconfig
      drivers/accessibility/speakup/Kconfig
      drivers/video/console/vgacon.c

..

The patch for this change is necessarily large, currently around 3,500
lines - there are very many places in the current console code that hard
code the size of a video buffer character as 2.  Each one of these needed
to be replaced by a variable whose value is either 2 or 4 or similar.
Macros like scr_writew have been replaced by scr_writeg (g for "glyph")
which, depending on the configuration, writes either 2 or 4 bytes to the
video buffer.  And so on.

The patch is currently based on

commit 50782d9796dc3fc65d1e1b1a90e8887de3338baf (origin/linux-6.13.y, linux-6.13.y)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu Feb 13 15:24:29 2025 +0100

    Linux 6.13.3-rc1

, though I could easily rebase it (again!) onto a different base.

To use 24-bit glyphs, the new setting CONFIG_FB_GLYPH_24BIT needs to be
enabled, and also the new kernel parameter fbcon=glyph-24bit set.  It is
intended that the old VGA standard will continue to work unchanged.
However it is not currently possible to have 24-bit and 8/9-bit consoles
running on a machine at the same time.  Currently FB_GLYPH_24BIT is
restricted to the EFI framebuffer, though this might well not be
necessary.

With >256/512 glyph fonts, the standard program setfont works unchanged.
showconsolefont doesn't work satisfactorally at the moment and would need
amendment (it has a hard coded limit of 512 glyphs).

I would very much like further to develop and to refine this code to the
point where it is suitable for inclusion in the mainline kernel.  What do
you say?

--
Alan Mackenzie (Nuremberg, Germany).
