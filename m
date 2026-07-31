Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7D2DC32C;
	Fri, 31 Jul 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504183; cv=none; b=afEvDdnfWqUKrRm9vCEzH5U4Axra/gQZb/bDwL2gDPoqDYCVN1Vca07ArZtUGEukTHVh5/2i5Zl1fivo0MHeraTz+Qt+Y7JTZhyGREnuuJSB9GhxPvxOkFbvgW714wvF1sI8cdrVsiFIqSVA63KQS3+SDMUVwkPtRtlITKWCFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504183; c=relaxed/simple;
	bh=lttGdRcdtsr1Ye79AEZUBF4rHbLXZNk7nNHM982i0cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQb1J4bGVPFHKJ5GEXsbHh9PNqa9S0rvEWTvpKrUCkTaR43s4iKuTzsur+56j+8ePnrRXU9bB4+ssZeQgVocv473543kxMtl9QGc+IRErcM/i4TzBUqz4H8y542JWCFgjwMukjk7Oj7hP7825vsCTk1ugBioF4ONI61cnan0FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yo2GIs0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yo2GIs0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67E1F000E9;
	Fri, 31 Jul 2026 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785504182;
	bh=djmvzhkuCHisV7ATbKjuLGiE9H8+1kpsSbKwMLrGQCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yo2GIs0vChsdEFLbh7dfjUk8LwK2CzyIXBEDukqgo1Dgl5zwUPlIdEQNaq5Bae/iF
	 LRBbrlw/hACK7vd7ZtokWwNYF4mNG06gq+Wo18+MOOpULMxtge5vNYKgF6XCY0CrDH
	 01ZWDd9Jf/v9bt+LHcrn4kbQdRFDcYgjqLO62TBg=
Date: Fri, 31 Jul 2026 15:22:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] serdev: use tty_port_tty_get() in
 ttyport_write_buf() to prevent UAF
Message-ID: <2026073144-sputter-gusto-c640@gregkh>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
 <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
 <11b34a60b7f66379e66f4cff779acdccd3fd0c8d.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b34a60b7f66379e66f4cff779acdccd3fd0c8d.camel@posteo.de>

On Fri, Jul 31, 2026 at 01:00:30PM +0000, Markus Probst wrote:
> On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > ttyport_write_buf() snapshots serport->tty as a raw pointer without
> > taking a reference, while ttyport_close() can concurrently release the
> > tty via tty_release_struct(), leading to a use-after-free. Use
> > tty_port_tty_get() to obtain a reference-counted tty pointer, matching
> > the pattern already used by ttyport_write_wakeup().
> > 
> > Assisted-by: AISLE:Snapshot
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index 48ce5b3f8308..4d37c8130dd7 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -85,13 +85,21 @@ static const struct tty_port_client_operations client_ops = {
> >  static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u8 *data, size_t len)
> >  {
> >  	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > -	struct tty_struct *tty = serport->tty;
> > +	struct tty_struct *tty;
> > +	ssize_t ret;
> >  
> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >  		return 0;
> >  
> > +	tty = tty_port_tty_get(serport->port);
> > +	if (!tty)
> > +		return 0;
> > +
> >  	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> > -	return tty->ops->write(serport->tty, data, len);
> > +	ret = tty->ops->write(tty, data, len);
> > +	tty_kref_put(tty);
> > +
> > +	return ret;
> >  }
> >  
> >  static void ttyport_write_flush(struct serdev_controller *ctrl)
> 
> It should be the responsibility of the driver to ensure
> `serdev_device_close` and `serdev_device_write_buf` are not called
> concurrently.
> 
> This also applies to
> - serdev_device_set_baudrate

Doesn't touch a tty structure, so why is the same reference count logic
needed here?

> - serdev_device_set_flow_control

Same here.

> - serdev_device_wait_until_sent

Or here?

> and more, which currently iirc even introduce a null pointer
> dereference if called with the serdev device closed.
> 
> I don't see why `serdev_device_write_buf` needs special protection
> here, which the other functions don't need for some reason.

It's the access to the tty pointer that I think the issue is, right?

> As with the previous patch, this still makes sense for hardening.
> With scope_guard being used,
> 
> Reviewed-by: Markus Probst <markus.probst@posteo.de>

Great, thanks, I'll send out a v2 next week with that change made, as
I've done it locally and will wait a bit.

thanks,

greg k-h
