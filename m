Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53911AA7A6;
	Fri, 17 Jul 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293980; cv=none; b=MVqOntXgVFhKJHDCcnhTMqgDK1v48vE/CSVAv1Fqy3N7V3MwmcxmizZ4lQX37PhT2cabo4r+f9k0F0hFc7aNM22+iDToaxMdrbor/AKyLj0H7PZ0p1pWmHzP3IgzivqgMktZE/V6ODN97U6ShgEbRGKfqAMvoPbGHXW8taLjZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293980; c=relaxed/simple;
	bh=urQWHGm30hiABc3/nk3aTx4LfwS52Tqd0cKIxbID1Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqBfTo6SFyyhjJ2jt5/a0Hn69mP5nPNITewZVqzb95uzRWy2k0juVmuZJR7YGobq6SlZsDsdhSI80X1Pn0ttdov0d0RalyBkbOVyR9kMugC5XF8B5odfVqd8WlZLAsR8UVcv7H2mtXPfRFYt0br6stCEPONxr4CYrwUwH3YH2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoseNnns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoseNnns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81D1F000E9;
	Fri, 17 Jul 2026 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784293979;
	bh=aZTORBupc8j640bJyMKRsjKjZo0c9CWZC4bL0TBveaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yoseNnnsC2njJaY5/ZVRGlc08u83ISYVVJNKWek4s3GPOnGjNLbnfb/jsPDrP3165
	 pM+atmb4rvQcOF1S/TJcK15WMN2SRIcpo6ZltoXMFOLP5zR/zLtUGlQoESSuF3fNuY
	 /I9LC2eAz/s2OQrd0gTc7oEMw/YbL/gE8tVdKCks=
Date: Fri, 17 Jul 2026 15:12:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Message-ID: <2026071717-unexposed-theorize-d707@gregkh>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
 <DK0U1HB4RVRG.3S824JZSFIF1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK0U1HB4RVRG.3S824JZSFIF1@kernel.org>

On Fri, Jul 17, 2026 at 02:07:48PM +0200, Danilo Krummrich wrote:
> On Fri Jul 17, 2026 at 2:03 PM CEST, Greg Kroah-Hartman wrote:
> > Should I drop this from the tty tree and take it through driver-core
> > instead?  If so, no problem for me, just let me know.
> 
> Either should work, you can also take [1] through the tty tree, I don't think
> there will be any conflicts.
> 
> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
> 

Hm, that gets messy.  I'll just add these patches to the driver core
tree, along with the above linked ones, to keep things simple.

thanks,
greg k-h
