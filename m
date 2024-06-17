Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDD1946B1;
	Mon, 17 Jun 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620906; cv=none; b=DD5IV4A/EeBwIkQI90zl8VcqdCTxzAmb6Gjq+mdB4rG4nwbGXeYsLsP+aiALrhY/LA1hVNZOO8jfhBv8CduFl0eAdoRUme7EyONczh3OtXO6ihDYK7dJiH+D7W5JlUmuXBDjZdE7R2YfZBoVI+W0+9/mGYYs6Yb5xW3VDDnjbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620906; c=relaxed/simple;
	bh=7MNSQdheqd0Teank99xiHbe0rGv6/Y36NZ1kmeWpyI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErWVBV+vX5dvl/iu3QnRptKho8kT9m3zy7epxJ2ZaNkoy35+CmLjqCOog9t26pEQG19cos0qS2IQSU3wn9lNp8JsoHjcHrEVOQxnT5hmCGJgBzYNqMJ9loaKHmyAQtoQvnwTt5MQ7VopbPkf5prBhYizrdpa+V4tqs/QIqHA7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v3rb0rNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v3rb0rNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D610DC2BD10;
	Mon, 17 Jun 2024 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718620905;
	bh=7MNSQdheqd0Teank99xiHbe0rGv6/Y36NZ1kmeWpyI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v3rb0rNcqvCI0W4sYEa+btFktGn7COfvkGn4fc292P9Kf5iWe8hzVWHYzZ9swIRf5
	 nT9tB6Scwjuml76OcHSFmxTcluNYdV9ElpoStDrwINFSads00P5eIE++w5MENnsCSp
	 a+cC2QuUZZYcJGlyvrENgAXtm6/4faPnCDrsxlVU=
Date: Mon, 17 Jun 2024 12:41:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tony@atomide.com, jirislaby@kernel.org,
	ronald.wahl@raritan.com, thomas.richard@bootlin.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] serial: 8250_omap: Implementation of Errata i2310
Message-ID: <2024061745-enzyme-penny-6c12@gregkh>
References: <20240617052253.2188140-1-u-kumar1@ti.com>
 <2024061704-vengeful-exemplify-261a@gregkh>
 <46e0461e-08e2-4fcd-80dc-f1213d57489b@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e0461e-08e2-4fcd-80dc-f1213d57489b@ti.com>

On Mon, Jun 17, 2024 at 03:17:54PM +0530, Kumar, Udit wrote:
> Hi Greg
> 
> On 6/17/2024 11:52 AM, Greg KH wrote:
> > On Mon, Jun 17, 2024 at 10:52:53AM +0530, Udit Kumar wrote:
> > > As per Errata i2310[0], Erroneous timeout can be triggered,
> > > if this Erroneous interrupt is not cleared then it may leads
> > > to storm of interrupts, therefore apply Errata i2310 solution.
> > > 
> > > [0] https://www.ti.com/lit/pdf/sprz536 page 23
> > > 
> > > Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > ---
> > > Test logs
> > > https://gist.github.com/uditkumarti/7a7ab6994581bbb09cf1a4271c592d8e
> > > 
> > > Change logs
> > > Changes in v2:
> > > - Added Fixes Tag and typo correction in commit message
> > > - Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
> > > Link to v1
> > > https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/
> > > 
> > >   drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
> > >   1 file changed, 20 insertions(+), 5 deletions(-)
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >    older released kernel, yet you do not have a cc: stable line in the
> >    signed-off-by area at all, which means that the patch will not be
> >    applied to any older kernel releases.  To properly fix this, please
> >    follow the documented rules in the
> >    Documentation/process/stable-kernel-rules.rst file for how to resolve
> >    this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> 
> 
> I realized the same due to other patches, this not getting applied cleanly
> on stable (using git am).
> 
> Let me know if you are ok,  I will port this to stable kernel, once this is
> merged into Linux tree.

Ok, but if you properly put a cc: stable line on your commit, the stable
team will notify you when/if something fails to apply, no need for you
to try to remember to do it sometime in the next few months.  Please do
that, just adding a "Fixes:" tag never ensures that this will happen at
all.

thanks,
greg k-h
