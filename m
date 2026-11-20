Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160395;
	b=pwMwA4a+wH7dKMuA4I4Lh52UgQgLbYol3TSyiTanFNkFZ1HtGFGAykRlqSm3zvomkeUH
	 yP1FYrN2tAFEoqTsHiX/4H1sO1Gm3/aBBKimn4vJ0WbI/aarMDvn0JqYFKqd3BwdyeH+Q
	 UHrUF31bT30tDBXg0dtS3SUL6mMv2kzXYINN3m100pHjcNOIFqNWkZS1D5MIo8qaAICGV
	 DkD97iYXhIIpz+fNIm2tZZJLmzKOm0PX1LGqzWgGCDuh6m0IldGoBKLlBOq4Z9yDyngao
	 c0wsHm3kif9GIwEarPLEjzJkizOImVk+Uz+x4z22+EQh7KJ7eCCpV0o5IskNDGOCM1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=281v9l0ySfen5W2wSaFKAN7OPOCJQl5o+cFOhoCAqxg=;
	b=etHMKrSvZH2scfGul2CeyVLyUAXsIcgR6hiOYTEgYisI0X5Sfd4Neg66nL3xHy+23L38
	 KN+Abvw9a6OUmUT2Y0XGcArIk/YHGEyYrBSct3oeSwtSv6SMQVBO5GYAf8qiuUhdjn0T4
	 9x8U8Ld7tpLdWSFxoTS35Kwmqf3FfunYHZ2BrsrulQRmQFeMpsYuibXw9FuJlwGvbO2O+
	 X1fWGIIMpXMWtoQBx4lHbyY7CTnKwRf1L4vx3fn5B3XD36MvZZxTkTw+Y0KD43gCP+wGB
	 BC8TWMY9gURgc7oNwuNQEc35KcjpFyh+pD8Ek2855IVvqEpc6EfnrVIaJ9ElG3tyrxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1ZuvYaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9D606A320
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1ZuvYaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0846E1F000C4;
	Fri, 20 Nov 2026 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795160395;
	bh=281v9l0ySfen5W2wSaFKAN7OPOCJQl5o+cFOhoCAqxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1ZuvYaYMbBQXIarwRau5hb9sQVeu7XT/tS18glzgsyEdi5TF101K3q/v6RCbEEfK
	 9UM53lXYeIqfUHlA7AW5kh/yEnBujS5Oxbqwt7rOVce/JEWyfwdV1neFBd/Da6O0/I
	 VAEIrDcFmW96u0VQywbFlrnBIu/JC+aFz6CUFJQVRtQ1oq3U4kpLS/MsKspTg65Yip
	 c1zeeFJ1E9x9HqqN/IXvxaLEIjHT8g4hbFiXFs9iYoPJCW5i4IcFA3dEdeyIxqcXro
	 L3wcdBloDa6zm3O9XFOiAy09cykIcdAnsHxTh1rXFFtE3i8Y5tp71eHKI0aMT8xq7k
	 lssn3FwPVCSNw==
Message-ID: <sashiko-outbox-224640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: max310x: unwind only the registered ports
 when probe fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120-max310x-teardown-fixes-v1-2-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
 <20261120-max310x-teardown-fixes-v1-2-eb52c8b612df@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:39:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_add_one_port() queues work on the port it registers: set_mctrl()
> schedules md_work or, with RS485 enabled at boot, the RS485
> configuration it applies schedules rs_work instead. When the IRQ
> request or the registration of a later port then fails, the error path
> unregisters the ports but leaves that work queued, and it runs after
> probe has returned and the port memory has been freed.
>=20
> The same loop walks every port, and a port the register loop never
> reached still has line 0 from the allocation. If another chip holds
> line 0, the loop clears that chip's bit in max310x_lines.
> uart_remove_one_port() returns early for a port that was never
> registered, so nothing is unregistered, but line 0 is now marked free
> while the other chip still uses it: the next probe is given line 0 and
> fails in uart_add_one_port() with -EINVAL, and when the other chip is
> removed its port 0 is skipped and stays registered on freed memory.
> Reachable with two chips when the second one defers on a GPIO, for
> example.
>=20
> Unwind from the failure index down, with the removal helpers, so that
> only the ports that were registered are unregistered and have their
> work items cancelled, and take the exits that come before any
> registration straight to the clock release.
>=20
> Fixes: 78adccac1ff9 ("serial: max310x: Assign port line automatically")
> Fixes: 5d888f1c32e2 ("serial: max310x: simplify probe() and remove() erro=
r handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-max310x-te=
ardown-fixes-v1-0-eb52c8b612df@vaisala.com?part=3D2

