Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174432;
	b=a22pGI/LbU2VHFLfWUAc7JkH0eNu1AmgeTAJoAHfXWtqxiGCfU+A/+SQpWnqni1YtzaX
	 QW54RaK35YL1NOpMfK+KhmmEXEomGYRbCU1pJyMUFiUdSuAZQ8FYj2b7eYThJuoXbuBIH
	 RYHeBmhot94wg0YnUjLW73sNouH295OH3VsB3GNvVpr903Cr9/1I2tAAc1Q8XsB06cYH0
	 jt1yboS0/f2X2Z8lAN1PDDLtHR3CNO7hKTplSTeZL/u6AdZk3F8z5pdtzAPIasTEa38zc
	 VzNklAO98N4NJRAT4yDYtUug2ANst0Wi2Kjxlul/bvm4weOO5MH3Ubwc8AGqiLiUspQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174432;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sUk59b+T2K14YuMo3CJoRJci3s8ihXcRp7M6vLN0UUY=;
	b=vIWYLYIgBwbCoE5NxzCyY3yUVZbtASOw7wDxFuklOXs5jy/7dSQBYFpw4BlRDDLv2fPs
	 18LbkfroqMbyPj518QoF6gKT/Gndp60mHbDkJ7aNTZ02BtEZj3hqyzxyOfAHFU8Dws2He
	 7hFT4n0Cj2v9TrEB9zdFiXqs/vVr6bkDypVFK2YAoAAk9panHgn+qUbTC83mY0fiEAgWw
	 PwCb/1362QtLKAEFWQbPCwlLw7v6yHFovcMMEe4XNpxZ/tXuY32iCrz1lFsBfvREL6Hra
	 FD1qGyoRQdBqvFfSSzkzyX3b1+b8vZKreEk3u7Tq/8t1+ZoPEhxjez10msdsnosVqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz7CEkNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC39606A320;
	Fri, 20 Nov 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz7CEkNN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4814E1F000C0;
	Fri, 20 Nov 2026 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174431;
	bh=sUk59b+T2K14YuMo3CJoRJci3s8ihXcRp7M6vLN0UUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qz7CEkNNS9GFr8NgxhYKdUfytRX3Qhu9kFy9M+07vHDjkt4Avx0n0n4S6/PDbmK0G
	 hNthdwuh9XKRJN+yQBhP1nrC63jnBTeljPiKIq+oEEN/N78g6VuO/WBLaQRxQIYFcu
	 fevn2Le9japoDsqYsdUg1IxbYB/1UG/kHQ2OY/GjMyYyCdoO/t2k4Xg0lCBCZPrRtu
	 SNLbYxlrxxgmWq2uSJ+6bV/PznC/j9/F3/vCTq4kXJC1N2JKnCZ+VWrjxM4tYQoOVW
	 6sQozZltBUtxUC6t1hoCOcOYG0nlexCfu7ECwKpVGB396q3Rm2VGzxq9iQxB0n663H
	 a90js91TUVltQ==
Message-ID: <sashiko-outbox-225055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: reset ldisc to N_TTY on reopen after hangup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261120112455.1353962-1-johan@kernel.org>
References: <20261120112455.1353962-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:33:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Line disciplines should not call into a TTY driver for a device that has
> been hung up as the underlying hardware may have been powered down or
> resources may have been freed.
>=20
> Since commit 638b9648ab51 ("tty: Fix the ldisc hangup race") the line
> discipline is however reinitialised on hangup which means that ldiscs
> that register class devices on initialisation (e.g. N_SLIP) can call
> back into a TTY driver after hangup.
>=20
> Commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup") later
> moved reinitialisation to open() but that still leaves a small window
> where an ldisc could call into the TTY driver before the device has been
> opened.
>=20
> For hotpluggable devices, open() can also race with disconnect,
> [ ... ]
> Fixes: 638b9648ab51 ("tty: Fix the ldisc hangup race")
> Reported-by: William A. Kennington III <william@wkennington.com>
> Link: https://lore.kernel.org/20261118145636.3534234-1-william@wkenningto=
n.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120112455.1353=
962-1-johan@kernel.org?part=3D1

