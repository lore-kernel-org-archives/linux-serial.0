Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F02135A67
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292181; cv=none; b=gTJZi2Tiqe/OjA9T5qk8+WtjI5fcWL061sVxGCN15d5NwIUXHzsrtgdoGI1EvsWtd3y71M72Yp+rRT1sAqEKtOc0LlNzq1vaTkOCgQ2ra/BIG9/blldmUIERhfxljv1saCzfPlFborNmisgo0fHtc1fDDH4agSqzwkkKpcKgWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292181; c=relaxed/simple;
	bh=dOxdME2FokB9hRdd7JjcniyIFSzAQyPzxZ7AzsMbJMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsLiLMaWrsLKJCadD5GkmVnVnKEPPQbd4v0GwT6s9PMdnUm+2XbnLhD6zhUyd91sP9NdYvNPRiFeyXlyZ8Ll84MirDx5SppWkMj49Hyn4bL33EECe3WEGhNENWvJyDNoEvCUjOVg21oPlYcYc05O4WBdAp/CW1GnImczJ6dPd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=drMw/duP; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="drMw/duP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713292178; x=1713551378;
	bh=BIDs04sJtbgfAiuNZcYHHoKZXettnAp939uQ5VQM0HI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=drMw/duP6znu7Y72oZiB/i9v4BXv5LGJ1LGuqiNtu8Un+mKz9Hvh7yqtus9C/O/rV
	 5rIiQc2qWvKxo4Bd5tLuMOTGXvEIskNXTcoRXx9t/jscvzYWtEKpJw3JrtJ1cOQKxg
	 4ZPms01ZQ67CM9enosRbZhFIV13dyMM2kXJPvUr9W8Bn3phL+t6aCgdGRlLKlAD6PC
	 /uFQs5LuBK4NBqO3NxUP4j61cUU+y1KYMfQ/RcAaCe2nwiQnDPUi8QbyLA4BojZrZ0
	 UO580tFo+yvHje6+vMKdmxENrIASYQZW2ns8c0t+bEbbcoeVBivSDJcs1k206RX7W7
	 GXFurFSJ3VFEw==
Date: Tue, 16 Apr 2024 18:29:28 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v2 1/3] serial: core: Store fifo timeout again
Message-ID: <20240416182741.22514-2-mcpratt@pm.me>
In-Reply-To: <20240416182741.22514-1-mcpratt@pm.me>
References: <20240416182741.22514-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a partial revert of Commit f9008285bb69
("serial: Drop timeout from uart_port").

In order to prevent having to calculate a timeout
for the fifo device during a write operation, if enabled,
calculate it ahead of time and store the value of the timeout
in a struct member of uart_port.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
V1 -> V2: new commit

 drivers/tty/serial/serial_core.c | 3 +++
 include/linux/serial_core.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index ff85ebd3a007..9b3176d684a4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -414,6 +414,9 @@ uart_update_timeout(struct uart_port *port, unsigned in=
t cflag,
=20
 =09temp *=3D NSEC_PER_SEC;
 =09port->frame_time =3D (unsigned int)DIV64_U64_ROUND_UP(temp, baud);
+
+=09if (port->fifosize > 1)
+=09=09port->timeout =3D uart_fifo_timeout(port);
 }
 EXPORT_SYMBOL(uart_update_timeout);
=20
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 0a0f6e21d40e..c6422021152f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -561,6 +561,7 @@ struct uart_port {
=20
 =09bool=09=09=09hw_stopped;=09=09/* sw-assisted CTS flow state */
 =09unsigned int=09=09mctrl;=09=09=09/* current modem ctrl settings */
+=09unsigned long=09=09timeout;=09=09/* character-based timeout */
 =09unsigned int=09=09frame_time;=09=09/* frame timing in ns */
 =09unsigned int=09=09type;=09=09=09/* port type */
 =09const struct uart_ops=09*ops;
--=20
2.30.2


