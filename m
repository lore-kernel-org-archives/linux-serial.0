Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7EF42A96;
	Fri, 25 Apr 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591397; cv=none; b=RRGvKHlN3QmVK/sxTvqz//iMPh5dw79eruRJyGUEoF3aNRPPyOiQCmkOlI/9XVxS+JnwugLmuJORwCxNLNmAZ/TOqZWUVfU/4ZWeOUqdqng9YpXkX9cSGDaAsP+kMfRRCQNWcQJE7Jd67n2ZYzse3GkHfTh25/uFtNsPWkmZhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591397; c=relaxed/simple;
	bh=+XqOAPew5a1b5gfu8o+UlqkLvmOLpEvfcxPMD/2pIHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeHv67bZrUDs9np1ayVTOa41Xn0e+1JQIuf2fi+aNIO5TeX8a/PRBFqBqQ3WqwlmbFoWBpJO0q73GGIrPb+Zx/lsNVfZHqGDXBU1qGelW6dAye8T9ndVjZCDLsi5puEXIvZzDAuaJ6uHtDrk6Vrzr8fdnvaCYoOZPsJtHlgFUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbS5112T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbS5112T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976CCC4CEE4;
	Fri, 25 Apr 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745591396;
	bh=+XqOAPew5a1b5gfu8o+UlqkLvmOLpEvfcxPMD/2pIHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbS5112ToWDXcpzzgUQG25+mP6+L6Ns+1G48SI3CcZ5QpiPgsq0jgTeAUYRiKfigT
	 BFMqLZBPAC8JrAAt3tJLj+ZJ4Sjfene6T3qBmg3thahovInns0tFALqLnCJ+1JR4iL
	 0XiaaGhzoQ1lY2GNCFAyxgjDXFZsvks6KiWoYdSw=
Date: Fri, 25 Apr 2025 16:29:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] vt: implement proper Unicode handling
Message-ID: <2025042517-defacing-lushly-10d5@gregkh>
References: <20250417184849.475581-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417184849.475581-1-nico@fluxnic.net>

On Thu, Apr 17, 2025 at 02:45:02PM -0400, Nicolas Pitre wrote:
> The Linux VT console has many problems with regards to proper Unicode
> handling:
> 
> - All new double-width Unicode code points which have been introduced since
>   Unicode 5.0 are not recognized as such (we're at Unicode 16.0 now).
> 
> - Zero-width code points are not recognized at all. If you try to edit files
>   containing a lot of emojis, you will see the rendering issues. When there
>   are a lot of zero-width characters (like "variation selectors"), long
>   lines get wrapped, but any Unicode-aware editor thinks that the content
>   was rendered properly and its rendering logic starts to work in very bad
>   ways. Combine this with tmux or screen, and there is a huge mess going on
>   in the terminal.
> 
> - Also, text which uses combining diacritics has the same effect as text
>   with zero-width characters as programs expect the characters to take fewer
>   columns than what they actually do.
> 
> Some may argue that the Linux VT console is unmaintained and/or not used
> much any longer and that one should consider a user space terminal
> alternative instead. But every such alternative that is not less maintained
> than the Linux VT console does require a full heavy graphical environment
> and that is the exact antithesis of what the Linux console is meant to be.
> 
> Furthermore, there is a significant Linux console user base represented by
> blind users (which I'm a member of) for whom the alternatives are way more
> cumbersome to use reducing our productivity. So it has to stay and
> be maintained to the best of our abilities.
> 
> That being said...
> 
> This patch series is about fixing all the above issues. This is accomplished
> with some Python scripts leveraging Python's unicodedata module to generate
> C code with lookup tables that is suitable for the kernel. In summary:
> 
> - The double-width code point table is updated to the latest Unicode version
>   and the table itself is optimized to reduce its size.
> 
> - A zero-width code point table is created and the console code is modified
>   to properly use it.
> 
> - A table with base character + combining mark pairs is created to convert
>   them into their precomposed equivalents when they're encountered.
>   By default the generated table contains most commonly used Latin, Greek,
>   and Cyrillic recomposition pairs only, but one can execute the provided
>   script with the --full argument to create a table that covers all
>   possibilities. Combining marks that are not listed in the table are simply
>   treated like zero-width code points and properly ignored.
> 
> - All those tables plus related lookup code require about 3500 additional
>   bytes of text which is not very significant these days. Yet, one
>   can still set CONFIG_CONSOLE_TRANSLATIONS=n to configure this all out
>   if need be.
> 
> Note: The generated C code makes scripts/checkpatch.pl complain about
>       "... exceeds 100 columns" because the inserted comments with code
>       point names, well, make some inlines exceed 100 columns. Please make
>       an exception for those files and disregard those warnings. When
>       checkpatch.pl is used on those files directly with -f then it doesn't
>       complain.
> 
> This series was tested on top of v6.15-rc2.

I've taken the first version of this, should I revert all of them and
then apply these, or do you want to send a diff between this and what is
in the tty-next tree?

thanks,

greg k-h
