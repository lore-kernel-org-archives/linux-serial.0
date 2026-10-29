Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283818;
	b=tQjwq/b1tVWT/JnJbgoLZLr7hPVCXsOzpbbn6EOyKSgKp8+6IajjbRHyN0WsVHiqXtkZ
	 2bmImNFCSFldcOu/pxNOKJRkKa2SLSanu3M3qTwvUl07WmtKWU6Vop5Zof4b4XvR1I3R3
	 l6oHYEAv3DD6ukDBolJKsfkfrr1ktLa5iGU7WjNTCFKa2ZdGccvWwrKNUgzjDw6R0ZygG
	 dYfmK2chWQsKHwp4t/QTpDl5++G9+7h1kvXR2KT8WY7V/x0mg+y35CuYKc/3vLxsvRKAH
	 +XBJxFy/nhPV2o+dLvyV2PSyCpghNFObAeJ87drhUhx+zzj1XRt1m3ixYyFuAoquDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dE/NgetrldSRSR8pZ16YV7+rfzU0sZOZA39M+TeFD3c=;
	b=wMjCg8XziUWymULqYi2afTfMGu7A4Bu/V2ZLEJnlGpz/zNh3tEU5msWXsakQgwB/KYOM
	 jrOzUfLh0kWHn+b0thETHq8RU62wYsJ/jlSsb2COa5WJq8uG0k1T7YodzGg2Mu5s4NY9g
	 i15mHhoE89tXIES2cF60gi1hzgTIYLTg4WkV02sAupQdbViLCEZzn4P4eOzgbxurKoJP5
	 REjUx36YQq6VmJIV2f4hWlTy66EKY8bZOGD/MTZJGKQVNcYCXN2A2ZIvzeuoBqP3FiIBs
	 VD3TwTd077VEaqBFmVFigG8dEWCL9XkgD3eOgmnpyvqIOBXmHq3E08ttafKG6Y4yAxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRbdaYsQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA5606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRbdaYsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69521F01828;
	Thu, 29 Oct 2026 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283817;
	bh=dE/NgetrldSRSR8pZ16YV7+rfzU0sZOZA39M+TeFD3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KRbdaYsQFV6X9wggOrAJhpy8ZUvmQgOoivWGW0OZugF5co2Yp+IcFTEIdcTUBTpoj
	 tyK2Tvry+VjORBHOY4mfcxTzhbLfefS/XiLoWmdYYArb8P/ssEYtWtpGwQP7TuBBB6
	 1jkhcreIDSiCuuj24kxHCgEwyffDekdQtXCQvrTtmMKqEZAxlPlPeDm6NGOgSkNbj+
	 W5f+IzybL90ZgYT98ztoFrIi2Z271dEvlmUZOqRMRSLjbBUHPlBQAqEakeV/afvS7j
	 5xikVDgnRYUXJmtTMHWFU/RoCiTrHGXBwfI95KVzhpR30Sv38dZVzLBmNLZqP197W0
	 G3euYdomCSj+w==
Message-ID: <sashiko-outbox-189507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_hdlc: fix duplicated prefix on partial writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng Yongkang" <teel4res@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <179328314077.648427.13745367584859897488@gmail.com>
References: <179328314077.648427.13745367584859897488@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:23:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> n_hdlc_send_frames() passes the whole queued frame to tty->ops->write().
> When the driver accepts only a prefix and returns a positive short count,
> the current code puts the whole buffer back at the head of tx_buf_list
> without adjusting its length.  The wakeup callback later sends the frame
> again from byte 0, so the prefix already committed to the peer's flip
> buffer is transmitted twice:
>=20
>   DUPLICATED PREFIX: magic occurrence 5 at offset 19968, frame index 4
>   drained 36864 bytes, target 28672
>=20
> n_hdlc_tty_write() still returns the full count because the ldisc owns
> the queued frame; the short write is an internal transport event.  Drop
> the written prefix from the buffer and requeue only the remaining bytes,
> so the next wakeup continues where the driver stopped.  Full writes, the
> -ERESTARTSYS rollback, other errors, and a zero-byte write keep their
> existing behavior.  Clamp a driver report larger than the frame to the
> frame length.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179328314077.648427=
.13745367584859897488@gmail.com?part=3D1

