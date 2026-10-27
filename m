Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089965;
	b=o94pdVOCrETjFsS1nQU4EBfd/mhCjGyoa64q0jKyVaP6hpJ1gGnyjRDbf8nvVkJ+DE8I
	 R2PkuMxuK6ijw2nK7dkSbIsrMi6zGnU/k4jyLUR7j/9ohaJEpuDnUOpTs3DIAI7k/AKQ6
	 gD+qp9Sp3xUQpyyAaM/XC6UpFSEtJ6sgSm4vcDpbDevt6U8QHb35hMXxFDK9oIq2kVBf8
	 7ou7RyZsJW8HpdKXoHDMV313ZzdxWhNR9ODeEbBQsiKl5wQ2OhpVvrPyga4EEcJhu0nSu
	 WENjvN7MJm6YbdXC3DxSX0sroCmUHXvqv3iJ1qwDbBmaZf82Obf9CqAX2J7K3EjFGSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sYs1BYDn8W4SPucvoPufU/nHsMkZGGDS491DX6TWtmI=;
	b=kka5Eoed3vsckU9nIMk7soItGG4NZwYtHI/EEki9WOhrgZNn88Jq+UmdmE0yPBSH6BdK
	 AuMoTqO0bQvZJxuSSkS2CSQdpYAH+1m7AP8E2A67jZb4u8bBwVXfa5WPzhaiOTaiena6i
	 yCu8npVJi2XS8C7mXePxKfVXza92SQ2IpCQrDZeh2vRi6UR94GbBa4Wkgp7aVDBK3UMSt
	 iUgLI46DgaLtRdjBoVDOnWI7lgNXs8ZtET0S+OrbbEYIuA4HWtilnKclWnHjXajOGW0Ss
	 fCPoHhgRJrNLYpVMlZHChIp8ajih4v5wCGbi9hhddKPfxCeW1/vRHE6QXv3lUS9vimQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3ww8cVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FB606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3ww8cVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5551F031E2;
	Tue, 27 Oct 2026 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089964;
	bh=sYs1BYDn8W4SPucvoPufU/nHsMkZGGDS491DX6TWtmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3ww8cVWtMhpVVEEWDQ44D2YgEfedNrBpfOsNqdTzOJZ02rdZeTEWnadt8UOnvrVA
	 PUEkUv7l7qgRipqH3iBq+520R2wrnIsdgIkJdre31m9/nsgsBiNFGEwuubhtRO5aZ6
	 0afFmaQk8r/WlknLnSSAaJUPfZm6cq01Z1RjuRTd5Ee8ApmbBI5O0k5HgwUKZ8yXq9
	 DLL4qy0fPGi6U6qdhJvIX+L5Ew7xHjZztbr25TPvpz/aQL/8lmJ5nLc2or0G4/ECfZ
	 e8uz/kSQ8B3oWrW4EoRCEkdZiq7klnY5rzxcVtzR2hjbSQ6Vhh1WsoX0Csy2aXTIE9
	 z7mYZJw/sU7vA==
Message-ID: <sashiko-outbox-186286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: discard flip-buffer input for TCSAFLUSH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027082236.56724-1-dennylin0707@gmail.com>
References: <20261027082236.56724-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 08:32:44 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> set_termios() handles TERMIOS_FLUSH by clearing only the line discipline's
> input buffer. Data already committed to the tty flip buffers can be
> delivered after that flush, leaving old input readable after a successful
> tcsetattr(TCSAFLUSH).
>=20
> This can be reproduced with a noncanonical PTY: complete an 8192-byte
> master write, wait until the slave reports 4095 unread bytes, and apply
> TCSAFLUSH. The remaining 4097 bytes are still readable afterwards. Small
> amounts of pending input can also survive if they have not reached the
> line discipline yet.
>=20
> Use tty_buffer_flush() with the referenced line discipline to discard both
> receive queues under the existing buffer lock. If the line discipline has
> a flush_buffer callback, also unthrottle the tty after releasing that loc=
k,
> as TCIFLUSH does. Otherwise a paused input source or sleeping PTY writer
> can remain stopped after the queues are emptied.
>=20
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027082236.5672=
4-1-dennylin0707@gmail.com?part=3D1

