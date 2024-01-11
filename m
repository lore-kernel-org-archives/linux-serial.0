Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B2814
	for <linux-serial@vger.kernel.org>; Thu, 11 Jan 2024 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kiRmVSS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1704932851; x=1705192051;
	bh=OkijiJRSxRVwfQmNOQyfPf4G65ZauMEV3546lKD1NdU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kiRmVSS0MAP+lN1koA8/H2LWxs1U6Ao4PB1IJbe/EplLh6vONLTNFLVlJa6PQjaPB
	 4x/yEMwxQI2ncMZ+BHf+Ll86FabImYyBg9/cOtsqCP+RM4lSykT/2mpuLxu7LkvYlj
	 sClfb9ALClDG0zpVJQvYBrEY8ZaTM/ou2gVNZCKuLz2wQ8KzRhpzKKPZx6sxk/05/m
	 n3a86uJV6To79UNz6SOrZ+SnHYAiBOGWKBtjcH4DxzJeoETTFg7QEwFlUPCR7j4AOS
	 h9kAOArObmTyHFkLITab9Xe1z+VCHQ+97ccDJGl6BzexljvS/5MMtIdwWA5evK6y0l
	 CYF72fbQHS2mg==
Date: Thu, 11 Jan 2024 00:27:07 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <20240111002056.28205-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
reworked functions for basic 8250 and 16550 type serial devices
in order to enable and use the internal FIFO device for buffering,
however the default timeout of 10 ms remained, which is proving
to be insufficient for low baud rates like 9600, causing data overrun.

Unforunately, that commit was written and accepted just before commit
31f6bd7fad3b ("serial: Store character timing information to uart_port")
which introduced the frame_time member of the uart_port struct
in order to store the amount of time it takes to send one UART frame
relative to the baud rate and other serial port configuration,
and commit f9008285bb69 ("serial: Drop timeout from uart_port")
which established function uart_fifo_timeout() in order to
calculate a reasonable timeout to wait for all frames
in the FIFO device to flush before writing data again
using the now stored frame_time value and size of the buffer.

Fix this by using the new function to calculate the timeout
whenever the buffer is larger than 1 byte (unknown port default).

Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mcprat=
t@pm.me/

 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 8ca061d3bbb9..777b61a79c5e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2076,7 +2076,10 @@ static void wait_for_lsr(struct uart_8250_port *up, =
int bits)
 {
 =09unsigned int status, tmout =3D 10000;
=20
-=09/* Wait up to 10ms for the character(s) to be sent. */
+=09/* Wait for a time relative to buffer size and baud */
+=09if (up->port.fifosize > 1)
+=09=09tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
+
 =09for (;;) {
 =09=09status =3D serial_lsr_in(up);
=20
--=20
2.30.2


