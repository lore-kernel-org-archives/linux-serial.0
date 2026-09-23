Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7353B14AB;
	Wed, 23 Sep 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173718; cv=none; b=MLC3RdxL4kqB7SwGd/QtwHVqbMBdUL6OxDI7lKDvvS5KcodG7E3dXRb5x59MIex+okYeabYNFk4a7gM90FclEOzQBLfak5MgNsRFa26wtM2ZOY54fKSWzw7MTrXiWT4OSQB1Oy19Hqt9bnZbicJ+lBWi6wPKnTM+QRQyGBgks6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173718; c=relaxed/simple;
	bh=XSERXU2ZdNZYUopBn50o2i3OZ219cAqBQhhbjm3F8e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzzqpFa3SIyNMA0jg2l3AeA1TOlu7ihrYaNTTWr7f3c4OXiPH9mOp2g6R/BGbLOfU1CB7cN06SJDawVP6TIkfJss5qx3JW95nRruJVPwiKX04Nlx6fHbukWfrJxiWchJnn0LGa0q9U3q63BkYo3kU/jxaEsGaBiCarrKE3yE4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fntGoFcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fntGoFcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653BC1F000FF;
	Wed, 23 Sep 2026 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790173716;
	bh=83/PBegOGy52s6j5W1iw8J1pOtvUqqXH+Cg7DByM+jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fntGoFcc2GkbEDmzEVk6q3fFj8+o3DOS/c5Uo+rT0Qj1FEcUgiJ9yQ15PNaPGKpIL
	 gdmdWIoZQ0LIv3ftOTKmXxbv3UwX9yH7OIbmP8q7Qkf0WPuedlvO7z9lfyEJXpl+kX
	 l5nNyLDf5T6BDI7lmrt6ND5Z8chIuuMWWeRS+zdg=
Date: Wed, 23 Sep 2026 16:26:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
Message-ID: <2026092327-tinwork-native-7a87@gregkh>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
 <2026092356-chatting-dust-3de9@gregkh>
 <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>

On Wed, Sep 23, 2026 at 01:31:49PM +0000, Markus Probst wrote:
> On Wed, 2026-09-23 at 12:35 +0200, Greg Kroah-Hartman wrote:
> > On Sun, Sep 20, 2026 at 02:29:58PM +0000, Markus Probst wrote:
> > > These functions will be used to simply the serdev rust abstraction. It
> > > also contributes to the fixing of 2 race conditions in the serdev rust
> > > abstraction.
> > > 
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  drivers/tty/serdev/core.c           | 50 ++++++++++++++++++++++++++++++++++++-
> > >  drivers/tty/serdev/serdev-ttyport.c | 38 ++++++++++++++++++++++++++++
> > >  include/linux/serdev.h              |  6 +++++
> > >  3 files changed, 93 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > > index 7500efcdfc21..7d24f16710cb 100644
> > > --- a/drivers/tty/serdev/core.c
> > > +++ b/drivers/tty/serdev/core.c
> > > @@ -187,6 +187,51 @@ void serdev_device_close(struct serdev_device *serdev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(serdev_device_close);
> > >  
> > > +/**
> > > + * serdev_device_pause_rx() - pause data receive
> > > + * @serdev:	serdev device
> > > + *
> > > + * Pause calls to receive_buf.
> > > + *
> > > + * The caller must guarantee that this does not run concurrently with
> > > + * `serdev_device_open` or `serdev_device_close`.
> > > + *
> > > + * Note that if a call to receive_buf is currently executed, the function will
> > > + * sleep until it has finished.
> > > + */
> > > +void serdev_device_pause_rx(struct serdev_device *serdev)
> > > +{
> > > +	struct serdev_controller *ctrl = serdev->ctrl;
> > > +
> > > +	if (!ctrl || !ctrl->ops->pause_rx)
> > > +		return;
> > > +
> > > +	ctrl->ops->pause_rx(ctrl);
> > > +}
> > > +EXPORT_SYMBOL_GPL(serdev_device_pause_rx);
> > > +
> > > +/**
> > > + * serdev_device_resume_rx() - resume data receive
> > > + * @serdev:	serdev device
> > > + *
> > > + * Resume calls to receive_buf.
> > > + *
> > > + * The caller must guarantee that this does not run concurrently with
> > > + * `serdev_device_open` or `serdev_device_close`.
> > > + *
> > > + * This can be called even if not paused to ensure data receive is active.
> > > + */
> > > +void serdev_device_resume_rx(struct serdev_device *serdev)
> > > +{
> > > +	struct serdev_controller *ctrl = serdev->ctrl;
> > > +
> > > +	if (!ctrl || !ctrl->ops->resume_rx)
> > > +		return;
> > > +
> > > +	ctrl->ops->resume_rx(ctrl);
> > > +}
> > > +EXPORT_SYMBOL_GPL(serdev_device_resume_rx);
> > > +
> > >  static void devm_serdev_device_close(void *serdev)
> > >  {
> > >  	serdev_device_close(serdev);
> > > @@ -398,6 +443,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
> > >  static int serdev_drv_probe(struct device *dev)
> > >  {
> > >  	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> > > +	struct serdev_device *sdev = to_serdev_device(dev);
> > >  	int ret;
> > >  
> > >  	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> > > @@ -405,7 +451,9 @@ static int serdev_drv_probe(struct device *dev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	return sdrv->probe(to_serdev_device(dev));
> > > +	serdev_device_resume_rx(sdev);
> > > +
> > > +	return sdrv->probe(sdev);
> > >  }
> > >  
> > >  static void serdev_drv_remove(struct device *dev)
> > > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> > > index bab1b143b8a6..e8aa89e733bd 100644
> > > --- a/drivers/tty/serdev/serdev-ttyport.c
> > > +++ b/drivers/tty/serdev/serdev-ttyport.c
> > > @@ -7,8 +7,10 @@
> > >  #include <linux/tty.h>
> > >  #include <linux/tty_driver.h>
> > >  #include <linux/poll.h>
> > > +#include "../tty.h"
> > >  
> > >  #define SERPORT_ACTIVE		1
> > > +#define SERPORT_PAUSE_RX	2
> > >  
> > >  struct serport {
> > >  	struct tty_port *port;
> > > @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
> > >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> > >  		return 0;
> > >  
> > > +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Ensure writes by the driver are visible before allowing traffic to resume.
> > > +	 */
> > > +	smp_mb__after_atomic();
> > 
> > This scares me.  Why not use a real lock? 
> > 
> I can use locks to make it less "fragile". But I don't I think I need
> them.

Always use them first, and then remove and do "tricky" things if you
really can measure the need and can prove that they are not needed.

> > WHat's the issue here, you
> > need this to be "flushed" before this call:
> > 
> > > +
> > >  	ret = serdev_controller_receive_buf(ctrl, cp, count);
> > 
> > here?
> > 
> > And you just tested a bit, you didn't set a bit, so what are you trying
> > to ensure is written exactly?
> This should be an acquire load operation (paired with the release store
> operation in `ttyport_resume_rx`).

Where is the load?  This feels wrong.

> It ensures that any writes before calling `ttyport_resume_rx` are
> visible in the `serdev_controller_receive_buf` invocation.

writes from where?  There wasn't a write before this that I can see in
the diff, hence my confusion.

> For instance, in the Rust abstraction the following will be called in
> order in probe (with the following patches):
> 
> - serdev_device_pause_rx
> - serdev_device_open
> - dev_set_drvdata
> - serdev_device_resume_rx
> 
> This atomic lock effectively ensures in this example that the set
> device driver data is visible to `ttyport_receive_buf` before
> `SERPORT_PAUSE_RX` is unset in `ttyport_resume_rx`.

This feels rough.  In talking with others today, serdev really should be
reworked to be a "real" bus here, which should solve these issues,
right?  Perhaps that's the better idea overall instead of these fragile
links?  That might also solve the other issues with serdev where people
want to use it for dynamic devices (i.e. USB devices).

Thoughts?

> > >  	dev_WARN_ONCE(&ctrl->dev, ret > count,
> > > @@ -156,6 +166,32 @@ static void ttyport_close(struct serdev_controller *ctrl)
> > >  	tty_release_struct(tty, serport->tty_idx);
> > >  }
> > >  
> > > +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> > > +{
> > > +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> > > +	struct tty_struct *tty = serport->tty;
> > > +
> > > +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> > > +
> > > +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> > 
> > What keeps this bit from being set right after you test it?
> The statement "The caller must guarantee that this does not run
> concurrently with `serdev_device_open` or `serdev_device_close`." in
> the kdoc of `serdev_device_pause_rx` does.

Oh that's going to be impossible to keep working :)

thanks,

greg k-h
