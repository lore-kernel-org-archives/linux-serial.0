Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401B175D5D;
	Tue, 25 Feb 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501361; cv=none; b=R3HaMdC11YNiZ4e2Gg8PquN7ak5jZI6wzJ3i9P0+hwhBBxc/8eEiM1MoYjouuah9XVxJHaW4D/o9W0Uwz22LIWcpcJ9VAc9b+/gwRp99XDumKX28WYBSkfFZvoR8mePWl1UVHhF1o7nKGO5KB7UqX0+u12vpcKU+eJe2pcOAdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501361; c=relaxed/simple;
	bh=1wLbTyZpyrnh0HaPTC3hRYX/EzNCdBJG7jxtJKU4pcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMtWlvLkl3aky9uWM4g3WLQnYlIF0J++g4x72C4fCO/C62/aj9zDS6Dptu15KsUxJlCVsVbFTxr9tTSSVzvzqRJjs52mKH0H5iRxGsj50TSnXpQ60vTvkT6dxFfXzrC031Zbe2RUdPwKRxZ/ZbJEKnmZGv5DOOg+0vlBu/IwuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZcW+nm2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZcW+nm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BCDC4CEDD;
	Tue, 25 Feb 2025 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501360;
	bh=1wLbTyZpyrnh0HaPTC3hRYX/EzNCdBJG7jxtJKU4pcs=;
	h=From:To:Cc:Subject:Date:From;
	b=nZcW+nm2jbZiPBblDJ54HjvOIhO0EFCkMKSZanOXkJMza/OcPcMa18XwYX2IQf3IB
	 dkEaV8rvCk89y9gUdHKH+InPs+gp+EXT082UMXe8MP7dibogBEpVJ+cSk/6oOJGHVz
	 9QJ2YM4TZLWbuR3w/Nl/iCl1FIAUm/SIqnOzYK/6urdND86Vf2ZHJZ260k1jV4bZMv
	 jZvf+WqqAgKDCeh5IXIvsypExXR/A/EYOOfpOWIuU618tgxySjIBwd2dBCLtg/MOIW
	 c5xu+uPPzg6cvfxcZT9QAW5var2YzMSFaAqqPo0Y5VWkrRPpcV8hV3ADEbC88xcOG+
	 VJAlOP23LQeWg==
From: Arnd Bergmann <arnd@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tty: serial: pl011: remove incorrect of_match_ptr annotation
Date: Tue, 25 Feb 2025 17:35:37 +0100
Message-Id: <20250225163556.4169086-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about sbsa_uart_of_match being unused when
CONFIG_OF is disabled:

    drivers/tty/serial/amba-pl011.c:2945:34: error: unused variable 'sbsa_uart_of_match' [-Werror,-Wunused-const-variable]

The driver is not actually used on any machines that are built
with CONFIG_OF disabled, so using of_match_ptr() won't save any
actual memory, and it can be best removed.

The corresponding ACPI_PTR() annotation does save a few bytes on
32-bit arm since CONFIG_ACPI is not available, but for consistency
it seems better to remove both along with the __maybe_unused
annotation on the ACPI table.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/amba-pl011.c    | 6 +++---
 drivers/tty/serial/ma35d1_serial.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 04212c823a91..e3b8590bc880 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -3001,7 +3001,7 @@ static const struct of_device_id sbsa_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
 
-static const struct acpi_device_id __maybe_unused sbsa_uart_acpi_match[] = {
+static const struct acpi_device_id sbsa_uart_acpi_match[] = {
 	{ "ARMH0011", 0 },
 	{ "ARMHB000", 0 },
 	{},
@@ -3014,8 +3014,8 @@ static struct platform_driver arm_sbsa_uart_platform_driver = {
 	.driver	= {
 		.name	= "sbsa-uart",
 		.pm	= &pl011_dev_pm_ops,
-		.of_match_table = of_match_ptr(sbsa_uart_of_match),
-		.acpi_match_table = ACPI_PTR(sbsa_uart_acpi_match),
+		.of_match_table = sbsa_uart_of_match,
+		.acpi_match_table = sbsa_uart_acpi_match,
 		.suppress_bind_attrs = IS_BUILTIN(CONFIG_SERIAL_AMBA_PL011),
 	},
 };
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 8dcad52eedfd..285b0fe41a86 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -799,7 +799,7 @@ static struct platform_driver ma35d1serial_driver = {
 	.resume     = ma35d1serial_resume,
 	.driver     = {
 		.name   = "ma35d1-uart",
-		.of_match_table = of_match_ptr(ma35d1_serial_of_match),
+		.of_match_table = ma35d1_serial_of_match,
 	},
 };
 
-- 
2.39.5

