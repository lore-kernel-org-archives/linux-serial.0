Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7B3A1DB;
	Fri, 24 Jul 2026 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871272; cv=none; b=bEDzKxUuHrwvTUD+eUGYkbo0Ks8OOiSzlWKMnM9wMABd4+v0Mbkh0HKeMwrALNPT/pqdA7bxwsUnZh8zbQSZQlfdMTocKv11yjP0HEumyG/L9czpJuib2HJEXGuT2c2bxCZ4weunrxdfKny5s6rh00IVnq9i+c19joWTU73zhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871272; c=relaxed/simple;
	bh=MU+789g6DeauvPtvTt6a3p0NedFE0rTQmlIJlURIQ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh5aZXKGyA+Qwr+OertqXrF8+RJaACRwjdSMNmKnpCt3lt2xF5yidO4J3NukUdNepk8OYgFsRezATNm6rqdin2K53JKIjAqHAAQFv0vDfiyxo7PbmWTcbcVg7geARrLsTNNMa2BARJFUZze/pGqE1l3hZ9mByMgY55iePrVqZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SNzYsZ3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNzYsZ3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C551F000E9;
	Fri, 24 Jul 2026 05:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784871270;
	bh=yJpgQxTxm4jDRN2KRYXe9Fu81fij2GnkQjQHHYhOqwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SNzYsZ3TdjAbEcgLuUgRZio7co1q1Mo6e2TCphJ9fHDRHddzKwvJfKKKnSuQWGRwc
	 6mryL5UrbvXSFq+ACzQ4CtfeaWurAXHBQSAIy26VubpSD8Nvlj3gZ56IEbd8ODmw0r
	 6/5yFdSVIqErRvJTAdhlOb67Ja19dEHqvqBzX0Jg=
Date: Fri, 24 Jul 2026 07:34:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Markus Probst <markus.probst@posteo.de>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH v16 0/3] rust: add basic serial device bus abstractions
Message-ID: <2026072414-dedicator-canopener-9d85@gregkh>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
 <20260723205912.3441137-1-dakr@kernel.org>
 <DK69583TKES2.2ECSGER5Z77I6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK69583TKES2.2ECSGER5Z77I6@kernel.org>

On Thu, Jul 23, 2026 at 11:01:17PM +0200, Danilo Krummrich wrote:
> On Thu Jul 23, 2026 at 10:59 PM CEST, Danilo Krummrich wrote:
> > On Sat, 18 Jul 2026 15:33:09 +0000, Markus Probst wrote:
> >> [PATCH v16 0/3] rust: add basic serial device bus abstractions
> >
> > Applied, thanks!
> >
> >   Branch: driver-core-testing
> >   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
> >
> > [1/3] rust: add basic serial device bus abstractions
> >       commit: 99f59aa82341
> > [2/3] samples: rust: add Rust serial device bus sample device driver
> >       commit: 4b2c9156d312
> > [3/3] MAINTAINERS: serdev: Add self for serdev
> >       commit: 6b71fef6f05c
> >
> > The patches will appear in the next linux-next integration (typically within 24
> > hours on weekdays).
> >
> > The patches are in the driver-core-testing branch and will be promoted to
> > driver-core-next after validation.
> 
> Greg, since I've dropped it from the queue a few days ago I've now picked it
> back up.

That's great, thanks!
