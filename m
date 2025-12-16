Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92883002DC
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916095; cv=none; b=l3jP/y7/Hh8N5RwCtySsHxsuWBCHvrJvgb9Oi0DlUrdVpaowSRIW1z/HnrCwTFojm3o/jL2GLDJXMbFTguyFBrXCkXAwJ1rJoHAjqtYgHI+VTxNdM4Njn6NWBgeJRtUootZXxtmLhlD/vV5/kW8d/53kVsu9Y/QlUek+SBnJlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916095; c=relaxed/simple;
	bh=xMby1a1XbwXyyAMcbSk6Tc0DWUNm1+Cr/Fetx5uN3do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3uUbrAWMhxBKQzbiPM5awMwoXf5XRchon7+7qhbQTNCxOOphxiw0FMFqwvPxANNzRInAEFGMqiToa9SuoK1U0quFmMuw3Bn6HWz2YIp4Un3AQM18jnXsQT1JtGI41puomqTQljNxMOq2MB6VqNxYePx1QbhMexxM4p8WQJhOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=UZVJWS9F; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="UZVJWS9F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VzRSPdNSmAwT93/mrBLp/yqB1/Pf4fnEK3imS7zRYWQ=; b=UZVJWS9FOLMEpIfzliB0CcCqQM
	0z8nIwN2AoZRUoIVHe3Ch6pvTvYDpKrvlmF/q0hhhdWTMQhnzlMCGcn/dVldAq11NZXNkpMKlaXs/
	1oDL07mGBn7u7EC218crUq8OkVGw63KYBGAzzpcsM5IU8JrHCBxH5hF6MdIIUtN9poic=;
Received: from 188-23-39-151.adsl.highway.telekom.at ([188.23.39.151] helo=hornet.engleder.at)
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vVarg-000000005P3-15ZZ;
	Tue, 16 Dec 2025 20:37:44 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH 1/3] serial: 8250_keba: Add missing includes
Date: Tue, 16 Dec 2025 20:37:24 +0100
Message-Id: <20251216193726.55449-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216193726.55449-1-gerhard@engleder-embedded.com>
References: <20251216193726.55449-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Andy and Ilpo suggested to add missing includes, because the code shall
not rely on indirect includes. Add missing includes and remove one
include, which only enabled indirect includes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/tty/serial/8250/8250_keba.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
index c05b89551b12..e9e59ce79138 100644
--- a/drivers/tty/serial/8250/8250_keba.c
+++ b/drivers/tty/serial/8250/8250_keba.c
@@ -6,10 +6,18 @@
  */
 
 #include <linux/auxiliary_bus.h>
-#include <linux/device.h>
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/misc/keba.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
 
 #include "8250.h"
 
-- 
2.39.5

