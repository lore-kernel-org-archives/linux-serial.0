Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD747D452;
	Wed, 23 Sep 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156779; cv=none; b=AUVEd6ujPtkOX7TN6RcyWYkwSpS6Llj9eXPlM8yloF4/jos8dMPgCPX92hlFghKsgmErD0bBPVX630F2cnmbv17/D/EavAVg0JRLIB2WN4NdtV78+CsOnNVHD3FXt1vm4TSELI2+LH+7jMxPYJ1np7ZDY6Y+TQ33EiPWP2gLtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156779; c=relaxed/simple;
	bh=LJTIqZsPEUPlVXOK/rHFv13b58M63O91P2MXJ9CatjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KINwek+d0d3woyCgQP2spbHLeTLQNCYkjS5odw0N1TrQ/QBVIg6Riye+auiRD44p4Q41n1xAMbFtxs1C+vWjYsqADU5/vYHVmf7CV9YW9Rf8bhPHMPLYdOXWbf6wvIt2pdUEM7LYPljH/9iNh8MO+K0LHiYxMpr9S5nrHmIMRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjoZ6+QN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjoZ6+QN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68C31F000FF;
	Wed, 23 Sep 2026 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790156777;
	bh=XK6Xdxe15IdLMTyDt3yGKI1mP52p4jn9ANXRWki1w7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XjoZ6+QN1MuJCm3EaTj+jpluqceF+/0gqvTaQRYJtEwE8f9EBF+Ppu9e8AzDQU3eC
	 hO1pL6hywB4bvEeRk+ZgLceffms3gvNvKjyN2NNxL5I3cMBXSCPhOc3/td1xwkN21Q
	 D/7I2lIIoxHqjTKgqIHy5mDY0vLPJXmrLGVcWh+M=
Date: Wed, 23 Sep 2026 11:42:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: Re: [PATCH] tty: rpmsg: close port lookup-to-get race
Message-ID: <2026092327-stew-margin-1e89@gregkh>
References: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com>
 <2026092154-anger-sensually-aae8@gregkh>
 <20260923001647.1337001-1-csh0052@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923001647.1337001-1-csh0052@gmail.com>

On Wed, Sep 23, 2026 at 12:17:41AM +0900, Sang-Hoon Choi wrote:
> rpmsg_tty_install() obtains cport from tty_idr before taking a port
> reference. rpmsg_tty_destruct_port() removes the entry under idr_lock
> and frees cport. If channel removal drops the last reference between
> idr_find() and tty_port_get(), the install path dereferences freed
> memory.
> 
> The first-open path and channel removal can run concurrently.

How?  What causes channel removel?

> tty_mutex
> serializes TTY initialization, but rpmsg_tty_remove() does not take that
> mutex. tty_unregister_device() prevents later opens through cdev_del(),
> but cdev_del() does not wait for an open which has already entered the
> driver. Before rpmsg_tty_install() finishes, the port is not attached to
> the new TTY, so tty_port_tty_hangup() does not close this interval.
> 
> RPMsg channel removal may be initiated asynchronously by the remote
> processor or transport. In the test, the local process only needs
> permission to open the TTY node; channel removal is initiated
> independently.
> 
> I reproduced this with a UML kernel built with KASAN and a synthetic
> RPMsg device using the real rpmsg_tty probe and remove paths. Test-only
> synchronization forces removal after idr_find() and before
> tty_port_get(). The opening process drops to UID 1000 and GID 1000 first.
> The unpatched kernel reports:
> 
>   BUG: KASAN: slab-use-after-free in rpmsg_tty_install
>   Read of size 4 ... by task init/23
>   CPU: 0 UID: 1000 PID: 23
> 
> The allocation stack ends in rpmsg_tty_probe(). The free stack is
> rpmsg_tty_remove() -> tty_port_put() -> rpmsg_tty_destruct_port(), and
> the invalid read is in rpmsg_tty_install().
> 
> Take idr_lock across idr_find() and tty_port_get(). If the entry is gone
> or its reference count has reached zero, fail the installation with
> -ENODEV. With the same forced overlap, the UID 1000 open returns ENODEV
> and KASAN stays quiet.
> 
> The test uses a synthetic transport and deliberately widens the race
> window. It demonstrates the lifetime bug and an unprivileged opener, but
> does not show that an unprivileged user can deliberately cause channel
> removal on every RPMsg platform. I am therefore reporting this as a
> normal lifetime bug.
> 
> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Link: https://lore.kernel.org/all/179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Greg, thanks for the feedback. I went back and reproduced the race under
> KASAN before preparing this patch. I can also provide the test-only
> instrumentation and the complete KASAN log if useful.
> 
>  drivers/tty/rpmsg_tty.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> index c5fd6d9b3..b2765bae2 100644
> --- a/drivers/tty/rpmsg_tty.c
> +++ b/drivers/tty/rpmsg_tty.c
> @@ -49,12 +49,19 @@ static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len, void *p
>  
>  static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>  {
> -	struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> -	struct tty_port *port;
> +	struct rpmsg_tty_port *cport;
> +	struct tty_port *port = NULL;
>  
> -	tty->driver_data = cport;
> +	mutex_lock(&idr_lock);

guard()?

And if this is a "real" issue, that can affect things, why not use the
built-in locking that idr has to resolve this issue in a much faster way
than this mutex?

thanks,

greg k-h
