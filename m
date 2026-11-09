Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235917;
	b=OzXkHT7WYSRfgHcIuZ/tf/JLFATEFl7S0WCXAdUshIAcDiQzAkYhbMAILBSRPHPON96+
	 3gAlf3V+fnse2YprD5ivo2CxzxtHWqxoWHSxXScC4KSo8bhLr96DFQjVRJb7QsnXgZQNZ
	 UmnEgIWzkMTTbnkrb6BmvWW2aMqexxssNazprEIzTa/KISUZn7Q0yGu2mbRb0JTNtIDTd
	 TOAEZl383S62N2+NoenjsOrBja94Q4/zTibcgEsGWpFy7hHJHCaTTfaLeHHYyKpnuTKze
	 GeY8XG55k8fLJLx96SBla0ONxMw9MrpUafSUpwxiIQ+9PwOcS3NhqY4nBiPs6/+nK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235917;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QVN3Q7FA2EALt28ulM5kE5A2x0Xe8k6YsLJ/Ap5Gs+0=;
	b=iP+k5IgJYO+9hmsxzcS1y8jXI2VACvp+BKYeB2FoKzmVdzL0M7iCygYgKiCW50PoQsI5
	 p2FuMW0om4YVzUEJX4/q0iq+gyD75EMCE5w8+D4jKknTBewihConUJgjAxN5/9fv2dWYX
	 RBcjgSrFbcMSGkXRdVGx5prHCRtBNGxXk274JZS28efg/kGHOhnPIJMYoJUjN8o0owJJW
	 B6wVpEiIiYr+tERqV3pE/eqVCEu8ce/VG6VBntMKTzKAazDg4YOWaZMVAuE40FC6jjHX+
	 udRFNZvQgoKPlEWuLGFmgXP+WuwgvYnsNqnbV28LnfW8zWBCi0e1cVNNg9/EfcCywHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hW6KFwfq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D0606EE80
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hW6KFwfq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF91F1F008A5;
	Mon,  9 Nov 2026 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235917;
	bh=QVN3Q7FA2EALt28ulM5kE5A2x0Xe8k6YsLJ/Ap5Gs+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hW6KFwfqxMT9Onm7lVlGqvAdiDxFjsySMby9DYZSOybv4A00vK3g+4zLwYLsqN8E8
	 i+Htk6/2/4wznHUxKE3cwDMrFcpxndMB1/sXRKKiDMornzKVeTfGzuW+yN7vOgBfHY
	 P41C0i88ai/6KR08qJiFlx3gJcANjnKb1YHwTHd4Oko2EVIWzuwnux7IIRsjMVYCXf
	 /YGu4tQ56jfqB7wIWnpy5tTgf6Q9xgW4dt4OnM3XjKYRDidCRTCqakvinUkkn7D742
	 v0US8DHy8SB+LP2DphzpMS/E+Kcwsx7U/DWPTtDPkGpd2gEv5GDchxdulQOcfdN2L/
	 8WpA9jEyTyF/A==
Message-ID: <sashiko-outbox-205133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: Select U6_16550A for 64-byte FIFO
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-8250-select-u6-64bit-v1-2-04bc8332fa34@gmail.com>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
 <20261109-8250-select-u6-64bit-v1-2-04bc8332fa34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:51:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>=20
> DesignWare 8250 ports that describe their FIFO in the CPR register are
> always configured as PORT_16550A, regardless of the FIFO depth. On
> UARTs with a 64-byte FIFO, such as those on the Rockchip RK3328, this
> selects the 16-byte rxtrig_bytes table {1, 4, 8, 14}. The rx_trig_bytes
> sysfs attribute then reports 8 bytes while the hardware triggers at 32,
> and writes to it program the wrong trigger level.
>=20
> Select PORT_U6_16550A when the CPR reports a 64-byte FIFO. Generic
> autoconfig already assigns this type to a 16550A with a 64-byte FIFO,
> and its rxtrig_bytes table matches the DesignWare FCR RT encoding.
>=20
> The FIFO size, TX load size and capabilities are still taken from the
> CPR, and the default FCR value is the same for both types, so the
> hardware is programmed exactly as before. The port type reported to
> userspace changes from 16550A to U6_16550A.
>=20
> Co-developed-by: Miroslav Ondra <ondra@faster.cz>
> Signed-off-by: Miroslav Ondra <ondra@faster.cz>
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-8250-selec=
t-u6-64bit-v1-0-04bc8332fa34@gmail.com?part=3D2

