Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E811DE3BA;
	Mon,  6 Jan 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171097; cv=none; b=ujikh6cybd+2CQWq6ea08usSQI/2xxWsMK74XktYq5aiAlcUlRL36afvFilHNcUQbI1vTvFFoOuXGLzKPBVPL6wcTVVRPA45tI2z9g2PV+ycTxFYyKWYqmZfa3KS9/xz3Ky9rNnCV+rwEj7eAFarmT5HNSyHLFoqyCK1Ht51ros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171097; c=relaxed/simple;
	bh=KPu/4PTb5LD6gnZP2D+rico8lHJSTMg1z7/3992BAKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnQknuhW2eXY8Zd5vbvi5eTQC7mDGDRfvN0aUxDnZYHG7Q9QYkfoXDSQHkz28Ox1HeTmWRkGjMqCnolM3/QXxpyWoIvVDKQiISERWz+7YPjLreGctYYY4TB68V3Ki3xHwrwUaefgij/S9LNTXjAv+Ay/sdQLDsnp7TRUag185oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRz+XQqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRz+XQqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F86C4CEDD;
	Mon,  6 Jan 2025 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736171096;
	bh=KPu/4PTb5LD6gnZP2D+rico8lHJSTMg1z7/3992BAKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRz+XQqtlOXXZa8uYmek5OrFMQqwafbJSPflM9ao4NGLeSuqh+fn8B7x3M/KijHpp
	 iiHXovJqjRGggYsV5UNF7Ivs+54pZlRohjnBNzQ+j8dZbNYVA7o3cVYzUZSKZi6UNG
	 bH0BqFUTaa+3ekEZIawXQviFGVp2Oj4nyhwIjl6g=
Date: Mon, 6 Jan 2025 14:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Message-ID: <2025010602-cozily-rind-c2c6@gregkh>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>

On Mon, Jan 06, 2025 at 10:24:52AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, January 3, 2025 5:08 PM
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
> > 
> > On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > > Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need to
> > > increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> > > initialization failures.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 57b0632a3db6..7cb1e36fdaab
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -245,7 +245,7 @@
> > >
> > >  #define DRIVER_NAME	"fsl-lpuart"
> > >  #define DEV_NAME	"ttyLP"
> > > -#define UART_NR		8
> > > +#define UART_NR		12
> > 
> > Why not fix this properly and make this dynamic and get rid of the static array
> > causing all of this problem?  That way when you get a system with 13 uarts,
> > you will be ok :)
> > 
> 
> Hi Greg,
> 
> Thanks for your comment.
> But I checked all the uart drivers under drivers/tty/serial/, UART_NR
> is widely used, currently almost every uart driver that supports
> multiple uart ports defines this macro, this value is needed for the
> nr parameter of struct uart_driver, also for console index checking
> and setup.

Yeah, it's messy, but it can be done (for example see all of the
usb-serial devices, we don't limit the number of those ports in the
system except to 256 I think.)

> This patch just refers to many other uart driver patches to extend
> maximum uart number, such as
> https://lore.kernel.org/all/20240112095300.2004878-3-valentin.caron@foss.st.com/.
> Agree that it will be nice to dynamically allocate everything, but for
> now I prefer to simply change this value as there doesn't seem to be a
> good uart implementation at the moment, not sure what you prefer?  :)

I'd prefer not hard-coding stuff like this but if it's going to be too
much of a pain I guess I'll take this for now...

thanks,

greg k-h
