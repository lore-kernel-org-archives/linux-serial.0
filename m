Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823952;
	b=IYwfiI8KkdnHBFmWqPn+gQRa67M97k6ODLd07Ia+3wJOvD4SeVBYY8r89gJ+gs0goDm5
	 T5Vhr30+IFH34vkE1Qa3LkGGkrXC8xJ0DclPoXpn0y49G9FpG7v6kw9ClIwXl7NmAbST4
	 x9MiWQW2GHBcve3ekKlm/+gWAkFjuI/mlN2JYHe0YpvhNYZPVtLUk1kXQ14HQzCBlXE2w
	 aroZC5ot5NzBEuIK79W6d+3Gcq241xHKnXXD8KnaWEOQgYP87AKs/BohjdbHW7RdQgyNs
	 zrIB8zG3MTzbNAMU/bzpksAZu5MKU1VXdeNfywICqUofsuwmmt4wwTXnbkp25J4VyeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823952;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w2hIEN+rNQ8wRw5vWDCiXXrJavNOh7azirY3cXdTpm0=;
	b=Qv2eBVx9rQiHTJj5TWKKRURyVhSllsk4scLcURJ/PDTzNDdYcc+Pz00fJedWhk9cpWfG
	 ES9w0kkJ6EkVfd7VLk7I/SajC3pmax4L68NhiS/1UtAV170t1Ao72W4tPXq/JuUfsMa+X
	 l5v8nxp+HGTFQ+2X2a2jRJNCG7m70Fx3aeTPI5/tNHwcW03OysAN3mpMAMPdkkzBXT18X
	 4Q3wlAwIQ+O6gvjoixWWtJgdKXHHbQnKFmrfs8tdCh0ZUD5erW2jIeh/cu9WcFia9GMlz
	 e+PCa2bvSMIuO7aZu26F9HNA2l+z6YffO7mmfD4+vdq3XvX6bVdu/LW8Qz/+sintaEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBi8qT22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A732606A323
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBi8qT22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B07B1F000C4;
	Mon, 16 Nov 2026 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823952;
	bh=w2hIEN+rNQ8wRw5vWDCiXXrJavNOh7azirY3cXdTpm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UBi8qT226ZuFIZ7plShYKfLrh+UMYEl8IUmO7tbCF6qd6v4dTDWAxzyXOU28CgCaT
	 ASuKsYaf+IsvivIEXr9j1/J9yKsEQqbGigL4eEJOvvdHjpFlKpZNIj79FmxbKRNprS
	 zozgVUJC7PAR41DR0Ze3zJ7xvqSXUGsN5dn1rleLPSonrzXGR5Edid7TNdh7TfcBQ7
	 h6jOim1Ag6SZR3QNUeX4B6Q0mfnxN4ea8Le6xtHm2sARBkGmZGx2YCuSzaWbxP1BKj
	 PQ3ijduFJrM0LiJG0I/o7eMwWx+tKnvBFbMGuxPLadyVAmca9PB+avqoQ52gOkSFxc
	 xy20h2LuUFwMg==
Message-ID: <sashiko-outbox-216695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] serial: max310x: re-check the TX queue before the
 after-send hold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-max310x-tx-fixes-v1-2-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
 <20261116-max310x-tx-fixes-v1-2-61c01f180911@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:12:31 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> max310x_delayed_stop_tx() decides that a software-timed RS-485 envelope
> is over when the transmit queue is empty and the chip's TX FIFO is
> empty. It tests the queue first, then reads TXFIFOLVL over the bus, and
> only then takes the port lock and arms the after-send hold. The bus read
> sleeps, under load for tens of milliseconds, and write() queues data
> under the port lock in that window. start_tx() finds the envelope in
> MAX310X_TX_SEND and does nothing but reschedule tx_work.
>=20
> When the stop routine resumes it sees an empty chip FIFO and arms the
> hold on a queue that was empty before the read. The hold expires, the
> RTS release is scheduled, the rescheduled tx_work pushes the new data
> into the chip FIFO, and RTS drops while the chip is still shifting it
> out. The tail of the write leaves through a disabled transceiver. No
> FIFO overflows, so no counter moves; the loss is silent.
>=20
> Seen on a MAX14830 behind a slow SPI path with 20 ms of before-send
> delay: 25-byte writes every 20 ms lost 1600 to 2200 bytes per port in
> five minutes in RS-485 mode and nothing in RS-232 mode under the same
> traffic, overrun counters equal; 96-byte writes every 60 ms lost
> partial chunks of 14 to 75 bytes a few times per run.
>=20
> Re-check the queue under the port lock before arming the hold. Data
> queued before the check keeps the envelope open and the pending tx_work
> ends it once that data has drained; data queued after the hold is
> armed is already handled by start_tx(), which cancels the hold.
>=20
> Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardwar=
e delays are too short")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-max310x-tx=
-fixes-v1-0-61c01f180911@vaisala.com?part=3D2

