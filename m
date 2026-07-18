Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE23242D88;
	Sat, 18 Jul 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383830; cv=none; b=Bl9QrcLu4aY65ddtERVTTHOyDcYJQUMjsSTDUYFOsXAlIAf3u1h8oe8WFwytDSJcBE/A/AsjHp3+F7u3+nzRYMLz01fQSninGEvz1VUjIUKiywMsNu56AyppFqA+5WWA7WfF9YLM/EhD4VK5QQJKkRY+7Xl1rhHx/ecXcV+7pcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383830; c=relaxed/simple;
	bh=I2fnp2z3mxevuHuneI381VhE7e8pnGLapsQ6rXUMpdw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ScGxZNYujpV+wGi+9FM3TCreSCYQJYtn9fHKvzdavga8O+8wU6YBR23bdInDQJ8eHeJ9g8qt2vOcogAfR2F//b3FdTy0d1YxUr2sqafbUwd3LuNN2pD60vL7Ft6gZwMT6lMh18EX04N5UKUTQU6rkF2sZFXSje247n5JzeNvygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGeLvXjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGeLvXjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C9E1F000E9;
	Sat, 18 Jul 2026 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784383828;
	bh=I2fnp2z3mxevuHuneI381VhE7e8pnGLapsQ6rXUMpdw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=bGeLvXjp/t17ftZWfXRDsAx9oPkClmXntFDzdbtuV9l6Q0f0qJj0idaq4tQtOYF6y
	 6/U37a6lgcaI/TBovJ7w6q/e7bmh05RbzFtnQOI4mYk0UgEkmwJwQ1KOaNI4ByxAdT
	 lmd711ETEc+OhSsb8ImrJnDj9fbiBsAGQTzBdctRqiDXhilJvYL+vdKcbTlNhWMZu+
	 Mm5ACV8hHZkbNyN5KVl1ULS3Yw0HiWw2rN636FWznMazXfZfCs94LhvBK0+ckDSM2N
	 2t+zFOHS1SUjLv4ZHRQqBlnWbW1gozEdBjDomU4oxxySQH2Ab60L0GYB0cP4wzDlf+
	 233tlFXzz2AOA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 16:10:23 +0200
Message-Id: <DK1R9VZND2NS.36X0BL0F957OI@kernel.org>
Subject: Re: [PATCH v2 0/4] rust: serdev: trivial fixes
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "kernel
 test robot" <lkp@intel.com>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
In-Reply-To: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>

On Sat Jul 18, 2026 at 2:47 PM CEST, Markus Probst wrote:
> Those are small fixes discovered by the kernel test robot and Gary Guo
> after the serdev rust abstraction have already been merged.
>
> This includes
> - a fix for a documentation typo
> - adding missing `#[inline]` attributes
> - a small structual change for timeout

Thanks for the quick follow-up, the patches were only in the -testing branc=
h, so
I dropped them from the queue.

Can you please integrate those changes into the original patches and resend=
?

Thanks,
Danilo
