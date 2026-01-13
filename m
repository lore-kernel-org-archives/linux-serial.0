Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E92350A35;
	Tue, 13 Jan 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331442; cv=none; b=mP/LKAwlSTur/bbLSc+2EeKj3wr1rElfQoBNf5MgcQgDrAooB11qLEEmofi43YuPfEmpywh3m9qSFrrllxciY2jRTK/STT4ZJN+/81r/61eQqlsF7lZnJ4WUMXVBpb6AFdh0EQXn/CVBqu0xh4RhHfC+4tMD1Dv4wTSytKEpzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331442; c=relaxed/simple;
	bh=1/AkY4Hd15pem0LVArGnolFn301RsjOr66DRQhsaaNk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mmPoMOz2VgVHCOd/6M16pAg70IKb0iYrY++axGxNgg704pwn8QAdQ/BRClkH1pkxKl0aOlOyc6IPWGGlL5u8eRPOfq/uSrAnKAeIhkvLg0ZrheRNoLtbekM5T/5//MwJQmxUOkd3ZMt66iReMcDn9gPM9uqqJ6lzMW78mSW81eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2ug91q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2ug91q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63BCC19422;
	Tue, 13 Jan 2026 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768331441;
	bh=1/AkY4Hd15pem0LVArGnolFn301RsjOr66DRQhsaaNk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=I2ug91q3COTduELdbgc551Ovr2P4dv/rNEwkP4iFQblA962vvWLgTa6/+SxGzQMhY
	 zn7lbm41UF+qmC0gH79CWU4Ofhr1bcUytcasDqx+ifJfOsLGpinyNMszCYeErUg8gc
	 7h96CkeyJCk009r+EmJH1L7MuBK5xn53NX2dVGQbU3WBk5rYcKswGnjBeLXS0GiUIO
	 mUg2CBMiHYoQTQfhpLp0Bc9bM2juy0iCTAYTg+yn7lGKkwOSTaDQU8G/jjaPWBClaA
	 q7nZQD5Fl3UGeJoW8gBLhHKTYwY3Ic2ZTmhLdtX5JPomAojGlmU3MVuS93kuXHKnnO
	 3ajh90hl+hLtg==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 20:10:37 +0100
Message-Id: <DFNP6FEZ0S1O.1MQGAXEGX1P7@kernel.org>
Subject: Re: [PATCH RFC 2/4] rust: add basic serial device bus abstractions
Cc: "Kari Argillander" <kari.argillander@gmail.com>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-2-e44645767621@posteo.de>
 <CAC=eVgSmD+bYh48gZteAaqwSHvcHes3CFmbUUBu=6UQ6fKCUJg@mail.gmail.com>
 <76491897ad6e0ff2749935c39702b93adc9951d6.camel@posteo.de>
 <DFNN75KWL8B9.1YHK1ZRV43W7O@kernel.org>
 <dcab1e61e451aeba27575c8245aef687caf94b23.camel@posteo.de>
In-Reply-To: <dcab1e61e451aeba27575c8245aef687caf94b23.camel@posteo.de>

On Tue Jan 13, 2026 at 6:59 PM CET, Markus Probst wrote:
> This is gated behind "if T::HAS_RECEIVE_INITIAL". And in probe its
> gated behind "if T::HAS_RECEIVE_INITIAL".

I guess you mean `if !T::HAS_RECEIVE_INITIAL` in probe().

Anyways, I now get what you are trying to do. (I got confused by late_probe=
(),
which I think is a misleading name for what it actually is and in which con=
text
it might run in. I think a better name would be initial_xfer() or something
along those lines.)

So, what you really want is additional private data that is valid between s=
ome
inital xfer happening at some point of time after probe() and unbind(), and
hence is valid to access in all subsequent transfers callbacks.

There are three options:

  (1) What you already implement, but with less callbacks.

      I think the only additional callback you need is initial_xfer(), wher=
e you
      return the init private data.

      For storing this data you probably want to add void *init_data to
      struct serdev_device.

  (2) A synchronous inital transfer in probe() as proposed by Kari.

      This is much simpler than (1), but still leaves the driver without an
      Option for the init data in its device private data.

  (3) Leave it to the driver.

      The driver can store an Option in its device private data, which is
      initialized in the first callback.

> Which one do you think should be used for the abstraction?

I don't know, it depends on the requirements of serdev drivers.

But since you already mentioned that there is only a single driver that nee=
ds
this initial xfer data, I'd say don't consider it in the abstraction at all
until we are sure it is a common pattern needed by drivers. We can always a=
dd it
later on if needed.
