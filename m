Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0043175;
	Mon, 12 Oct 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804556; cv=none; b=eP8D41fmHKDHU3k4BeEET6Oq6rwQiO+lBMHtLu4/MXLrBpVg/oQiVfaCaY7wL9CI6dv16hSayboM2hBgFjkCJeE6PrcVPBcVKvXfys009rYwS0qVYYiOufcx64Z0fZQSPT/FJJ7O2+YC5tetT9MFGFaKRzWNSH6U/ZEdNNNXJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804556; c=relaxed/simple;
	bh=ZO3/qRJ8XAW5vKBDQW47sBH25Xfi0FHJc2hFILruI1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qItNPnId/7WD2YGWfFox+xQMdAnOcnvNjIpUeexyxwDgacV4KIfV2lvvyLigylnrNOUst3p6biukDa9PiGLNGVbJrX3gaJsqVW5GUsxLax6J2+ulA0KXgRN7t9NrfZTY9zEKdk/pGHqCFCEm3QFTsnFNVYM8PFYicN+iUxrTnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWpZN6xN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWpZN6xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AC91F0089C;
	Mon, 12 Oct 2026 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791804554;
	bh=MyQJDlMEh2BzZoV7sZh4ZKAA/Oy8fdURAy82AESJ0iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dWpZN6xNbtw4XXAk4T3LT1lV+e16wresSobW9KcBU/+zqDtkLfjkD3LFDv/Vc51bJ
	 Jr3K7uThOboCkYF3+ksXx2Yov9VtPRU6kOjpUd8JDHRnbis+bZaU+R9YcUKr08c97U
	 bDAoK49kXMJYqEipWt0WSiKsFKxjEjrb8vziwnUs=
Date: Mon, 12 Oct 2026 13:29:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, deller@gmx.de,
	James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 2/2] vt: Distinguish between blanking and VESA blank mode
 in con_blank
Message-ID: <2026101255-extending-concrete-2fc7@gregkh>
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094114.38549-3-tzimmermann@suse.de>

On Mon, Oct 12, 2026 at 11:27:39AM +0200, Thomas Zimmermann wrote:
> The con_blank callback in struct consw encodes blanking and display
> blank mode in a single parameter named blank. Its semantics equal
> the FB_BLANK constants from the fbdev subsystems. Yet it is of type
> enum vesa_blank_mode, which describes VESA DPMS levels of the attached
> monitor. Although related, this is something else.
> 
> For this reason, calls to con_blank fill the blank parameter with
> values that appear non-sensical at first. For example, to blank the
> console, but keep the monitor on, vt passes VESA_VSYNC_SUSPEND (eq '1').
> This is because consoles interpret '1' as pixels-off-but-monitor-on.
> The constant VESA_VSYNC_SUSPEND actually means monitor-vsync-off. And
> the argument used for monitor-vsync-off is VESA_VSYNC_SUSPEND+1.
> 
> To fix this by splitting blank into two parameters, blank and blank_mode.
> The new blank is a boolean to control the display blanking. If cleared,
> the console creates display output, if set the console does not. The
> new parameter blank_mode specifies the VESA blank mode for the monitor
> and equals VESA DPMS levels. If blank is set, blank_mode gives a hint
> to the console, on how to set up the signal to the monitor.
> 
> The actual interpretation is up to the console. Newportcon and sticon
> only handle blank or not-blank. Fbcon and vgacon implement blank plus
> the VESA DPMS handling. The implementation of both consoles is again
> somewhat confusing because types and values do not match. Clean up
> both with the new blank/blank_mode logic.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/tty/vt/vt.c                 | 11 ++++----
>  drivers/video/console/dummycon.c    |  4 +--
>  drivers/video/console/newport_con.c |  4 +--
>  drivers/video/console/sticon.c      |  4 +--
>  drivers/video/console/vgacon.c      | 44 +++++++++++++++--------------
>  drivers/video/fbdev/core/fbcon.c    | 19 +++++++------
>  include/linux/console.h             |  9 ++++--
>  7 files changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9e7b4419b422..f762c965351d 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4671,7 +4671,7 @@ void do_blank_screen(bool entering_gfx)
>  	if (console_blanked) {
>  		if (blank_state == blank_vesa_wait) {
>  			blank_state = blank_off;
> -			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, false);
> +			vc->vc_sw->con_blank(vc, true, vesa_blank_mode, false);

I hate adding random bool to function parameters as now you need to go
look them up to try to determine exactly what happened.

Why not just 2 different callbacks:

> -static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
> +static bool vgacon_blank(struct vc_data *c, bool blank, enum vesa_blank_mode blank_mode,
>  			 bool mode_switch)
>  {
> -	switch (blank) {
> -	case VESA_NO_BLANKING:		/* Unblank */
> +	if (blank) {
> +		switch (blank_mode) {
> +		case VESA_NO_BLANKING:	/* Normal blanking */
> +			if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
> +				vga_pal_blank(&vgastate);
> +				vga_palette_blanked = true;
> +				return 0;
> +			}
> +			vgacon_set_origin(c);
> +			scr_memsetw((void *)vga_vram_base, BLANK,
> +				    c->vc_screenbuf_size);
> +			if (mode_switch)
> +				vga_is_gfx = true;
> +			return 1;
> +		default:		/* VESA blanking */
> +			if (vga_video_type == VIDEO_TYPE_VGAC) {
> +				vga_vesa_blank(&vgastate, blank_mode);
> +				vga_vesa_blanked = blank_mode;
> +			}
> +			return 0;
> +		}
> +	} else { /* Unblank */
>  		if (vga_vesa_blanked) {
>  			vga_vesa_unblank(&vgastate);
>  			vga_vesa_blanked = VESA_NO_BLANKING;
> @@ -814,24 +834,6 @@ static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
>  		vga_is_gfx = false;
>  		/* Tell console.c that it has to restore the screen itself */
>  		return 1;
> -	case VESA_VSYNC_SUSPEND:	/* Normal blanking */
> -		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
> -			vga_pal_blank(&vgastate);
> -			vga_palette_blanked = true;
> -			return 0;
> -		}
> -		vgacon_set_origin(c);
> -		scr_memsetw((void *) vga_vram_base, BLANK,
> -			    c->vc_screenbuf_size);
> -		if (mode_switch)
> -			vga_is_gfx = true;
> -		return 1;
> -	default:		/* VESA blanking */
> -		if (vga_video_type == VIDEO_TYPE_VGAC) {
> -			vga_vesa_blank(&vgastate, blank - 1);
> -			vga_vesa_blanked = blank;
> -		}
> -		return 0;
>  	}

This can be vgacon_blank() and vgacon_unblank(), right?  That way we
have a hint as to what is happening and don't have to try to remember
that a bool as parameter 2 is blank/unblank.

thanks,

greg k-h
