Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649850;
	b=04ufZOMvpYcxR340ZdOd2MEvyWvqsFsRYzEJyLNj2pY/QCiS++zesUeJbySJOrkuox8U
	 rPm5H1L7xDKi8Pf41BPJsJ0HJN9lLSPUoBmWIkZ0sfX91199RPxv1fGJjBlhFlnZ6oeQB
	 Oma4C9ugr1Dk73pCJV2Gb8iJynC3gd1qygljifLlyxutlOWUCa740L46gQwjCc8Ht3GT3
	 b3Hh/ixLyddf6qUiDc1Fj+o7f7KDUqpKE+nvM16FO7XnJswKhFC1QEVlBDC8XQhEwM3BB
	 e3IhumsiQbK2JLKhtcLSH99pvCtJpM5+UwaGXvH4UaYAbFzZZ2Xc9dNOSPJRpaCW3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J0Uu2CVm+aK6qphIKD2FczueIB0qmqGw7i5rV6613Tw=;
	b=JH2YfODAAgDNWuPXW0iv9Kte5aFuGJjDqS103tUjIo1WkPW2iubLMp1hvAH2ZBi3/meZ
	 N5Ep/TMxAfrweEKhuf/YZw6nIWzefb4KwUCrPk2KxXmYkhdbLfKF22emHzaFwrWwn3tq9
	 0+2+Pt6uQ/ec+1Fy/zDCdQyEWewwnaAbLnr2S5TpKHteBx5xaoCx8sFsEBDSgVWcLUo5N
	 rLQwxlwhVzgZDxqmmQoYkhjwsMzjAyOAspeYYMwubw/NjtIreljE8LLvtuIIgqiQ3FEbY
	 XQhJxIngIUysotMa8eQdapg2qQHjR8yKkgBGJWNQ/0yS+yFbDS37qqVfynqhYAGgazw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFKbsKYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51E606D804
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFKbsKYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB76B1F00A1B;
	Mon,  2 Nov 2026 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649850;
	bh=J0Uu2CVm+aK6qphIKD2FczueIB0qmqGw7i5rV6613Tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFKbsKYgPQWnhtGM8gGgHY0XuB/1KcdUVa61MBHG/ka/XgoojWdjBn9VzTMziclOt
	 BjYO+3Xqn7nn0560HQMLj5xnFmJ8KCsXW8yBuvfqgaoRQHw14Jl+qCPYMjAz5eWJjY
	 ygAkSdRIPmzYsBbTmFph4aYQraIq23j8D6oGi5Oo7uwpEScWzKKoy3kMMkRFSadFS3
	 8tou8FDEr9hznqi0p+Givdmv6qCq8jrK3Bl2hTihGw/IvVHkp82MysK4+cADNajf8v
	 wZ2/ktpOW2lLIE8rUdTQ6NV+9vxhnyRp1xRgy8X/J4eK6LNNIF/IskjQ0BtIyHo5ak
	 ia/nbwn2GIdLw==
Message-ID: <sashiko-outbox-194050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/17] dt-bindings: timer: add Zhihe A210 CLINT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-10-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-10-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:04:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the A210 CLINT compatible with the thead,c900-clint fallback.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D10

