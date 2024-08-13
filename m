Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF115B7
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539631; cv=none; b=Fd7ci+DMybuhEqq508jG9xCKmwSO3ODWn80II8CwMCHil7T2rmYwdwcG5SMtEiN9KgE0TrmyqKrex9K+haP7oTnPq6yIxhJL5MzsO1eg/1VoMvtaK+pyvZt8GaLQFpO0Mw1m07CK98YJvZfGxuQ1MF/1AyOemyXRHvr47450Vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539631; c=relaxed/simple;
	bh=48XnNGZ2NZuoEQWsFmA0utynGlFXtYstHFdCR5YXSsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMR+C142kay2z0Z8W+HEDGOpvga8NtcJbNhbGNwmZJcaPiCJTF3F+f9Vu4oJ1yNPz8vzuHZ1yelEbzeVwglQTLXgzomCWoTKmyGDZ8tE9UALqetSGNWboFtQkgl4+8dXCE4H0fQN/k56GcQU/UEaDO0SUzm6zuhrVjn4KKZEgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjypzSWd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjypzSWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A058CC4AF0B;
	Tue, 13 Aug 2024 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723539631;
	bh=48XnNGZ2NZuoEQWsFmA0utynGlFXtYstHFdCR5YXSsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjypzSWdBbZt/ctd4dYrCv8Rl6Tq43RrAtVXF7KIoglGT+lwJGF6YkBqffz4+nV6B
	 ZPIr9KOrFMXDbCdo+1Qjy8B0wYUDZhnkB4LwwK/BeB/AZcTWttO8tvheOrqARjTgxZ
	 rQ0cmxrIiceQjnoPMD4hvkw/hNSjGa1+QqXfT7lE=
Date: Tue, 13 Aug 2024 11:00:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kevin Hilman <khilman@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, jirislaby@kernel.org,
	tony@atomide.com, linux-serial@vger.kernel.org,
	gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <2024081318-litigator-slinky-8f0b@gregkh>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hzfplplfs.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hzfplplfs.fsf@baylibre.com>

On Fri, Aug 09, 2024 at 12:04:23PM -0700, Kevin Hilman wrote:
> Thomas Richard <thomas.richard@bootlin.com> writes:
> 
> > If the console suspend is disabled, the genpd of the console shall not
> > be powered-off during suspend.
> > Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
> > suspend, and restore the original value during the resume.
> >
> > Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> 
> Hmm, this patch got merged upstream (commit 68e6939ea9ec) even after
> disagreements about the approach.
> 
> Even worse, it actually causes a crash during suspend on platforms that
> don't use PM domains (like AM335x Beaglebone Black.)
> 
> Details on why this crashes below.
> 
> Thomas, could you please submit a revert for this (with a Fixes: tag)
> and then follow up with the approach as discussed later in this thread?

Did this revert happen yet?

thanks,

greg k-h
