Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984F3C1D4D;
	Wed, 23 Sep 2026 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168253; cv=none; b=hi97yyabhSyV/ZKEOn5Tb/ThqxMKQZhq4dDzUb8sdVXdtbZYK9ZbWq79mPl4IsLB3s+5ttsplIxcz1vf0kNHOldKPJF246V+DipqfVKGzUMlXG5tuOdQUCOSSGnnrb4Z9UzYG1JJ69DQB+WtN0QWhf3kgL/Oe/fvxjz4eTkhalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168253; c=relaxed/simple;
	bh=vR3xnfQd/7uN9WZbT0SYHUvcczvUYHS5b7eJeX2Wm6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkyIv6FOlUsUSu/vXFtgOiQS8JM/NxDq+huE9SmioD0lfAaDhsA5ZpjShveSvMCfdZE3WDvdwK0MyAw2PDoi7PLtDvKcJ9zMszLxfDFlU5ULZVp5K26ZncymzBvONKGF/8y1Zdcz+OQkLmToNA0DKXidmjmWoqaVRRHX8gjuieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2aCZeGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2aCZeGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314F91F000FF;
	Wed, 23 Sep 2026 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790168251;
	bh=XLTp0wewpuY118fys5W1b0y8r0H8Q0XPdv/ybcdCmY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R2aCZeGOoimhy9ZsjHPyt7Tpj+VMRwM/K3DC6CHB4j/Gs+JUUEn87XvT95QYtpf3M
	 rZrnwM/DXu/9MMSTjWJIVD7qgO71fbB+5Lym+nUxL3QGJfJsJJ6vXiuEVXo7gtAX8x
	 1CpDdnq9Zv3XetVJM+tgJDKWIIgsTknGhuK1DDxA=
Date: Wed, 23 Sep 2026 14:57:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 1/5] vt: Add cursor-size helpers
Message-ID: <2026092347-try-railroad-7b00@gregkh>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915123304.1027277-2-tzimmermann@suse.de>

On Tue, Sep 15, 2026 at 02:29:12PM +0200, Thomas Zimmermann wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware
> 
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
> 
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. The new helper fall back to cur_default and
> then underline cursors; in this order.
> 
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/tty/vt/vt.c            | 93 ++++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h |  7 +++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf37495a8..5d2583cd6e79 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -71,6 +71,7 @@
>   * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
>   */
>  
> +#include <linux/compiler.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/sched/signal.h>
> @@ -264,6 +265,98 @@ unsigned int vc_font_size(const struct vc_font *font)
>  }
>  EXPORT_SYMBOL_GPL(vc_font_size);
>  
> +/*
> + * Cursors
> + */
> +
> +/**
> + * vc_cursor_start - Calculates the cursor's first scanline within a character cell
> + * @cell_height: The overall height of the character cell
> + * @cursor_size: The size constant of cursor pattern
> + *
> + * The parameter @cell_height is the height of the character cell as
> + * displayed by the console. The argument given in @cursor_size is one
> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
> + * For unknown values, the helper draws the default cursor or an underline
> + * dash.
> + *
> + * Returns:
> + * The index of the cursor's first scanline within the character cell
> + */
> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
> +{
> +	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
> +
> +retry:
> +	switch (cursor_size) {
> +	case CUR_NONE:
> +		return cell_height;
> +	case CUR_UNDERLINE:
> +		if (cell_height < 10)
> +			return cell_height - 1;
> +		else
> +			return cell_height - 3;
> +	case CUR_LOWER_THIRD:
> +		return cell_height - cell_height / 3;
> +	case CUR_LOWER_HALF:
> +		return cell_height - cell_height / 2;
> +	case CUR_TWO_THIRDS:
> +		return cell_height - (cell_height * 2) / 3;
> +	case CUR_BLOCK:
> +		return 0;
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);

Can userspace trigger this?  If not, who can?

> +		if (cursor_size != cursor_default_size)
> +			cursor_size = cursor_default_size;
> +		else
> +			cursor_size = CUR_UNDERLINE;

Why underline as a default?

thanks,

greg k-h
