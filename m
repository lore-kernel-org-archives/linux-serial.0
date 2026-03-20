Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BE1DF755;
	Fri, 20 Mar 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026034; cv=none; b=XADJGiEfYMCxYtt0O6UrjdOoQWeMm+lVJQW69SqyO4mOAOQLpJ7s6qbBW7tLZf/zxMaABkiOEdvJ+IX+QYCokoddTA3bYeElJX2IXEkSRypWZfI9y8RsxHIltPk6Llzm+hsz21Yhhv3LIWWxFY3+w2YaDk3zDlBz+2gUPMhUlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026034; c=relaxed/simple;
	bh=IvYbjw9d5nitPx0T3uk2/8jMvQoh90LxpamP/268m38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgh8bfLpOc8+Gv6wuBj0vRwjbfAcqDP83M2wgYwJesz1ZNoVRKPcf386JQm8cji9Ne4REtQij3tuNT5bwJBwbbKVuYZXnKWDgDqOPfKs/47PM5ghq4OCmQt6Et5tG9NZQ8ZHKR/M/2PHjKNbmKA8XHUl3FqRbEHm2yqQKHsalfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KX9wkFN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KX9wkFN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED315C4CEF7;
	Fri, 20 Mar 2026 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774026033;
	bh=IvYbjw9d5nitPx0T3uk2/8jMvQoh90LxpamP/268m38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KX9wkFN2ReY5GLgjhUVUM0unKrrYrhTMmEeYXB6QWdYFW71g2TkS4hF/TC7xmkhPa
	 MMXp9wRxlWzhCjwZ4gXXID84Fd2lRAqT3ZyLt8SbeNkRzhizbiSLSWSnmYAW5pEq8U
	 IBqmh6z3mPSIQjxNjWU/5TwUcSbSKJGe/cvTDQP8=
Date: Fri, 20 Mar 2026 17:59:21 +0100
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
Message-ID: <2026032048-curtly-refold-e4df@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
 <2026031447-margarita-untamed-e976@gregkh>
 <9e07a53053d1dd75a4ebe94aaa06e2279ef3701d.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e07a53053d1dd75a4ebe94aaa06e2279ef3701d.camel@posteo.de>

On Fri, Mar 20, 2026 at 04:53:09PM +0000, Markus Probst wrote:
> On Sat, 2026-03-14 at 14:31 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
> > > On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
> > > > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> > > > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > > > > > > Add rust private data to `struct serdev_device`, as it is required by the
> > > > > > > rust abstraction added in the following commit
> > > > > > > (rust: add basic serial device bus abstractions).
> > > > > > 
> > > > > > why is rust "special" here?  What's wrong with the existing private
> > > > > > pointer in this structure?  Why must we add another one?
> > > > > Because in rust, the device drvdata will be set after probe has run. In
> > > > > serdev, once the device has been opened, it can receive data. It must
> > > > > be opened either inside probe or before probe, because it can only be
> > > > > configured (baudrate, flow control etc.) and data written to after it
> > > > > has been opened. Because it can receive data before drvdata has been
> > > > > set yet, we need to ensure it waits on data receival for the probe to
> > > > > be finished. Otherwise this would be a null pointer dereference. To do
> > > > > this, we need to store a `Completion` for it to wait and a `bool` in
> > > > > case the probe exits with an error. We cannot store this data in the
> > > > > device drvdata, because this is where the drivers drvdata goes. We also
> > > > > cannot create a wrapper of the drivers drvdata, because
> > > > > `Device::drvdata::<T>()` would always fail in that case. That is why we
> > > > > need a "rust_private_data" for this abstraction to store the
> > > > > `Completion` and `bool`.
> > > > 
> > > > So why is this any different from any other bus type?  I don't see the
> > > > "uniqueness" here that has not required this to happen for PCI or USB or
> > > > anything else.
> > > > 
> > > > What am I missing?
> > > In Short:
> > > In serdev, we have to handle incoming device data (serdev calls on a
> > > function pointer we provide in advance), even in the case that the
> > > driver hasn't completed probe yet.
> > 
> > But how is that any different from a USB or PCI driver doing the same
> > thing?  Why is serdev so unique here? 
> > 
> In PCI or USB we don't need to provide function pointers for callbacks
> in advance, which will be can be called any time (even while probe).

All class drivers are like this, once you register with them, the
function pointers you provide can be called before your probe call ends.
So this isn't unique as far as I can tell.

> > What specific serdev function
> > causes this
> > 
> drivers/tty/serdev/serdev-ttyport.c basically only wraps the serdev
> calls to tty calls. This isn't directly caused by a serdev function,
> but by the tty part.
> 
> > why isn't it an issue with the C api?
> > 
> In C you can set the drvdata inside the probe and even with it not
> being fully initialized.
> 
> With Rust the drvdata is only available after the probe.
> But there is the posibility of serdev calling the provided callback
> inside probe.

Other classes have this same issue, so why isn't this a problem for HID
and input and the like?

thanks,

greg k-h
