Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897081;
	b=lE4Ji6FJf3JBsUOpewIfXsO9joZacTlVvRZkPJuuEzMgrqQEvyI60FbwqrnRC6EnUpJi
	 LIF33qRdrIs36qrDUFhCyimcZWwzrZ3ci6zUMlcir9zCo63TdH4/gv9/dhYTqdzqUuTwu
	 uFEGmT2FPQ76WZm9nFWpXHjs1Gj4BZ5K2QxyaJrxIl6eP2yjKkTSWpMieGTAVUlQC+zh6
	 04a4E/uLsPA3rznSLLL0MTXkMjzJVyEd6nG5S8Y6u/OtigRC2RyCt+v/15XROAmWsMH6/
	 9yv/g01qlBsS7OaSMF7C2nlEe7K51p7XZtRgNpPWjEAJwj4YfkkSmOxV8ADNDhRbu5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z4J55TYMjOYCrGPi5VRceRq/lQaYzxhJY79hLIzUgEk=;
	b=0BcRgPnzkR504Es+0pDDcYNgQm/w8YDV4x+AEsfnT6VVkSjp+1PNWTkhr9k6Nr7PPoAu
	 JU8AuFgm86vGoiheuaJf/0I5c9aVS43rmc5EkMVnkM351pCK7a1uFm6R9d8I4ghbPlMNo
	 fw9AYPqI9+ojW6mx4l/KiVljBE/2znJ0/OO7k075FjEzqFZKyxKU6EUQOWFNKgxwmdtxb
	 KaTGZzomlE1YK4AsaaL/u2nNcutpD6syYrCsFmd2Wn98cjhtTHmx/CWo0MFiOB1B9ULIW
	 I+eR9JrGRLTXoHC0rxhrP0drODsEfNFNeLu0oXXP22gyVINH3akfciv49tUAmw5IFgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1ZWt+Rp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615A606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1ZWt+Rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8721F000C4;
	Tue, 17 Nov 2026 06:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794897080;
	bh=z4J55TYMjOYCrGPi5VRceRq/lQaYzxhJY79hLIzUgEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1ZWt+RpqZ2CSiW4x/Jyp2bCj/LsOSsNlAwPhcWpG6TxGvkLaS1fPgeThN9sCyc18
	 Po5OrP/Hd3IlkBdWyfVWtjOcjiDHCRln4NaTuZvSCPtp6XNbhMYe9IRXA0UbJcA8UU
	 tZpHtDlPFeLYWBpz0N68Olo8DFQ/zlaWmn6qUZs/MC6s9bw+fbv90WRSd1xMHKdPkE
	 OLXbmEEqi7IqnM90pBPQnNVEG1j0RViCO4BiCKO2LZ02BSYAhINBBpMtgFBCnC+hTs
	 x+zOumpGrnQ1014tYKKPrdsGoSBxhjzNmDUlGLQrj6EeAifyEIJMIzgthtvAR1VSjp
	 DSBhf9AFxCCrQ==
Message-ID: <sashiko-outbox-218257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] serial: max310x: do not advance the TX fifo past
 a flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-max310x-tx-fixes-v2-1-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
 <20261117-max310x-tx-fixes-v2-1-b395126fd23d@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:31:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> max310x_handle_tx() runs from a work item. It peeks at the transmit
> fifo with kfifo_out_linear_ptr(), writes the bytes to the chip over
> SPI, which sleeps, and advances the fifo afterwards with
> uart_xmit_advance(), all without the port lock. uart_flush_buffer()
> resets the fifo under the port lock. When the reset lands between the
> peek and the advance, the advance adds the chunk length to a read
> index that is already zero, the index ends up ahead of the write
> index, and kfifo_len() wraps to a value near 4G.
>=20
> From then on the fifo never reads as empty: tcdrain() sleeps forever
> in tty_wait_until_sent(), and while the port stays open the work item
> keeps sending stale bytes from the buffer. Observed with a tcdrain()
> in flight at 300 baud when the port was hung up by an unbind, which
> flushes twice: the first flush left 498 bytes, the second found
> 4294967217, the draining task read 4294967276 and never woke again.
> [ ... ]
> and from a FIFO level read from the chip.
>=20
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-max310x-tx=
-fixes-v2-0-b395126fd23d@vaisala.com?part=3D1

