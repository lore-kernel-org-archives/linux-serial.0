Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE352181CE4;
	Mon, 17 Jun 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605342; cv=none; b=CEa0rbBxRVWHCEjg2phOmLdzVNsBhBuGl6CQnIkHn759xR+RAilL5flQfapM4b7kXhZkO8rvJT2uxGJjFX4191uW0+v5xeZu48uYXc8GCPlcNAvFKu1BRvoF6SMpj0TIDfDncxo0ZQ9XB/KQm28uEia9jWqq24/mkltims7fdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605342; c=relaxed/simple;
	bh=y07j14qPqdH8wPKemO1zLM+3jz3004W3JjHnGjkjRV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u52Z4pKwaRkPtdcvY6yoTNmBFTGKFuez07vEatpYCAKqXn6xyevfIaCtEuAA8ABiwbPWSY3tZ56xsWYGri0OOxvWndhhBKlGx7H0pCtkAtJYjKVneOKSq08UF7Gujrkphcj19pNzrr9FlB+D2kDgBx1S2c14+94e0KtMnc9T8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FDOn8SZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FDOn8SZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823AC2BD10;
	Mon, 17 Jun 2024 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718605341;
	bh=y07j14qPqdH8wPKemO1zLM+3jz3004W3JjHnGjkjRV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDOn8SZAqRz8FAuz3CMI0JCmLSzDkZ9jVGQ6MyYH3XE9AcPWFwv8b29yn0e+d9P+X
	 v3NxEF7o1T4qPsVHP/FvElj+7S86xBJiRpl/wL7TpHGHF9D+752MxeaZEe4EMLj1wS
	 0YETu5fYvIEa9tzja0XhbjkxsHsl9TiWPeD9/t50=
Date: Mon, 17 Jun 2024 08:22:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tony@atomide.com, jirislaby@kernel.org,
	u.kleine-koenig@pengutronix.de, ronald.wahl@raritan.com,
	thomas.richard@bootlin.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] serial: 8250_omap: Implementation of Errata i2310
Message-ID: <2024061704-vengeful-exemplify-261a@gregkh>
References: <20240617052253.2188140-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617052253.2188140-1-u-kumar1@ti.com>

On Mon, Jun 17, 2024 at 10:52:53AM +0530, Udit Kumar wrote:
> As per Errata i2310[0], Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to storm of interrupts, therefore apply Errata i2310 solution.
> 
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
> 
> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Test logs
> https://gist.github.com/uditkumarti/7a7ab6994581bbb09cf1a4271c592d8e
> 
> Change logs
> Changes in v2:
> - Added Fixes Tag and typo correction in commit message
> - Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
> Link to v1
> https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/
> 
>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
