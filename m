Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E493B71A1;
	Sat, 17 Oct 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223718; cv=none; b=CoKHV+EbzOAsKNeEdoZ/jMmlkuFFEU9NnRUq2doq6BZor64XBpmsaBGG227iQ4a0wI8p/cWfL3svDDFaweMHarQ/zlOasxk14EYaRjTFOLbUJfyYqB86zgWwzhJZdqQ8VeAQ1TfxiCwlMTbcgJIj4fxAEDeehaiNtnuVi7MUqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223718; c=relaxed/simple;
	bh=Tw8hJUhyTwi8lTcx047M6CYvFWd+zJ7pVwCTxqJs4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io8bnB9slXJdqqZVeL7wvatsxlDxtXnTkUAkKZYgYxACp/iDMnaSMbr7s37cv8W9puFh+xzhni3TkIiaMoOHbZ91t2XpibHycaUQepcIRrmSm7HzHMJpbPluqeqj2fGG5qWEXGV0+v1td0OH+EoQDiVGNla7ITaduKsPf4I7oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ko22WGJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ko22WGJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6EB1F000C4;
	Sat, 17 Oct 2026 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792223717;
	bh=mJAFf6584RgZ4z6pPlJH3mmCU2Tv3trUdU3KklbqpMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ko22WGJxPzQMensaPFTS4BAdyEKEMBDuRvRBpGqvs3XCMFFX92qtbsvnPePqOo1+A
	 177+37znf3aI/v03wVmgl2f5BGtAB0+cXmy6ZlkdQkgfqc6QGgxF6kWxEHON/UMSdm
	 fBO4tLGrN06iM/INr6ZZtpKT3AuHyU1vlHR53paA=
Date: Sat, 17 Oct 2026 09:55:14 +0200
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
Message-ID: <2026101715-penny-headfirst-1644@gregkh>
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
> +		pm_runtime_put(&ctrl->dev);

Wait, how can close() ever fail?  That should be something that just
can't happen right?

thanks,

greg k-h
