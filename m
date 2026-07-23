Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9A36AB5A;
	Thu, 23 Jul 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840362; cv=none; b=sN7c4ou5o87sdZQbqsZFbDvlPcfTJ6qzc5qZSvcg5kUg/GKQcqujW5y/XqWZo1ljyYR0BMIeA7Ap4UUm4i2D6BoaHML4xprka1Pequ09srHjr6Wsif2m7j44hBh+9kPrnP2NUGi9Mflo0spzF2l0ogqxtTGwdJ97UeEOKv9oE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840362; c=relaxed/simple;
	bh=3siq3ZRHQHupARL5OcYGzfPbFcHUXu8g33Ej2kheHDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAkO1lcMYkLi8oAWkaRLHVrQceC75KqLskksPEeZ2OsFFUl7l5tDMbdRV6coR5HjzayEMBhyMwQ7el6QohwTvbUa1+2kpTeZ2R8NlNFSVUSTCswB614b4YjtsUF/NNExJbrGMJQ1F/HypjN5y/OsZBIcBrHVNXIM9x+ZjL3os4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYwSWiPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYwSWiPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFF91F000E9;
	Thu, 23 Jul 2026 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840360;
	bh=5QlEtEB+KlYv+DW8jPCkBOH+68EPaADuCoS5PEm6aZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BYwSWiPwuqD2kKCxGI2pr+TIGSE1pyF9pR6pHr23oOs9oOumzQ6nBN6YCuQT8d6qw
	 scZe05tKL4XuEY4HRmVNBoM6ZCj2jiCNUebtZPIMnFozom1Sp3/5mK3JBuWY6Bmdgi
	 slR32XwX0O+mdL+z+toFqIb/sbMBqxAeZmFFd9j1oK02JB3SDIvdy+61g5+71H/MP4
	 0gd7tr5rTKqEl7i0qpu8hpCNFSxfHwpqDAcruahIoj1v2IlXEqluHKuNNhjEHj6kdU
	 DK9cvbawwnr9JcuOpk8INMLDjagyIF8kPiHoQHjqZuK4oQAtj29ej+kR8Om+d6VXoK
	 WbcqFtWsoh8eA==
From: Danilo Krummrich <dakr@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kari Argillander <kari.argillander@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Boqun Feng <boqun@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v16 0/3] rust: add basic serial device bus abstractions
Date: Thu, 23 Jul 2026 22:59:12 +0200
Message-ID: <20260723205912.3441137-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 15:33:09 +0000, Markus Probst wrote:
> [PATCH v16 0/3] rust: add basic serial device bus abstractions

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/3] rust: add basic serial device bus abstractions
      commit: 99f59aa82341
[2/3] samples: rust: add Rust serial device bus sample device driver
      commit: 4b2c9156d312
[3/3] MAINTAINERS: serdev: Add self for serdev
      commit: 6b71fef6f05c

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
