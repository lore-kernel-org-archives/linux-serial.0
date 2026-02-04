Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593C284B2F
	for <linux-serial@vger.kernel.org>; Wed,  4 Feb 2026 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191034; cv=none; b=u6h5lh3QyhnXDHUWBSD/berySNc3/iXAaGODLLferlJKTVIxRK8m+W+fS7ZUdwmB1ajRge41c65X62yy6LMUQtAMgeFX7L5AZz8taNkrz2CoHBkP+wukKl7ZnrAMdQhCqX+De3PZqJr+5Cn4k97Y/XCeJtBMS30bn+j8ZNHV2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191034; c=relaxed/simple;
	bh=niTBeRceDwoLEBT5u7iSTYKXkOktFE9vUm+m/Zpm654=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLI5Fp6pwgKRWweGtkKsdQ4LCHyOvLCVNX+9nW8dxHFuS/rvqWyg/MqYeHX1rn0FrEmM9CPcDbhBfUK4oOLBy6QU5rzlb0SZ+cWt9NxWScqL6vM91cHYdrbe25aLtFCY1vz6UbPUik4K1xY0hA/0dNqb3rtdu/XD0YpsjXcB6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i5J3EVDP; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i5J3EVDP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770191022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OSl8xOxJ6C6TvFYbGAz1Lq8WfjM3EbGNmNGuWiDCzvY=;
	b=i5J3EVDPzCAQZss2XJydQJjuOkCX2B+533ThcYhxLElHvNF6kGtv6ycxe1CoGHG+wEZlK4
	gKMjG1IVwLFIk9F5VVL/+Zo/Qr7TMEGZ/SRl7HzTR0rO/rzGuxSyCcIEMWtEFuTCAC6qK8
	JU4dZSav6Y+OeDV4HeoaU6VVsLXPM1E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-serial@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN
Date: Wed,  4 Feb 2026 15:43:20 +0800
Message-ID: <20260204074327.226165-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

uart_write_room() and uart_write() behave inconsistently when
xmit_buf is NULL (which happens for PORT_UNKNOWN ports that were
never properly initialized):

- uart_write_room() returns kfifo_avail() which can be > 0
- uart_write() checks xmit_buf and returns 0 if NULL

This inconsistency causes an infinite loop in drivers that rely on
tty_write_room() to determine if they can write:

  while (tty_write_room(tty) > 0) {
      written = tty->ops->write(...);
      // written is always 0, loop never exits
  }

For example, caif_serial's handle_tx() enters an infinite loop when
used with PORT_UNKNOWN serial ports, causing system hangs.

Fix by making uart_write_room() also check xmit_buf and return 0 if
it's NULL, consistent with uart_write().

Reproducer: https://gist.github.com/mrpre/d9a694cc0e19828ee3bc3b37983fde13

Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2805cad10511..0b2edf185cc7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tty_struct *tty)
 	unsigned int ret;
 
 	port = uart_port_ref_lock(state, &flags);
-	ret = kfifo_avail(&state->port.xmit_fifo);
+	if (!state->port.xmit_buf)
+		ret = 0;
+	else
+		ret = kfifo_avail(&state->port.xmit_fifo);
 	uart_port_unlock_deref(port, flags);
 	return ret;
 }
-- 
2.43.0

