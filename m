Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7522FE19;
	Fri, 21 Mar 2025 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581293; cv=none; b=rPYgkItTQ22cCGFLoQFJZWPiabWmVcpIkPZbqhobLuEixx64gzmtb6axRLNXkGuxpI70LFO84M2hEp8GjBaIeefL+7mpci11bA0ouje/J8AwIJPBcF+w8qMbeO2GVzfqmDhVxW1wuoNOfUQd7QkgZaHIZOIplHKQsGFrCET1U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581293; c=relaxed/simple;
	bh=w2DUIoPyngyX/6SZoDWhQE3sTJrL9S/LPtukMHudnw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7xNxbs0TJ2BTiaHfHVNCnuJNbUv2Fy2ZGtXPE25SVZeZg8DltzRM32N8UtjfXbNC97wvZLijhS740DPB9bjIWph5NkhApqU3En7pXh78TNObyhnEoWiY93bkHGCQDMPEGCpS9AuUyocATeoB4u1gzW5PR0SpbW/gOSHwLWqN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2ruMTJZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2ruMTJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581292; x=1774117292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2DUIoPyngyX/6SZoDWhQE3sTJrL9S/LPtukMHudnw4=;
  b=Y2ruMTJZDCvkalFUsS8NH/IO0DAkQnhHydKWPnwhwUxBVz8NNTL1xQ98
   xC3JpNjicas8f1Jq/7yP3APOQFanB3MKlkB+ZBlKxL0nKv2PgfND1qX5m
   24HTnnNzR3P3y3LzLh1tVvSHjskXqFO757j6Lv+LLHdxPK/OIEd4uj7aw
   CE+gi0ycSoPC5TM/yvykZJFNlodn1Ej+f2+9S/dlZq/hCZDPsYGQKopej
   mXxiM8zh0igJ1Pai0+BSMscd118YSYKFpzoWZzGhK75Rq3qsSrA3DOU8q
   e0/6Z9RPg4RfaJGdEDLvV8FcFYKGB7y3t+U0XNVZhzrTT77cz/ZuZhJVj
   g==;
X-CSE-ConnectionGUID: /bJnXnNSQ7WJEczFOwhERQ==
X-CSE-MsgGUID: U8sb3A0dTs2gWx/KFjjjWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="69212015"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="69212015"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:30 -0700
X-CSE-ConnectionGUID: au3BhlRXQomwcJVkdC5igw==
X-CSE-MsgGUID: uVf9PoQVQjuE7DAYDosxJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124423524"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 21 Mar 2025 11:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EEBD2708; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 6/7] serial: 8250_ni: Switch to use dev_err_probe()
Date: Fri, 21 Mar 2025 20:20:17 +0200
Message-ID: <20250321182119.454507-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
References: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 15bee1b7dc2a..c66bfc56838e 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -333,11 +333,8 @@ static int ni16550_probe(struct platform_device *pdev)
 			uart.port.uartclk = clk_get_rate(data->clk);
 	}
 
-	if (!uart.port.uartclk) {
-		dev_err(dev, "unable to determine clock frequency!\n");
-		ret = -ENODEV;
-		goto err;
-	}
+	if (!uart.port.uartclk)
+		return dev_err_probe(dev, -ENODEV, "unable to determine clock frequency!\n");
 
 	prescaler = info->prescaler;
 	device_property_read_u32(dev, "clock-prescaler", &prescaler);
@@ -381,14 +378,11 @@ static int ni16550_probe(struct platform_device *pdev)
 
 	ret = serial8250_register_8250_port(&uart);
 	if (ret < 0)
-		goto err;
+		return ret;
 	data->line = ret;
 
 	platform_set_drvdata(pdev, data);
 	return 0;
-
-err:
-	return ret;
 }
 
 static void ni16550_remove(struct platform_device *pdev)
-- 
2.47.2

