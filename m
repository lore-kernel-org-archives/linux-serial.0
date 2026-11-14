Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697949;
	b=RU+EsmEi3Lz8hu53QlJCIqTvmGFV6u+oFJTW/tBJlr8Y1vWYhr6SI1Kj2cdB1ppMRTQ5
	 ZTodTQyneKIrw4zQPywINjT7uIqfkAqLESas96vxWSZ/jrmc6cJAT5jUi9eELkURktg1G
	 yaug4T3jupgPEgfqRLcVSLKp0hWIdbXG4EEoEDs2sewTp0i9ITIwzgRSffSUtTAB03hDe
	 eFSjrpgv3Vlo2/JVFLHPaYCt3LlQ4faaUhdagwyQWwoKeVVr6lx9PKzgjD7eacZ9jK8w0
	 H486uPiCrg8qySErEBy/qPidoQNTbNe6IvpIeIbsRXJ1UFAAF6Erk1Ws/R8uI8NOpgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=09DPNXwO+IPPhbix6Jmq1fgyfDTlFSS+27cB1opFFqI=;
	b=qKeZ8AbQs4gLjki48aB4pq8wXOysCHIg5vRZu2Dee6kN9LTR6TewfLqtiAjgWPHkV/NM
	 wVp+CYMwBPOOP+hmOiXme8YMMknxJBKfmkqRaLISe7hHIFVQFjyfdv4QuIR9nyf0cwSOF
	 eCwAnHGn9bN7gWhOnxkZ7+iFXSBqPQ4DZ+7TcJad+3ZxwjTaX+A/fWwmEP1fCfMg8YEW/
	 vv8ris8+Upw82/97JvRz2H6zQZqvrQRvQ/TyPVFaS/qX4rGMOOq3wNpnrf8NOE89EnbQc
	 8Byj+In9ku+NhlS44wJp0ya1SjINcI9PRIjM+nXVkCOibBFeb7nHmOWx7g1tIoYTwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmy+BMJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E482606A32D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmy+BMJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FE11F000C4;
	Sat, 14 Nov 2026 23:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697948;
	bh=09DPNXwO+IPPhbix6Jmq1fgyfDTlFSS+27cB1opFFqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hmy+BMJoGpPse3kOg4csI1ylj/PPfjcB0RGkwu22U2XOxbVMhy+2oQdR3NxhMfUsY
	 ALJ+rtVnAWs3qHmem54LpFBt96AToIRzeSCpBouQtCI4zWj55qIi0nWdn3xN0wsBqX
	 jS9DFLp2D7ps0r+/22nDYB5kF/+vEuzf+ptuxSwu2PkuqEHQvObvcLdKylHB15/9QR
	 b3vqQ7kYTM7R8NSbxOEBKNl3N40dw1DbaoTF4W82PCRCs1F8kPc7ceHkstl7wrkgMa
	 FYn9LSzVE9cehTdJynEu8iBl17yh/LSsFzDu7JMiuOXPYP51WZ4SdjOPJrhXaW325G
	 d2sQYaYUepzgQ==
Message-ID: <sashiko-outbox-215083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/16] HID: ft260: i2c: fix large write transaction
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-11-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-11-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:12:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
> from busy device"), which waited for bus-idle after every HID write
> report except when the report flag was exactly FT260_FLAG_START.
>=20
> Multi-report I2C writes keep the bus busy between chunks for atomicity.
> Treating those middle reports like a final STOP caused ft260_xfer_status()
> to spin on -EAGAIN after the second HID report and fail large writes.
> Write-then-read combined transfers still worked.
>=20
> Pass the bus-busy check policy from the caller: ft260_i2c_write() and
> ft260_smbus_write() wait for idle only when the report they send carries
> STOP; intermediate chunks and the command phase of a combined transfer
> do not.
>=20
> The SMBus side matters for register reads. The command phase is written
> [ ... ]
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
> Tested-by: Chris Keeser <chriskeeser@meta.com>
> Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D10

