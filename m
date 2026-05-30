Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34E21ABC9;
	Sat, 30 May 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142106; cv=none; b=iGs84eRFDjAaKNJ89ETy7R6Cl8NC6upD7z6baH3wmRZEcsxuZ2MmaALy/KZzdDimXTKiB56EgXkLBWZR6cVLzFafrDZuFUrXpBMb6a5VqQTu48VoUcS22FUPUShbFDQvrRv6rz27JZrwsDPT5kff24hakAumGrWzjbAQdcnUBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142106; c=relaxed/simple;
	bh=jm8hdmAkEvJcbwS7hgydGF1qmrnzoDP4FHKn0i/2TXc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CWuwJ3pR9W5qlaHOuDK3IY1vG2yjXud4fhgjDvNxASktxQFwakrQQHS2Zm05EOnRxwc9ZqkiB1HNWFutpfqBAYXXOn+fE4qk0DL3LQoLbvQYNgRWqL1L5aFstyUKpB4jXMv3FvLR7M0twbJUn0ve7IF7tnhSPs/ZdPVcf1gJh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCqCaQI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCqCaQI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1A1F00893;
	Sat, 30 May 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780142105;
	bh=jm8hdmAkEvJcbwS7hgydGF1qmrnzoDP4FHKn0i/2TXc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=XCqCaQI3wTaiEpjHV+goSY6qoZCDZ8DaWIgGBul+wGjAgZWvz1L2AvWDURbUbLHXL
	 bOrBQqdGXVTtfC/wxJjKkhtbb9ecGvyvFErDQRz0kxTggLdFYwwi1WOLmu3ED+3cHd
	 pu9PoeZwr/zJ8Ntt4tyEuaVJPISqI6sPubXdr1vPp0N8QYwCdpQ1Zv/IPpKuttT3U0
	 1pU7LdDg9ePcx09dnPQFzY39KIPQ6ywI1Dk1grBW6IEv6DXLZ+WKdnEfqBi7SsN6os
	 P/1rNqCr62Fm1MdM5XT+rvEnUtKHMSkYV5FFl6BbURT0ht23Eb592jDlQ+w+HS9pYE
	 eWHTdoMkOr4Fg==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 13:54:58 +0200
Message-Id: <DIVZPIJYZ244.26RVUD86YHX1N@kernel.org>
Subject: Re: [PATCH v8 1/5] rust: devres: return reference in
 `devres::register`
Cc: <markus.probst@posteo.de>, "Rob Herring" <robh@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst via B4 Relay"
 <devnull+markus.probst.posteo.de@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-1-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-1-2a95f1da22a7@posteo.de>

On Sat May 30, 2026 at 3:13 AM CEST, Markus Probst via B4 Relay wrote:
> From: Markus Probst <markus.probst@posteo.de>
>
> Return the reference to the initialized data in the `devres::register`
> function.
>
> This is needed in a following commit (rust: add basic serial device bus
> abstractions).
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

For driver-core and DRM,

Acked-by: Danilo Krummrich <dakr@kernel.org>

This is useful in the context of the HRT work in general, should this serie=
s not
make it this cycle, please let me know, then I'm going to pick this through=
 the
driver-core tree.
