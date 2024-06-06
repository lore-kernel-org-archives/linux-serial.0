Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1C4652D;
	Thu,  6 Jun 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699728; cv=none; b=k/KL/bqIVuFwMhjrd3Jf9OlXq7bVI/aGdeQfv2nVIfXNFv1fu6JT4xO8QMBNs4xjSQ4LrU6lJL3lzQ+7Q7P4HzK7SOvvhKnVzUuAfOc/rqErmij8kzX25tFALGLifL7eAwDoaLMH+Yq9WqlKG8p9yUXWZWAMN76o5zP2Yyc5NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699728; c=relaxed/simple;
	bh=f+7fBhtcJlXgCJbJkgh56o4Pav2IO44UtKl6YoXUVAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDctpB+PZvF92UUcGL4cQTSum8X9GE7peagHZSyBzj5YNHtp1Isi2eKmy+7XK89jDgAl/EXnSWkyo6Ev5pitTf4BAfksr7B7S30NgfX0l5hEssx74HwZyFbvm313ghtmCsIsUepC6WqaDd8BnWG9IruHgLf6YWSCO9XtBk39708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6hQ/cSa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6hQ/cSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717699727; x=1749235727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f+7fBhtcJlXgCJbJkgh56o4Pav2IO44UtKl6YoXUVAs=;
  b=D6hQ/cSaF576EwugZKO76pY9mRN5ovVSFudaELQwI6AACHci6NiT/8iT
   b+OliaRJuy12CxYuGxDezEX+DyuQt1tfBkyfug6ui9uPIQfzUYGPhYMg+
   Tdl72/8epCoxijMT15uXVoHow+zAepExVc/QKzaLCv0oNYy200wqBMYw0
   s8SOpPrNMH7IkKOY/BTz+ZTkbQ0Vf9rs9fr37kzB/gN6fkRYC7E9EBtYD
   bpxeXS+yw8OPAWrHy0WwIrgASNiGKI91UPy6xzKhIjputj9DxsJzxDmM0
   vC+skY2LY1GzJb2qMSH7BzUa/Pp+dkCz9bu0Q4OiVP2lYfQWBdAl0oEXn
   w==;
X-CSE-ConnectionGUID: v99+iC7LQoy1GLxKjh59Kg==
X-CSE-MsgGUID: CGs3sbFUTzqy7UIBYs3aWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14548043"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14548043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:48:46 -0700
X-CSE-ConnectionGUID: RumPFe7yROqUFc9Uinxspg==
X-CSE-MsgGUID: zxQRNvS9Tc6m0XeCeGiL2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38179579"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2024 11:48:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BC2621C9; Thu, 06 Jun 2024 21:48:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_platform: Explicitly show we initialise ISA ports only once
Date: Thu,  6 Jun 2024 21:48:41 +0300
Message-ID: <20240606184841.3102545-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial8250_isa_init_ports() uses home grown approach to make itself
a singleton. Instead, explicitly show that we initialise ISA ports
once by providing a helper function which calls the original function
via DO_ONCE() macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_platform.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index ded985182e04..5817c1d72314 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -9,6 +9,7 @@
 #include <linux/array_size.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/once.h>
 #include <linux/platform_device.h>
 
 #include <linux/serial_8250.h>
@@ -53,15 +54,10 @@ void serial8250_set_isa_configurator(serial8250_isa_config_fn v)
 }
 EXPORT_SYMBOL(serial8250_set_isa_configurator);
 
-void __init serial8250_isa_init_ports(void)
+static void __init __serial8250_isa_init_ports(void)
 {
-	static int first = 1;
 	int i, irqflag = 0;
 
-	if (!first)
-		return;
-	first = 0;
-
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
 
@@ -102,6 +98,11 @@ void __init serial8250_isa_init_ports(void)
 	}
 }
 
+void __init serial8250_isa_init_ports(void)
+{
+	DO_ONCE(__serial8250_isa_init_ports);
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
-- 
2.43.0.rc1.1336.g36b5255a03ac

