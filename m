Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239C3EBF18;
	Thu,  1 Oct 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845190; cv=none; b=V5x2Hc9xkIgy2Kn/1KeR6qC7DRNoP32OF+8zO92Cwndg9Q5ywErgOeCsdr1/zREn5jyHnmlXw2j8t17EUZZ/qEq8P6rv2kGuVkrhOle1030etjakB3uBHa8VUbfEoVhfng+mNsW+9gOfWvQesktfdpw9ljlL2wxLFdMUVJevWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845190; c=relaxed/simple;
	bh=/n+HpAFyL5opcXfvNs5inPIWYnLZEZ2JOWwSwyIxluo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9BSAAD8HpTZpY52VdpL9so8/xiMnUUDnL60lPb9GHDMpbMj2Ddz5IhDq/oYBKPvDiVvbKA3yyJbLqxYjw/QROh4XjVuMgc14JQWquIl94MLcdPbohmbPtTLwo/Pxfy0X/wZ7dTDL9ooQZuVWzz8tN2RetUHWmnVWEEcuQ3qGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gl5pnPY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gl5pnPY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAB41F000FF;
	Thu,  1 Oct 2026 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790845189;
	bh=Qg3Weja5Q3oGkvaEMHZcYe3F1qNOpQXxAR+re6VwDN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gl5pnPY+TWiY33etkY/VLoSqJeVD9QLK0rsqIaNNfIAimk3hMzn9h76h8D1uWGR7o
	 BY04wSAeIwXRDh2vbBdvHd8XgWI9TbS8KiGhjF86utpbCQU6Au3x8vva3DV7M8iE2c
	 to1hZK/Ch63Zr+LGAfxBRkCQ0ahopfB7pjd+856g=
Date: Thu, 1 Oct 2026 10:59:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
Message-ID: <2026100134-handwork-detoxify-6888@gregkh>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928085724.41660-2-tzimmermann@suse.de>

On Mon, Sep 28, 2026 at 10:55:24AM +0200, Thomas Zimmermann wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware.
> 
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
> 
> Users control the cursor size with the vt module's parameter cur_default
> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
> case of an invalid setting, the new helpers fall back to cur_default and
> then underline cursors; in this order.
> 
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. VGA BIOSes also tend to use underline by.
> default. Upon initialization vt applies its default to the console, but
> each console might fall back to it own default. For example, running the
> ESC code from above with the invalid constant of 8 magically flips the
> cursor from underline to block size on vgacon. Another call with N set
> to 0 (i.e., default) magically flips it back to underlyine. Making
> underline the new default everywhere harmonizes vt, fbcon and most VGA
> BIOSes.
> 
> v3:
> - mention user interfaces to control cursor size in commit message (GregKH)
> - elaborate defaults (GregKH)
> - move retry logic into helper
> - handle CUR_DEF
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/tty/vt/vt.c            | 104 +++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h |   7 +++
>  2 files changed, 111 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
