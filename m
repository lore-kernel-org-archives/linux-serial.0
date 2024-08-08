Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9B18C357;
	Thu,  8 Aug 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113361; cv=none; b=hIQrHrtw3IAUhomVbNtj+pOPRThrKspkYJTPwDHZePYUcsvQ6Dq7Oj+UApL1kR2JPy5HfVZMpPT+ajIey6ynBrXvlZxn1f4w0pVshQ9+XGYz2UOeE0XPKmk0EAlOuN4hqrQ7vSjlrRiLPUmHUhji4K6G0RKpOMxPSGOSuCG7YJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113361; c=relaxed/simple;
	bh=X6/kBkEjHc/F/C9MNeI0wvDAMhnS3BamehrQ2Uf7rmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9bUk1DEAjWG5c3xcloMB9HGBfgFAj5JwfO5FtEitSTQ6HPXMIS0gex0PFYcpzlYBoTxQHZns6RqlDZLro39GwyLeewS+zbqOToNscAEVbYQbwL1ipEp1PIFl6yxIUzCdMPIjC0952VZ0aGNXTGeDzY3DRkYrbVznnnWsGwfQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv4c3W8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv4c3W8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C86C4AF0E;
	Thu,  8 Aug 2024 10:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113361;
	bh=X6/kBkEjHc/F/C9MNeI0wvDAMhnS3BamehrQ2Uf7rmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vv4c3W8qupRyUobgJwFY3BT22gSLSqhPfOrh2ezWbFsDrEI1lE4kp/dfvGtYjpzA7
	 MGNQaqKDJPTCgLZzXCjlkxDTvIJ9C9i9fENgJuQWCqxTqHWGxx2/j1XP3mb4uXHY7C
	 utG//gZCJ8l7/+bTqFk09SiD3s0hEBCPUir07Ne1CpreO5r4FvuS43DJtx4IpDcKQ3
	 aWq3qgK/kaWeBxtBV6txESoXabdpxDJiOpFG3b+EbFiP2URVKzUJkR6j3jgdHDMM0K
	 msO74UzQSjicHK8TjDQrbWo5gggEGQmJm4WK3uTnxLv64bw51EQymlBK/WGjoPxpkS
	 aAA274cMhWrfw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 04/11] xhci: dbgtty: remove kfifo_out() wrapper
Date: Thu,  8 Aug 2024 12:35:40 +0200
Message-ID: <20240808103549.429349-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808103549.429349-1-jirislaby@kernel.org>
References: <20240808103549.429349-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to check against kfifo_len() before kfifo_out(). Just
ask the latter for data and it tells how much it retrieved. Or returns 0
in case there are no more.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/host/xhci-dbgtty.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b74e98e94393..64ea96494997 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -24,19 +24,6 @@ static inline struct dbc_port *dbc_to_port(struct xhci_dbc *dbc)
 	return dbc->priv;
 }
 
-static unsigned int
-dbc_send_packet(struct dbc_port *port, char *packet, unsigned int size)
-{
-	unsigned int		len;
-
-	len = kfifo_len(&port->write_fifo);
-	if (len < size)
-		size = len;
-	if (size != 0)
-		size = kfifo_out(&port->write_fifo, packet, size);
-	return size;
-}
-
 static int dbc_start_tx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
@@ -49,7 +36,7 @@ static int dbc_start_tx(struct dbc_port *port)
 
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
-		len = dbc_send_packet(port, req->buf, DBC_MAX_PACKET);
+		len = kfifo_out(&port->write_fifo, req->buf, DBC_MAX_PACKET);
 		if (len == 0)
 			break;
 		do_tty_wake = true;
-- 
2.46.0

