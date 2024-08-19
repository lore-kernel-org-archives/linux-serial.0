Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB013DBA0
	for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070246; cv=none; b=P3lO5QXjJiCprJR75KV7vMGYyHM5kfqih/C7AnfLuhEsZHromk+j18NY/r64agPo62Xz9lMw1lB6dOmMF3ec3rS4RaitCcbcSAtKdFn02Lfram7qNF7icZkt7QhEpNi3e01lPw3KfJX+uHpIMaEKafI3sA8kvAUG366zGV0Cst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070246; c=relaxed/simple;
	bh=+qDm8HDJdayoSzro18P+BYhjs7g35mRixzpMF3a79hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfkTMcEM6VO03u625dg5vjZmHlbTbSb8jmffjVN7CvqWxPJWMCjYt7sC49ye0netGEJILPK16g8/avZqLDauS+ZZ2/c6nKEZ1LwLNZww5Df6Wivm/isD/JmadMvuHAUn1cQbtKpBFJgX3AfNrXvSjG7v1F0YDPCoaDFZDlNhwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sg1QS-000087-Lo; Mon, 19 Aug 2024 14:23:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sg1QS-001Ww0-41; Mon, 19 Aug 2024 14:23:56 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sg1QS-00BmDv-02;
	Mon, 19 Aug 2024 14:23:56 +0200
Date: Mon, 19 Aug 2024 14:23:56 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
Message-ID: <20240819122356.rh2f6ldpauvxhgui@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20240807-v6-10-topic-usb-serial-serdev-v1-1-ed2cc5da591f@pengutronix.de>
 <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
 <20240819101946.cf7x7xecdn2pfa4t@pengutronix.de>
 <dc936358-a718-4f1c-a2a6-695bbae1d2ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc936358-a718-4f1c-a2a6-695bbae1d2ec@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 24-08-19, Jiri Slaby wrote:
> On 19. 08. 24, 12:19, Marco Felsch wrote:
> > Hi,
> > 
> > sorry for not replying earlier.
> > 
> > On 24-08-08, Jiri Slaby wrote:
> > > On 07. 08. 24, 16:08, Marco Felsch wrote:
> > > > The purpose of serdev is to provide kernel drivers for particular serial
> > > > device, serdev-ttyport is no exception here. Make use of the
> > > > tty_kopen_exclusive() funciton to mark this tty device as kernel
> > > > internal device.
> > > > 
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >    drivers/tty/serdev/serdev-ttyport.c | 9 ++++++---
> > > >    1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > > > index 3d7ae7fa5018..94c43d25ddbe 100644
> > > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > > @@ -103,11 +103,14 @@ static int ttyport_write_room(struct serdev_controller *ctrl)
> > > >    static int ttyport_open(struct serdev_controller *ctrl)
> > > >    {
> > > >    	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > > > +	struct tty_driver *tty_drv = serport->tty_drv;
> > > >    	struct tty_struct *tty;
> > > >    	struct ktermios ktermios;
> > > > +	dev_t dev;
> > > >    	int ret;
> > > > -	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> > > > +	dev = MKDEV(tty_drv->major, tty_drv->minor_start + serport->tty_idx);
> > > > +	tty = tty_kopen_exclusive(dev);
> > > 
> > > I believe that the now added tty_lookup_driver() has negligible impact in
> > > this anyway slow path, right?
> > 
> > Can you please elaborate a bit more? I don't see how the
> > tty_lookup_driver() is involved in the serdev-ctrl open path anyway.
> 
> It's called now in of tty_kopen_exclusive()->tty_kopen().
> (tty_lookup_driver() is the major difference between the raw tty_init_dev()
> and tty_kopen_exclusive().)

Okay now I get the "now added tty_lookup_driver()" statement, sorry.
Yes, I believe that this is negligible. The main difference for me was
that the tty_port_set_kopened() is set accordingly which which is
important to not trigger warnings during the release path.

Regards,
  Marco

> 
> -- 
> js
> suse labs
> 
> 
