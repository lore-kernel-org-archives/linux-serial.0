Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D14CB5B;
	Tue,  7 Jan 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239410; cv=none; b=Cs5K9JV4JnJ838q6fYt9MXwoe5DoRxz5THdKu239kpPKGAxm1f2nqygr7bvWioXsENACJlK5ejElicy1saL2XibbRmS7xnRT/3U8ae0wg8t2vcUkfFubFJqXLdQq6fwBag+EoymkoaEK3tEG/8DDTm3jECoIK/Z58B3yEw3Bl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239410; c=relaxed/simple;
	bh=DAdwUoNX7sh/BI0530dT/yuqUo3/J+LAwToEo0tq3QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUedCCdtIXEI16eCvB33jaVoWMT7JfE30GTbDfDfFOkesLYlIQk0xQewtceuNgqj/KKIX3dPAQqXqUstpGK8T64gfsPZCGjX4cI3EELBAXY/3gictw6OJTQ3GEGM+bbiar4xnUE8Xx/fMVgPa7Kw3RFnygv7SbSDfLHp/OKWE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQs0c53f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQs0c53f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0DCC4CED6;
	Tue,  7 Jan 2025 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736239410;
	bh=DAdwUoNX7sh/BI0530dT/yuqUo3/J+LAwToEo0tq3QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xQs0c53fhFxNtrm87+aa/xvd73T0IIwvmIVuJx4McEJCASeDG+2kg5eMI6yxp/Rpj
	 l79jmbXwgFDdyCe7plOwV5P1gDrmD84KgZWAuJWRLxddf/ZyA0kOwu2aT4TJOmnkXl
	 T0a5yj7C67xJWnPSm27yvIHyBNrY0Mr/QwFqAyrA=
Date: Tue, 7 Jan 2025 09:43:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Message-ID: <2025010738-uplifting-avenging-63e8@gregkh>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <2025010602-cozily-rind-c2c6@gregkh>
 <DB9PR04MB84290597CC2BA6CFA096849B92112@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84290597CC2BA6CFA096849B92112@DB9PR04MB8429.eurprd04.prod.outlook.com>

On Tue, Jan 07, 2025 at 08:29:12AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, January 6, 2025 9:45 PM
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
> > 
> > On Mon, Jan 06, 2025 at 10:24:52AM +0000, Sherry Sun wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Friday, January 3, 2025 5:08 PM
> > > > To: Sherry Sun <sherry.sun@nxp.com>
> > > > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; imx@lists.linux.dev
> > > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum
> > > > uart_nr to 12
> > > >
> > > > On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > > > > Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need
> > > > > to increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> > > > > initialization failures.
> > > > >
> > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > ---
> > > > >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > > b/drivers/tty/serial/fsl_lpuart.c index 57b0632a3db6..7cb1e36fdaab
> > > > > 100644
> > > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > > @@ -245,7 +245,7 @@
> > > > >
> > > > >  #define DRIVER_NAME	"fsl-lpuart"
> > > > >  #define DEV_NAME	"ttyLP"
> > > > > -#define UART_NR		8
> > > > > +#define UART_NR		12
> > > >
> > > > Why not fix this properly and make this dynamic and get rid of the
> > > > static array causing all of this problem?  That way when you get a
> > > > system with 13 uarts, you will be ok :)
> > > >
> > >
> > > Hi Greg,
> > >
> > > Thanks for your comment.
> > > But I checked all the uart drivers under drivers/tty/serial/, UART_NR
> > > is widely used, currently almost every uart driver that supports
> > > multiple uart ports defines this macro, this value is needed for the
> > > nr parameter of struct uart_driver, also for console index checking
> > > and setup.
> > 
> > Yeah, it's messy, but it can be done (for example see all of the usb-serial
> > devices, we don't limit the number of those ports in the system except to 256
> > I think.)
> 
> BTW, it seems that usb-serial devices also have the max ports limit, you can
> check the MAX_NUM_PORTS macro in include/linux/usb/serial.h, it was extended from 8 to 16 now.
> 
> /* The maximum number of ports one device can grab at once */
> #define MAX_NUM_PORTS       16

That's different, that is "max devices a single device can use".  We
don't know of any single-usb-device that has more than 16 ports on it,
do you?  I've seen big ones, but internally they are all split up into
smaller USB devices in order to handle the bandwidth properly.  And I
think even the 16 port devices are almost always really just 2 8-port
devices, or 4 4-port ones.

Now you can have a lot of 16-port devices in the system at the same
time, but I think we max out at 256.

Oops, nope, we now support 512 usb-serial ports in the system at one
time:
	#define USB_SERIAL_TTY_MINORS   512     /* should be enough for a while */

Well "now" is relative, that change was made in 2013 :)

The commit that bumped the number also gives a hint on how to make this
more dynamic, if you want to read the changelog text for commit
455b4f7e18e7 ("USB: serial: increase the number of devices we support")
for more details.

thanks,

greg k-h
