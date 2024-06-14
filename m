Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0D38C;
	Fri, 14 Jun 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347615; cv=none; b=Rl7PB4+uDfnBv2Zfq8+Id3Kwh71SSgj95/heI+77ydPt7PAvVZsZf54h7ICFqoQy831sHDz1cFpR6SXwwqn/ug+5qekXm9Z+HqHM80YQj8bfgpL1z9ZwuuB8gCqWWcYFheqTOZDz8LJ+WcnekT/BlXCWzKJSQzNW4Gsfmyu8p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347615; c=relaxed/simple;
	bh=zlek80gvbIpOYdPgWm3SBR3CC1OdJL27D05Loa7qJg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARkD3TSj55lEOgqciXlURiLgohykae2vQhy8dOCGJlWI8IgAktsWP8Hngw/56IdUev+RorJevO+OXAv4Eg31tekWqdRr+FuEhAdGYm4qhjdwIoygqDZeep0QVC3MydCqliiMGcQ9Lw8HVAuVcE+7R+t+BmqCwu5kZd3Nvu8nlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWOnLc8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWOnLc8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C308C2BD10;
	Fri, 14 Jun 2024 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718347614;
	bh=zlek80gvbIpOYdPgWm3SBR3CC1OdJL27D05Loa7qJg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWOnLc8zBedufKG2+gNaXRm3u8REBNKv1/q9knkRQh8eqMhKZ8EJdKWJeSkwGdDqZ
	 lcivsbBctunXvlR0WvFUhYWhb8XjH9pwvDGcZlwF9a0TrGrikuk3fRml0Em/XiO6cM
	 meJT3tLSWhI69nKMalOA8sqsOvzGCQayWI9BTVsw=
Date: Fri, 14 Jun 2024 08:46:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tony@atomide.com, jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de, ronald.wahl@raritan.com,
	thomas.richard@bootlin.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: Implementation of Errata i2310
Message-ID: <2024061435-reawake-smoking-f639@gregkh>
References: <20240614061314.290840-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061314.290840-1-u-kumar1@ti.com>

On Fri, Jun 14, 2024 at 11:43:14AM +0530, Udit Kumar wrote:
> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to strom of interrupts, therefore apply Errata i2310 solution.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

Does this need to go to older/stable kernels?  If so, how far back?

thanks,

greg k-h
