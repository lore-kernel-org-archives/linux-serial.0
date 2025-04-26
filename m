Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E13594E;
	Sat, 26 Apr 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745659460; cv=none; b=VTcb6rF269NqsucMWH92mj7ff7QltRNfET8m6AR4X7UTmht68aPjiUKZFPBZbWIvG0YECkBFXLvzDpAroIH9Af3xE7ZfPsACSkbnJtCIpTxVeCHXY+ZYp0FuQDILyDC7kIUL7ZywJ6PLdKd1vFobj+ByUOOOLgScdxK6K1Lsw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745659460; c=relaxed/simple;
	bh=3HU1llpcqAH9jf1dYiuQkto3Ic+P7zmEPkPzWsUsNQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga0zI+JtfJ8VtDlKKFuWt5XkuA/u956oMXi3lEjJzPXe4dVHQu3XtF3EgY8g0MILIi4ddCvoLlQFkuN/TZE/R7TN0RQHtCIxZGj2mo/sBIsvcpPM3ZdZ2LroWYMjdbGeNWzB8VHxPtAW1Isouhvq1G6Bs9BB/R9c1iXyGBB2FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UeACbn+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UeACbn+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F44C4CEE2;
	Sat, 26 Apr 2025 09:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745659459;
	bh=3HU1llpcqAH9jf1dYiuQkto3Ic+P7zmEPkPzWsUsNQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeACbn+PcZfg+BhOKoasZijSgsRiiCZKL+ZukPX8tiUGPxBq78RDB87bD0fjxW/m5
	 gEAmPRed/W3X6k5Vma18OHSjEHE12n6CTwGsxchKzziZLuAjLRFpyLydV1espN0euV
	 /NwcWknM/c2Ajqmy+Iq1cTrWA+esiGqaUt+xEFss=
Date: Sat, 26 Apr 2025 11:24:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] vt: implement proper Unicode handling
Message-ID: <2025042609-diagnoses-whinny-36b1@gregkh>
References: <2025042517-defacing-lushly-10d5@gregkh>
 <2EDC209B-7D6B-4EFB-ADD0-58D494D8AF98@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2EDC209B-7D6B-4EFB-ADD0-58D494D8AF98@fluxnic.net>

On Fri, Apr 25, 2025 at 11:13:40AM -0500, Nicolas Pitre wrote:
> 
> 
> > Le 25 avr. 2025 à 09:29, Greg Kroah-Hartman <gregkh@linuxfoundation.org> a écrit :
> > 
> > ﻿On Thu, Apr 17, 2025 at 02:45:02PM -0400, Nicolas Pitre wrote:
> >> The Linux VT console has many problems with regards to proper Unicode
> >> handling:
> >> 
> >> - All new double-width Unicode code points which have been introduced since
> >>  Unicode 5.0 are not recognized as such (we're at Unicode 16.0 now).
> >> 
> >> - Zero-width code points are not recognized at all. If you try to edit files
> >>  containing a lot of emojis, you will see the rendering issues. When there
> >>  are a lot of zero-width characters (like "variation selectors"), long
> >>  lines get wrapped, but any Unicode-aware editor thinks that the content
> >>  was rendered properly and its rendering logic starts to work in very bad
> >>  ways. Combine this with tmux or screen, and there is a huge mess going on
> >>  in the terminal.
> >> 
> >> - Also, text which uses combining diacritics has the same effect as text
> >>  with zero-width characters as programs expect the characters to take fewer
> >>  columns than what they actually do.
> >> 
> >> Some may argue that the Linux VT console is unmaintained and/or not used
> >> much any longer and that one should consider a user space terminal
> >> alternative instead. But every such alternative that is not less maintained
> >> than the Linux VT console does require a full heavy graphical environment
> >> and that is the exact antithesis of what the Linux console is meant to be.
> >> 
> >> Furthermore, there is a significant Linux console user base represented by
> >> blind users (which I'm a member of) for whom the alternatives are way more
> >> cumbersome to use reducing our productivity. So it has to stay and
> >> be maintained to the best of our abilities.
> >> 
> >> That being said...
> >> 
> >> This patch series is about fixing all the above issues. This is accomplished
> >> with some Python scripts leveraging Python's unicodedata module to generate
> >> C code with lookup tables that is suitable for the kernel. In summary:
> >> 
> >> - The double-width code point table is updated to the latest Unicode version
> >>  and the table itself is optimized to reduce its size.
> >> 
> >> - A zero-width code point table is created and the console code is modified
> >>  to properly use it.
> >> 
> >> - A table with base character + combining mark pairs is created to convert
> >>  them into their precomposed equivalents when they're encountered.
> >>  By default the generated table contains most commonly used Latin, Greek,
> >>  and Cyrillic recomposition pairs only, but one can execute the provided
> >>  script with the --full argument to create a table that covers all
> >>  possibilities. Combining marks that are not listed in the table are simply
> >>  treated like zero-width code points and properly ignored.
> >> 
> >> - All those tables plus related lookup code require about 3500 additional
> >>  bytes of text which is not very significant these days. Yet, one
> >>  can still set CONFIG_CONSOLE_TRANSLATIONS=n to configure this all out
> >>  if need be.
> >> 
> >> Note: The generated C code makes scripts/checkpatch.pl complain about
> >>      "... exceeds 100 columns" because the inserted comments with code
> >>      point names, well, make some inlines exceed 100 columns. Please make
> >>      an exception for those files and disregard those warnings. When
> >>      checkpatch.pl is used on those files directly with -f then it doesn't
> >>      complain.
> >> 
> >> This series was tested on top of v6.15-rc2.
> > 
> > I've taken the first version of this, should I revert all of them and
> > then apply these, or do you want to send a diff between this and what is
> > in the tty-next tree?
> Please remove what you have and replace with this v3. Will be much cleaner this way. 

Ok, just did that, thanks.

greg k-h
