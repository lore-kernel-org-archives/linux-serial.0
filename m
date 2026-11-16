Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817795;
	b=Uj0Mgw1mL9ox2Dzmr1fil8atFdjCzzY1DpDU/ghlD5MQfRLDs5SL8xrprbwOZ/N0z+i/
	 Mfcr4PRMUaBjPkMEWxleS/qTRZcEz5oC34yDu83I6+6cAqj7UypnRAwqSKUun6fa81ZBp
	 wIeJ6HzR+/hPs3vfWIhtEuN0GqVvXWyLz5iILKIocSslcxBMnMQaltc1FjwxolaSRSlU8
	 +35YSvcaAgOmo06mfbfY6F/A+X0lOhNhlc/3nQOIGA1grngxwvbqCddoNeJOeAo75nRvQ
	 lvk4wdmDuAmCWktqiw7bcvKUUbM3WjZIkJ5x5X8TBof/8QRcrA5aWY3G9foksyQGqFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QkeanQyg45ZyNLmBoydWSV0J6Mj6F+lVtkcxuB94ObI=;
	b=O/T3f1HdqJbXR3HbgiQVtyaOGsAMDk46/YQeTMchejkUfzL0aZa0KxBNElZN1i+oAB7i
	 sq+PBFjB9KCBEGcmCzzdNHz4LIQnL0cSFIuL6zzoqfkCU0hAeCxqHWQhfwL8IrZ+5X/Qr
	 TKBS4pi8EFnHWi3YLv8KJdWcyyPrm4uIZMxotQerzeh1Cci5GRl0WN4bKOi+vn0o1kIQK
	 0yBYUKgOZhEXd0rkKEfhfhSst8oSVLpGbTH+iL/2FwWvPXqnk3i08K4AIu0jC1yULH/n0
	 UdEEjwpuqWLqhw2yOEAcfkhBwTohU1NNOeSqOirroiktI3HjUJoDA6xi//THt69+HOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OenX54h6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F0606A31C
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OenX54h6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1001F000C4;
	Mon, 16 Nov 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794817794;
	bh=QkeanQyg45ZyNLmBoydWSV0J6Mj6F+lVtkcxuB94ObI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OenX54h618q3uHZwCQwtTfa+HE95JRH2lot72iKzUSXzh5HDU7zBpgP20XKqfPwYj
	 Be8V6f9CpjMO8Uwi0R+1Phwo5MMuqksqFBvCQkHnZZE2z/gfZo0rooEFX9SiCEWwtl
	 ec/rFudHqQpa+VcvVubEc65zZ4HmeD+Ia8TguYZNLovEtiWlDhm+W5EW5kLUEN29SU
	 fAsAv2IUCDYpu7TwCFeqB5z+ZNpSx/cDUT7efMWvjqyDtUMFRu26Yr6gdPVoX6tSyo
	 u0FXTntMxEC1nBMba9HxCOg8FfZXETywUczPh8FeZDInfoiv/KsDyP2oxLmw4s9Udc
	 KkXflOzXRWIIQ==
Message-ID: <sashiko-outbox-216537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: do not hold the port mutex while
 waiting for references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-serial-core-remove-deadlock-v3-1-899237225221@vaisala.com>
References: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
 <20261116-serial-core-remove-deadlock-v3-1-899237225221@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:29:53 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-serial-cor=
e-remove-deadlock-v3-0-899237225221@vaisala.com?part=3D1

