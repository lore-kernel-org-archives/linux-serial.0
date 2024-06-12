Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678616C69B;
	Wed, 12 Jun 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177000; cv=none; b=k25S3Ppj9SdHwY17O5r5TrRViUE10Kn4Oh0Jp/2neqmrqV/oJPrNHs0jKlOqjuZOzpfwkZBENC53yXvXzE/OzUdw45cbCCcFIzWVqLsHTWqmejZFBd20jyQ0jFXfr6V3+jNj39LDd5aeoKpmRhULm9h0c/qJ/uUI8q1mmkHJsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177000; c=relaxed/simple;
	bh=om+CeYPKCOnLN4dmJthXsArxlQeFcaDsrz+sk8PbJrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft96gPOvfIeEpiUpEyH9FKbMHM+5zSnfNxPMxVA5Ogl82Y1Z5yeeF28/LIp+UevtpnV1qw8EE2ANzEP1NclPXPb//PeNojueRUgixcP84SC2b7JDAeQLC9Ds3TdewGQ6yzahVuTOx0+OrPrx3499GAFVxHs9Sd/kHaaYVU1BY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIpiJo5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIpiJo5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F0C3277B;
	Wed, 12 Jun 2024 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718176999;
	bh=om+CeYPKCOnLN4dmJthXsArxlQeFcaDsrz+sk8PbJrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xIpiJo5WPsePjV0XEHViYmADYGGw0Idy1sMoarLMMycZPYsGnbCmYEKb+AaATfUwe
	 gaCMrTv/JB9y9Q/QIROz+iqz6InfM41GKjziRU40+ChL0guUgFHm0j3lo+onhQVuSD
	 xHt4denCAz7zylMLbfOM5zTb5A9snk6Z6HNQr/N0=
Date: Wed, 12 Jun 2024 09:23:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <2024061226-laborious-jubilance-8df8@gregkh>
References: <20240611092251.159149-1-ychuang570808@gmail.com>
 <2024061118-sycamore-leggings-05a9@gregkh>
 <73d2167a-84ee-40a4-a68d-ba25229ff8ce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73d2167a-84ee-40a4-a68d-ba25229ff8ce@gmail.com>

On Wed, Jun 12, 2024 at 08:43:54AM +0800, Jacky Huang wrote:
> Dear Greg,
> 
> 
> On 2024/6/11 下午 07:11, Greg KH wrote:
> > On Tue, Jun 11, 2024 at 09:22:51AM +0000, Jacky Huang wrote:
> > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > 
> > > The pdev->dev.of_node can be NULL if the "serial" node is absent.
> > > Add a NULL check to return an error in such cases.
> > > 
> > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > > ---
> > >   drivers/tty/serial/ma35d1_serial.c | 13 +++++++------
> > >   1 file changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> > > index 19f0a305cc43..3b4206e815fe 100644
> > > --- a/drivers/tty/serial/ma35d1_serial.c
> > > +++ b/drivers/tty/serial/ma35d1_serial.c
> > > @@ -688,12 +688,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
> > >   	struct uart_ma35d1_port *up;
> > >   	int ret = 0;
> > > -	if (pdev->dev.of_node) {
> > > -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> > > -		if (ret < 0) {
> > > -			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> > > -			return ret;
> > > -		}
> > > +	if (!pdev->dev.of_node)
> > > +		return -ENODEV;
> > > +
> > > +	ret = of_alias_get_id(pdev->dev.of_node, "serial");
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> > > +		return ret;
> > >   	}
> > >   	up = &ma35d1serial_ports[ret];
> > >   	up->port.line = ret;
> > What commit id does this fix?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This patch fix the in tree ma35d1 serial driver.
> The last commit for ma35d1_serial.c is
> '6b64f8e360c00f180cffa1806095cdd2abc55b16'.

That is obviously not the commit that causes this problem, which is what
I was looking for here.  Shouldn't you include a "Fixes:" line if this
is resolving a bug?

thanks,

greg k-h
