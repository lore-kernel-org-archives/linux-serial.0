Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458507;
	b=Wgt9oTl0Kml7oyPquTPMrLk5AfOn/KvHxAfWjVEgo/NaT5YAcztThmJzzTLZiGTJiyiD
	 O9s8BxNRjxxnmMlQUAjohv3G9ZJBR0RXe0MLZXTwOhN42v9FvY4pfi+s8covD2FwveDdc
	 hpSQOoHZRfmHXDGVMmpzT5Z44sYedfZXyJySD2wpV/+FMbSALEb8bw/lDlflFzQkdaqlI
	 4NdziDmkMhee60NbB08eyIZjlaRrcGkXMRQh8/c1pC4en2lKYRaZoQawIHgxes+1XrgGo
	 kYkq9HDFzsRERhn7P3mLULV6E/RGX+YNRFOY0OKKhAShOlY4ML8LPfpSXV2yCUFvbmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458507;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YqyV26qgPWN9fkM56uLf4+0K80gX4I292zWG2QLfVwU=;
	b=EDpUJs0JK1LJo6Pj9RjYfHgVUfwhprINzxS9BHNVbvv3rrATfj1bm0h+F/Y8e1g0/AsM
	 hHLprKzqlEqjnhuhTD9g6E05hbFesDpgz1pbMYeVo7yZRnFP5znB9ZXYQAXPCOH7zLaoH
	 GfWnqmD+/+JnBcMRL22io9+vwzj6AX3q5DTYLhLX2rbfCIL82EW0+bP6r6aHrjzhzQM92
	 aNBb2tNjphigm2qvet3Uxm6Q9e52ZExEJR328O50il3ztmof0G521FWDuuf1DEy4LiKuR
	 5flWpS55V3HZj7AX9A8kJZCZfnL3rmZAsCSYfIUzDl6wMIgx2G8jBRskRtc/MMzY3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IU9Tz6DW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB63606A32A
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IU9Tz6DW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D13F1F00A05;
	Thu, 12 Nov 2026 04:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458507;
	bh=YqyV26qgPWN9fkM56uLf4+0K80gX4I292zWG2QLfVwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IU9Tz6DWA/ti1Xs98IXt+Ac0Xllg3MEd7GuzW69PVADayoj7HBmV1sMmsO8g8oBCK
	 m0pj1L3W0dhP+z3tMWYJ9MeoGUgvx4XzOVCOfdKrqHd9wIS1mOaghI+b994nT4oLvK
	 4uUUyaznJS+5H135jsZirRx+wt10Bg3dxu4cWEDosCW8qTIna2KrPVpRBD7NzNXpY3
	 J1mZW/OHQvBbTsIEf1Ntcy1fqtPe3mLSCwLdVtQy1SKGphQocoFAZLKVOb7cfCdDYq
	 rw4ZLJmp2RAQAi50vxeWbBLwwVWrF1BkrmrlaRv8+S0kr/i3YwXU4ZVPzcPQQfCu/s
	 fW6IGL8hly9Nw==
Message-ID: <sashiko-outbox-210378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: core: do not touch the port after
 dropping the last reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
 <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:41:44 +0000
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
> Read the state pointer once, before the decrement. The uart_state
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-serial-cor=
e-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com?part=3D2

