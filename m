Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB93C3F48;
	Fri, 17 Jul 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294325; cv=none; b=PRLhHEJvSo6Jyl67LhcNW49YS6L0S9IeK9dgqW0seeGBgkqnwJyeIqK8W1xd0jfpbTnFbCo/Pwptgan9v0YroI56Sk8zDebFEbIacHu5C6E5py6WTDds13IxQBcbXosTLZaCYy1X9azaGyaRyCVdNBdCY9+a5i+7DVckRuIJr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294325; c=relaxed/simple;
	bh=StrZZkbkEBXkcvvDSVtBfzIXVZHk+AUFE5g7a36Y3bw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=eVzjkdqGzipU4TyCqp6MLfWg1TYyz8dEV04m4gLjFOHZjP9SWUpa4uBXSlTGKddglaPPRRkDtDCWHs05Da1+JoE2aDvpAKUgWnvHSlrJSaV8DMiTD4CoAgO1AP8z7PeD9qF1HKwTdi3N1MYps8D9GDSc6QSziCO/e3B9Ct/Nk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFmKg2q1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFmKg2q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728721F000E9;
	Fri, 17 Jul 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294324;
	bh=qebFb9kCb19SfwfSRMp3eWIP4hxUMV2hgZ9XQ+zu9yw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=lFmKg2q1qULxsd63TwlcA0PmzbIWkXyFruHY+D4Tn3kCtKNCZxHso18H0L+4t3b3Q
	 D8tRK/APCjxfRt6oCOkwhHyfCzizRwAMAfHMoNJYU8NW2n3Gcx7bnX8T8l1S4nRA9H
	 0cKD/WiF3KsjW8sdoS6Lg1gF5k74knqsSYZgYMVcrI2ABJ36Wo/kdL/Xjb+lnlStDU
	 67tQ4z3VpDLuS53vvsYYxVJnVaXG/mkVspPtvCGa59XdR5Yj23ybe9YJ9Q8AUCYgwl
	 EW+0JbnhPGkz+aoYlU4UKcpIo4vccUNXrIiOm3iJ+/PTL+PsRg50DI6tUNyBA6Ekl/
	 2gmeUl0u3z+kQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 15:18:37 +0200
Message-Id: <DK0VJPMJS1JW.1BPGK7DBODS16@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Cc: "Markus Probst" <markus.probst@posteo.de>, "Rob Herring"
 <robh@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
 <DK0U1HB4RVRG.3S824JZSFIF1@kernel.org>
 <2026071717-unexposed-theorize-d707@gregkh>
In-Reply-To: <2026071717-unexposed-theorize-d707@gregkh>

On Fri Jul 17, 2026 at 3:12 PM CEST, Greg Kroah-Hartman wrote:
> Hm, that gets messy.  I'll just add these patches to the driver core
> tree, along with the above linked ones, to keep things simple.

Yeah, that's cleaner, thanks!
