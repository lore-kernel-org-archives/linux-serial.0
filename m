Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549B43169;
	Mon, 30 Jun 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288074; cv=none; b=gYnovlHxKn6YEl51oUSVRShr7axU5/+A4QgWY9EsdYjY2imkGNAJTgsA+L2L8ND59riAFOaE4aNY6HbEvStDQJ2JbXWPGe3s3x7O8HXIJLHKNLn4Js7Eepm5jABgOIIaPDLSHuzx4cvHqK1CVQLAf9qwFDBzKbb84xWOesWuwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288074; c=relaxed/simple;
	bh=OOfCX+tqQ1fjFBetrtTnJUEf0K9wpR5VfafBcS9p8yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txKnKEqx/zpzcdMrfDGgR1O0q+e/wUKwPxywIvdr+luhi8s+pc+sgifM2FcuwsRZVoC36LhwFhZo+OQZJ7tDiDOF8CrS3VhtIJxnVKn8+7cPSYFirg7s801aiFejwVI4QUtcW6qPcrcWiF8phHr8prxdXaROmmPRkpW/qWgrsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJqk60tx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJqk60tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751288072; x=1782824072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OOfCX+tqQ1fjFBetrtTnJUEf0K9wpR5VfafBcS9p8yE=;
  b=dJqk60txRQ1PEGbkhbU0eZNMdMN7G5adDNszWK5zCTo2LhO/IdPJh31V
   AWsaulEPPIUse3WjPHWvwiN8vv0DbtDjU5fFjHjRz6moAhQxiFw5n3yGP
   faCj7ZfbRWKZztybdaFoZ0Wz5vVXcP0AW+AAuGOlIgaPd4wz8llv11ebM
   Ot2IJVnLKuvWExTg7F7m+ecOqIvSL4utM3qi7idNAbpiiZuGTd8A0WUo2
   4HhmCo4KxVkhTbG42yiCdy4WmMNRR/8PcTFMZnCRI914TVI99UYRaGWLe
   q05lw1+0etAw3RKsQ7u4zm1REFJ1zlru1PLZJKklFHNoAj4BBZakg1QtP
   g==;
X-CSE-ConnectionGUID: /DOLujfcS6et7MLtXUPMtQ==
X-CSE-MsgGUID: ywj+t0NxQGuItPlW3Olgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53636079"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53636079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:54:31 -0700
X-CSE-ConnectionGUID: 6YI7XAVyRl2974aP6Wi7iw==
X-CSE-MsgGUID: beu3Uqz7R0WFnWridMaI6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="152932171"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Jun 2025 05:54:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22F763AB; Mon, 30 Jun 2025 15:54:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8520_ce4100: Reuse mem_serial_in() in ce4100_mem_serial_in()
Date: Mon, 30 Jun 2025 15:54:27 +0300
Message-ID: <20250630125427.2266455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one place in ce4100_mem_serial_in() the code may be replaced with
mem_serial_in() call. Do it so and collapse two conditionals into one.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ce4100.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ce4100.c b/drivers/tty/serial/8250/8250_ce4100.c
index 3dd88f372a51..8221b872fd33 100644
--- a/drivers/tty/serial/8250/8250_ce4100.c
+++ b/drivers/tty/serial/8250/8250_ce4100.c
@@ -35,13 +35,8 @@ static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
 {
 	u32 ret, ier, lsr;
 
-	if (offset != UART_IIR)
-		return mem_serial_in(p, offset);
-
-	offset <<= p->regshift;
-
-	ret = readl(p->membase + offset);
-	if (!(ret & UART_IIR_NO_INT))
+	ret = mem_serial_in(p, offset);
+	if (!(offset == UART_IIR) && (ret & UART_IIR_NO_INT))
 		return ret;
 
 	/* see if the TX interrupt should have really set */
-- 
2.47.2

