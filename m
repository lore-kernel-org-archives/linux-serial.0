Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B1143867
	for <linux-serial@vger.kernel.org>; Mon,  6 May 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995635; cv=none; b=UrK/j4S7VWl4x80pwTFz3bBbqevu3mEYAggYUZfk5BoL5ptsHMhyXp1hV9rkLkgGQjioT+js3U/4lQovxC76eXFgnlZ/W3uSo+E2dAqfkiGVhP2kXyWb8apXKbcZiylyndEVCqgcN+AEpMXx91vYL3BDWZeLae75AliRhmulR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995635; c=relaxed/simple;
	bh=BsQOXq+ahxAfweHQAWj5mwNGLsEtbwecliFaCCUsygw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeUAW+y4xz+9K9yDpggx7z/o2Za3hFgfGJ+/bNw87nnoI1dHC9XFoPLc9RtzmRGcK6OonDltBSugUgEqPqjPIp/nxZFldFcGl0+XbrXbD6Wdi+1gymO7T1z0GCBjalvMPAhb3fawVukWATyNTVPK2OFtHB9hQqZFD2nZDqM0XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gmbYN0eW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gmbYN0eW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=3vmDFjar/7zOCQ0E0AN2tIN3W6sFdzg+LLuJUacu2Pw=; b=gmbYN0
	eWVvpz13qeB+CpgJkjp6DR7VNk0TN2JEzS1AL2OvdXgr3olGLemUU6Zh0VJyg2ii
	ZHU8EGzAz6BY08+lbGpAD6Fhvsw/CqnPalBxo/pLbucRc3qG5vJzQFnKPy2zWQ/V
	tejPXcu6/l1Hf5iZFNanvcwYc8CMSo3TyopoZDkofxjZuFjj4TcBs0pxasac7U5k
	f4xCkxy3Sanuynmpo1bsKF5sa67UVIhK9VfWwnM1r/uwYF7ZldyTZoKDRPVVbBeu
	WEaSsrch/ny8MflRmLpTxh/nO0Z2PvsIFzLomm4u7NFfPcTjGeb/dOYU1F7WaPsh
	los4Y2U4t2QcdLoA==
Received: (qmail 172821 invoked from network); 6 May 2024 13:40:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 May 2024 13:40:30 +0200
X-UD-Smtp-Session: l3s3148p1@hUhTiccXfrYgAwDPX0CuAO+oYiCi4tWm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/4] serial: sh-sci: describe locking requirements for invalidating RXDMA
Date: Mon,  6 May 2024 13:40:18 +0200
Message-ID: <20240506114016.30498-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506114016.30498-6-wsa+renesas@sang-engineering.com>
References: <20240506114016.30498-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure everyone knows that calling this function needs protection.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/tty/serial/sh-sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a6f3517dce74..09eb0c824b10 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1258,6 +1258,7 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 	return -1;
 }
 
+/* Must only be called with uart_port_lock taken */
 static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 {
 	unsigned int i;
-- 
2.43.0

