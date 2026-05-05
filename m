Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F2EEC0;
	Tue,  5 May 2026 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939388; cv=none; b=rN3bRcQ2U2mxsePAEIV/Z0oape68TYX4+YgzCs3p4O3HKUQp0BmGwdHRyPD52bw61tKgHmo73Ktx4n1Sxrr+TA0KXHAOZhxyXGYQ3FSr2ix3+8frtpHzZHGplEMXDW0fSXJAtyklcc5jlHt+kr/k7a1haNjmS3OcsW2u7Cm63Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939388; c=relaxed/simple;
	bh=aXy6Z/Hgj61TCbWjQBYjpxTjhDiemSubJbDoQZ7vIds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdMcNC+j2ZDHJS4EuU+WFppu1fPw3mfVXp4ZswzFCzz2dqTd9POvF+/+75qJ7bN5gNZ70F9O4Lw57pbGy+0KBuIgvJY0URXx2z/QCDx+zmy6mNhZ4mxA9rHtEFIYP9MSxhypJ1mA+Qxt+t/gQ2KP7uGJ8lsEgvlnN0UJeMAwxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC13cDzt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC13cDzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C331AC2BCB8;
	Tue,  5 May 2026 00:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939388;
	bh=aXy6Z/Hgj61TCbWjQBYjpxTjhDiemSubJbDoQZ7vIds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KC13cDztD/0U65hHLB02E0r6/JHTASe3RVXsELcgvuM66f8qdP2NxXpy1gh6vzbRH
	 GuuBK4vsx3RiUcCTQ+cpqITU80VlmYfpHCnsFAusz/LmyMgoTjQtUAfeej9pcc6jZi
	 MZN0PIN8ka9ToQE4Y/rriyRfY9aZ+4RLLq9qk6fqsKJ5IH+A5Pife1mJ4NArjN3pm9
	 p/eAgNg5iQAUbvd0C+SB0D/zDFd5ATeAX3jWMpXCPBbGhl+Uzg+EAESEsZr6Q6mfn6
	 WVxjp55lvrD3vzw1JWOfQORp3GLqsfakZ2AqzSaqbE6ijveQE1fx/7GopIgN4vg13T
	 vuY8F7dqh1dMg==
Date: Mon, 4 May 2026 17:03:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Haren Myneni
 <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Julian Braha
 <julianbraha@gmail.com>, Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH v3] tty: synclink_gt: remove broken driver
Message-ID: <20260504170305.06aa591b@kernel.org>
In-Reply-To: <20260504031519.18877-1-enelsonmoore@gmail.com>
References: <20260504031519.18877-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 May 2026 20:14:53 -0700 Ethan Nelson-Moore wrote:
>  drivers/net/ppp/Kconfig                       |    4 +-

Acked-by: Jakub Kicinski <kuba@kernel.org>
