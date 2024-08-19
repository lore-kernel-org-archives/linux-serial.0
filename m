Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC22900
	for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062809; cv=none; b=FZSZlvrb6m6QwelFYPhETITbg0iYLMp3cC657Khx9p1uHRgYgEhOfSashGQ+1Rc1tg5uniLaOurY33srSVcnFH3EW1GQidtFJulMqNlKOL9QhCHB83a77wK9G7PhVsgb+R92YLBGLvIINwqTsGN9CQD+dIijpx+SClRcQctED9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062809; c=relaxed/simple;
	bh=0Umx+m4HI45RbSJPDjOFaFY1O8psasyvfUTFc4sNLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo7QITG3Q1J1/xgQWMBszsyqjrWHe6gZa72EcOEQkZsICqA/wrHZbiyTz2IQuLkliZ8UbztPrX7PfzdP2pjRX3qwMa8ytTXOTfUTQYV+f7RfWvl2yE4ofZ6ye+jnXveS+eYbobw2ojc7E7M4d31O+t5Dp0Ey+tneIlxT6OGZypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sfzUJ-00043g-Dh; Mon, 19 Aug 2024 12:19:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sfzUI-001VdU-Sn; Mon, 19 Aug 2024 12:19:46 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sfzUI-00Bkev-2V;
	Mon, 19 Aug 2024 12:19:46 +0200
Date: Mon, 19 Aug 2024 12:19:46 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
Message-ID: <20240819101946.cf7x7xecdn2pfa4t@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20240807-v6-10-topic-usb-serial-serdev-v1-1-ed2cc5da591f@pengutronix.de>
 <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Hi,

sorry for not replying earlier.

On 24-08-08, Jiri Slaby wrote:
> On 07. 08. 24, 16:08, Marco Felsch wrote:
> > The purpose of serdev is to provide kernel drivers for particular serial
> > device, serdev-ttyport is no exception here. Make use of the
> > tty_kopen_exclusive() funciton to mark this tty device as kernel
> > internal device.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >   drivers/tty/serdev/serdev-ttyport.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index 3d7ae7fa5018..94c43d25ddbe 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -103,11 +103,14 @@ static int ttyport_write_room(struct serdev_controller *ctrl)
> >   static int ttyport_open(struct serdev_controller *ctrl)
> >   {
> >   	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > +	struct tty_driver *tty_drv = serport->tty_drv;
> >   	struct tty_struct *tty;
> >   	struct ktermios ktermios;
> > +	dev_t dev;
> >   	int ret;
> > -	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> > +	dev = MKDEV(tty_drv->major, tty_drv->minor_start + serport->tty_idx);
> > +	tty = tty_kopen_exclusive(dev);
> 
> I believe that the now added tty_lookup_driver() has negligible impact in
> this anyway slow path, right?

Can you please elaborate a bit more? I don't see how the
tty_lookup_driver() is involved in the serdev-ctrl open path anyway.

Regards,
  Marco
