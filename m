Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEE38D3FD
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166442; cv=none; b=uyG20T9KEGvqTWmZoIcNmTIJOSxBz5YN0yiHzX+ONGpQsrawl5gZlj0+TfiQ4ng0dszzn2Fu22QpAoTlmBIdJTv1pzRkSQN293j6Yxz/BOM+qSiQQjneO67yznsvoTmzlpPatYrNz197Saw48rsrxbgvbcOao9yc3GCq2PY5rGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166442; c=relaxed/simple;
	bh=+WkP6H2OBCq91d83Xya9TlV1W8uyyyHKMDG2pDhstPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ripGvteQbKAu/kLxjdnebO31kBx4j8pwgKLW5NYs1MnBnlVvumKZ20qNsbDGLWlt5qFkkVuVYIyrG0cyuBeqsSG91reDc3LwiNi49T5iFlfKAmz5rCiEEMq5qOBHPeK2sogPntjLuMWCiwFLsh3vssSDwU6cMLoOnYZjAGGi9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzU2HEG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzU2HEG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFCF1F000E9;
	Mon, 31 Aug 2026 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788166440;
	bh=+WkP6H2OBCq91d83Xya9TlV1W8uyyyHKMDG2pDhstPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzU2HEG4UDqf6amF9G9/9DfyvKrhGqego9HubiKXJGRehB/0TwMnDqIaG+do2T0z7
	 6Z16RB9KFxvqXq9rpLHuzJ9hz7PhtVZ/Qn9izqegfuahCeKzJ0Z4nHwtYrCC7R30nv
	 6aG2GjeEZ5ZhRXKw3SwwozdHx3uz0imvzOEmxmq6gutTHGH24mEkLwqarCooFEhFhX
	 lCeTn9/QyAWtSA/tBSBWJpHm6V0zaJ4em3fv013RUCHTN3z6lRjDQLHc+KiIfqxWMa
	 A4RD/eKpqDfB/zTc2pxvBFwv/G0ENh5Sckjq2ljXaa4IyqFQxCz+KUWNxb3l36ib+H
	 B3azir0vZmsZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] tty: port: replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831-tty-v2-1-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
 <20260831-tty-v2-1-88cd58c3c640@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:54:00 +0000
Message-Id: <20260831085400.6CFCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> tty_port_alloc_xmit_buf() allocates the transmit buffer of a tty port. The
> buffer only backs the port's kfifo, the data being sent is copied in and
> out of it.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-tty-v2-0-8=
8cd58c3c640@kernel.org?part=3D1

