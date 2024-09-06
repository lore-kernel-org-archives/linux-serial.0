Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D815C613;
	Fri,  6 Sep 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663288; cv=none; b=HkCjXxepTvT3ZlCnMP0+ckqlk6P1mD3ysOd1L7nfXxaLiVYIEx+fySWB4nGAodfu7R2HJWaMWlOC6urzx3qhx0l52F4aQMKymMxDamT30J2ezl+y7QJ2tGmFvFKJDCcKIUXhMZAElQ1rV1atntzeb5BgVjEMt8+dcL0pzJdqclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663288; c=relaxed/simple;
	bh=K+TyAlOejg63hmx9YlhvDKcjkusM06MwT8AYsMGptEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+vDibM3NwBAZDW7cyeSbCFrwngfQLZY+bA7nuJ+BpHEfRMj8CeAyV6dG89hbLjiORKmYRICul47HoEuKySyj259ZVOPY/33OciaiczHG4hpB5B0f9BRehZtOzL8Uff37kWGz538XvAOtAPeuEpllqLMZLdM4bBIMG93sfHg4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UNTJN6sg; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UNTJN6sg"
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D3F1AC0000F7;
	Fri,  6 Sep 2024 15:54:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D3F1AC0000F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1725663285;
	bh=K+TyAlOejg63hmx9YlhvDKcjkusM06MwT8AYsMGptEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UNTJN6sgMrTL+c7d+3RdvAUmk6EJqQ2R6OpgG9A3POXRfnMQiUWua+ltgURgT2zC8
	 SnleS9qGmo+pl8u0RhEYcOPmw7bzLaiv5fUwodmHjN6FaPArGLHQjxWAEx8knz1V/E
	 HuBiF1HnWYvWUMEgx2fWu7edkDYMiSgiHDnRh0sU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 73AE918041CAC6;
	Fri,  6 Sep 2024 15:54:45 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-serial@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
Date: Fri,  6 Sep 2024 15:54:33 -0700
Message-ID: <20240906225435.707837-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write to RP2_GLOBAL_CMD followed by an immediate read of
RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
however by then the device is already in reset and cannot respond to a
memory cycle access.

On platforms such as the Raspberry Pi 4 and others using the
pcie-brcmstb.c driver, any memory access to a device that cannot respond
is met with a fatal system error, rather than being substituted with all
1s as is usually the case on PC platforms.

Swapping the delay and the read ensures that the device has finished
resetting before we attempt to read from it.

Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/tty/serial/rp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..8bab2aedc499 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
 	u32 clk_cfg;
 
 	writew(1, base + RP2_GLOBAL_CMD);
-	readw(base + RP2_GLOBAL_CMD);
 	msleep(100);
+	readw(base + RP2_GLOBAL_CMD);
 	writel(0, base + RP2_CLK_PRESCALER);
 
 	/* TDM clock configuration */
-- 
2.43.0

