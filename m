Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE1253340;
	Fri, 31 Jul 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486517; cv=none; b=qR/HthdbMq/TcM4Sibx+8zlafDaGfpZ9tHt5XMupOfnCBYbch2q66K9glWlt7zyVhwKP8kuAPQV48chnFALIi+9YNSKEubvX8ZTyMwl7E9nJEaY5jzVmgKv9Eho5c/29BUg2UH4vI6+NPM1bAsJKlItIXqCJHjH/c+w6NN7RGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486517; c=relaxed/simple;
	bh=rHAWX+QSHMAFDUyI19EU53mZcTLdsFUVbBf3N4hX9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2YzalAn5bASHRmOZ6BmKqEXdVYQ+CHN+o77NwPWZ/V/R9JkMBo7ikSSwk6WFdOoKPe55fPluniKFwuKkpyt2afx12UQlrcNOmIcaZbuzNqbjQBTH6YHcEVseMb1wkWtPt4iGtYM1cepkeaRAhS8hCMe2xDXFHIbIj9bBz4zOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvOlp29u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvOlp29u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEC41F00A3A;
	Fri, 31 Jul 2026 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785486516;
	bh=8GDTRfAP7dRgN9+1b/AB2a68zvYVBgQcHw0U9xaHWwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vvOlp29uHZIUZ1trLTC6hJxHXDNqxuAekYKQTGuxIw7lCmE5isQzTf2mFXFOhRmYc
	 hlzkoEilTe2QDKE2t69ERfxpQ9DU/s6+xDaUdzTVNC33Thn4c8VnjncW0MmfPhhud1
	 XADXlD8/9pIsIXG53IQBuZ3yddLvQ/hpEo/4Oya4=
Date: Fri, 31 Jul 2026 10:28:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>, linux-serial@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	Joshua Rogers <linux@joshua.hu>, stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] serdev: use tty_port_tty_get() in
 ttyport_write_buf() to prevent UAF
Message-ID: <2026073132-nucleus-retying-680c@gregkh>
References: <20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
 <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
 <d6d96f15-03f5-4213-9d7c-145b5a8c3f79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d96f15-03f5-4213-9d7c-145b5a8c3f79@kernel.org>

On Fri, Jul 31, 2026 at 10:24:02AM +0200, Jiri Slaby wrote:
> On 31. 07. 26, 10:06, Greg Kroah-Hartman wrote:
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
> >   drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > index 48ce5b3f8308..4d37c8130dd7 100644
> > --- a/drivers/tty/serdev/serdev-ttyport.c
> > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > @@ -85,13 +85,21 @@ static const struct tty_port_client_operations client_ops = {
> >   static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u8 *data, size_t len)
> >   {
> >   	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > -	struct tty_struct *tty = serport->tty;
> > +	struct tty_struct *tty;
> > +	ssize_t ret;
> >   	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >   		return 0;
> > +	tty = tty_port_tty_get(serport->port);
> > +	if (!tty)
> > +		return 0;
> > +
> >   	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> > -	return tty->ops->write(serport->tty, data, len);
> > +	ret = tty->ops->write(tty, data, len);
> > +	tty_kref_put(tty);
> 
> Here,
> 
>   scope_guard(tty_port_tty, serport->port) {
>     struct tty_struct *tty = scoped_tty();
> 
>     set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>     return tty->ops->write(serport->tty, data, len);
>   }
> 
>   return 0;
> 
> appears to be cleaner.

Yes, much cleaner.  LLMs really don't know about "modern" kernel coding
styles (they always use min_t() and don't like guard() code).

I'll respin this and do a new version in a few days, thanks.

greg k-h
