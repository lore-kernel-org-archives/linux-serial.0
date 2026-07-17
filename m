Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD23C3F7B;
	Fri, 17 Jul 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289831; cv=none; b=Ksnwz+nS8wCeAVqbxkgJcopnWDqCywy/itN6rDs5sqWb0OuKyJiiQj+aIs260Y0h0VysjEmP/3nUK4H9Mwo41xquiYa4RJbnNWGuapKzvlgYSl8H19hKiv16goTutF6U6B3pMXffF9BVHb+0wnsWQ46pzZ5IOJcSB226q4LknEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289831; c=relaxed/simple;
	bh=hGFSSP/8JtBx4EJXP1Po/WkVp313a+sVf4Vrxri8tzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRrHe+gD4hZ8aJz9vHz4ANd4zwcLbEqYken7hs3LlmKuc42zPLm3do6lR6zck/nTCse2PWl678tIFEHj/Rkz1dhiPQgQSH1yJ/7dRsubkQiRaPIK9wsoNucbDp+zt0Obw6EOnBrCvIDyn7CSBKc3SEDrrzQ9JzQIXzXhNOByjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ThVR7oy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ThVR7oy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7066A1F000E9;
	Fri, 17 Jul 2026 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784289828;
	bh=VSLA+rT8tjPVQ6J1CMEUPfkyicD10Zp1i6IB9Ga5VNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThVR7oy/crZOE04QMjSmxOX/FDDGsDWp6ffjeMqsTZ8W31GV8SJ9QDwSC9IteQTAl
	 /hgjWi0Ld3mIJvLccOfhi+zRP0rQVIi+yz0scxJ4//V/HNRfrPz1Fzj8vbCu/o8WOD
	 Kbs49bKOY+8SncbhCPtZSvjIqlhmBDGXy/gkcCgU=
Date: Fri, 17 Jul 2026 14:03:41 +0200
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
Message-ID: <2026071719-afflicted-eleven-1be9@gregkh>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>

On Fri, Jul 17, 2026 at 01:22:40PM +0200, Danilo Krummrich wrote:
> On 7/17/26 1:14 PM, Markus Probst wrote:
> > On Fri, 2026-07-17 at 12:55 +0200, Greg Kroah-Hartman wrote:
> >> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
> >>> This patch series adds the serdev device bus rust abstraction into the
> >>> kernel.
> >>>
> >>> This abstraction will be used by a driver,
> >>> which targets the MCU devices in Synology devices.
> >>>
> >>> Kari Argillander also messaged me, stating that he wants to write a
> >>> watchdog driver with this abstraction (needing initial device data).
> >>>
> >>> This series depends on [1].
> >>>
> >>> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
> >>>
> >>> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> >>
> >> Given there are no objections, I'll go queue this up now, thanks.
> > Thanks for merging, but I haven't seen the dependency
> > 
> > https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
> > 
> > getting picked yet (its at least not in linux-next), so it might not
> > even compile. Not sure whats holding the patch back though.
> (Ah, saw this just after I replied to the other thread.)
> 
> Nothing is holding them back other than requiring a user (which is your work),
> so I did not pick them up.
> 
> Also note that tty and driver-core are different trees, so picking it up in
> driver-core would not have helped tty.

Should I drop this from the tty tree and take it through driver-core
instead?  If so, no problem for me, just let me know.

thanks,

greg k-h
