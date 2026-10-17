Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF41FCFFC;
	Sat, 17 Oct 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223637; cv=none; b=dVV/OQZc3jkoJSTRvzkuBkqonpu2aQ14S2qUOpMx+jNI1qDFgNkBMXqUB6na92Px1FPw+HKfj+cKnZXSdlkBb6oA7jiLBgKcmYWd4l5d/qXL43PxYkK8nWtJ8GJpHztty1q4BYz9o3tAQ2HmxiqBTPRcLiUmSVBN1BAtL2pownc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223637; c=relaxed/simple;
	bh=zlr2BEUFDbhQ4XjmrjsWL9T1nu95OyHippgy/GRORY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O09VmkE09iW5Zy8/uQGlLW8loPtI7GtHJlOCgUN528KHuWNGlBH7EEGMq+iyzGEiyV0h4MVuxAzgEOJpmcopG1+DQgkCUhs3O0phQcfh3PnREGNd1Fyaixdk+E70Pr2dSEDWvwWaQXQQ7XTDluvJV118D+2KkqW+6SfiATKIKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gomFtb2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gomFtb2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE71F000C4;
	Sat, 17 Oct 2026 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792223636;
	bh=A+Rvbj3Y0hrsl690BetdCOZ7NOyL6lYrFiPiwcsUCjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gomFtb2svMy2XJeZq8TKGJOHojmaqIsSID4ozs4DLKblG2lJnhk0mtebgxfikS57f
	 V9Gzvdce9Xw+UoYdJ4OmyEQXezCCviVPSEzX1h42+MpjwGRMbaQgfDjl4cdZWwSqAP
	 h0MdZyMszS7I010sEuMikUfyXG/TSxgVnvM9e3hc=
Date: Sat, 17 Oct 2026 09:53:52 +0200
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
Subject: Re: [PATCH v4 1/4] tty: serdev: Add mutex lock
Message-ID: <2026101758-confidant-comprised-e1c0@gregkh>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
 <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>

On Fri, Oct 16, 2026 at 06:00:32PM +0000, Markus Probst wrote:
> Besides more predictable behaviour, this allows for several hardened
> behaviour changes:
> 
> Return -EALREADY in `serdev_device_open` if the device is already open
> instead of causing undefined behaviour.
> 
> Allow calling `serdev_device_close`, even if the device is already
> closed instead of causing a null pointer dereference.
> 
> If the device is left open by the driver after remove, close it and warn
> instead of leaving it in a invalid state.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/tty/serdev/core.c           | 10 +++++---
>  drivers/tty/serdev/serdev-ttyport.c | 46 +++++++++++++++++++++++++++++++------
>  include/linux/serdev.h              |  2 +-
>  3 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..77e8e1d4d2a6 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *serdev)
>  	struct serdev_controller *ctrl = serdev->ctrl;
>  
>  	device_unregister(&serdev->dev);
> +
> +	/* Warn if driver did not close the serial device. */
> +	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))

I understand the want to give a big "splat" if this happens, but if it
does somehow, you just crashed the box due to panic-on-warn, which will
result in a CVE being given :)

So, if this ever can happen, we should recover like you do:

> +		pm_runtime_put(&ctrl->dev);

And you can warn about it in the kernel log, but just not with WARN_ON()
please.

thanks,

greg k-h
