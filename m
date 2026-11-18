Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979513;
	b=qebA5BV34nhpUQlY3P6kHuFbWSqW6XS9vGibh1NPpjivR9FxaB5DOQw/Fen+s8CRX4hT
	 aCknW0Gq1YcGsuLnSWELy57Hocx8cuG3fej8KztQWOl6OObfAJtivjxkLIwhWcv7dMzVC
	 nQkAi5+EnrHEIJo1J8erxftjvjpqRILrc4yWiA70G7qE7F8sblks0vRfhFJem6zsMQAm1
	 oCNKpBJGsY0dnHLOrezpyjz39Y+pcqrpuiIaZFVvvA3ehWoni9cEkwTE5oC4ePOXfuFEd
	 Lcf2jonp4XPSI/1ltd1yHA6gCruwE81Qm6OFLP7x5pCiMLW/tdNEZIGNcEeoIHPNuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4DRXRwyxPgLekVOHcPBxlST01UhHORv4J+YCCf+FlfI=;
	b=H8Mkvew2ueVpJRMDFfGdRdh9r+ot7nEcsXpdFsiGnQzr+HlZriwNNNFJrK7L39frDCGi
	 K19rVPRjGCeqRL1vvJunwm0h9eBKZMitH9JHA5FGCNCCxuSxztLZNAqifvbrnXzwlZxXo
	 HsGgWh21OkVz/bsnAmGCMSaMWutdFAwv1XIZI0hMJEdZqH3p/vtl0omDIj3ac+whRZjI+
	 KjtljqC9jbS+e5+422+Gqm9vQETZEC4z7LV5yR2KxQWQJdfJPugoJD2VAC+G70ODMJGo/
	 Q82pW1sW+SR85pQWHqEypYsolsLdG3+ZDqjSJr6y7KDMaNUozk3ytRfBCq8lOAszuMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XHHQGynu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF0606A31C;
	Wed, 18 Nov 2026 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XHHQGynu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C326B1F000C4;
	Wed, 18 Nov 2026 05:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794979512;
	bh=4DRXRwyxPgLekVOHcPBxlST01UhHORv4J+YCCf+FlfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHHQGynucuaHpDMZ73ApRibVw4akXZhkNPrKImIe1uu7hozRTKuuC0YQ2vYn1oMFe
	 zYpbKU5gIrfd5uyOIxmZRHtqP9v7rHXjhupRGJllgtFuy6wdnSD2gGcnDj8Nroz37/
	 5tcTy5nUJe/NUIioQe2HQHucy2F6BbIfvLMgRXvE=
Date: Wed, 18 Nov 2026 06:25:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <tomo@flapping.org>, Jiri Slaby <jirislaby@kernel.org>,
	markus.probst@posteo.de, ojeda@kernel.org, a.hindborg@kernel.org,
	acourbot@nvidia.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
	boqun@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net,
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu,
	work@onurozkan.dev, linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v3] rust: serdev: use Delta<Jiffy> for timeouts
Message-ID: <2026111857-boozy-hamper-7924@gregkh>
References: <20261103011143.917147-1-tomo@flapping.org>
 <20261117.200726.1503876918333666825.tomo@flapping.org>
 <DMXKAJKEIMFA.X1EWOKG0JRWG@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMXKAJKEIMFA.X1EWOKG0JRWG@kernel.org>

On Tue, Nov 17, 2026 at 03:39:22PM +0100, Danilo Krummrich wrote:
> (Cc: Greg, Jiri)
> 
> On Tue Nov 17, 2026 at 12:07 PM CET, FUJITA Tomonori wrote:
> > On Tue,  3 Nov 2026 10:11:43 +0900
> > FUJITA Tomonori <tomo@flapping.org> wrote:
> >
> >> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> 
> >> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
> >> which is a c_ulong alias. The type does not show the unit.
> >> 
> >> Take the timeout as Delta<Jiffy> instead.
> >> 
> >> The C side treats a timeout of 0 as "wait indefinitely". The Rust API
> >> does not keep that meaning. A timeout of 0 or negative is rounded up
> >> to one jiffy. A caller that wants to wait indefinitely passes
> >> Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
> >> The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
> >> this gives the same wait as a timeout of 0 did before.
> >> 
> >> Reviewed-by: Markus Probst <markus.probst@posteo.de>
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >
> > Gentle ping.
> >
> > Danilo, could you take this through driver-core? It applies cleanly to
> > driver-core-next.
> 
> I think serdev stuff usually goes through TTY.
> 
> Greg, can you please pick this up?

Will do when I catch up on serial patches, thanks.

greg k-h
