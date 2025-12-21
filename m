Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D42B9A4;
	Sun, 21 Dec 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766335616; cv=none; b=te2KXZfviIIqw5PwnGXlXmCKhPfZ6/usfsLhf1ZSrZdBIarKFQc7N5kZxntMV7AL8/24Wyv4YRrLnV3lRI8+/BmtVB3FBh19EwqPp096uRRk/Rm3LT1AZH++hm1jgmif1XP3dwwvFLYMhJD1mY+PzcSAGfh2ts+sYQO2O8RQbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766335616; c=relaxed/simple;
	bh=s0ebzDnyKZE8Dk0Nbz6OL0CNg0zWcdXLCS5nOsn/rCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5x6OLgRpx+b5zTCIxlJG/BIua/9FQlqdm4ZN6L3/k0/sEifZ7BkdxB1MpfUSPqnQ23YQ2z22YRZoYTeBzIE+f6bUG+b5tyUEqJOroX3FuQNb6jxpGSpAjWSZjUL+wk7zyx3qipbMQDIpIFnMizPPvlnQDeONxccjhM+oGB/H2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePbJhc3o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePbJhc3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBC9C4CEFB;
	Sun, 21 Dec 2025 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766335616;
	bh=s0ebzDnyKZE8Dk0Nbz6OL0CNg0zWcdXLCS5nOsn/rCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePbJhc3oWcGS5dNfVVC4wuOE+T1FVv0nJGv6D3K6lWo3gJnBK1zWshUOfwkDHG0Fc
	 LON4WR+nvqFGfz3lqvKJWwXxDGtfRgdgWj2O0WYcydGTV3euldrszyv8pOYLBuVT6y
	 bv/IfHc9e00zvBSLr9sWnvsWaDUmOkS4W9/S289A=
Date: Sun, 21 Dec 2025 17:46:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kari Argillander <kari.argillander@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
Message-ID: <2025122145-from-monetize-28e2@gregkh>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
 <2025122138-saucy-unexpired-0b98@gregkh>
 <4b55501e500edb8416ed690757f72752f1c49517.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b55501e500edb8416ed690757f72752f1c49517.camel@posteo.de>

On Sun, Dec 21, 2025 at 04:28:11PM +0000, Markus Probst wrote:
> On Sun, 2025-12-21 at 17:10 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Dec 20, 2025 at 06:44:05PM +0000, Markus Probst wrote:
> > > From: Kari Argillander <kari.argillander@gmail.com>
> > > 
> > > The serdev core has an internal is_serdev_device() helper, but it was
> > > not accessible to drivers. Make it public by declaring it in serdev.h
> > > and exporting the symbol so that modular serdev drivers can rely on it
> > > instead of duplicating type checks.
> > > 
> > > This allows example future Rust serdev abstraction to have
> > > 
> > >     TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>
> > 
> > But why is that going to be needed?
> > 
> > > That way using bus is easy for other substystems. Also some other
> > > subsystems expose similar function:
> > > 
> > >   - bool is_usb_device(const struct device *dev)
> > >   - bool dev_is_pci(const struct device *dev)
> > 
> > Yes, and usually that's not a good idea, unless you have a bus with
> > multiple types of devices on it.  I don't think serdev has that, does
> > it?
> > 
> > Only under special circumstances should this be required, so I'm curious
> > as to why you would ever have a pointer to a struct device and not
> > "know" that it is of this type?  Who is passing that to you?
> For example, the pwm rust abstraction currently only provides a
> `device::Device<device::Bound>` reference in callbacks [1]. If we want
> to write data to the serial device in one of the pwm callbacks, we need
> to convert the `device::Device<device::Bound>` reference to
> `serdev::Device<device::Bound>`. The TryFrom implementation provides a
> *safe* abstraction.

While I like the feeling of *safe* you can mark it as *safe* as the
driver core can NOT give you a callback of a pointer that is not of that
type.

That's how the C code works today, and is why the C code does not need
this function exported.  The rust code should do the same thing.

thanks,

greg k-h
