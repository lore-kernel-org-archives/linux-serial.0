Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142946;
	b=EmU5N8tMHOpvZBO610EN1qaL8V05+r+RyxZ6zBPsaqpsLra3s+hh5u/nLFXtm//8VrAP
	 lCn3kFwsQbmW+Is5wThOvx7B2gWnwVTtBCzA2YUNDAROVg11uYwa2TuhZX6kqQmz4ykQ5
	 k5nWSgmez7QUDBLnXLxolpE9lMbHpFQ2p3RcKwgkRcoLkY8PMqSyqJhomn4oP7059sil0
	 w0bKHqKNC4bvYcbTjnpMvS+fUWgLH687C3YaA5CUy3WDbh96ML2qbyLw7UAVGazPThpWx
	 DvrH6at1nuSCBSI22BlxX3xFthBo6CrDN54zxTIG1pwieoPTdGuJlBNqeRI9WRyeGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NsrqXjKhCMyFgI+jwTuQxyOR7+xUoZeoI29ELKQ7lb4=;
	b=sSk9zB1fap6oaBxE8VUEEUGxRdYEEViEjHSOsbhOZSWuvFLHumjItbDrKsxXCEq+1xla
	 fxQg09S7MhrYYBqSmx9dAifoqGZJ5hLosWdElB+NxcS8Qg6htUJOdyurddFLLpxdgNwAP
	 +bfLpt22mS7/JDNhzbAkqva9R3yrvaac7nBWbhpLQ6DuQL+VdA+imx4UCTqX3/QIQPdU3
	 GYVxsvHN/CbB4zn5VJGklhYs/MBXPKv/jvYOKdAIo55JyIyNalwg7riAAQ8eDjyW1XC9j
	 o7yZERSyD2BY42d3n/rnzRQNErL3qNbAGQpCpBXuZV22rcEEhL+OkQW7XMGX9WPe03A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZM1jWXp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79D606A320
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZM1jWXp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB4A1F031E4;
	Tue, 27 Oct 2026 23:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142945;
	bh=NsrqXjKhCMyFgI+jwTuQxyOR7+xUoZeoI29ELKQ7lb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZM1jWXppAzlavr+t+m6NblLkSi2Y8S/1Q4dV/SxnzsY3pCyXrmGJUkmiraqwbFfd
	 2r+3Yp1ARCiz2+JPUCTIJ76wcSNQGakunFnB6doSR2uufHGunL4N0tYB8mYVJiXvqJ
	 butDTKWUJcpIk6H+4Fb48CdITCSOGz8Dr4mLK/PXdW8/jK07I1NHodAhQbjX0vFizb
	 en6E5T4jZoTIywjrn98pjbNdZUWnAv5JsljPX4KJuat42buPBiwE0DfjmDTBq7S3ds
	 c+BcGgwrJimzW6XdeIjcfXaiozP3yRCJ7j+NYaUKfr9JKbGxJRUN/+g67PeVMunH0q
	 d1tmDEWhsbHsQ==
Message-ID: <sashiko-outbox-187200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:15:44 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
>=20
> Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platform
> data. Use common Allwinner setup helpers to configure the transmit load
> and receive trigger table from that depth.
>=20
> Derive the receive thresholds from the documented 1-byte, quarter-full,
> half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 128
> and 254 bytes; the normal 16550A half-full FCR setting selects 128 bytes.
>=20
> Build the threshold table during setup and use the shared 8250 conversion
> helper to select the nearest lower threshold for sysfs writes.
>=20
> [ ... ]
> Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled during
> termios changes. Its clock is a gate on the shared APB2 source, rather th=
an
> an independent baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-h61=
6-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com?part=3D4

