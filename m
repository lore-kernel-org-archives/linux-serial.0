Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534442E427;
	Mon, 12 Oct 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804606; cv=none; b=UcSPvgncAWOejvsZY+KHFuNG+Us8mjMpqQRX9KjCH58CK4IdQZysu4IKimghWAiyTutYjAJWS2rFetuqjlSVItZ33+OypDWwEQWCZZEagtZX2mfIWZl+RhJqJiF/CoaHVOoqmPEKLCl7uaAdi+lhzwaZV6FU48/Kzv5Qt3V/3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804606; c=relaxed/simple;
	bh=GMqYlcJY6KWHhvK0yxIbeQ8q4+4YftLk0/DJhsXoctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnaxxdcsv2gY6/sJJwYu/Dv9UECCvr87PPWFIIAFXM3ccM+FQF3JPzvFK6SRZoZ6i3f9yfCwK/lbVHQBvp9OlPaXhtWgLS1UOFOAYbMv8grVTTQdyq5kktNNkiTFMwAbhfzIMDX667bMsbOe5dHQt3q91U6/bZ0PQMylhx0pP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NiawYKdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NiawYKdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4820A1F0089B;
	Mon, 12 Oct 2026 11:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791804604;
	bh=nOqouu4CbKUeQwH6hz9o5ZUpBHBT6LEPFamMHiuCaf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NiawYKdRWc387+CU0fgS3egwsmKOha1tG1rxr/WgpUImm7/C8BX2ePMX6T2KSVVbE
	 YyivYh7PIgh3yMekv+3WjiToxpqzGGKVBO08wfM80upHkwxSELLnAbVt0B05gWNZtD
	 55dP5VFSSjtUL2/WbV+wAfo9UK+nsv+TsH12JzkA=
Date: Mon, 12 Oct 2026 13:30:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, deller@gmx.de,
	James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/2] vt: Use boolean as parameter to do_blank_screen()
 and do_unblank_screen()
Message-ID: <2026101228-unfreeze-drearily-670f@gregkh>
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094114.38549-2-tzimmermann@suse.de>

On Mon, Oct 12, 2026 at 11:27:38AM +0200, Thomas Zimmermann wrote:
> The parameters to do_blank_screen() and do_unblank_screen() signal
> whether the call is part of a switch between text and graphics mode.
> Convert to boolean. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/tty/vt/vt.c              | 20 ++++++++++----------
>  drivers/tty/vt/vt_ioctl.c        | 12 ++++++------
>  drivers/video/fbdev/core/fbcon.c |  4 ++--
>  include/linux/vt_kern.h          |  5 +++--
>  4 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf37495a8..9e7b4419b422 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3374,7 +3374,7 @@ static void console_callback(struct work_struct *ignored)
>  		scrollback_delta = 0;
>  	}
>  	if (blank_timer_expired) {
> -		do_blank_screen(0);
> +		do_blank_screen(false);

Same type of comment here, this bool doesn't really tell what is
happening at all (not your fault, 0/1 doesn't either.)

I'm all for this patch but shouldn't this be fixed up to be 2 different
named functions entirely?

thanks,

greg k-h
