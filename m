Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670414;
	b=o1CWevSRB8o0/0s986+BRinMYKjnERZbzGD/5dW4YOmJh1pbRlhyngOKdhPxRvtVxrQu
	 WAB/x34Ru5DLd2YPIpXBW+fKLy0qOCxjJKUmU4j8+3QPOoENgxaK9+//v6lixUwJRzQZY
	 O7o3vAucAaxFGK5O27NoeE8KNMlmeU8fnFK0NmZtrufLzvYUMjJvhEaadTUdddcdPSwM6
	 sbJEg1TiULeaLJv9wwSc5JrKhYb4KwlEx8eTBcT6fuEKJVS+Mz0Y7jtzshOWXab0nmWGN
	 SNkcKO6JCsERGIYsutXMzIthNm3i8XQQYgzl0L3+kVjkiUXYMx58pXl9S+ZBC21jNAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670414;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z3QTa8ms+txC3lYz14xIezLttDZPt6XXlqMjf1q/6Bo=;
	b=vlM6pJCm1A1pjMkzst1O6hLoq8wf1lPMjqDjhBO/0KTMtQG0MCuRTjYgOnlXLb4vo8pe
	 Dn3lft48xUDEluDAbxJiJnBQhyy3QGPo4bK20biWp6zV/klAilChCeVkFI1jUsCPtJPXB
	 Pz8WyXxN0AN5eovLs8k4n0S+Vvz2r4LKzXkmj8FUTB/2RUKvJI4+HGby4zDkNNdO4Pdkv
	 ioUuWLDzQPyvqLqfvbdM0Dq43l6rRoRfZ/hCryWr7rzfZzAYJYnZ28EVm7RpyVW9eo0gI
	 7ASwOSuvfs1B2cvyMjHzJ+3TwkEtkYol6rRyTUhGFED0CB8PWFe1rzIVndJlq/k1X3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6fVlOb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6F606A31B
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6fVlOb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F191F000C1;
	Thu, 22 Oct 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670414;
	bh=Z3QTa8ms+txC3lYz14xIezLttDZPt6XXlqMjf1q/6Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6fVlOb5B5HoidOy1D+3XWAbyNQND67+UIxVw4ZyBMxYuhWM+ktTh6koKJ64tqtRD
	 IpRznutKny7H8ySjRssQZigoqNMzrdJdebm3DsWnH7F1/3CkCBnJk4jHp7AfkKsC9u
	 BjPTfCYuZZep/WaoeUSJ8OVXR9fp73c7tcbDasusLZVNdqSQ+ZFg2ghMqpDPGvp9ov
	 eJ6COBRn6lcY8SzZgxevyGNntKeUpBO0Y6rwtMiwiW9hSVcVcvkPB648VlSWDG7x8V
	 YRsvEzrSG/SJGgAdGD6OadxELDkXwYO9dD0624vKOMp4nWznzIB+wlQfdrQlcZK5lo
	 j0j2FC3EeHq8g==
Message-ID: <sashiko-outbox-181407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-rust_serdev_probe_refactor-v5-4-a27d862a415a@posteo.de>
References: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
 <20261022-rust_serdev_probe_refactor-v5-4-a27d862a415a@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:00:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Initialize the driver's private data directly on `PrivateData`.
>=20
> Introduce `OpenGuard` for resource cleanup.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-rust_serde=
v_probe_refactor-v5-0-a27d862a415a@posteo.de?part=3D4

