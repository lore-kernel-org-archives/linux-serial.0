Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B843382367;
	Thu, 30 Apr 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579141; cv=none; b=jt2dPgSgrf9lT9d02LuRpIbOTEFkmzhzcqboWHjuiAMB8dc4UGMVA7ztvhzoEsB26GQu7ofI/2c7RY+32F7UcMVLhe4um1BcLpRhVCTid4YJLBoklWiqXlAwTqRWH1Wl+yX8RuTv2UJztxCiiK/+GRP1Q5wjs1Alm7JIbnugKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579141; c=relaxed/simple;
	bh=LBnU4AivRmdyKTS0Xcm7sAN9nbgjFQEu0IgaPDtNX8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeLyqgR5Vk6CQRVcRRPPEeVHXt+CDu/irFg5WOYym7Zny8M/Q7hpABn0KyETgCdT1m8vqyl0vOywD3LiMIlwdHhVWfvD4nwxTS6rRXaK2nO/Aa7ke0u0GLDzlOrj1wCB1c4i/rfIBTcRAx95hPjQQdDnj8VntMGtJe3et1H8Fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D37FyE44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D37FyE44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A84C2BCB3;
	Thu, 30 Apr 2026 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777579140;
	bh=LBnU4AivRmdyKTS0Xcm7sAN9nbgjFQEu0IgaPDtNX8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D37FyE44Yvvn2cExwQ3DmwgarHkzu8WUVgaowMhD+LmI77+KXzdBK44lKtn+fFUgO
	 bDSpV9CoNJi+BNPgdd0UKnu4ogxf1eb7bKc3aQbAkOGlv1S0uL1gaj47H4jPYZGD6F
	 ELGMa2Wzsk/mtTY92+5Ti3XPzZXWHt9gxb3Qe/WyFzeVbTCM6GeA+HIN1/HGJ5L3OL
	 jAMGMxkf/Y5mCzAdwHsIGTNRCYNHpJi/prLhuFyMoP3cAGZI83iFkM8L7ZClWRXRz2
	 W2CedreT/+hzZYdFf/jLgPz08IQck7uK1kQPtbXn8J0GMY1oTCQv1ZhHnUPsntX0hj
	 iUkbOn6Q6Y2wA==
Date: Thu, 30 Apr 2026 14:58:58 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
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
Subject: Re: [PATCH v7 0/4] rust: add basic serial device bus abstractions
Message-ID: <20260430195858.GA1650658-robh@kernel.org>
References: <20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de>

On Wed, Apr 29, 2026 at 08:21:30PM +0200, Markus Probst wrote:
> This patch series adds the serdev device bus rust abstraction into the
> kernel.
> 
> This abstraction will be used by a driver,
> which targets the MCU devices in Synology devices.
> 
> Kari Argillander also messaged me, stating that he wants to write a
> watchdog driver with this abstraction (needing initial device data).
> 
> @Rob: Are you willing to maintain these rust abstractions yourself,
> as you are the expert on this subsystem, otherwise I would take care of
> it with a "SERIAL DEVICE BUS [RUST]" section in the MAINTAINERS file. In
> the second case, I assume you are going to pick those patches as-is into
> your tree, after they have been reviewed?

Well I can ignore the Rust part as much as I ignore the C serdev part... 
Honestly, I need to find someone else to maintain all of it as I don't 
really have the bandwidth. I don't think we should split it though.

And I don't have a tree for serdev. Greg picks up the serdev patches. If 
the Rust folks are fine with them, then I am.

Rob
