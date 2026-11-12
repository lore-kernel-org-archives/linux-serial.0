Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459163;
	b=iXz+fBluk6Aizox2sW1+5j+gOAYO/ZJNrnglf4HIsSnCSGflszeDfhd/GxJTEoYiqoWP
	 IOdkZYTYKn4veNwSF2Q0UjxlEQ4aLAMxAu4+6oRxIzGz6OJm9DOc18LCqVW/ir1KssdVF
	 nFdb+p+HfTminNo/b3keP3F2CjJ1bOjTEjdbzUzEmOI8nyGMYdWCyoI1l2xUEpufc7qRp
	 0Y5tyAOCB6JgJ6DXCnuMGVFP8d4qSocNAwvC1c6u9F+imw004l065HebYH5kVziADLwr1
	 EGbDrLD0mxWZBAkomOVZt4qJ364EUECmzYyqWE7VhhRnUIjo2WgZEIolaulNzY3nvBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459163;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sPXftoChLni9IHCsaEj3W8Fustwsmyr3s5NXA4C88Sc=;
	b=aW3OlUBfEb58k1C6VXlJm/Ohb7tb2KA2dwTEZNtnUrrJ5axsg1fqPFXskxr+qeH3oUuN
	 fiZUctCBEjYk6djj4uwGBXrLyw9UyK6cKaKaem626w6acAUiuFpLrv/AVPGPnpZvcNptx
	 DuwsDYasRyA2R8CsiCog9rSiio2+OTxNTf1UczZko5zQUI955L+4TCtwQ1WcMRd8Gia2j
	 tSXzyT5M6okz3ZZW7jawTGJPCrEJVmRtasZUbGThLBl/bCLsffpJo5oc/AVHtlCJQzIHD
	 Q1yU5gIGAMQKFpwKtu4nnrYqRfnVVvBV5Da27nvvL1+r7iS3AWgtI2SUGlX6qolOIuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ViLw/gdF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFA606A31C
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViLw/gdF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB361F00A05;
	Thu, 12 Nov 2026 04:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459162;
	bh=sPXftoChLni9IHCsaEj3W8Fustwsmyr3s5NXA4C88Sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ViLw/gdFWvgN6X9CwwNgjxsugfYJ2eyEttL0B/0L9cAIXzxYVs8SqISlVrrTYluGU
	 z5NUO1GW229gQGRTK/IDZ4XI6tWS58S5sSSR7nNOKK6trGehInUcE+il3SMCe8RfCW
	 JwkygBqgHvPfwrM2iXt5OqWSXUzkFnNNXtuXIitYdv/lkPR46TN5uwxITMpPulPGWg
	 xCY0suKsMNXDnE880EUqu+DB/Ln9PZ+ytkWsP0/gMWVJl/PQQRm67AwrLOJFvb5tyD
	 SuNfEX0ZwIKpdtL27o/7HRUEwprh9ACehagFMj8nY1XftHiX6cxJttyt1KbmfXiAck
	 OjL6FhPZo4uOQ==
Message-ID: <sashiko-outbox-210398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: core: do not hold the port mutex while
 waiting for references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-serial-core-remove-deadlock-v2-1-d3ee4ccec37a@vaisala.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
 <20261112-serial-core-remove-deadlock-v2-1-d3ee4ccec37a@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:52:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial_core_remove_one_port() takes the port mutex and then waits for
> the uart_port_ref() holders to drop their references. Since commit
> 8ca59f7baee7 ("serial: fix ioctl hangup race") uart_wait_until_sent()
> takes the port mutex on every poll iteration to check for the hangup
> before it touches the hardware, while holding its reference for the
> whole wait. A tcdrain() in flight when the port is removed therefore
> deadlocks: the removal holds the mutex and waits for the reference,
> the drain holds the reference and waits for the mutex. Both tasks sit
> uninterruptible, and the port is unusable until a reboot.
>=20
> Reproduced by unbinding a UART driver while a process drains a few
> kilobytes at 300 baud: the unbind blocks in wait_event() under the
> mutex, the drain in mutex_lock(), and reading the driver's proc file
> blocks on the same mutex.
>=20
> Drop the mutex around the decrement and the wait. The decrement is an
> atomic paired with uart_port_ref() and uart_port_deref(), which never
> take the mutex; the clearing of the port pointer stays under it, where
> uart_port_check() readers expect it. Between the hangup and this wait
> the removal already runs without the mutex, so a mutex holder seeing
> the released port is not a new state.
> uart_wait_modem_status() takes a reference and then the mutex in the
> same way, with a smaller window, and is covered by the same change.
>=20
> Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-serial-cor=
e-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com?part=3D1

