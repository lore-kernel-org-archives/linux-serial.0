Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735942;
	b=BO0y34I/UZ84iLBoSlQSB2fj5JL85Lx0r4EnvT/zFNewd99Th3p3cFvrw8Dm9mZwVsHa
	 86hV0oN4+XaRmABmacw7le18QSUDrJ/Va9OHNrzPe6DfBJPTAio257yk7jHs5L8irq7Uy
	 YxGJoy4okWIpPqhTSIPfkOPLa6UbxkPhR2K/VY4Vf4T4BhFi1Ns3TcO1DO8wPBABbEeQ6
	 06tWAzomEZaS7+s0xWAIpi7nsXsklP094xFP3/LM35BQQbwGuxqhANZYUgzXHw7J5djGp
	 CuQhpvYWSSdKQpHCEybTErV/RzAtPdIADL1QWVZMtBMip8qGCZRFvXy7DS9y6kmJC5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+jZvp7e4s9WrkmsRr8sDopDpOaYpVmxpfywLZzHH0uw=;
	b=A/65Av5ncMiAoGUzaw6zZIu3ZGVrRmbZO6s/ehY2bXScdCHk3MyZ4GHghksjCvJccSnD
	 Yb+xocdaUKJk5DVjAQLqdtiKwt9F7lxh4vYKzA+O439qCuiCd6LZ4IydVnVkmJZwhLyzS
	 Kw5iaKQI3rrXsFgYMcX6fz5wRkLrF6H/fyBsd7GYAcmS+pKJxJmoRFIsuDM2HwS36WQQj
	 9CZzDqb1W20ivYOLN7FtLJEilRulSAsL6xxqYcy994+ufxbWkslt4LypJPfAnxlhwI+9X
	 1XJFVVMcIsGf8RmJGgMl1c39Xo0/8mnVu0RK0H8ULpifzOe3GVB/jiGxes443LMDDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U47dKGGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F34606A31C
	for <linux-serial@vger.kernel.org>; Thu, 26 Nov 2026 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U47dKGGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1961F000C1;
	Thu, 26 Nov 2026 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735941;
	bh=+jZvp7e4s9WrkmsRr8sDopDpOaYpVmxpfywLZzHH0uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U47dKGGUCnAd0/Un+9BKwDWzucqzYWV4Iu/JPWvjUE8vMq118WBKYXr0uZO1Tiuni
	 09U3FFE3QsFz++/DurJaKRgrF5KJnfxtqrhwA7W5CmSYNcRO4nh62H7i16R6bs2gCx
	 PewnYyUN9X1mgX3WLnjbio5eZKZimNOyw8sc3WtAmr4RDQuUPGKsTq/drB7iiCciln
	 XpG1M6bA6zDH309GffnRxZQssGSW9kvuu8ys1iAylRqVHltRHEP7D7BgbOrFtI6u55
	 vMEG0LjkFwjSdNRuAAvm4lEKXsj9QN5ozzIfFAz0XlgV6E1/SNb0Z7vukPB4mD4NYO
	 b6tbyADn4dZwA==
Message-ID: <sashiko-outbox-236341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 00/19] riscv: Add initial support for Espressif
 ESP32-P4
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VsOtdG9yIEh1Z28gU2lsdmE=?= <vitorhg20080@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261125233020.1380594-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 23:32:21 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 19-patch series:

- Patches 1-7, 9, 13, and 15-18: no issues found.
- Patch 8 ("clocksource/drivers/timer-clint: Add Espressif ESP32..."): 1
  potential issue (1 Medium)
- Patch 10 ("serial: esp32: Restore the ESP32 UART driver"): 6 potential
  issues (5 Medium, 1 Low)
- Patch 11 ("serial: esp32: Add support for the ESP32-P4 UART"): 1
  potential issue (1 Low)
- Patch 12 ("serial: esp32: Rearm TX interrupts when the FIFO is..."): 1
  potential issue (1 Medium)
- Patch 14 ("riscv: Synchronize instructions written to ESP32-P4..."): 3
  potential issues (3 Medium)
- Patch 19: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 8, 10-12,
and 14.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125233020.1380=
594-1-vitorhg20080@gmail.com
