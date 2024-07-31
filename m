Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2948801;
	Wed, 31 Jul 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421547; cv=none; b=fOYxdW+1HE6iaS/bDJQ3nBd9gWOklmp29/Xip8pec2seeeV1WBEos2YhFC0YV7YlNQjyU7fHptafANgCaiO+42yucJQte61o2GfcYu3lIRqb9/792TNRgiygYy32XL7mfDLm5K8fOOgIpWlj+zCFFdJE94JXCd9wAsP6hK6bIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421547; c=relaxed/simple;
	bh=2h6O1NClaBPnSuuunY0YO6sUq1+WbcmCZpgEFOzJ6cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1BEEH0i/9XdMyw8c7rkQAMsFClXEZDXY66RnYz7SyC/p+qlcpE+HG/4r2f8pbR6bYLrt5xXErBNxY7GnmnksOGaAaFN/Sjd0rwWHT7IcqRIBzy67aD6n3Oqp43ndmXn3/5HXwyOy8zHttDl4MDsNMGKIrfL0w68o1alvAjzUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGVbC9Xm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGVbC9Xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD6C116B1;
	Wed, 31 Jul 2024 10:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722421546;
	bh=2h6O1NClaBPnSuuunY0YO6sUq1+WbcmCZpgEFOzJ6cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGVbC9XmOLTx1O3U6DpdLZZHrH2M78iLy17BA4+9OZkn/7/S5QT1kFt1ldyHKbgC/
	 bsHgE4l2B2uwBBQKz4OEgo0u/BCWPNZGSh9qdMfyr5dOr460NyvJgye2zc4qAHRJa/
	 /X9IuQ97glTB/G+SzTuB9WdExvit5q1vQiB1rilo=
Date: Wed, 31 Jul 2024 12:25:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, stsp <stsp2@yandex.ru>,
	linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <2024073111-probe-endanger-cc8c@gregkh>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
 <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
 <2024072401-obtain-heap-6d8d@gregkh>
 <ZqDdDPF_N9tcbu_S@gondor.apana.org.au>
 <ZqDeTlq-1NP3dne_@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqDeTlq-1NP3dne_@gondor.apana.org.au>

On Wed, Jul 24, 2024 at 06:58:22PM +0800, Herbert Xu wrote:
> On Wed, Jul 24, 2024 at 06:53:00PM +0800, Herbert Xu wrote:
> > On Wed, Jul 24, 2024 at 12:15:39PM +0200, Greg KH wrote:
> > >
> > > -ENOTTY is the documented result of invalid ioctl arguments sent, I am
> > > pretty sure POSIX requires this somewhere.  So this was fixing a
> > > requirement here...
> > 
> > POSIX does not specify this at all:
> > 
> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/ioctl.html
> 
> In fact it says:
> 
> If an underlying device driver detects an error, then ioctl() shall fail if:
> 
> [EINVAL]
> The request or arg argument is not valid for this device.
> 
> [ENOTTY]
> The file associated with the fildes argument is not a STREAMS device that accepts control functions.
> 
> Of course this is all moot since POSIX only specifies ioctl(2)
> for STREAMS devices, but this patch in question is literally
> going against the woring here.

That's going to be going against a lot of existing kernel code then.
-ENOTTY is the default action of almost all ioctl handlers when the
command is not a valid one, sorry.

thanks,

greg k-h
