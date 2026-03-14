Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086C1AF4D5;
	Sat, 14 Mar 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489155; cv=none; b=NMPJjy/wlC2iazgmQEKuds5MgIfsAuJEILaOlyoPkh9soQCsXfa4nuLgX9V9dJNQB+CGzDOBYXMEW8aFJK9oMnyqk87I3c68MwkCkk7/tPicXgMupInT15ImyyN3TTsmH5Pz6u+hYc1oFDSHrdQyCgVgRyGtlGRV8c7zQx43+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489155; c=relaxed/simple;
	bh=YtuOZ55W8PDmlGkVLBE4be0lCpswLb+7bbBVz7Kd9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te6tn57jL5w2+6lW3jDDob9Y+qrWFnEu0KHHgHkNqh3dTaa7debviRvNP3VOwj2cgcv/AoL/ad958qSAy7WmlQciMaev5mq0Pzfy0QDvwGBaZRbLml1DrLMiex0u/xuVzNjs6nFD4QQlWN23ONGKZw1GHGQmyZdvpXdCQho0YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s9+v0ZA6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s9+v0ZA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A56C116C6;
	Sat, 14 Mar 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773489155;
	bh=YtuOZ55W8PDmlGkVLBE4be0lCpswLb+7bbBVz7Kd9Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9+v0ZA6+GWWKYRvJli/W2sGWMVldNwhLNWxqAFjZ5rblzbxzv+HV5KlIdTDLjT8K
	 3BBzTsWonv56AhpnRF5hqtt4nY58f0l4pzxhxqtBJkTNyuloB6bsl+/t6uqQNbHVRy
	 hrlhYQ0VlW8oXaaO1rEAAiIrimDaIXCWNv0He5JI=
Date: Sat, 14 Mar 2026 12:52:31 +0100
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
Message-ID: <2026031422-shaded-matchbook-5078@gregkh>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>

On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > > Add rust private data to `struct serdev_device`, as it is required by the
> > > rust abstraction added in the following commit
> > > (rust: add basic serial device bus abstractions).
> > 
> > why is rust "special" here?  What's wrong with the existing private
> > pointer in this structure?  Why must we add another one?
> Because in rust, the device drvdata will be set after probe has run. In
> serdev, once the device has been opened, it can receive data. It must
> be opened either inside probe or before probe, because it can only be
> configured (baudrate, flow control etc.) and data written to after it
> has been opened. Because it can receive data before drvdata has been
> set yet, we need to ensure it waits on data receival for the probe to
> be finished. Otherwise this would be a null pointer dereference. To do
> this, we need to store a `Completion` for it to wait and a `bool` in
> case the probe exits with an error. We cannot store this data in the
> device drvdata, because this is where the drivers drvdata goes. We also
> cannot create a wrapper of the drivers drvdata, because
> `Device::drvdata::<T>()` would always fail in that case. That is why we
> need a "rust_private_data" for this abstraction to store the
> `Completion` and `bool`.

So why is this any different from any other bus type?  I don't see the
"uniqueness" here that has not required this to happen for PCI or USB or
anything else.

What am I missing?

Also, all of this information MUST be in the changelog text in order for
us to be able to accept it.  You need to say _why_ a change is needed,
not just _what_ the change does, as you know.

thanks,

greg k-h
