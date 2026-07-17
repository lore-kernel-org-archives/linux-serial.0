Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092323E9C21;
	Fri, 17 Jul 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285720; cv=none; b=rsLNKNNCtTki+JWciVbJt903QhzruxWNNgND5i4ShWhJu2G9dIsKl3Xark+4Wq3OfGMdGQOTG/yc/2mW0Lpxiubp96bfwqZtjiRjAQBed8ANx1Wdwqa8MTiVQ7U39Sv4XclG3r3SabdBt0b7HeHx9KCDUX4BJnhFApnZfFGLsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285720; c=relaxed/simple;
	bh=oqhEzQvOV1BOZVUFidHi/Gjxf2KiZ2mlDeQcFmKQ0E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btFrZ94IIqnT382Omu/ujYgaCalMeKTAsSpDcyS7AS86ASHuGhovDlGEPPilXP8umirwlIeoLlMoemp+yIlOSGdD46q6TKCNFcCk640cm9royfmR4ptObQo6kQTUDDC92csHByMk5LRRuLFmZOeuvOe+Z7PArMOjEl7Q7o4bN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2rOna6d7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2rOna6d7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25431F000E9;
	Fri, 17 Jul 2026 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285710;
	bh=np5EK8wmnij7Xk3htUt9hFn8FK1di2cvVoPPQcRvhzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2rOna6d75JFg+Yitd99pCkx4iD+5MlcJy8dpI+umsalvV4XZg7hHpoxItYVEPxa8v
	 6A8irRIXGkb8vZ2GAowW8YcZl8DEcTfd8IimuiQmff7rcex6gUCXyxcv5x371RSu0e
	 3ONAscrVfUKiAEePXe8NxBJTVJ3g9JQwqPRWNkmg=
Date: Fri, 17 Jul 2026 12:55:03 +0200
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
	Simona Vetter <simona@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Message-ID: <2026071747-android-overhead-c927@gregkh>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>

On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
> This patch series adds the serdev device bus rust abstraction into the
> kernel.
> 
> This abstraction will be used by a driver,
> which targets the MCU devices in Synology devices.
> 
> Kari Argillander also messaged me, stating that he wants to write a
> watchdog driver with this abstraction (needing initial device data).
> 
> This series depends on [1].
> 
> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Given there are no objections, I'll go queue this up now, thanks.

greg k-h
