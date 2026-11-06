Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927550;
	b=cot8km6gn9W4a3t29rNQByTWB6O1KWMqyg+7XESMp6uXnex8qi3AfvUKzua0mZ5U5+pa
	 ddKoZMwGywe86AtlW86avnkXYO9gSP5rgsUYhoe1xvcuthaJVzZZig+lot++AOx9W3gm4
	 2XaRzXzrhFtj5RAOOWutRUm54hMXAudpFGZc1bN69Ii+i+8FVLtnorZcJjF/kq6RAej+o
	 nH+jm3tzvpUeHWJ7lkFdKaVXcy1mh8c1yzp2E0j37o/bEab6afYkBcM1SUK5pCkeLxFQY
	 5Nfl22NY7TTRq/1ovKUrNlF/+03qXFJUqhkYr06IT1B0rYy9zZUjBvkHNkVMrW0BHrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927550;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5suAWvdwrAXGHA24st1HvPcwRCXlyHUJgGCedr8xSEc=;
	b=qPcG1kmRWJfM0CbWIUpQ0jxxViVuNZH8V9KIjZw2BSgyLSbCWJPn0T1Y7D3v4U1CPNqq
	 dJOeSoJtJLw80dNLm/v4S5Sgpq16ONMcMi8LWZbqSwSrzYzedJiayrXhdX5efVnp7a3uG
	 sQDsQDL7ep4tbW7Mh/ORdduWw5JUBkUKiKKU4vW950CMu+TvHpTE+bDp4Vph0qD7NqKhJ
	 IK1mun0o8emsdySb/6EDJk+XbgcaLrO5JjrQg25pl5sv+i6rE5pcTl7zi07677lPiED9y
	 8yZ1E8NtBvHb4FXWnXDF4XYl5hBacDyY7u1ObLvzdy8sJffG692HKPBUN1uTz8bWSKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJxEmEWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8F606A31B
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJxEmEWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96D01F0089F;
	Fri,  6 Nov 2026 01:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793927550;
	bh=5suAWvdwrAXGHA24st1HvPcwRCXlyHUJgGCedr8xSEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJxEmEWDU5z7f5jA6hXKp5bWeKwmf2esxiKKqHtK9L/gmGHBmjfUIhi2SxJbCzrLU
	 OMb2U6D8PjhptaPghXS1ltJqSaG91tnKkvqvH3P8TuTF4oO+TNTbL5xuKb1nz61x0z
	 Sol/uX9/QiRrp8SjErrLA12JXyaVmdqFd+6FiaFpc/wR/GrGTqn5ZqbpycuL4S8ts6
	 qq7cOIHcTFOp12cR6BugyTigIzyce/Xqj3FMcpg6295QCCmZMMBP6B5jv+z5SF7Nws
	 KF+GGjy++QFha20IO1pHGq3eTx4Jkx2MPsfs9li160aQQRiJ0aCshjp9A2h7Ug6WDU
	 9jWTFSrCT4I3A==
Message-ID: <sashiko-outbox-200485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: mps2-uart: Remove the ports_idr entry when
 probe fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changyul Lee" <lcy8047@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261106010611.1708587-1-lcy8047@gmail.com>
References: <20261106010611.1708587-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 01:12:29 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> mps2_of_get_port() adds mps_port to ports_idr, but mps2_serial_probe()
> does not remove the entry when mps2_init_port() or uart_add_one_port()
> fails. mps_port is allocated with devm_kzalloc(), so devres frees it
> when probe fails, while ports_idr still points to it. When another port
> later registers the console, mps2_uart_console_setup() looks up the
> console index in ports_idr and uses the freed mps_port:
>=20
>   BUG: KASAN: slab-use-after-free in uart_set_options+0x650/0x7a4
>   Read of size 8 at addr ffff0000018c41a0 by task swapper/0/1
>   Call trace:
>    uart_set_options
>    mps2_uart_console_setup
>    try_enable_preferred_console
>    register_console
>    serial_core_register_port
> [ ... ]
>=20
> Remove the entry on both error paths.
>=20
> Fixes: 9f25e07b882b ("serial: mps2-uart: move to dynamic port allocation")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106010611.1708=
587-1-lcy8047@gmail.com?part=3D1

