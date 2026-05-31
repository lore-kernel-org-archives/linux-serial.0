Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126438C2D0;
	Sun, 31 May 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250245; cv=none; b=qeFxLJ3W0tRInndyJgKP/6jZdeuVfhSthCR0nuCdiJwddWwFM5ADnySR59j/Qyj1UaPulnKdHoN7NEkLSRupoWBo1m+FNBQ84hm3Gl6lvsD6KA5qAbgW0mbbedzrfoIFHP4h4IcoLhjDU4TkOSwHh4vDkWiKkrZ3FnqXm4mcqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250245; c=relaxed/simple;
	bh=OpwwfpuDat0PLBpEmIVKRTwlA8l4xHYQHuV7EJjt+eU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nSGOVo1a6glvV0Ruucz3aj58mhkMy1ssdD5JsTkXNiL3aH83CHNr3Jo9XrlRXjDjy2RXfe2WFH8PdMcY+Xp+k/tod1B5mwV+kAw177EAIZvCAT2MF61TmdgNecgLxfkEOQcqtdSz8MhjHl6J1wuU1odVyI9FXtBUSHCWlL2xe7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHSYeL/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHSYeL/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4BF1F00893;
	Sun, 31 May 2026 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780250244;
	bh=OpwwfpuDat0PLBpEmIVKRTwlA8l4xHYQHuV7EJjt+eU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=AHSYeL/ohiyf+9qZFwNCkh88Ediyj90Je7rFdaRyHJ6WgOUmqQfiTjPiT+rogzXeZ
	 pANqpaGD/nbhU9O3wrfTIFlNHsQaJPjeP7S6vtYVQ1yrdJ+M61VW7ygmImSQHCX79n
	 1qFfTo2cYVm0gVX5EWcj7lfEJ9JUvSS7IENd4/fWFOWt/os1tGMa5AiyUhii58e9YI
	 UYJXONQzdZOB2l65Rk8qrosXWOLeCaBKLfg2gKi9hALfx1UO6/9sTMeux+6vO6QpFB
	 Sc/+wc1SMxvqkdQYIqr4ezD+RWJvzl38bxXMdMEknYiFHIWZZotvkt2hGzQoCmq7W3
	 4ryPk2chCInNA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 19:57:17 +0200
Message-Id: <DIX21GVNFWF8.2AT1AX2B1NV6K@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Markus Probst via B4
 Relay" <devnull+markus.probst.posteo.de@kernel.org>, "Rob Herring"
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
 <20260531065838.7352-1-work@onurozkan.dev>
 <b6191edf3dc052fa86fae12fa5746d0c1c9c45ed.camel@posteo.de>
In-Reply-To: <b6191edf3dc052fa86fae12fa5746d0c1c9c45ed.camel@posteo.de>

On Sun May 31, 2026 at 6:37 PM CEST, Markus Probst wrote:
> How close? Should I rebase this patch on top of the srcu patch series?

Since it isn't blocking you, it would only make sense if SRCU makes it this
cycle, but this series does not.
