Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816823;
	b=y2zZQ4y1wley9H0/dyNQ32X/T7PHRizursEj09ptV7bwQGwAIJM2m2FF61yXIbcd7Os8
	 OyP3wE/klWeS5Z1t+iSTWRjhAJFpz5MzrkDZHKTJ4sHaNEky3zhNIj/XQjV52Xuu0zEu0
	 LdHsj3V04U/rfI9iTlB0q4cK8+hLzh988WGe4ZcIqry2J9PmvRv8xTTY8sNW0yR1o5kxR
	 XhrzwpBZsCCVgK2orz9/gcxLw++PkFn7ky06r4USmMqMcyGFJekhWzUlFJrR0gLktw4/X
	 X8iSuv2V5GLQhEOU5WtU4IU5d3QiAor9+bOAcjrmcbd+HF3MQHXakYY1A/Mvq3fCqEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8jGVP2F0tdGRU+0VTjbCEvW3JOnewwPwtmy1bPgadt8=;
	b=G93oZ8STMX2v0gqdVctEU/vGcwYKwATTZp9xTpsrnCjeJB2BTewiANXAHR35gwDSNl6J
	 s2lIpo5Esol17Fec9FcHwxmHQ7+eN2tM1506Kh67hATdtlyqQkASdAhL9b2nfqXGPekdv
	 xl+hH6mFIAUyy6eA5V4G8UnHoUqPGyr0SnX/p9doM2eJIy0xwGDqMCv6HZilKkG9SVoqt
	 I9LlCv1mgW/ON4KJyaLj4wtosBlBuFqmaUgkwt9cWEXy+ddRGm1lBuJrlEGb+VvNySkHp
	 knLI2TrAc98JwU7E7XdNKewrokbAyDUptjRnVJfx9p/HnSgjfZcp6B646CkWIuD4EwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0lDzl94;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A673606A332
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0lDzl94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1E51F000C4;
	Mon, 16 Nov 2026 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794816822;
	bh=8jGVP2F0tdGRU+0VTjbCEvW3JOnewwPwtmy1bPgadt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0lDzl94sMkpVpb9YLAYFntLob/LFEqwYjulDla3jaWSXtsaR9t/xANB3bnWMn3jB
	 7Fno7PY3zndpf8JY4bNZVY30FPW836BCbdgqBhQH0vEW4xfCDjdNUkAx0s5Q3mK/nJ
	 G8rpqvrlLMMJwmB0OkplwN6bVhA3WsXhzeybPk8jKP7pS6Jk55EMzy/P3z47xYXP+T
	 QSgGU5fvwooC/PcCM5uYdbgyzTgcAtxyqcuibvV0KFJSP6szvVKyFrEB4KicTN/7Ey
	 kcREtnMY/hXmRwYMJjM6OHmWgkO8egOFNQdp1Cu6qWPfiBeNSAB6UzeAfD8wzQxphr
	 uRtw5YcHdLvDA==
Message-ID: <sashiko-outbox-216516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: do not touch the port after
 dropping the last reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-serial-core-remove-deadlock-v3-2-899237225221@vaisala.com>
References: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
 <20261116-serial-core-remove-deadlock-v3-2-899237225221@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:13:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_port_deref() decrements the reference count through uport->state
> and then reads uport->state again for the wake_up(). The last
> decrement is what lets serial_core_remove_one_port() return, and the
> driver may free its struct uart_port right after that. A reference
> holder that drops the last reference can therefore read the freed port
> on its way to the wake_up().
>=20
> Read the state pointer once, before the decrement, with READ_ONCE()
> so that the compiler cannot load it again afterwards. The uart_state
> belongs to the uart_driver and lives until uart_unregister_driver(),
> so the wake_up() target outlives the port. Drivers that unregister the
> uart_driver in the same remove() are a separate matter and not changed
> here.
>=20
> Found by review of the removal path while fixing the deadlock between
> port removal and a blocked tcdrain(); not reproduced.
>=20
> Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part=
 2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-serial-cor=
e-remove-deadlock-v3-0-899237225221@vaisala.com?part=3D2

