Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167383F9F28;
	Fri, 31 Jul 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499288; cv=none; b=Rk7XAacFPtNjQu5JhNPf5v6NhPzL7HmX1F5pnr505uWZtzsSxwEKlwnkT9HaZ5KTnxV6Z8z2RY/N7hT4ccLeB5TmRlxcmtMZnsHdivfA8cpfleutQyZaqYzybEeNj2XSUZCB6c38D4BszhgAzlBBjRxhccmawH0DC7XGKSSJ1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499288; c=relaxed/simple;
	bh=q7Nwj2aqA1CPK5wZI3J4qfBJ6tRAmfN3I4QKv/spCsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu2g10tLApFcveh8zOAC/oCzIBHuwSwKmtaiy0hEADzimR8XsrWHOu+KhoguAR3CH2jL2idivQ8L2sI3PkFaCAz3QKvaatHyYkBG11YihHzbQ2AtfleEVlQhVNLM2H/HQzKrApH0+2uwy2jN2EmnKMN9ld/UaoOe7AkaO/WfL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJyIuGQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJyIuGQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF51F000E9;
	Fri, 31 Jul 2026 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785499286;
	bh=sPNrFcTbyXHy/7oFSQzFLnaMalbJv2BvznK68sZekBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJyIuGQdb+MYYCYY0rA5YF1vzzXryrrT+zg56ZDOOGfzUI6EfW3dSwh2nW9URTpZt
	 kmVlpQR7g7oyd52qDM25kGt44gigod8ACPQl4Ug7vKNARkSPUn8v1csk4eSbaRhXeR
	 4aqQTf/6SxHSP0zwpdP1GllLhKALw82jVwbBx8Pg=
Date: Fri, 31 Jul 2026 14:01:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
Subject: Re: [PATCH 1/2] serdev: fix race between tty-port unregister and
 in-flight callbacks
Message-ID: <2026073118-handwash-vitality-5f3f@gregkh>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
 <20260731-aisle-tty-serdev-v1-1-2401a3189327@linuxfoundation.org>
 <edd75d5a4362e5c8e7b691f65768d1fedc30309a.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd75d5a4362e5c8e7b691f65768d1fedc30309a.camel@posteo.de>

On Fri, Jul 31, 2026 at 11:30:53AM +0000, Markus Probst wrote:
> On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > serdev_tty_port_unregister() clears port->client_data and frees the
> > controller without synchronizing with in-flight flip buffer work.
> > This can cause NULL pointer dereferences or use-after-free if
> > ttyport_receive_buf() or ttyport_write_wakeup() runs concurrently.
> > 
> > Add cancel_work_sync() to drain pending buffer work before clearing
> > state, and add NULL checks for client_data in both callbacks as
> > secondary hardening.
> > 
> > Assisted-by: AISLE:Snapshot
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index bab1b143b8a6..48ce5b3f8308 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -26,9 +26,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
> >  				  const u8 *fp, size_t count)
> >  {
> >  	struct serdev_controller *ctrl = port->client_data;
> > -	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > +	struct serport *serport;
> >  	size_t ret;
> >  
> > +	if (!ctrl)
> > +		return 0;
> > +
> > +	serport = serdev_controller_get_drvdata(ctrl);
> > +
> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >  		return 0;
> >  
> > @@ -46,9 +51,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
> >  static void ttyport_write_wakeup(struct tty_port *port)
> >  {
> >  	struct serdev_controller *ctrl = port->client_data;
> > -	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > +	struct serport *serport;
> >  	struct tty_struct *tty;
> >  
> > +	if (!ctrl)
> > +		return;
> > +
> > +	serport = serdev_controller_get_drvdata(ctrl);
> > +
> >  	tty = tty_port_tty_get(port);
> >  	if (!tty)
> >  		return;
> > @@ -312,6 +322,7 @@ int serdev_tty_port_unregister(struct tty_port *port)
> >  		return -ENODEV;
> >  
> >  	serdev_controller_remove(ctrl);
> > +	cancel_work_sync(&port->buf.work);
> >  	port->client_data = NULL;
> >  	port->client_ops = &tty_port_default_client_ops;
> >  	serdev_controller_put(ctrl);
> 
> So why exactly does tty keep calling `receive_buf` and `write_wakeup`
> with the tty port closed?
> 
> After `serdev_controller_remove` is called, the tty port should already
> be closed by the drivers.

Are you sure?  remove can be called by a device removal, while close
might be coming from a different code path (like it is in userspace.)

If this is impossible, as close will ALWAYS happen before remove, then
it's not an issue, but that is probably not the case, right?

thanks,

greg k-h
