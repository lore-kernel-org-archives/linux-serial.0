Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PPKzJKIs"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF98199A
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 22:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1700894197; x=1701153397;
	bh=5nP4UibmKvCQk3hSYcEQtKKldnSTGqeffNlYEsVAavA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PPKzJKIsjNl+mthUrHYXyVU24xnIEWFKLkKaWiFOU3npWsWgf+t+5XqJV2KE+l8SU
	 /kBewbraui6KnYXVUqU08Nog9bZyTcqTKAgo+7LOwqGc3vjeeJUdL4JHulkW62yb18
	 3NVQHyPzdSN3w0YqehoOfeHGT4GF2t2K/AQTrbIbv1GOAHmwHDILYbNnDVb+4v5b2l
	 kc+/osLvcI45j93fws9KCTogibQLUQ1YLUVyUe9r344VWu9SgMgN42mdsvj+NBaRbJ
	 RyeQMCgUB+rISA4WVJaMF59by2Lcv8I+E1H+//OMZilMzR8qF9FxgStMkXe/V3j/St
	 hwELFJbd8TWhA==
Date: Sat, 25 Nov 2023 06:36:32 +0000
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <20231125063552.517-1-mcpratt@pm.me>
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


