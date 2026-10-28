Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172197;
	b=3Hi46/bdm7ErYOx+BmKBgnqp7N6y4pOY993qHRdIH+OB8VCevEosDbf58GNaoOjJtave
	 K33jwo+NGdjcYOPoSzrW8KHcyGZZKLwTItgJQVG8Sp1g1/ioUlZoF8koCnCCO1dPgo2PA
	 Y7Hh36Q6jUrfEM9V0eEuOUSI3ll35jbIY48Chn1PK/mdnE96nX/HjXy+5Kfe8eSse56p8
	 ZeQvpehw2/VNoy0ULujfOLM112jmaA+toXWgwGq5ouaJan7s+1i0DGatFxzJXdm7HDiQt
	 bj/rBaHH1n2phkcgfswMq5lA6rP7VP4/7nxUyencQr3AyXNsYMfRkC4IN6QasbfX8Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qnOlG2pOr/qQbPu63jLwX68UGGKr9Rw9UPpEccC9NY0=;
	b=1yRSNvMvROI0QpT/fm/kr2SJT1GrGl+NMqUQ3hbPbl5fHXM++zzdqzvQbq90uT8f/xml
	 ek8p03Y6WzkbxmmJtat4zOYR4A7oVofjHyP1pUkS3l6LQxncuGJwv2dx4LadTNcOVdqP4
	 Kr7OjM6jXK/Wvh/NfX6/1D9tbo4jYp5cA3AD0G8hcnKpcqYyAG9ubnYLAtv9NGESjH6Pr
	 YB/3YLoKodZbyp+Y6XotmPPR/a726hBFIHqtYExMQUhPExBnpRSbMhm619sy0efDB2IrN
	 t59pQmcWRt+R/BmTKDpXUYG1bPjr07EhDVn4K9p32FJslKMKxrESMBYzDDT1+2MkbFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEuNLnpZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EEF606A31E
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEuNLnpZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD241F01825;
	Wed, 28 Oct 2026 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793172197;
	bh=qnOlG2pOr/qQbPu63jLwX68UGGKr9Rw9UPpEccC9NY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WEuNLnpZThyZTMipNtKgrGIKc0RDp61R6Dld1nKTPHFd9UfajaylrOBhS5q5EMRGI
	 nxR+SdixaRr6ZLCSFqM2skQiA3n1mzGlmhTpFS1NGivlfH3zZUm2ZMXGp48+LHUrNA
	 yGmxL7b14hUu6qkEQiphyvi1+driSFZWujD0O605iiN87UYwe/ymZQcImKA+dxQ0wg
	 +n/jrhUXnS4RuLVEFMCP3Ij/TCJLUKHuL/0X/dD2mHLX2PycDddU/U/H3a82JwxWbt
	 1YTAfHpMQje4hxpUUh7+tYphXfLXFVslfJdE8FII9A5YU5Ocq3pUYeu8AviTI4AQSL
	 mrc3sx9fr5ifw==
Message-ID: <sashiko-outbox-187576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: serport - defer write wakeups to a worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>
References: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 07:23:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> UART drivers can invoke the line discipline's write_wakeup() callback with
> their port lock held. serport forwards the notification directly to the
> serio driver. I-Force's callback can transmit a queued packet through
> serio_write(), which calls back into uart_write() and tries to acquire the
> same port lock. A notification after I-Force queues a packet but before it
> sets IFORCE_XMIT_RUNNING can therefore deadlock.
>=20
> Defer the serio notification to a work item, as required for transmitting
> from a line discipline's write-wakeup path. Initialize the work disabled
> and enable it, along with TTY_DO_WRITE_WAKEUP, only when a serio driver
> with a write_wakeup() callback opens the port.
>=20
> Clear TTY_DO_WRITE_WAKEUP and disable and drain the work when that driver
> closes the port, before the serio driver and port can be torn down. This
> allows the worker to call the driver without holding serport->lock,
> breaking the lock ordering cycle with input event callbacks that write
> to the UART.
>=20
> Also clear TTY_DO_WRITE_WAKEUP and disable and drain the work on hangup,
> before waking the reader to unregister the serio port. The additional
> disable keeps the work disabled even if a driver opens the port while
> hangup is in progress.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-submit-ser=
port-write-wakeup-v1-v2-1-c05d96259985@gmail.com?part=3D1

