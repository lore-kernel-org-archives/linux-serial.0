Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79A328B7F;
	Wed, 10 Jun 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070717; cv=none; b=TdNBoWiz7kiFnFKqW4G6gtJdYcBBadpCKdh+MsiBPyaTSCtjXXt7AkoIFbDDuDKhbEqvamdSne4rXKDxuGXM3x8JtGFfIXUrIEge193S2JtSpnFIEU3Y9sTnUmPwHGmOHXZ4NcdkPAdAh0FHbWGDrJa+NxynGCebIQFavc8K3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070717; c=relaxed/simple;
	bh=MVAClQ3y377XeawufPV4NkWcc3q+d2vwkJSVtF4fFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdcKyuZ6laZx5sLdO7t858W5a/Ksra817RsmOVw4KFqdGbdPKBRIEj8SPqKuLCVBWy1T9O90Frf7c/62pji+rH9SoDgpbVgertMPjammmhGN+Tbaf1yicakgs37WTbbNxVDHa/PRjH9db+AYjr7BWhBswRA46FT9ikp66Sm4d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=AQwWKDjb; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="AQwWKDjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1781070715; x=1812606715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWi4qg4g4K2oHkvxFUDReR22f+2eMM46oJa4PVPc5yw=;
  b=AQwWKDjb+w+4B2Md9YlWN6KRCWzV6uQLzuQDTl0He3ZgBsmP3D4bVarg
   M1onDFYXhblBGDrPuKtlt+r/t+VZ0tsLQqQF3veqjb5DSzFN+q4ECgLzS
   ZTfRnBgUk5RyrgXmdE953R4UWMYWn+t83hxJwMRtIMfINypJVq/0c9qw3
   RgQ3ib91cEg3ylWX/OuHRHY6+M1ZDoFfjemg4Cx7JLMQlCiwffuLcihaU
   Eh+s1f6hMjI9+M5KvrjhM2chd3SpgMgpqfw5EdUzZ3QxkKCt15grUkJUU
   aLuAiXPyEtcdnSthr3RN+Xn1Rdid+VqkBG0XHSbp6DtnSDqpm3lJu9ttg
   A==;
X-CSE-ConnectionGUID: mRgQ58OVQzyBAJjnxzo0Lg==
X-CSE-MsgGUID: eyDAzniQTWqwGj4+9mwOGA==
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 14:41:44 +0900
X-CSE-ConnectionGUID: 36v/yy0oSLKcNz6MEqeSdQ==
X-CSE-MsgGUID: kKhbxw/zT7K3rp1BocZurQ==
X-IronPort-AV: E=Sophos;i="6.24,197,1774278000"; 
   d="scan'208";a="643898805"
Received: from unknown (HELO rahul-Z690-S01..) ([43.11.34.175])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 10 Jun 2026 14:41:44 +0900
From: Rahul Bukte <rahul.bukte@sony.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rahul Bukte <rahul.bukte@sony.com>
Subject: [PATCH] serial: 8250: force synchronous probe for the ISA and PNP drivers
Date: Wed, 10 Jun 2026 14:41:30 +0900
Message-ID: <20260610054130.2825182-1-rahul.bukte@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86_64 defconfig, booting with driver_async_probe=serial hangs in early
init. The 8250 PNP driver is put onto the async probe pool.
serial8250_register_8250_port() runs in a kworker concurrently with the
ISA registration done from the serial8250_init() initcall resulting in a
deadlock or NULL dereference.

  - Deadlock: serial_core_register_port() holds port_mutex across
    serial_core_add_one_port()
        uart_configure_port()
            autoconfig_irq()
                probe_irq_on()
                    async_synchronize_full(),
    which waits for the async probe pool to drain.

    The async PNP worker reaches the "port already in use" check and
    tries to unregister it.
    serial8250_register_8250_port()
        uart_remove_one_port()
            serial_core_unregister_port()
    This blocks on port_mutex.
    The init thread waits for the worker and the worker waits for the
    init thread.

  - NULL deref: when the worker instead observes a slot whose port.dev
    is set but whose port_dev has not yet been populated, it hits the
    null pointer on the call to serial_core_get_ctrl_dev() in
    serial_core_unregister_port().

Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
---
Found while experimenting with driver_async_probe=* to improve boot time.

Tested on x86_64 defconfig under QEMU + KVM with driver_async_probe=serial.

 drivers/tty/serial/8250/8250_platform.c | 1 +
 drivers/tty/serial/8250/8250_pnp.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index ad3a7bc31d6f..af946d12e764 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -284,6 +284,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.driver		= {
 		.name	= "serial8250",
 		.acpi_match_table = acpi_platform_serial_table,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 7a837fdf9df1..3f41a9d6cb27 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -521,6 +521,7 @@ static struct pnp_driver serial_pnp_driver = {
 	.remove		= serial_pnp_remove,
 	.driver         = {
 		.pm     = pm_sleep_ptr(&serial_pnp_pm_ops),
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 	.id_table	= pnp_dev_table,
 };

base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.43.0

