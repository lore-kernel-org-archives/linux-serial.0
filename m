Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102548D893;
	Thu, 13 Aug 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637435; cv=none; b=ouio0rUJkFleCwTbT0MzuCH6vUw0k0nsB5Fd1+SSR2W8TB3LvfjNbQWFYDM05oY9smYLaF5+bEBQqu7xGtjmJdjq+z+OXzT48cZGYFcn8qq2ZEuDwC94VluvHwiBCgpuhPEwIPUniBJ1vkvAoVwl6b4elFKQyDEOm1bHhtAN9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637435; c=relaxed/simple;
	bh=Mtp5EcHSWvPhAbxGUw5m+zLXaONkMy3lXpi147Uayi0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=bUoyXPTp7SNaVPmzRZQIyQSAYpVUQR9gNh1gi0oxfcfp8H+az7KbmcFABjcxAUgwNoIx8NyVq6SbI80fFbdm5dMQRefs48Haf1vpRRaL5FAKJ6ctd2YT1RTpQs4BEHZBWN8LjhQFbi7o+vB3nHwHqx4vasHNOcM56Ikzpv3LE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfAe2O09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfAe2O09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964791F00A3D;
	Thu, 13 Aug 2026 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637425;
	bh=Mtp5EcHSWvPhAbxGUw5m+zLXaONkMy3lXpi147Uayi0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=IfAe2O09B00SzgL6iUgvNWEfyokuwSos10KZI1CCX47stIad5o1CABgtCf7y/rRif
	 pfsDqYl0GKBLOEmexEJoXQoLSdufHqFzHE0pCaibfVEjLARl7wmbi6o+nUrxKywkLw
	 ++BeotHyQV31W1RqIQd8nk6YEiB6NYS4gCT5bEk6EexUwylEpQlOnZ7z+st5hYrCyS
	 h8iDRoOMl9q0/jQfxjT71yjLCvP+gtZFFW+UUbB4FMsNbG6Jmt1IR4TcoY7HcCRlUq
	 TpyyXOlsBL7bPOx2NGrmbAkkzL6n9Oh0eOJE1ggGZR4GbM4YIEDWe1IDvaM1k7EQ+m
	 01G91LLfkrMhg==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 18:10:21 +0200
Message-Id: <DKNY3WDXMO6Y.FGQ71361WGUG@kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field
 access
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <driver-core@lists.linux.dev>,
 <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260813152444.514580-1-dakr@kernel.org>
 <8e716c8ed7172fa28b569bf59a146c262a29e0c2.camel@posteo.de>
In-Reply-To: <8e716c8ed7172fa28b569bf59a146c262a29e0c2.camel@posteo.de>

On Thu Aug 13, 2026 at 5:53 PM CEST, Markus Probst wrote:
> Should I send a patch regarding the 2. error?

The second one can't be fixed with a patch in either of the trees, as it is=
 a
real merge conflict.

This one is only fixable in the driver-core tree, since as_ptr() is a
preexisting method.
