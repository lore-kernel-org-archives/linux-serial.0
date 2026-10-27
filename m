Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099573;
	b=ZTbiImc/xovCykrZ+/TgA5hjechnFPQ/CgLZ6ybWJLf0TCyIf0KGAt0BPPTdr/twreUE
	 UGomRgwhCfPN0Ct+YrzWfr/Y+8c1l8iCZVF0ZqTqe/RY2Ddpo2TQ8vb2XX01jQ3dl+ofc
	 z3+aTsuHNoFnug3/a2r+A7xdNc2EPP4oJiDwFSrx1V+emKwhtWKE6Bw5oiJrUGbiNxf1g
	 TsNikQo27JNQI4+sLII9QWlVaKbzZfqFZURSp/e0oR3TE6xPLC3xOfK/mfz+px1s1UGqt
	 JQpRFgKk1/CuVeJs2bOiJS09UQv/bBLZulMVkgCz7SSRdf29lw/HxOfKeR8P5YZNw8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2NVOded0rXfvTvIIxCzYpL8Vtagay9f9LuEDqMAvqQ4=;
	b=d7CgIjLmhiJLtv6rSLfTd95l5f12ZQTsQNME7PEKr9VamMAhgZ8UlLhLQFHWrkI7TUq4
	 Mho0m8/W3zMVbaXVVVNhuL/INSSJcWMEgpO4G3OfXtSkxBUahcAbgGIjjsXj6QrKH1fQW
	 WKiuMQlwsyv9R4sQi7zjVGlj+PEWYnLttKRTu8a+0xrh0V1VZ7ULCHVFaUUadPM+0qzwc
	 zGbmGc6nNWgVkUsu+UvlWH2bLa045krfXIP0sFhs+QewkIWF2B1g+l6FRFN4M1j82mNZE
	 fSqzS7oPtvhUcnHfQBkdopAI/fXAYSS4w4FKc2JZmNMeElHvVR+QoCR4W0OElApy9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdCCBAa8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF486606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdCCBAa8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578421F01825;
	Tue, 27 Oct 2026 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099572;
	bh=2NVOded0rXfvTvIIxCzYpL8Vtagay9f9LuEDqMAvqQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EdCCBAa8gL/Or/jOEa6LEYvVF+lruW2fV7t5IN+1Noh+ej82gD2O04JyeWcCcLIJt
	 9JivbxUA4Aq0mvothHWsZz84T/HN8K1a9bgMoCt/Rvt6IOuX8OOC7jgFeULtiWP5r0
	 j41kyRBlt50KmLEJvRkBmBfUguZUwQ4Rq8W6vQhQZW7EnwBN/Fd4kBO+1AgnOxccFo
	 DsOOkKHL9fk8HR+dAns+be361PH9NY3C7++Rb43fnd+o4AmnnEkpKybxs2aX38dvhy
	 CmCys6px/phoAa40hzoZSuqgSQsbXAt1/6mOgcJpmBHc8JDcqPqBjV4wE4rB5h6NSI
	 Yv32lf7aWRI8A==
Message-ID: <sashiko-outbox-186421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/24] serial: 8250: hold hash_mutex across irq_info
 lookup and linking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-7-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-7-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:12:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Joshua Rogers <linux@joshua.hu>
>=20
> serial_get_or_create_irq_info() released hash_mutex before returning the
> irq_info pointer, allowing serial_unlink_irq_chain() on another CPU to
> free the irq_info before serial_link_irq_chain() could link its port,
> causing a use-after-free. Hold hash_mutex in serial_link_irq_chain() for
> its entire scope so the irq_info lifetime is protected across both
> lookup and linking.
>=20
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Fushuai Wang <wangfushuai@baidu.com>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D7

