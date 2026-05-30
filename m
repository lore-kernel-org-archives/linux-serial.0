Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103B334695;
	Sat, 30 May 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157678; cv=none; b=ugPutfByu1hkQpAkaP6D9rvlYnUZat0Y8nAoNEgs8xv3krWZAqTa5RzsbyYq6STlKmBlLaTYwsq7a3mVI52ffaGS+fZgio+fjK2+ocBHtGfajVqcjxpWhY7xByLMK1Nz4A8CjvO0xv+Y9hnKdrEzAx8GJozCrVyYEXZqreIU2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157678; c=relaxed/simple;
	bh=a1HJb7wM7dbrPtrdf2u0hQIT9klNUXKK9GONYcrJZ5U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=UFpiE3soKE7D0kfoK9z7DloxKKJRgIs60cWQ3QRin+7QCfHVA2H1bBGZV/GKmQS3IVMM8XR1C2hoWjm4/+fg8lm4G0ycvEfwAsY10fgZRc+9xi2sLYnDUDxy2vCcE6sxILthOx4aRGXojhSHxM2WNmdRIuk4mIuirvBrnJNdKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzINa+ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzINa+ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F061F00893;
	Sat, 30 May 2026 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157677;
	bh=a1HJb7wM7dbrPtrdf2u0hQIT9klNUXKK9GONYcrJZ5U=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=ZzINa+iguSKy5ptBu0K8zr01QzrekpsQEKMK9bwYi/o+eoydvuSChjmASxWo4TaAa
	 lk2/CUWeM5DKzXYXBIjs3gRAT/O7Fffh0YjuoAr6WuAJyv/q5hyTS2dqBc80T5831+
	 Bjs5StxZnh4+euTg/AGkxMSCWZ6Ud5vfVCS/PWkkq2bgzWppEyUmKho4tO6VnszErG
	 AYpljMjadlXtHyli2PlfP2590MtcMep0Y9Q/8RVT3TvRknneCXg/Ie4euzCoGV83jY
	 a3kT0kVpXm1mq2HnysvUG+SecQKOUQBhfki0OtdevNkcGo2XCZhsnYVA6XvdCdQY6N
	 o/OnzP8fMXFng==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 18:14:28 +0200
Message-Id: <DIW587AGXYCS.39MR1B4TVSO9@kernel.org>
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
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
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
In-Reply-To: <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>

On Sat May 30, 2026 at 4:51 PM CEST, Markus Probst wrote:
> On Sat, 2026-05-30 at 16:35 +0200, Danilo Krummrich wrote:
>> On Sat May 30, 2026 at 4:27 PM CEST, Markus Probst wrote:
>> > This would work, but I don't see how it would get rid of rust_private_=
data in
>> > this way. The device private data will but the private bus abstraction=
 data
>> > needs to outlive the devres callbacks (which is done by rust_private_d=
ata).
>>=20
>> Why? You only ever use it in the receive callback, which won't be called=
 after
>> device unbind anymore.
> Because the possibility exists that some classdev ops or Drop calls
> e.g. sdev.set_baudrate. This is a null pointer dereference after
> serdev_device_close has been called. I interpreted it to add a state to
> the abstraction private data which would prevent those calls (early
> return with error) after serdev_device_close has been called, but this
> would only work if it outlives these calls.
>
> But it seems you were refering to something else with the state?

Yes, but I just notice that I'm a step ahead. With the lifetime model class
device registrations shouldn't be guarded with Devres anymore, but with a
lifetime.

(This also entirely eliminates the need for having different devres stages =
to
prevent drivers from smuggling a newly created Devres object into an existi=
ng
Devres<Registration<T>>'s data, which would be unsound for obvious reasons.=
)

With this there is no way there are still class device callbacks after the =
bus
device private data has been dropped in the first place.
