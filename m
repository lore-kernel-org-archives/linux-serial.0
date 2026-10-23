Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769582;
	b=bKSTlSE8yDcBu1CYO7fuDdb+OXm4g8RQ/Bfc/0Y/8qfh5Cfsrbta0JuGwoWwlxMTnV2r
	 YAkFyRwQSO8CvAiYXFZlecXhMrRlGlVZrVq3dEOr8bT09k10D6itGhufN77D/tsXtpAtB
	 CSulTeKI1ZD3c6RHZFGcxSHsf3q5ZH/fsJ3yrpORxeENSU+Vi2U7vnfBqXniyClDuOBja
	 SJmh+Y3pamop0Oe6Ee9hBHBJN5nbun18vFqtNp4uMsWOIxOWf285f/tLGepePUQVDbWN4
	 Py1OolrOiUKhy8QcOj3MSoTGdCVFhvV13UQDXeGvUOc895BMkmReLfbekknoVowS1LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769582;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jJpx3VxDNQiUjNCKFoRTUEOYuiUMPCrtApSCV3e15Bg=;
	b=vfxgd48qelgBZ9sJg062QxfE4MEkKP6EV+1Jv1GxGbMQLT9AgcQs1qeg0/pAmgYCcIXB
	 vlPMdg5/9bQF24n1vivMctAGTpkrWjMs7YZ3XFvMnX9d5Xr+K3JoGlRg2RJ3aCqqYbiSV
	 ziWyOxqtReisVgIM4EbCEJuXPYZFmLksP/sFy5Y/emCHLRcG5LJ4jXNI5KxctVzyekGEE
	 WR4XfrlI3rPy8ZZhNPi6jsMn7qQwdDz1L/nLg8S6asXx4JuENh7c82rl76pXdT4+bbJcr
	 e534wrA9STbDDTEe4ZWQRZGGJ1aFaB3Fx+4/dQdOtN1FkMyqWXlkMwcTCBWm+6SHxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vDKvkzjd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E0606A332;
	Fri, 23 Oct 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vDKvkzjd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDA51F01829;
	Fri, 23 Oct 2026 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792769582;
	bh=jJpx3VxDNQiUjNCKFoRTUEOYuiUMPCrtApSCV3e15Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vDKvkzjdb8gdKSi/Ac7FiHQEbAKfCPTxxPclQxErRO7tn0q/gc/cg3R9Vp8GS8wY6
	 5AhB8wS8ooSm8L0cSl3YPadQI6iWfHMoZ8bePbPqMZDJnqbG/GHG/vRqLFPslS/R5q
	 x3BKwUyG4UTuxDg+r1lvlLE4MxNCtWA0zZVRV81I=
Date: Fri, 23 Oct 2026 15:37:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, deller@gmx.de,
	James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 7/7] vt: Remove old-style con_blank
Message-ID: <2026102312-chute-proud-204a@gregkh>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-8-tzimmermann@suse.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023132448.115747-8-tzimmermann@suse.de>

On Fri, Oct 23, 2026 at 03:16:17PM +0200, Thomas Zimmermann wrote:
> All consoles implement the new con_blank plus con_unblank. Remove
> the old semantics from con_blank. Always pass a VESA blank mode to
> the blank parameter.
> 
> v3:
> - keep con_blank's mode_switch parameter

Shouldn't the "v3:" stuff go below the --- line?

thanks,

greg k-h
