Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735C223DC6;
	Sun, 31 May 2026 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780264148; cv=none; b=oLJw8yYhgs1x4J7hCZcUlU3UDIuzP78M6zEJzJ6Tn6qEMCGu/QKLiAkpx8zlpgpn4kjkfVmd+FbfLqHphQycvKcl9I2S5eVr4FEik+rxhvhzFVOc4fh/XTXKRAxK+tpf8Slic29PXjU0t3K3DWaoV31VyvvIWH2fnDP2QSeUEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780264148; c=relaxed/simple;
	bh=L+ffRUF60vNQKYusqHpysiqlE6F10p7SF3tPVvi3AmA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=C5qfqfxRLBr0if+W8H+WAK3VOlOtk4YFqrBP4cm/Kn04hsuuU2dkiB7SZGtd9hOwTFIUceAj7gKatWQs1Ql/pcxtika4X/ny9KgFSXSyTDzoRgBDLf9FIVuH91j6eeCLzMsekLbSd6q8bqihod9ir4wMsmdAU62oCfE93Xnse0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gezCKlVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gezCKlVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2211F00893;
	Sun, 31 May 2026 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780264146;
	bh=L+ffRUF60vNQKYusqHpysiqlE6F10p7SF3tPVvi3AmA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=gezCKlVMpK/cNhif0323MPZ5yTHiTdOBBH7LLBsRzD+yhKZAmNe67+tH2KRprtphm
	 +3SbrLyMWbH//guqNJpELaJpYEN+1gbFiuMVselAJ8RYh+grES/nfyDWiJIf5RhiP+
	 31IIG9YuVzY+bkicD3y2Oep7XrqP0l2gaORBB1HPsYyxYl/KnSgrlsqDfJOBev/Dra
	 1/pANUFgjwYpNIHbkGocM63nvQuYdOLU60hnDmPZlfeQ20qlbLOoTfd7E5zIbjLl5Q
	 mQ2YTpzeWOOrIER5JTf0bcXLcrTDUTTpp4YDBWy/WYQQ77O8mtl2fta7Wd9v9Uhm4u
	 2ZRBk14QW5GjQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 23:49:00 +0200
Message-Id: <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
Cc: "Markus Probst via B4 Relay"
 <devnull+markus.probst.posteo.de@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
 <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
In-Reply-To: <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>

On Sun May 31, 2026 at 9:42 PM CEST, Markus Probst wrote:
> I just noticed, is it even possible to use SRCU here? Currently the mutex=
 not
> only ensures that no drvdata access happens after drvdata drop, but also =
that
> the receive_buf waits for the probe to complete, as the drvdata hasn't be=
en
> initialized yet.

Yeah, if you drop the completion, you need the mutex.

(In case it wasn't discussed in previous versions already, there is also th=
e
option to just attach separate private data to the receive callback, which =
would
avoid this synchonization problem in the first place.

You could have serdev::Device<Core>::open(), which takes its own private da=
ta
and a corresponding close(), this way you'd allow drivers to control whethe=
r
they want the serial line "open" or not. You just need to make sure it is c=
losed
eventually.)

That said, I don't know what turns out to be the better approach. And maybe=
 it
simply isn't something this initial series has to tackle? I think your driv=
er
does not implement the receive callback?
