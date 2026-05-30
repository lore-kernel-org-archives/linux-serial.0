Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F11A5B9D;
	Sat, 30 May 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170367; cv=none; b=lEVuz2jcHddI9ApozuXxA+xoFa44XgfNDNWOTUzJNgv3+mvWCDKe5u481OpzCFa8r773Ghwk/a23Ko6K4TVEwxuPd6hHWZkqpfreAEJVj9Q658uGZUxR+F6ov6joPs+hCGi0DhxWb63awgO7aE7U+0M+z76DRfuE4O/threN9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170367; c=relaxed/simple;
	bh=srBCy/zdErG7s9yoPUyWO9/eyzhiARnTTF7Wgqa2KHI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=QWNt4FPMd4gxjhZndFZabc9AiPZK9jiuUbQzG2MmqQbscC5h/7FTsRxPb6nMl1G2g59ITy1D3wXB0cv1VhyMOjzP0R+WKD+sPPsKTbg2fACaMzV3S/tf4ZHiJexRUIuyN5j8566vjITw26mUgWkcjgjt16qNKndFfu6HwCxLkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBN/B1+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBN/B1+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2451F00893;
	Sat, 30 May 2026 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780170366;
	bh=srBCy/zdErG7s9yoPUyWO9/eyzhiARnTTF7Wgqa2KHI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=dBN/B1+QhwvG/s7vUQWrXB2MAfJ/CfV1cQ91HSJBXyEKyMfZqpO/BTKiUViC6kRyI
	 XKpms9IW1BTjFjnQBN52Ukx0tIEXJJsCXzhL0lemL7OlqwLkNZ/qNIvnafAYO38w5y
	 XGjMdcEZv9v3W73qpFMZvPv9SaM7lLWg9r16XLFN1rt9kFHE/tX11qdTdHXVaWCy6Y
	 fnpbm4E1GJKZhfFgasaTTq+095fuf8JY+XtL81WdSi63BZ5LZgmNtDHdf8FDm2pNTd
	 Ei8pc4QkW3n4xY10yTC5TyJVoAJQdk6NBb6zzrZVrmoGJq34E2XQLR9kb0Cn+cFU4y
	 9Krwv9FftSh4A==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 21:45:59 +0200
Message-Id: <DIW9Q5GVC0H2.2BEOWKL02AMWA@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
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
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
 <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
 <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>
 <DIW587AGXYCS.39MR1B4TVSO9@kernel.org>
 <01e20401845ce5eab5731698ca8a0f8f44ed3eb9.camel@posteo.de>
In-Reply-To: <01e20401845ce5eab5731698ca8a0f8f44ed3eb9.camel@posteo.de>

On Sat May 30, 2026 at 8:55 PM CEST, Markus Probst wrote:
> pin-init doesn't have enum support yet, so at least in my driver devres i=
s
> still required for now.

Hm...how is this related to having a registration type that takes a lifetim=
e
rather than a registration type being wrapped in Devres?
