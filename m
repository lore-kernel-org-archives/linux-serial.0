Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789242;
	b=ebaPUrR+292VoIYM6NuOsCj7PWD8l91X6hBOINySGsO0Mt39zv06ORgNnh2NbSID0xWo
	 MbAsAWg2vzXKMo2GXS0NOd3hVMbaMCqPRN81gtmBhVO53W26q9a9AI7VqML6I7V/zzbrw
	 W6kgV5UnfCPznAv6wIg0laXgabw+JijuqdQFq+EABImU+TohTkUsEM40C/Yp6HT87UcvI
	 pjsiE7F1VxBe9zoBPj5c6STBqlkX4isEXnfLSzunVjWMWkY1ZCuzY7Qcxm3cqM4BzdHRs
	 iJD7D+Ewjy2RI2hD/EFOP3+zlzFKcElEUILs1ACFopgFE2o75loYeFC6jg1mnop0oYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LChWdjSPYOMXY/Lwpo76VTco/6Lcvm8hi4w53u27brQ=;
	b=bFTr0AO/C+ZdZJC9vOQ0zLbgGycFC+rbDgqHWlSaX7GfC6GaVrPdoliBZOoULX8hCoyF
	 8p3fXxLdEOykOo2TpKKNDl4efhzFXsEXZjG+5lhBHhiBUEW2qI4YqJz78NWAt9zT6o8lt
	 LsWk0FUuE6RSELoSjKQARH//pa5Kob2AeO7KaJIRN4xcS0ruQJ+UTfUc/x4OFjZusKCkC
	 LbuO5B5e1rTdPl0e29x4C1wyRRYRcg3ffJGsQFua4KyxMUNtUIj88pdG4KkKKrkek/xSo
	 6umRXJkd8Ai65Klx9ZlIMXACEjWmzrR4IgHG9f/r359MLViufEr6NzwR+VWy/ZEpy0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQNMIWKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F7606A326
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQNMIWKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BAC1F000C1;
	Wed,  4 Nov 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789241;
	bh=LChWdjSPYOMXY/Lwpo76VTco/6Lcvm8hi4w53u27brQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQNMIWKSPJthQGHptARHbkSH4Wgk+XTntRayjwQaNf1+sPPsR3FoeRx7JNh5PLPaL
	 9r8syyB9R2/db4cRq7aq+xuyhVnRZBoS7a8NDI3cK8YDJO/FhHavYdntQLECGf3ifg
	 EEwEIpgHJL59ac3X1GVJx2YbgZ/qRGl/c+KlXK6QwBnvzBYcmNiPYW8yy/q3X84mG+
	 ywn5N7jv/w+5kDP0iJ4PSxXqXwY2H1oNY/GGHnmpqJuFBNuzAoASd1yulvqqTHNC2b
	 95rXy8VqkFOf5mvxcwbqEdKe5VpAeN+zc5P0JlAl9f0JFjs0kzAWm2jtf9xCPpuJPz
	 PfF7h/dv0CtOA==
Message-ID: <sashiko-outbox-197119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: core: do not hold the port mutex while
 waiting for references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-1-6a30597adcbf@vaisala.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
 <20261104-serial-core-remove-deadlock-v1-1-6a30597adcbf@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:47:21 +0000
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
> [ ... ]
> merge.
>=20
> Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
> Cc: <stable@vger.kernel.org> # 6.18.y and older need the open-coded form,=
 see below
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-serial-cor=
e-remove-deadlock-v1-0-6a30597adcbf@vaisala.com?part=3D1

