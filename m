Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099650;
	b=YHb0vzpNO6VgFhkn8rNzhtiuFoJwk15aRyEsZTkXAUt+bVMDnAB5ln6S/PcmQPKv8OcV
	 d7pMtXKYEykGyab8nvZ8j8vDvUGYsAdD8yy2zx0NAmgZwrX0BxelmhCXVQOQyyOAfhG2m
	 XUgRceJZwrih9i7v1TPkuY7F8CvSGAjdhCIRx+YGaVAp8KA7a9CZ7Hvi+a2Dr4UofmGxO
	 fNq//U2fdRA5yNBDIGqkvTrqXatqBF8gEZBLg3DgIQR1vQDlAHQbEhQ7fCRYQGRBHNgsD
	 eyzbazBl2wJZozLZet4vt/dhlSAnY2190lzaBT08R6H/gsm5laWvKyzAIrI7B/hY3wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VEw22usREZ8y9BZP4VbVOZCabT9+URaZ0tiikwEG3uU=;
	b=Fcu3Px1p8r2DVmSDsVBfANMcm4F/4rpvOfIDUvKmqILHZ7Y9qlMCzInajiIDyArCaoEN
	 KmyZk8esWDE27wtHYJ1az0XEMV24EmtHEJJWT9QhwND7swqKtpwHT9nJk3bvN14FM1DUD
	 P/vbXsYatYKH/8nocx8IxMjWKnjjvGSr1uMHAXCUj2k9Ks2dZt/A4yoOB6vk+kKfDtr9t
	 /fHHw1L0rPZT3d3R0Mbg/03KbVyXSxv+2lO1Ni5EdqyhxZIlTaRqyjle+aD5N8it+Na1f
	 /KLGJK4Qj6j79WkRp2dxHbMVgRctGVu+pqFgKIHZIvJ02FZDfd9q0Wq9eqzNXW6bRhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKiGCqG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE7606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKiGCqG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3AB1F01825;
	Tue, 27 Oct 2026 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099649;
	bh=VEw22usREZ8y9BZP4VbVOZCabT9+URaZ0tiikwEG3uU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dKiGCqG70inx27YwOD5sjy6r/+L5sEWsebaZzCH4RDEZcVJE+aavHPqH0tUrsWLLu
	 kse9zNjjlRG5WOnw2QqY2es0klgz8Pz6MZ4Zqrz/1dfDbGnLn2tcuhDgxAZbcbxXRF
	 rIHQKEVPrefp+JLGfA1PTCHO+oRSBOoy34eUhn4Qs9PV+rqBiBabNXd8XhyEDri5pH
	 lGY8287fkvE5tjQHFFtxl677gUl8/0PvKR7y8lXeRXCIzKfvO4g4dy7dz/0aV5C4di
	 oAnvS7GHmo0q4bP8b4fPg5fWpH5ay2ycWgdTxxqvahGGf8oyySPKxXzAYTCq/HnhIl
	 480j+JFjGvBBw==
Message-ID: <sashiko-outbox-186426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/24] vt: serialise the producers of the flip buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-1-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-1-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:14:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Chris Mason <mason@kernel.org>
>=20
> Typing on a virtual console while the console replies to an escape
> sequence can make the kernel write past the end of a buffer. A user who
> can write to the foreground console can cause this on purpose if they
> can also inject key events, through /dev/uinput or by writing to the
> /dev/input/event* node of a keyboard.
>=20
> Input for a tty goes through the flip buffer of its port. A driver
> inserts the data with tty_insert_flip_*() and then calls
> tty_flip_buffer_push() to pass it on to the line discipline. The insert
> functions take no lock: they check that the current struct tty_buffer
> has room, copy the data to offset ->used, and then advance ->used. So a
> flip buffer supports only one producer at a time, and a driver that has
> several must serialise them.
> [ ... ]
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ronan Pigott <ronan@rjp.ie>
> Cc: Liav Mordouch <liavmordouch@gmail.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D1

