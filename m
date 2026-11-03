Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668642;
	b=uG2/pLUWgE1BNUSD5lC8+xb+ImV7xeInuROu8mwiOdIOJ6xqqomTVIXgRaRtz+Z5biYv
	 8VuWYtnwXdc5nCz4HMLfX1X/ojB3JleOxGUuvYhzU72Uy1rAmlatEVgGrkBS8K1R+C86O
	 QguduqFr+Xmxyb2NB1RnAC4YpmkYpUbif38vcWILw+mXjSVb97/rLp7PCSIBduUj7YBW6
	 dZ/62v+zKN4VLuSUI+FDcUR/uqKrdZMHJ1XJTVcxw7/h5uI46+BCXa10lfqY37eC57JFj
	 dIUsIgRZlx9BAz5yBih/gr7X9gnjgodpqQ1JjygWuzvj15nLLXlREyrtRXXYu6DkzBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mGuf87FRa/5xSLWL7V99f6qqu0kcvZdIvkAqfRma/1w=;
	b=ANSXfiXQ6hdFUcCvYBgDdEGzwDD4CycY/LhV0Vv4Fqiz+T1eEhN6zmJCOAEC+OFyeK24
	 r5tnRnwVFkjM8AzkjfMxHarFwSd9QBzPmdFZ6u4yId5V4lkSvX8TPthxYgIV8cr3GsjwE
	 Bc3XfhrrEdUyuoIXlAr63ud9PvbHx1JHXYqopJ0+UbwdzqmCcPrE6S9/JvG0EZbdXR7aS
	 l9r5IRBWNwK+mo6+9OK1tD3VT9w8adReUWhII9s7e+ebq9nJY5WFSEhRlsJU9GNrQtvYh
	 YZTgSkvEhV+RgDMkaoZvfd0W13IQIYI+adReF5P3ZMXHnDOnwgEnNlh8Q7Cw+eeq3zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6GsTD2q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978E606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6GsTD2q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7851F000C1;
	Tue,  3 Nov 2026 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793668642;
	bh=mGuf87FRa/5xSLWL7V99f6qqu0kcvZdIvkAqfRma/1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6GsTD2qhjnadaNd1hq1DYJ2ggOojj81nou8G0xW9r5kKOXd7wNCilDLRx4Zfy+oz
	 Kl1gnWAiEULUY2yjWtaBQDehkEt2cDm8ziPPA6PMXxQMrCrUzk+vnrjLOWpDDd+L9D
	 jRTHCqLX3bKyBX0/6WtAT2ajm1uWxvIG1eRCDU8hYMga7NuE3YwBMt8eu5W1CqiF6a
	 3rY9PrxeiGiyWxgAIANXbnKJGbQWRAQn1kdgovY+g590T3iruRN3xFz6B25Z+OJCsR
	 I4HG9YyRYhlAyFZhWYuzSskW3L9pEWOM9Z/5xP50SnepqaPDOLGOWllrKHhEnpzAK1
	 kWYyKBHXhyMaw==
Message-ID: <sashiko-outbox-194421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rust: serdev: use Delta<Jiffy> for timeouts
Reply-To: sashiko-reviews@lists.linux.dev
To: "FUJITA Tomonori" <tomo@flapping.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103011143.917147-1-tomo@flapping.org>
References: <20261103011143.917147-1-tomo@flapping.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:17:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>=20
> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
> which is a c_ulong alias. The type does not show the unit.
>=20
> Take the timeout as Delta<Jiffy> instead.
>=20
> The C side treats a timeout of 0 as "wait indefinitely". The Rust API
> does not keep that meaning. A timeout of 0 or negative is rounded up
> to one jiffy. A caller that wants to wait indefinitely passes
> Delta::from_jiffies(isize::MAX). That value is MAX_SCHEDULE_TIMEOUT.
> The C side replaces 0 with MAX_SCHEDULE_TIMEOUT before it waits, so
> this gives the same wait as a timeout of 0 did before.
>=20
> Reviewed-by: Markus Probst <markus.probst@posteo.de>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103011143.9171=
47-1-tomo@flapping.org?part=3D1

