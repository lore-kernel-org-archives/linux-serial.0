Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33187EEF0
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651291; cv=none; b=BHpUDifdhQY+Ks8f/PFuADkozYIj+v2YrnEW5PcnB12LFUHlpR+l3JbO3ZIiKYU3yKe6EwYqTpoOXG5rvBSrFt8Um8E4oFmNjeJ37ia1soCtVMV19RMDYShJEZbF8na+3I5g57nrM58UBauH+3puMNrW+iBteB/ZULSBCf2o5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651291; c=relaxed/simple;
	bh=MXgl26BMB/e8/A7HL6hVvR4NIoiVBV4J5RKndyj/F9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPw0axPi3rIXWFgd7dAzH5Uz173qVD1coRFXWnLNo00FyrIxeNxX0YiSsfJETWzFSmWZ37FQdbiMvfi+Xtg6AdxsTxSovHb2mozZBZ5LgHhrtSQvweJhBwy6P0iBcrnmtoyinnWON5tyBRDyHlzznf6wqoYhw5jvUbXhVm5bUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNAvzIM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNAvzIM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED59EC433A6;
	Tue,  9 Apr 2024 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712651290;
	bh=MXgl26BMB/e8/A7HL6hVvR4NIoiVBV4J5RKndyj/F9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNAvzIM4JVu2/AId79AM1LEppS88OgYyOQoPAt6vZ+FHuClfGTgZ2y2SCBh9QSQnh
	 LhEucKjbgwOHD8qpopEfpzfd9qMFQEFnnLFAsWnrwEgSDq/w7ZejMGBbc2r5I/epoq
	 Pg5QqumvUbnXwQfDv7E+auDV4/v++PV953DKro2Y=
Date: Mon, 8 Apr 2024 16:56:07 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Matthew Howell <matthew.howell@sealevel.com>
Cc: "5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com" <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Darren Beeson <darren.beeson@sealevel.com>,
	Jeff Baldwin <jeff.baldwin@sealevel.com>,
	Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Message-ID: <2024040856-repaint-botanist-3503@gregkh>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
 <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>

On Mon, Apr 08, 2024 at 01:11:42PM +0000, Matthew Howell wrote:
> On Wed, 2024-02-21 at 16:16 -0500, Matthew Howell wrote:
> > Allows the use of the EN485 hardware pin by preserving the value of
> > FCTR[5] in pci_xr17v35x_setup().
> > 
> > Per the XR17V35X datasheet, the EN485 hardware pin works by setting
> > FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented the use
> > of EN485 because it overwrote the FCTR register.
> > 
> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > ---
> > V1 -> V2
> > Fixed wordwrap in diff
> > 
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 23366f868..97711606f 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -596,6 +596,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  	unsigned int baud = 7812500;
> >  	u8 __iomem *p;
> >  	int ret;
> > +	u8 en485mask;
> >  
> >  	port->port.uartclk = baud * 16;
> >  	port->port.rs485_config = platform->rs485_config;
> > @@ -618,7 +619,8 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  	p = port->port.membase;
> >  
> >  	writeb(0x00, p + UART_EXAR_8XMODE);
> > -	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> > +	en485mask = readb(p + UART_EXAR_FCTR) & UART_FCTR_EXAR_485;
> > +	writeb(UART_FCTR_EXAR_TRGD | en485mask, p + UART_EXAR_FCTR);
> >  	writeb(128, p + UART_EXAR_TXTRG);
> >  	writeb(128, p + UART_EXAR_RXTRG);
> >  
> > 
> 
> Hi,
> 
> Just wanted to follow-up on this to see if anyone has had a time to
> review the above submission? Please let me know if there are any issues
> / anything I need to do.

There was review comments, did you not see them:
	https://lore.kernel.org/all/ZdaAI4uZ1Byx2cWs@surfacebook.localdomain/
