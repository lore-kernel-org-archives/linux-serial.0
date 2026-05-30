Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEF26E706;
	Sat, 30 May 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151734; cv=none; b=FqOkFkg+ekTnQXl4gegNYdFFNk3vM99NQ02vSjf3E7kfljDiO04BdJkYZ6KmStZP0KAtqbBHF4GNQ4JoBU5lEsXJnOPReHi4jMmLOz2Un12rgcx4xgeL1hPcros2YPdApWbdKWmcMt7HgpY3+Vn+eDfc2xapZdjq3F9oVajHxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151734; c=relaxed/simple;
	bh=YW9seKnP/M1qHHCsdG/YjklFD3veFxmymb7oG7X5SzI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ql1sGLOEq2N+qIb6QBADarH6FXiH9dwpC84yOecu5WpV4bXeoQCfZTAeFQTzJCOrdBXvtWj9wbbR6lhK9OWtEHQkXVXqC60CwE03UCb9ru4+l91iNfeSEB7tZ5E/BKF1r0O13hB7hWea3pk5s+joL8Vs0Z2cXwyYxDj8IDXJV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW1RdPAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW1RdPAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF9F1F00893;
	Sat, 30 May 2026 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151733;
	bh=YW9seKnP/M1qHHCsdG/YjklFD3veFxmymb7oG7X5SzI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=WW1RdPAq9v2x+zA97z8xw5rfY3jdFySIz0YOrBira1zvg1h2Rt/Bd5znPa2vHfEY8
	 EA3gu/nzZ1Ffv3+yKBd0WENZuhoSAvqH/AvHvezvLjQnQqC5npTYBhmerkXOwP63ih
	 /VLakqbiSnRLd/rhWJRgqbKMbykHI9g3pDnftQfrSGk/b8jy6xuY3t8o6AMnIH6DbM
	 pP58Rv2LaTcYhRkEmpq2hZSHKtARBwR8MKMKQ0FGL0xEo2u03ftPdoNQ/R0MtYeMBE
	 u8Qv6bPkiryqp7elwzeBhkFBv7+kmavvySaAmerKsulJaPHSdLf8LSPsE+A4o9IA3Z
	 SwkuA0rDUEitw==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 16:35:27 +0200
Message-Id: <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
In-Reply-To: <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>

On Sat May 30, 2026 at 4:27 PM CEST, Markus Probst wrote:
> This would work, but I don't see how it would get rid of rust_private_dat=
a in
> this way. The device private data will but the private bus abstraction da=
ta
> needs to outlive the devres callbacks (which is done by rust_private_data=
).

Why? You only ever use it in the receive callback, which won't be called af=
ter
device unbind anymore.
