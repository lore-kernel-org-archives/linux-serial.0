Received: from vsvhrvbk.outbound-mail.sendgrid.net (vsvhrvbk.outbound-mail.sendgrid.net [134.128.88.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956F4D6C4A
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.128.88.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849144; cv=none; b=G5yQYWlfIfwCHEXSk+kt3k0I6iFl6lyGsACr5maA7d/+zP41GMB6+UAU4+s+P+J3ao1BSD1WV7x5pP1bCRumi40VJDoAcaiNlwEJgRm5UEQU3+zqGkbnIhK8WVw5web/jvtqz8ZMcMC38dPFUfkpAvcf83J9tk3DVQxRwB6rKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849144; c=relaxed/simple;
	bh=JayDvb+NMe0QFgGgdXJR+wsVQ6GU/3Ar1ygT39VoP7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=D8snk9V8uxkFzgrBTIuPcBuazXFIaI0oa4TeUClRvREfEGpVTtxw5Izer8wLyYqVwe9JamkBuN3NR0BL7tclpU0hTTnLfjJyqjwlPSE/xv6zN/8apvqHKY4ACOUnMgCOinpmF5oOIjSg1E9r5s8U47JFGfe75SkPHm3EkFNdvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flowbird.group; spf=pass smtp.mailfrom=em8284.flowbird.group; dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b=EMPyaBfe; arc=none smtp.client-ip=134.128.88.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flowbird.group
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em8284.flowbird.group
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="EMPyaBfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flowbird.group;
	h=from:subject:date:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1790849135;
	bh=dkh+iQGMnw9T+8ze7wszRjMKumqhhWgFa9I9djiFz1Y=;
	b=EMPyaBfervbdr3JATG+AyELV9hfoKl/IlypTz8Qx6AVI9gd5l9YESR0Z/R63wPdoq8iS
	sjhlFOdfQb9sbJ8KHJKixHpv5rgmqdgZ1yMFPNlfPRBOwtFiO3bA9rOotkf3P16idwx+yD
	mZvBphVZFuFkGpE1SrVG0PQc1KK9LXX1ss4OJv0ym9fuQtariiWq/Iwu1/DdZOaN8/ZTrE
	n4PFDRo17e8rINsYVXftxqjT0QyzK5b6k/TB3s97uHnMFIWWDQS5lSqpdnv+ho9jS4/2LJ
	c8UQCiqdKyOcQ0Hq1kEGKtmo30fkgolxw4VHpOWEV5KWiIbP/OX0TbXJeqGw+q6w==
Received: by recvd-5bb5b9cb76-dn8gx with SMTP id recvd-5bb5b9cb76-dn8gx-1-6ABE306F-75
	2026-10-01 10:05:35.701443327 +0000 UTC m=+147873.877541912
Received: from FR-BES-DKT15120.home (unknown)
	by geopod-ismtpd-5 (SG)
	with ESMTP
	id BCf2UazxRLSlh73RSXbOIg
	Thu, 01 Oct 2026 10:05:35.455 +0000 (UTC)
From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: [PATCH v2] serial: sc16is7xx: fix data corruption due to unexpected
 xon/xoff
Date: Thu, 01 Oct 2026 10:05:35 +0000 (UTC)
Message-Id: <20261001100534.1225894-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2EmxcfyuLMH4=2Fbg2doT3ED5Nkn+NRIhYpRg=2FjjzcGJxXskVm5GzbVM6ryOL?=
 =?us-ascii?Q?ZDTHCknSk3Bx4wVetjJrUM6AGHj5hDGo6NZ5Elh?=
 =?us-ascii?Q?umy6VTycgROQXZu1cPemWML4O1jP1wVI8AfgxFJ?=
 =?us-ascii?Q?ClY0Rnb4GCFdsA5jGZ65krRICS9MGZDP3BwO4hH?=
 =?us-ascii?Q?hmXIGhmscaG5MXqmdePL9VWQdORoq9YsZc5eAIZ?=
 =?us-ascii?Q?wcOFb1+i16royDmkZ2vyVHDu5rXkuNkf8q48GY0?=
 =?us-ascii?Q?AEPbePtmh2p61AIKHzURsfZ7HA=3D=3D?=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Jon Ringle <jringle@gridpoint.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
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

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
---

 V2: rebase to correct tree, add Fixes tag

 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 296079c16fdb..7ddc8a38adab 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1516,7 +1516,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
 	/* Initialize port data */
 	port->type	= PORT_SC16IS7XX;
 	port->fifosize	= SC16IS7XX_FIFO_SIZE;
-	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 	port->iotype	= UPIO_BUS;
 	port->rs485_config = sc16is7xx_config_rs485;
 	port->rs485_supported = sc16is7xx_rs485_supported;
-- 
2.25.1

