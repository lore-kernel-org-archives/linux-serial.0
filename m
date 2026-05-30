Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217022F39B5;
	Sat, 30 May 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150126; cv=none; b=rnE8sVMR69GP6w4xbDDNIWs62N6gQww5ABludzGRRq3HdGF6j+NchdVcPqoXAraZRUJsrSpFO/IeWEV2ktRB8Fvr9eOq6YdIVDZc9oJxLW/8wp7OJHBkq0ziathgNnib5defTaTXtxdw4E9J67rlZat+AWKBVrqGwTQpVGYIno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150126; c=relaxed/simple;
	bh=9h3omsab3wD/YbJIteGGZlazo155REDIL3udFpbQEu4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oZ4nGoHlZWmQk0j/cDS31NfwRh0T4EUYjJIjBV2hO0FRsUcu9kEjSOjyDZuyoF/OppHLEshMPhQ5O+xIocTTt7T8tftDYZuCN56xtzW1Y8bot0ZzwHgXUOAtNOnhLRl6GAFpQZdcB/4+sgJUC98hmrJOct4APRBngDPYIV6GXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyTrtnhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyTrtnhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BCE1F00893;
	Sat, 30 May 2026 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150124;
	bh=9h3omsab3wD/YbJIteGGZlazo155REDIL3udFpbQEu4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=RyTrtnhjoXqfk12tW+B26C0j7dyZxT24tdh7vHcLGFGPR8j4MRvPrEJk3MoJ5OwhE
	 Ms/N6bKrTZKrjm+flKjpjDdjOKkdp/aFVAx0oaLvkwAPIuxz4L4odMYr2SWI22rrOQ
	 /2er9ydLD2hQKwuAs2uSOCgdmccUG7wonj4xgP3N4xe5QZEGf4L4AGf1OQgrF/qi/k
	 N8fwwFbqZDWGpYNcNbUWAOs1New611dojdb1HGAEGoUwE0jfP5DZdorcgtYH3qURbP
	 lGqrf/L8503gPHNxSk73ilF7aUAKpnWNWJS3AnT2gFFrd9+jJJYOS4M5F1L6nL4slB
	 ZxpB27juk2mVA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 16:08:38 +0200
Message-Id: <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
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
In-Reply-To: <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>

On Sat May 30, 2026 at 4:00 PM CEST, Markus Probst wrote:
> On Sat, 2026-05-30 at 15:53 +0200, Markus Probst wrote:
>> On Sat, 2026-05-30 at 15:37 +0200, Markus Probst wrote:
>> > If I think about it, I can't even close it inside remove_callback afte=
r
>> > `T::unbind`. With the driver lifetimes, the driver could store the
>> > `serdev::Device<Bound>` pointer in its DriverData and could still make
>> > calls to the device.
>> >=20
>> > Any suggestions?

Now that there is no public drvdata() accessor anymore, all bus device priv=
ate
data accesses go through the bus abstraction.

So, you could go back to your original approach and wrap the state in a bus
specific bus device private data wrapper type, which would also get you rid=
 of
the rust_private_data pointer you add to struct serdev_device.
