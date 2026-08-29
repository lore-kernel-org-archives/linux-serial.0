Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782F2E764D;
	Sat, 29 Aug 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005287; cv=none; b=MA6uD5pXoJkkuI57fbDnU623Z8qgBaTrHrrP/1TTBciIgrRSo+9DRLL/PYZGDbvXWpyhgL7cI88yJudw9CdM0AQdPkfJzOwUlp8GeTWFHlAgR5kJYpSHyaazWZymeNuffYao1mT/rBr0DEjP+14/1CzhmSc0SvSkdMPdfFr8tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005287; c=relaxed/simple;
	bh=YJtOqnodoYELs0jHPLD7BM5BiHAHcSBYQRaEQuBgJ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/X2/aHTMerY1M9H8U6on+TSRAp3E9aSPmycHQq+F0g4Q96DXYyHIiPAIwbLazteCTmlR3zWkUL2sKwrgc2CZochZNidJ/fFwduGBr9fHs/PzGIfMKS+VRn2dcsxd9EtlL8nZXO8wyYuS4nxicsc48axAKraIqK1iVwUhOM0vH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmxNPYHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmxNPYHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BAD1F000E9;
	Sat, 29 Aug 2026 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788005285;
	bh=ys9sRKbgEpc5JxVtcfwGv4NRd6EIcf1du2RYoL+jQgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmxNPYHH9C+VyW/6yjXarFBxkmWittKOqczKtopSFHjUu7RNdtA0Vn4VZlV01MpzE
	 HpF1Wp/O2vLeJWJGbuAWVcngR0otVdt759/9esMjn73f4hK+Anxer6AdwwZfzhi9yT
	 XkgrUIwWhe609SKpK6scBf5lzVWfBevDRJA4Bdzc=
Date: Sat, 29 Aug 2026 14:06:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 9/9]: vt: Misc changes, e.g. to #include directives
Message-ID: <2026082918-hungry-disk-c472@gregkh>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCI6JhoH5D7ss34@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCI6JhoH5D7ss34@MAC.fritz.box>

On Thu, Aug 27, 2026 at 06:58:48PM +0000, Alan Mackenzie wrote:
> vt: 32b glyph: 9. Misc changes, e.g. to #include directives
> 
> Rearrange some #include directives, add some clarifying
> comments, and some code changes which didn't fit elsewhere.

But you need to list those code changes and why you are making them, and
the #include stuff should be it's own patch, right?

And why this:

> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 13f4e48b4142..18affdb3c7c5 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -48,6 +48,8 @@ static struct vc_selection {
>  	.start = -1,
>  };
>  
> +static unsigned int size_row;
> +
>  /* clear_selection, highlight and highlight_pointer can be called
>     from interrupt (via scrollback/front) */
>  
> @@ -340,6 +342,7 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
>  {
>  	int ps, pe;
>  
> +	size_row = vc->vc_size_row;
>  	poke_blanked_console();
>  
>  	if (v->sel_mode == TIOCL_SELCLEAR) {


You set a local variable that is never actually used anywhere?

This feels very very odd, especially as the "last" patch in the series.

greg k-h
