Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894B1D0F54;
	Mon, 21 Oct 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495501; cv=none; b=B6033z1QY7ed40KVWg9sbOSe3le/1wOoKWYBkLdowEzVTmeirog/GxyX2FjsgQxZh89SzFq2Tdjdwtjipkxrnj20jrceNr/4jM0nAIGWbhMOfx/ja4HEh/rw6GB/WUwWKT+NqWYjfE1ifkoHAWdoO+UctsujLNYuOLD49fzGAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495501; c=relaxed/simple;
	bh=Q/vHeCvRemXBDdF6JOsV/LJSic0sR7ukVpxi7m/3URA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0GY3skYhgowUQKueVSI0cYqT/YCPHtddbBGNuWZGOl3Rwht69oWCB7uqpwyrmoNLIZDn+peLei6860Wl/502g7Mk1r5UjCIrwfq3yQMr7YbJDrtHYMKXYPOpPh0JFkmPCwIQs5A/WHBHDCo9KzEyRj/dSBThK1vtMnYzZtNSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkTIECbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkTIECbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E94C4CEC3;
	Mon, 21 Oct 2024 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729495500;
	bh=Q/vHeCvRemXBDdF6JOsV/LJSic0sR7ukVpxi7m/3URA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkTIECbvT/1ITopz/KTnSu6xS9L+g59e8y9t5fzgzv2o4c5Pkb8oSudj4pVnZHQcF
	 Jr2C2FABZfw6oMfKZbFG9+nDpDLBafC+5iS/680Tk2ODH2+3R9R0iDjtr4dOIvQi4I
	 h0UKZ17pBdik9LNNw8EDhjzXCJWg8VLlSFTlDkEg=
Date: Mon, 21 Oct 2024 09:24:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai.Sain@microchip.com
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] tty: atmel_serial: Use
 devm_platform_ioremap_resource()
Message-ID: <2024102148-stamp-isolation-ae90@gregkh>
References: <20241021064321.3440-1-mihai.sain@microchip.com>
 <2024102151-showy-partake-a2aa@gregkh>
 <PH8PR11MB6804FADFEFEA51A8B35F894482432@PH8PR11MB6804.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804FADFEFEA51A8B35F894482432@PH8PR11MB6804.namprd11.prod.outlook.com>

On Mon, Oct 21, 2024 at 07:16:31AM +0000, Mihai.Sain@microchip.com wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, October 21, 2024 10:00 AM
> > To: Mihai Sain - M19926 <Mihai.Sain@microchip.com>
> > Cc: richard.genoud@bootlin.com; jirislaby@kernel.org; Nicolas Ferre - M43238
> > <Nicolas.Ferre@microchip.com>; alexandre.belloni@bootlin.com;
> > claudiu.beznea@tuxon.dev; linux-kernel@vger.kernel.org; linux-
> > serial@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [RFC PATCH] tty: atmel_serial: Use
> > devm_platform_ioremap_resource()
> > 
> > On Mon, Oct 21, 2024 at 09:43:21AM +0300, Mihai Sain wrote:
> > > Simplify the request port function by using a single call to
> > > devm_platform_ioremap_resource().
> > >
> > > This will also enhance the printing from /proc/iomem:
> > >
> > > cat /proc/iomem | grep flexcom ; cat /proc/iomem | grep serial
> > >
> > > f0004000-f00041ff : f0004000.flexcom flexcom@f0004000
> > > f8020000-f80201ff : f8020000.flexcom flexcom@f8020000
> > > f0004200-f00043ff : f0004200.serial serial@200 f8020200-f80203ff :
> > > f8020200.serial serial@200 fffff200-fffff3ff : fffff200.serial
> > > serial@fffff200
> > >
> > > Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> > > ---
> > >  drivers/tty/serial/atmel_serial.c | 12 +++---------
> > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > Why is this a rfc?  What needs to be done before you want it merged?
> 
> I used the rfc tag in order to get the feedback from you and all stakeholders.

You need to ask for the feedback you are looking for, we don't know what
you feel is wrong here.

> If the modifications are OK for you I will send a new patch without rfc tag.

As we are drowning in real patches to review, I almost always just
ignore RFC patches as I know that means that the submitter feels there
is still more work to be done.  So please always take that in mind.
Please ask for reviews from other developers in your company if you feel
it is not ready for our review.

thanks,

greg k-h
