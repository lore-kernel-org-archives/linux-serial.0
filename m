Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099842;
	b=yijPWXwfG5vnn782/3Pg1JBdg59/6jVoqpZPpZZNq0+FU+SQYF4RzIXM39uM8HjBQUtN
	 OBqn5SYsTOR5AyMlpfrICC42YeUNp0HC6sD11bC5lrlN2pEkNp6mZiRB2AtYLPORL8dfK
	 OGmU/0kos3OkUICmRjOWZO6W9sjUq3wWh4WJhoDgi+JET0GyCDlv36TDOdHo+lgeHsVs3
	 UMe61OmkZ+jA2/Rh8LhB4zjxI45dBBzVxfNJmlj9pWTV8yhvXhZexaiWI+onQxOLKRh+J
	 sD6yP7A/YqBloetjpz/ZyUU/VNDoaoYZ4yax5QKTL+7V+9QonE0qqvwTMTImP/RZtLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NX6QQdB7P9RjKf3QOMPxTcD19/orsIR5/4aWa4V6AWI=;
	b=wxR0dPsPMEu+5UVyMB1SSi+eWfqZ2Qu6FIOPr8zDbzi3pYgOFBrKFJ478bhoQySv0rRj
	 CGC3vtYMqar0H5lP5bsxbKpRRsEcXuW9ekZkORf2OGojTb4kgNJ3p7H+cnSShA9xOs/vc
	 Bb25CAvsdwA013zXuW7y4Fvrp3yBe9ueJzbysleGHXwt7Dmgqmubha3A1TsdNt5yPbO7G
	 XHZtM/v+v3dBFYG/coDvFWvohxBBtyLRn0NmO89GQuYVBibU19E3+BfpFJJYRbZ7EU6eA
	 s/iwSh9DCVESYzJOzFBf3K5D8F8EV2BUwpzXWrW/QqU2RSoH53V+5hVKutgRvpNj04A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqllQfdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F10606A32C
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqllQfdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F31F031EB;
	Tue, 27 Oct 2026 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099842;
	bh=NX6QQdB7P9RjKf3QOMPxTcD19/orsIR5/4aWa4V6AWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqllQfdM8O9AT9WeCAyxCznPKKlcXAG9dAfrYWXE7QNWGOjicaz8nrSqu5G6puXjI
	 PTaQLvU6glKMHr0rHgdIO6RgKt3WTuK5e8/Ka/lEkm4QyrHgSjUQl+atwCoA6528wX
	 9d9A/r513eQBXGZB+E5Fv5OBvBh0D22MkM5laTu8l1jzxcQsLKVAfyXVUX2FtJYwM9
	 ihKtJwb3kZIBLFovTspQ49So3in8uLFqZ9JX9f1Tixm9/OJUcPKtppp/kOOkEoqh/6
	 yjxE6AhNnpzs1hEVSI4XIHSqdgqhZnllsTTsupz9Ty79v5vONuKslMbpUPL58KW/KV
	 ekqWICIvEQ8EA==
Message-ID: <sashiko-outbox-186431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/24] serial: 8250: dfl: add bounds check for
 device-provided regshift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-12-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-12-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:17:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Joshua Rogers <linux@joshua.hu>
>=20
> The DFL UART driver reads regshift from the FPGA feature parameters
> without validating it, which can cause undefined behavior or
> out-of-bounds MMIO access in the 8250 core's offset << regshift
> calculations. Cap regshift at 4 to reject unreasonable values.
>=20
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D12

