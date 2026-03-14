Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78682517A5;
	Sat, 14 Mar 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773495104; cv=none; b=kL8UGPr/XY+R820PFk6tAJ7F/8R/ikytvU6mzn9L4MCqJ+iuVo6GgMm2JBFyL7c+KV2ZqeWIHdCUwhz1eBW0+Ek4usao9ib2yVNdRfNoBa/T5YUe3ryWBifOdozak2ro8kSXOPqqNhOCrpy5ijmc1rvXWxdkpLVJ4D6Y8Uzvoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773495104; c=relaxed/simple;
	bh=33fhq7j5vg+tmMCu8Sapd06qjx9fDJbLUGUc3OjM+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZRxGTmuyUQb86Pbk2Z2/59nHIzcb6nkuricDK9ewLafJMOBgJl+z+N3BE72eSBPzWv5Lz4mxBDw+5ifndHZd4MGhPgjWjQWoC2Zm9mT4UykYcGd6DUxOF7O7A1+7AnHq56ZjUBjeQGmPPVRFH5NhK1puTdcgjFeKWw3y/vvEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dv9u0Zpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dv9u0Zpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F5EC116C6;
	Sat, 14 Mar 2026 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773495103;
	bh=33fhq7j5vg+tmMCu8Sapd06qjx9fDJbLUGUc3OjM+E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv9u0ZpwOCbxh1VMl/0LobIPwxuijRelA04TesVduk5vbbp+kGnqw9UNedhXkOOPt
	 TgOyvngKw842sT462V0uXDzZPJyziLSVipaw4mLC3ezBVhYFy0S4I/UtVix2RzkKKh
	 ROKzexdoLNYAubV50MkEEGhFHovLrU33mKuM81sc=
Date: Sat, 14 Mar 2026 14:31:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
Message-ID: <2026031447-margarita-untamed-e976@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>

On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
> On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > > > > Add rust private data to `struct serdev_device`, as it is required by the
> > > > > rust abstraction added in the following commit
> > > > > (rust: add basic serial device bus abstractions).
> > > > 
> > > > why is rust "special" here?  What's wrong with the existing private
> > > > pointer in this structure?  Why must we add another one?
> > > Because in rust, the device drvdata will be set after probe has run. In
> > > serdev, once the device has been opened, it can receive data. It must
> > > be opened either inside probe or before probe, because it can only be
> > > configured (baudrate, flow control etc.) and data written to after it
> > > has been opened. Because it can receive data before drvdata has been
> > > set yet, we need to ensure it waits on data receival for the probe to
> > > be finished. Otherwise this would be a null pointer dereference. To do
> > > this, we need to store a `Completion` for it to wait and a `bool` in
> > > case the probe exits with an error. We cannot store this data in the
> > > device drvdata, because this is where the drivers drvdata goes. We also
> > > cannot create a wrapper of the drivers drvdata, because
> > > `Device::drvdata::<T>()` would always fail in that case. That is why we
> > > need a "rust_private_data" for this abstraction to store the
> > > `Completion` and `bool`.
> > 
> > So why is this any different from any other bus type?  I don't see the
> > "uniqueness" here that has not required this to happen for PCI or USB or
> > anything else.
> > 
> > What am I missing?
> In Short:
> In serdev, we have to handle incoming device data (serdev calls on a
> function pointer we provide in advance), even in the case that the
> driver hasn't completed probe yet.

But how is that any different from a USB or PCI driver doing the same
thing?  Why is serdev so unique here?  What specific serdev function
causes this and why isn't it an issue with the C api?  Can we change the
C code to not require this?

thanks,

greg k-h
