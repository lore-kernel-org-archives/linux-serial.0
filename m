Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D511925A5;
	Tue,  8 Oct 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378590; cv=none; b=ijNzMAT6LMYZd8o8tDTqmCZrBK0goRMVzGQLFQq7HR5fOyasAOBUF+MgAqVHX+vOKmhM7/YSklqQlf8bsZhkuyZRmkMGdpB3ddTJY6X7Yzk8UuFxVSK0GziZT8i9yo0ODFRg/XurBeGnFeXmy/YApSHYgEFtQlMeire8W3NFI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378590; c=relaxed/simple;
	bh=PdJBOIJCIeq/GPsMhSfGTFSTAi6DRh54T3OVSZccCzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANYrnAPMI1t3T7KwJApIiVeCCfoPZe/aoPlwm/QUVJqiLShoHqPOB4l9RxQvQSGOA5bxOaVX+K/ngxOBWep0vojcleRWw4ZsqZTc1U47G1yNL6Z1IR5WhCMY6K/9JQNwzsv+FqZGV5aL0OfeVixHVHeTVdej8FXPOxwnui2U8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogEW73lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogEW73lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B99C4CEC7;
	Tue,  8 Oct 2024 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728378590;
	bh=PdJBOIJCIeq/GPsMhSfGTFSTAi6DRh54T3OVSZccCzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogEW73lmnate6m1aBHqomv4ldFMmyzsu/jQyJBpk0aaL7iJSjHZ/3uhgxiZm4EDhX
	 aO7NnyicOyqxS+7/p73abtdZ3Gvk0CH2IAD5DJvvvCFXQF1vmIK6Eu/ezJ2VppBYlS
	 koUo3uJ4h5uFcYudwNtZM64ZYL14xpPyrtPElCIU=
Date: Tue, 8 Oct 2024 11:09:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai.Sain@microchip.com
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] tty: atmel_serial: print the controller version
Message-ID: <2024100851-macaroni-giggling-7826@gregkh>
References: <20241008083459.51249-1-mihai.sain@microchip.com>
 <2024100842-luncheon-severity-afc0@gregkh>
 <PH8PR11MB6804E661B89912C18703AC6A827E2@PH8PR11MB6804.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804E661B89912C18703AC6A827E2@PH8PR11MB6804.namprd11.prod.outlook.com>

On Tue, Oct 08, 2024 at 09:05:24AM +0000, Mihai.Sain@microchip.com wrote:
> > On Tue, Oct 08, 2024 at 11:34:59AM +0300, Mihai Sain wrote:
> > > Add support to print the controller version similar to other at91
> > > drivers like spi and twi.
> > >
> > > Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> > > ---
> > >  drivers/tty/serial/atmel_serial.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/atmel_serial.c
> > > b/drivers/tty/serial/atmel_serial.c
> > > index 09b246c9e389..5f93974918c0 100644
> > > --- a/drivers/tty/serial/atmel_serial.c
> > > +++ b/drivers/tty/serial/atmel_serial.c
> > > @@ -2970,6 +2970,8 @@ static int atmel_serial_probe(struct platform_device
> > *pdev)
> > >        */
> > >       clk_disable_unprepare(atmel_port->clk);
> > >
> > > +     dev_info(&pdev->dev, "AT91 USART Controller version %#x",
> > > +              atmel_uart_readl(&atmel_port->uart, ATMEL_US_VERSION));
> > 
> > No, the other drivers need to be fixed up, when drivers are working properly,
> > they are quiet.  This driver is correct by being quiet, please send patches for
> > the other ones to remove these types of lines.
> 
> Is it acceptable to use dev_dbg instead of dev_info ?

Sure, but why?  What user would ever need/want to turn that on?
dev_dbg() is for developers to help support things, a dbg call at probe
time is rare.

What would you do with such a message?

thanks,

greg k-h
