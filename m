Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6941A6823;
	Sat, 21 Mar 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774074777; cv=none; b=W2TEARJYuPOX7XTBq0WEuMkVNBIwqHzRcAxcC3ODlncsTyOSuWF9/De8QkmHwQu+X25rd9NTRTDEnu4XhpgcCmBsk+OTslII2WcCt8FFkON639PSlL0WZDnHOOhjtBwcfreaHcW6OszyHr+zxIDP2F42Yl0bJTAYySupjHoyU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774074777; c=relaxed/simple;
	bh=Nh0bFv2iBn1iABFVSO04HUyXbHCIJaZUIxWdaDEIO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/YpQK1O1DQ/LUe339TwPdqbm/79eH4gLBM6M7FirVaz1064bVCcsQ2ZyKVBvRB5R4JXRfc4HTH9sS9JzA0YPYdSRBKVBkOw4WAF3BWCBRHGtKLBEUpkbaeVJupRR8IgTV1DlHH+24yBK/H7mi6LyWjlalMtwPowuyDavDILhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbI+4TvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbI+4TvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4579DC19421;
	Sat, 21 Mar 2026 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774074776;
	bh=Nh0bFv2iBn1iABFVSO04HUyXbHCIJaZUIxWdaDEIO5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbI+4TvMtVxD4SSry3yJnEc6WOCAv7LmvHoolgpvGQhsqSA/VBJIrKUEcMc0/MN2p
	 CsTjfccErr5e26m+J5qEFysxQlF75rJsAkCdniox2Waa9swl64zUV6bcgmxsYw0rSM
	 MvG0cE0CW7ihUcwENmfHoChLsiikeYG4DeOO9fnc=
Date: Sat, 21 Mar 2026 07:32:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: yuhaocheng035@gmail.com
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: Re: [PATCH] tty: vt: Fix slab-out-of-bounds write in do_con_write
Message-ID: <2026032123-earplugs-stunning-0c6f@gregkh>
References: <20260321062312.4290-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321062312.4290-1-yuhaocheng035@gmail.com>

On Sat, Mar 21, 2026 at 02:23:12PM +0800, yuhaocheng035@gmail.com wrote:
> From: Haocheng Yu <yuhaocheng035@gmail.com>
> 
> A KASAN: slab-out-of-bounds Write in do_con_write issue is reported by 
> a modified Syzkaller-based kernel fuzzing tool that we developed. The 
> report indicates the problem lies in vc_con_write_normal 
> drivers/tty/vt/vt.c:3141(scr_writew(tc, (u16*)vc->vc_pos)), which writes 
> 2 bytes to the right of the allocated region at 2634 bytes.
> 
> Since it did not provide any repro program or enough information, 
> the cause remains unclear. However, adding a validity check of vc->vc_pos 
> before scr_writew should avoid this issue.
> 
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>

What commit caused this problem to show up?

And without more information, or a reproducer, I'm a bit loath to take
this change.

> ---
>  drivers/tty/vt/vt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 6e0089b85c27..95d860f09837 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3138,6 +3138,13 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
>  			      (tc &  0xff);
>  		tc |= (vc_attr << 8) & ~himask;
>  
> +		unsigned long end = vc->vc_origin + vc->vc_screenbuf_size;

Ideally do not create new variables in the middle of a function,
checkpatch should have warned about this.

> +
> +		if (WARN_ON_ONCE(vc->vc_screenbuf_size < 2 ||
> +				 end < vc->vc_origin ||
> +				 vc->vc_pos < vc->vc_origin ||
> +				 vc->vc_pos > end - 2))

That's not good, if panic-on-warn is enabled, as it is in a few billion
Linux systems, you just rebooted the machine, turning a simple overwrite
into a denial-of-service, not fixing anything at all, but making it
worse :(

> +			return -1;

Do not make up error numbers :(

thanks,

greg k-h
