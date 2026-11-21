Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795243344;
	b=HgR+I0pHnaTPFLjlE9tJN3s6BeNzK7scNhQszi7zQ3B+nZwov8AFsgi5bpWFKtQ5Cu6V
	 nhi/JUXrZDrbNC6A+6kv1ooyQebTKIoZRDWlQqcp0HTp9XBCmbtEvwpK+Z6LzChk9mRJp
	 ltwzzYMnyWraS8lZvLQMOdqj06UQanWYzmb7xTCShhMRt84bFyfcNfivpPq3d9tAnNMVv
	 OepS1jLWtLCze0Cx7+RCCmZThG+ugcnYKguNeR2GWc4G5+/K6b+ipLvnVVAL6iPGKkdoL
	 PS2uhTMn38kloXuCp+JVHkCCTfrVd9Dx4/ieMLKLKQZc2ssDA265XpSbi30p4Z9s5rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rhUOzl4rQYhqqc0Ow+5zZzLQktKcamYz16xGkjkfPfc=;
	b=20iE+AShmnf8hkyYbSX5CF1BpUggVVnRBjAJJ9oy2M8Xw2y9FACPAO9G4UISmU+hFt3s
	 J6Rf+GFCNGXZJuwullnx7x2kIay13uPKeM22wH567jr1diz/k2cWi3xF5aoKqeHSzJQQA
	 eXNt/fN3EkEIij+UDkpMttl0MiN5iwxXDQ2fsX1B45PZq4O+UYmxicUG/HQFgq5nkbPph
	 lGPx8+rwNHB+RrHbHCwdz+kV5edaxpClY5ZcNrNubfZllT62FZldv/4PvAyGaH+ZjMwiR
	 DlspSW+jzof9Nyvz9HS2MJXPIDtJAjw4w8R/7HPNSXpSmMwcp8yRw44lQvNiOSTFFJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZNV435k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE77606A333
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZNV435k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5881F000C6;
	Sat, 21 Nov 2026 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795243343;
	bh=rhUOzl4rQYhqqc0Ow+5zZzLQktKcamYz16xGkjkfPfc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jZNV435ktwwtUpkEJi5In9h88ig+kDW6hd3Meq3WVeS/Xfc7dFnvGXjKy/3ZYpgjc
	 hGFcErJY66CjyoMdl64QUevuH9XiHALzVAwFmqPM51yk9k3l2U9MPIyCyeckUPjroQ
	 3IDoiuwWpUWuIuE+gUoxSa6aBq4DLt7A/R1LHtvtIi/S47zcZiMr70HOno9EhnbeSB
	 9vovstcYykSV0FzQ0bZWbQ1OoFGBoT0WvO25cNCrbhH3m3Wz/wr1S0ZIoChRR09GGc
	 uPRz3eUntQQw7Hc78dLBHZ6ZQnWwFTuGb7HJo57R0S80cmh4m/pxkQbyctW8JtQbGB
	 9JDN7DmAOz/yQ==
Message-ID: <sashiko-outbox-226704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_dwlib: Restore NOTEMT for em485
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyao Kashizuku" <fuyao@sjterm.com>, linux-serial@vger.kernel.org
In-Reply-To: <awE7o4z1DMGb-YMg@debian.cyg>
References: <awE7o4z1DMGb-YMg@debian.cyg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 06:42:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fuyao Kashizuku <fuyao@sjterm.com>
>=20
> A DesignWare UART using software RS485 can transmit one byte and then
> leave the next write queued indefinitely.
>=20
> dw8250_setup_port() sets UART_CAP_NOTEMT because the UART does not
> interrupt when the shift register becomes empty. If neither hardware
> nor platform data supplies a component parameter register (CPR) value,
> the driver leaves UPF_FIXED_TYPE clear. When autoconfig() identifies
> a 16550A, it replaces the capabilities with the type defaults and drops
> UART_CAP_NOTEMT.
>=20
> If the TX FIFO empties while the shift register is still busy, __stop_tx()
> then returns without arming the stop timer or clearing THRI. With no
> further interrupt when the last bit leaves the wire, em485 can stay in
> transmit mode and a subsequent write can remain queued.
>=20
> Restore UART_CAP_NOTEMT in the DW software RS485 configuration callback.
> This lets the existing em485 timer finish the transmission and release
> RTS after the last character.
>=20
> Fixes: 5ff33917faca ("serial: 8250_dwlib: Implement SW half duplex suppor=
t")
> Assisted-by: Codex:gpt-6
> Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/awE7o4z1DMGb-YMg@de=
bian.cyg?part=3D1
