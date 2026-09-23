Received: from vsvhrvbk.outbound-mail.sendgrid.net (vsvhrvbk.outbound-mail.sendgrid.net [134.128.88.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41F5328C7
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.128.88.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172082; cv=none; b=kq5fDB5dB3YHTjCPtVEWvV6Tl/JPTcut/TYJ3uVQ2VFc55LHxaSEzH6QypemPiVPw9dBztzltLnPbQ29C46SWWwak6jAz9EWXpbMadaHguDZhRFiKC476TBk3+cjPhwxHERnR48TX0XQpMRKqgs+Tl0Fz7Ue7b78Vn2vNOMMcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172082; c=relaxed/simple;
	bh=VtCAOF3URoYoFtvn3phbkHKKn+WK22yhRZJIY5QUryU=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=FG3R0aTXFI6sbW0v27NtSfVgspHwt9+Xwo8JLoyfT203lklmF9x9n7YXK79HoBow+3P7B/0DGErD4UFML9JswFsUTicaKdFZfaue24D4SJwBbvXitwZ8JXVQ6LON+LZH2sek+EveWLb86DIWE5gJLuBHG8PjBKTzTMpuv3G9R6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flowbird.group; spf=pass smtp.mailfrom=em8284.flowbird.group; dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b=mDui+zbQ; arc=none smtp.client-ip=134.128.88.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flowbird.group
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em8284.flowbird.group
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="mDui+zbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flowbird.group;
	h=from:subject:date:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1790172077;
	bh=yPwdXincuadvk1qnquPvV+ndT1MCQhh1Fha4ubgEw18=;
	b=mDui+zbQXLrxyEO3GXdFMr2lu3IWAb2RsKot/K1w9KHgOUZ+1F7M6PVx9oh5JN0F0FBa
	Qew+gHBRQIjDVlxhFeakomcVzFRxHZEA0vn1I+ouxLHtG+pUIQMKx6Msrah1A4PFuYzSxK
	xgmRq1X34WCw8e5fuY1gN2RVmjuE4Z5Llp3SjWSormHeUMjYffL63AAevchloQkGttqRR2
	6q1XWGQbBbJ5Tnlxq8E1D8PvVZIICH5W2UvvcFbN5BLb40HRF2H4TdeMVAo5hGq/C2Q8nY
	HsSEuQZG++MBFLa4XzPUzxbfP7xjL7huhPYGcXoNb0fgN8BBgAaVij9iQk7v5Hxg==
Received: by recvd-654b7d464-9fg2j with SMTP id recvd-654b7d464-9fg2j-1-6AB3DBAD-57
	2026-09-23 14:01:17.324560652 +0000 UTC m=+79740.228257346
Received: from FR-BES-DKT15120.home (unknown)
	by geopod-ismtpd-9 (SG)
	with ESMTP
	id lvMj_yaWQuiHaU3lj77woA
	Wed, 23 Sep 2026 14:01:17.034 +0000 (UTC)
From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH] serial: sc16is7xx: fix data corruption due to unexpected
 xon/xoff
Date: Wed, 23 Sep 2026 14:01:17 +0000 (UTC)
Message-Id: <20260923140116.340406-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2EmxcfyuLMH4=2Fbg2doT3ED5Nkn+NRIhYpRg=2FjjzcGJxXskVm5GzbVM6ryOL?=
 =?us-ascii?Q?ZDTHCknSk3Bx4wVetjJrUM6AGHj5vqZhoOo=2FP+S?=
 =?us-ascii?Q?eUiwnxscbnaaNspiYhRwjAaCD3JVzCL91QfKDQi?=
 =?us-ascii?Q?NgjoeJPNAhO9MlhyJ=2FE1I5ebCF0+bt20fsqRtpR?=
 =?us-ascii?Q?y4I1rEQ9ST8W3h8rM9EDMVOZICn18sJmigaaxz6?=
 =?us-ascii?Q?O3tp=2FTJV=2FOetXHMh8v=2FoaGDwepEZ1Yy48dTEcN1?=
 =?us-ascii?Q?oORZOtAtkPKOXOrnMaVxNagNFA=3D=3D?=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
X-Entity-ID: u001.LMXSJIKpad5A1O6egCWHyQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

The hardware supports automatically sending XON/OFF based on the
FIFO status and that is already implemented by the driver.
However that capability was not announced with the UPF_SOFT_FLOW bit.

When the port is opened with the default of XON enabled the driver
configures that in the hardware.
If userspace does not want XON/OFF (which is normally the case) it will
use TCSETS to disactivate it. However the serial core optimises this
to only notify the driver if someting imporant has changed, and for
XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.

So we end up with unwanted XON/XOFF in the data stream.

The problem only occurs if nothing else needed to be set by termios,
ie if the user space requested values are the same as the default values,
except for XON/XOFF.
Since the default speed is 9600 this means that the problem only occurs
when requesting 9600, otherwise the call to the driver will be made to
change the speed, and that will also clear the XON/XOFF.
As 9600 is quite rare these days that probably explains why this hasn't
already been seen.

It also only occurs on the first port open after boot since the subsequent
opens will use the "logical state" set by TCSETS but not communicated to
the driver the first time.

Signed-off-by: Martin Fuzzey <martin.fuzzey@arrive.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9b152ead050f..f0a9a3dcd0e4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1485,7 +1485,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
 	/* Initialize port data */
 	port->type	= PORT_SC16IS7XX;
 	port->fifosize	= SC16IS7XX_FIFO_SIZE;
-	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 	port->iobase	= i;
 	/*
 	 * Use all ones as membase to make sure uart_configure_port() in
-- 
2.25.1

