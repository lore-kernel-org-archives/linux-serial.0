Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735938;
	b=YzdD5ruI+TlRBwCOPjiOvZgcytE7+Kop7p7Ejm7IAeAmrb026LmE1GS+HjEeV2IqPm78
	 pJkuiUX4ODksrzneq7gg+tzVIY/iDU8ChyZbOVCFWaUYnZ5buuH0ECv7twXB16dW9hs+N
	 QkAM1dxAAF6vCnwXf2XzBn6aBBGhGyvX9KpkpuRtckNk+cVWqY4ieDptjvi+IaPOu5F3D
	 DlKCqtR3ZtcrexqMqckquobKvq7HXQLM+SBn3/lQGZipmpgNFw9dE9CSt9CGX8H+gjogJ
	 B9vnVExWjctd1awd290pwMmVr6q2TzQS68Mu3/Vgjm+m62mjSxRc8OkR/Pvt44VoMOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hlr8Eo66Ll0b0+G41kkku3y6ks8dABzxZhGZaCi0TcE=;
	b=JnaIr0UuvNUMCUjdV/KcWD3MgJ6ZuHvlfsyNYNyvMjpvlWS1nyVwvKKPMk+WjJcxgHOA
	 rsYlCFDoX4f9dmiiNH4xo7crBfalZBBWjKionxKIhd1NzqEwBzNedVIPgpKNddFUV162k
	 EVgEdqZRZ8uYCg1NI3z9IdF4rHUHpb2TAgZw9cZ2pc4ZxCrJdL8gRrWFtZvawMt67FzY6
	 eVH3a6dRsEDufcmhWHj64dynVCXaiHtkS6FeOlrkXKfNZu7/YgtJbMABPPM8VjDCneHAf
	 1MjkeAMv1atcNKiDs/2Yd6QjkbjFfwcI7qmrfItOJSYd79TQSZ03Of79WVoE8ayHl9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZjwkCw/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F7606A31C;
	Thu, 26 Nov 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjwkCw/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0F21F00893;
	Thu, 26 Nov 2026 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735938;
	bh=hlr8Eo66Ll0b0+G41kkku3y6ks8dABzxZhGZaCi0TcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZjwkCw/sNCOdWMHQ4oNaPMM+6Mk1jGT83rzoZx6iEp07270sSu3/LlVmgkQWN2slz
	 f9/p3NQLUmuFn6IFIRidJ/R3yTpy4IpINN4uzwjssqfIKxnTVjQnNGigKykataOe8+
	 jbjLJq7+qEnYRgpkV0iRFovvgpvOvSdxmiMi/2qGngTfzNFfSvGkEoahDjWtceX4aI
	 2G7yGtjtd5SZaViJmKiPdYAsE+cewatSUI/f+6Wmih8NqqE3XKIWiq8hwlC6ZkiWWZ
	 K30/DoNkBbMhicoclo4bxmicrLTdN1cTmqQDrGO2WKxyjAZVLzDWeVUhuYteqGwOWH
	 8T59S/7sUN8Vg==
Message-ID: <sashiko-outbox-236333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/19] serial: esp32: Add support for the ESP32-P4
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VsOtdG9yIEh1Z28gU2lsdmE=?= <vitorhg20080@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125233020.1380594-12-vitorhg20080@gmail.com>
References: <20261125233020.1380594-1-vitorhg20080@gmail.com>
 <20261125233020.1380594-12-vitorhg20080@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 23:32:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] serial: esp32: stale console setup claim in commit message
--

commit c3883508f7c188e23ecf9d3f613c855b10843a75
Author: V=C3=ADtor Hugo Silva <vitorhg20080@gmail.com>

serial: esp32: Add support for the ESP32-P4 UART

This commit adds ESP32-P4 variant data, clock domain register update
synchronization, baud rate limiting, and probe/remove error handling to
the ESP32 UART driver.

>     Propagate IRQ lookup errors, including deferred probe. Serialize UART
>     port registration and removal, and clear the port table entry when
>     registration fails or the port is removed. Keep the console setup
>     callback available for probes after init memory is freed.

[Severity: Low]
This isn't a bug, but the last sentence in the commit message appears to
be stale. esp32_uart_console_setup() is not modified by this patch; its
__init annotation was already dropped in the preceding patch in the
series, commit "serial: esp32: Restore the ESP32 UART driver".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125233020.1380=
594-1-vitorhg20080@gmail.com?part=3D11
