Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873564;
	b=46SlEJFl/rlUnYPn7ixdBjUWy7Vqeet8Dg5oZQYlhjPwHDg+JyLaZ0B3/KAdCoOSY7Dd
	 8sbY+1kq1ARttPYCw3d/AEWVDPRj2NoBVA/PYwzM5JIzbi3X7nEfJ7f9Oz2cJle8crURA
	 bo/KRO1+1reXA/Gc16iFR2YGOdcGOI8eypt7DKp4RTpa55DVlX1dfcGmrEB6Ed4nl2a/+
	 RY3U4JelCFt9bYIw6nJlR+PUm1x3OLEpGC7nyPBmDHWSusfMuC/aRti/Y4Ef6PTYjbW8c
	 uT2Zo2QQTT+vLWCyePkPxReP3xE4eoFsgv4jzMBGQ7TanbzoyJrNlzahyFlRZbrevMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rbgyGJTTga9fgE3Ki3jzvdfKLLUE2+M3mPbkLTiEAh4=;
	b=nJgdsaxpQ3RfoK5WhC5n87zA6ZOkkuFviCQY4IzC/ZylS3kl1hjhYT5vDFhjv3/+tBKs
	 Hhlb3PrPSfWmX+hEexDnyVGe0zr93GothZDg1hM7GhrGwojHw23oIDm2h9afAiDtsJdKN
	 hmrpJC7dlBRxY+1l9lz3+G0ICWD2QRKrr4rpdokT3H1jHf4RnEnj/LjHBQEdPcTQZ2E5O
	 WHl0K+WlmakCQ197PwAmZe8pB7GHypaVYCSJ3Own/49Exf21fKc0eJNKIogRsD2/kOMrC
	 5IJj4+j+3VUv1cJzm3zhkFb3sD/Qktw8tTtWdUs/wght2xN7ArSveeM73Cs+3QVsH7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV6ZhXA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E6606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV6ZhXA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C4D1F01825;
	Sat, 24 Oct 2026 20:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792873564;
	bh=rbgyGJTTga9fgE3Ki3jzvdfKLLUE2+M3mPbkLTiEAh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jV6ZhXA73EVR4IQHKvqSrnWDVxT4/1U+I7RqCvnTiUm7SIVY/wzBuJeteSauo6ifv
	 RSs06O5UWPhhGx5BntlbZ0nuou8aIJE5wF9LyeFCl8fuPMRJ9OXeVRiiRWifdIwyFC
	 4TBQmWvSCLnhkMSuxDd/u12x4gN2yzBEeIUi16/X+HA3Z7VU9ojrH9nVgljEqnjdu5
	 oKZbvsufmgzB2zUmbw7cjnOpYqkhgnKvijcHfD6IDxCQScXKA8lkS8S9x8X21YjdB/
	 5U1qoZ6o5RGSmomblrd6CCuqLE59USgdel0bIjHTAekxvzGr564adv3BykygWFWHrY
	 7RcjcZji4pnVA==
Message-ID: <sashiko-outbox-183870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-1-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-1-286fc1b8c3c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 20:26:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered.
>=20
> Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
> Octeon continues to skip optional-register probing while retaining its DMA
> setup; on 32-bit builds it retains the generic setup. Keep generic setup
> for devices without matched platform data as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-h61=
6-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com?part=3D1

