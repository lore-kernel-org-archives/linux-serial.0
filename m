Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427789;
	b=pp4MuFW8XTlDs8AIftww5OZT5G2QCXFtKBL+7sFfyeKVl7u8TxWvMP1fayWM7cjbQUsf
	 kp1yxNyvtaED1pTgSkNQ0OWoBX4GIHPWN4F4pBWr1baMLi0yTbYlvSrc5neLey6ZBtdzL
	 7axupHRpniLHopMhCyyeNZuzuaViOyNpqZp4CHvFr97ckCJRXPPZMjjpsVHBkyuWgJ3EF
	 BlUAEWImJZFNIjXiYpFiYDWBFWs4LZroWqZ0Ay5nnL+dglbAaqkqfx+HmGRcg799lZRAt
	 GcIehrBfMQLw7faGqem49n7qrUQBZJ+A00jt4NG/emTuJz+f4+ddee40T2YCdyEeXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oo/EqW8FKgvDuXtiD6FosWgTpKVBw98Q/Byww4Mx400=;
	b=z51kQUWXsSpu2VzwwZ+IP8aVbHV75MafJa3RRMOmEQG9TtFmNjDW1y2NhC9J5tflEiFD
	 ins4yzsj+wn8eCuYz/GHkeQC/uCV+AYtckbT1xd7kOgcGpgPjOf5tEM4ZEiB9bS/HLmrA
	 2dCwegnU1FbUjKccvvnxsgZz/hv/kpTQ9kZNhsi+w97BmUviV+niP/RsozcQVT1ThsI2V
	 xqoRGax1F8bDSTNbHA2YodVj4bNZQfQvWP/GeRRO/chAJioXwbNUcHeJFuhBIFSyOrRHA
	 +IWxh6ByONH7QnE/AbOEzGq2ZxQcVC30gG+tCOixMS5xf1L/2yYE7NpM/XOPRZ1UPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpbD9oME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB606A321
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpbD9oME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5297D1F00A05;
	Wed, 11 Nov 2026 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427789;
	bh=Oo/EqW8FKgvDuXtiD6FosWgTpKVBw98Q/Byww4Mx400=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpbD9oMEKcaeFm6SStDLWRybQGLdO8L5mfb26paN3TEy2VBCXe+9I+f54R20BV1lL
	 tzcY05trzzCqDZPVV1lraAwOoqcegNEYU2DMrXemAOal7Tf9jOGg59p+ZneQg49ean
	 m2s/RL1+BkqzQgpqPaG8J1C3zcCRJwi7ZhxcHxo58BoDXeJdK+xeSAMeDwO5AbWvJx
	 BfvCt5KX8ngsbF76H5wP/eF2lqaRzT8NSvYQu8G31ApZgp+BKBkuiY90LgQYP5qnsb
	 WnfkbgIN/knnkoT0LVVC6gKcsquYs2JRGGCfSoge9VtRM0KFlbR24oDIFN59apTR2K
	 gNgLxjxTZmZKw==
Message-ID: <sashiko-outbox-209610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] serial: vt8500: Drop the port index bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-4-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
 <20261111-vt8500-serial-cleanup-v1-4-b33594a25f87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:09:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Stop reserving a line in the vt8500_ports_in_use bitmap before probe
> acquires its resources: nothing ever clears the bit, so an early probe
> failure strands the line, and a retry then fails with -EBUSY on an
> aliased port or drifts to the next free index on an unaliased one.
>=20
> Pick the line from the serial core state instead and let
> uart_add_one_port() claim it, as the core already refuses a taken line
> under its port mutex. Rely on that for concurrent probes too, so that a
> racing probe fails cleanly with no driver state to roll back.
>=20
> Keep the allocation policy as is: honour an in-range "serial" alias,
> otherwise fall back to the first free line.
>=20
> Fixes: 4001130df1a7 ("serial: vt8500: Add devicetree support for vt8500-s=
erial")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-ca000721-4a5b-4d88-bdb8-7f1e438dc=
81e
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vt8500-ser=
ial-cleanup-v1-0-b33594a25f87@gmail.com?part=3D4

