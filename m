Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64148EC91;
	Wed, 23 Sep 2026 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159761; cv=none; b=TSyLTjjSDoSMs0lUcZeQW4mD9qZeZtQ8UALnrTqbuirjJbb4izvbHwkg3ED/1Ma9wJ9wKubTwC5Z4xEwnhXeQA0kIdVfWekJ2sxbASuB8EzS60Q3BkQDKe9sAUviUWvcXvN4UdEcN9OIc2ekRN+VEmgNTX575AxWQuPTgkV9ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159761; c=relaxed/simple;
	bh=eZIHb0J5aaBGeIdNifmxvKv3Vw/+/WIteprI/Fa0klk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtKcoBkQ563Q3stbd+KEFvBsYon4anBPGJBj+YDWcBi7W2X3D+JCVA+xKpYBy1/qEZTamzGivHHSQqaZXeVZi64YR7DIN8l6XbGLp4Uk9K5MMdU7H36D+pkLVY+z934EcbkwA7JUU+3UnCJWP0CdQdOA7phzBmzWsppdIWeJnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wmuSkB+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmuSkB+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB881F000FF;
	Wed, 23 Sep 2026 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159742;
	bh=NzYqyRImwYBZyIwILNRFj1XIoNhIukvodGkX+t4dqx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wmuSkB+NF6zhenRzL6ZxseHK0xfUQm55nueP399xmc5vKVdJ4+9GFCzKp1UAo4UjD
	 Rc1EHV8hSgTinHbN7TTeJ/LV/+k6ng1H2i0JVVFTZlozSje8HiceldUJe8+jcscTuI
	 bvrLRp2yk/fFaK5fl5XxDZb48OSB5+hqRVLuprFE=
Date: Wed, 23 Sep 2026 12:35:38 +0200
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
Message-ID: <2026092356-chatting-dust-3de9@gregkh>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>

On Sun, Sep 20, 2026 at 02:29:58PM +0000, Markus Probst wrote:
> These functions will be used to simply the serdev rust abstraction. It
> also contributes to the fixing of 2 race conditions in the serdev rust
> abstraction.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/tty/serdev/core.c           | 50 ++++++++++++++++++++++++++++++++++++-
>  drivers/tty/serdev/serdev-ttyport.c | 38 ++++++++++++++++++++++++++++
>  include/linux/serdev.h              |  6 +++++
>  3 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..7d24f16710cb 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -187,6 +187,51 @@ void serdev_device_close(struct serdev_device *serdev)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_close);
>  
> +/**
> + * serdev_device_pause_rx() - pause data receive
> + * @serdev:	serdev device
> + *
> + * Pause calls to receive_buf.
> + *
> + * The caller must guarantee that this does not run concurrently with
> + * `serdev_device_open` or `serdev_device_close`.
> + *
> + * Note that if a call to receive_buf is currently executed, the function will
> + * sleep until it has finished.
> + */
> +void serdev_device_pause_rx(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->pause_rx)
> +		return;
> +
> +	ctrl->ops->pause_rx(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_pause_rx);
> +
> +/**
> + * serdev_device_resume_rx() - resume data receive
> + * @serdev:	serdev device
> + *
> + * Resume calls to receive_buf.
> + *
> + * The caller must guarantee that this does not run concurrently with
> + * `serdev_device_open` or `serdev_device_close`.
> + *
> + * This can be called even if not paused to ensure data receive is active.
> + */
> +void serdev_device_resume_rx(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->resume_rx)
> +		return;
> +
> +	ctrl->ops->resume_rx(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_resume_rx);
> +
>  static void devm_serdev_device_close(void *serdev)
>  {
>  	serdev_device_close(serdev);
> @@ -398,6 +443,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
>  static int serdev_drv_probe(struct device *dev)
>  {
>  	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> +	struct serdev_device *sdev = to_serdev_device(dev);
>  	int ret;
>  
>  	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> @@ -405,7 +451,9 @@ static int serdev_drv_probe(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	return sdrv->probe(to_serdev_device(dev));
> +	serdev_device_resume_rx(sdev);
> +
> +	return sdrv->probe(sdev);
>  }
>  
>  static void serdev_drv_remove(struct device *dev)
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index bab1b143b8a6..e8aa89e733bd 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -7,8 +7,10 @@
>  #include <linux/tty.h>
>  #include <linux/tty_driver.h>
>  #include <linux/poll.h>
> +#include "../tty.h"
>  
>  #define SERPORT_ACTIVE		1
> +#define SERPORT_PAUSE_RX	2
>  
>  struct serport {
>  	struct tty_port *port;
> @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
>  
> +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> +		return 0;
> +
> +	/*
> +	 * Ensure writes by the driver are visible before allowing traffic to resume.
> +	 */
> +	smp_mb__after_atomic();

This scares me.  Why not use a real lock?  WHat's the issue here, you
need this to be "flushed" before this call:

> +
>  	ret = serdev_controller_receive_buf(ctrl, cp, count);

here?

And you just tested a bit, you didn't set a bit, so what are you trying
to ensure is written exactly?


>  
>  	dev_WARN_ONCE(&ctrl->dev, ret > count,
> @@ -156,6 +166,32 @@ static void ttyport_close(struct serdev_controller *ctrl)
>  	tty_release_struct(tty, serport->tty_idx);
>  }
>  
> +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +
> +	set_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))

What keeps this bit from being set right after you test it?



> +		tty_buffer_flush_work(tty->port);
> +}
> +
> +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +
> +	/*
> +	 * Ensure writes by the driver are visible before allowing traffic to resume.
> +	 */
> +	smp_mb__before_atomic();
> +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))

Same here.  Are you sure you don't need locks?  This feels wrong.

thanks,

greg k-h
