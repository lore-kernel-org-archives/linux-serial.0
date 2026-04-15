Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836C37EFE4
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240104; cv=none; b=VuicyC+O0sLkHfTrPBOVJ/cDZvzSdaALaHsREIEsAHBZ0rqbfLNKG42rZYR2zbPIiYTHMYYZkP892WW9ZKL4ZEdg5k58Gz9Xv7aQI/hXRLu2mSdkZX+QUk6OpXkEGVOJHvfjoil87WYxjyU2iLBdyPhb508enNFENa+KVdO7KZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240104; c=relaxed/simple;
	bh=zH5R+3omkoQn/yAIM3vhsojb37s2SpmxgxeKfxNZIWA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FfADZO0fvuDTEdExSE6wN2NhMjbHuLWMuMOA+PT4qPfciVpaLkXbzGA8/oUPLzQHJX+ZX2Vcb+bmDjmb8V239XpcVHC1qavZ4g5S5Zt7X3KCCHzD/JlPR6Pb7ba5zBgSLGITAH/V93//4LqRFOzPnizQjV1HOiRw+bywjdCmnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VkAWM8Nl; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VkAWM8Nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6eit5hjru5dlrjhlanp5minbjy.protonmail; t=1776240099; x=1776499299;
	bh=zH5R+3omkoQn/yAIM3vhsojb37s2SpmxgxeKfxNZIWA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VkAWM8NlrE1ffvGK4ivg14Cn6MX2ogD5bOObVAS9zVy074Sfj2tkhl87UmsM6HYan
	 9BE7OJ5EFjdLidik4H8cu58duoNFzvZGMyg+iETdRmCamJ8pbp3E6Lrzllch0IsGwX
	 LCiwxUIN3e4j7/Dl/gERhuTGOS9JlamTiQnEQwf6S0p4Q3FNZKPDvr/StQmxTVvSFm
	 K/QRNaH6cyp6rqjm7k4hZptjhdMdX2y8iA5meaJFed0cDnm4gvTIu8sN1U+WzThqf3
	 85goLcKDI5cKTWoJF4voZMIMInFvAvXVb1TdKrRcI96x6H3iZ7potRNU3Uo0f4Yorl
	 zLaT4m2yRoggA==
Date: Wed, 15 Apr 2026 08:01:37 +0000
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
From: kpursoty@proton.me
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>
Subject: [PATCH] serial: base: do not disable TX on hangup for console ports
Message-ID: <1fpGAFo1KYyRDeGSGmaDWx6gXbV00C83qU_tep62Zu_cl9JfjpjWg8SKhw6z0owZ9eEMzXR2GnZ_U3V2PVi2R1fuGAmzgK43GYbWkCIBFf8=@proton.me>
Feedback-ID: 133470881:user:proton
X-Pm-Message-ID: 785f3e68caffacde9b766153f0d21ada41986603
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

serial_base_port_shutdown() calls serial_base_port_set_tx(false)
unconditionally. When a TTY hangup occurs on a port that is also a
registered kernel console, this permanently disables the console
transmitter.

uart_hangup() already guards against uart_change_pm(PM_OFF) for console
ports (see the uart_console() check in uart_hangup()). Apply the same
guard in serial_base_port_shutdown(): skip TX-disable if the port is a
registered console.

Without this fix, any path that calls uart_shutdown() on a console port
- including TIOCSCTTY with force=3D1 (as used by init systems such as
procd) - permanently silences all subsequent kernel console output.

Signed-off-by: Kervin Pursoty <kpursoty@proton.me>
---
 drivers/tty/serial/serial_port.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_p=
ort.c
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -110,5 +110,14 @@
 {
 =09struct serial_port_device *port_dev =3D port->port_dev;

-=09serial_base_port_set_tx(port, port_dev, false);
+=09/*
+=09 * Do not disable TX on a console port. When an init system calls
+=09 * TIOCSCTTY with force=3D1, the kernel hangs up the previous session,
+=09 * triggering uart_hangup() -> uart_shutdown() -> here. Stopping TX
+=09 * kills all kernel console output permanently.
+=09 * uart_hangup() already skips uart_change_pm(PM_OFF) for consoles
+=09 * via uart_console(); apply the same guard here.
+=09 */
+=09if (!uart_console(port))
+=09=09serial_base_port_set_tx(port, port_dev, false);
 }

 static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,

