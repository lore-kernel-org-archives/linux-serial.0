Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv4EuZoV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABFD18C;
	Tue,  5 Dec 2023 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701806133; x=1733342133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VX5s/H5E4eN0Nu25dVQLMsRgd9WON4N1XPDB015Uxuk=;
  b=mv4EuZoVvpBmKM38duTZebneYE1i1Anot+VrtPb8Cp4NfJCMG1tgNF52
   0d3b+sJ3k6V/1NGXWle6RDzpK0so796PNlZA3YBP6Pynsry0DNiMSHhON
   3sgXrN/FzIzEd4QvfOsBX+hGLrdgFnp0w4svRsTIquJOlVaC8SZCEK/7J
   Wt5KdER/2CTzUnaUULDp76QKMrelk+7XtNgp21sMKTIxTLoqRr0lneMxt
   rc2CrtkV2S1+HNTasXWlzVrzAixAf4hUL73WlaY+yOaCLxQ+2qg8tth3b
   WEB656t3PhlJbVnEd5UMljRC6HECzuf/IydoodShalFLl76smxL4K0O5c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="458268879"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="458268879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 11:55:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800082305"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800082305"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 11:55:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A4AC42BF; Tue,  5 Dec 2023 21:55:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART
Date: Tue,  5 Dec 2023 21:55:24 +0200
Message-ID: <20231205195524.2705965-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Granite Rapids-D has an additional UART that is enumerated via ACPI.
Add ACPI ID for it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 63b14ce9c009..2d1f350a4bea 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -775,6 +775,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.43.0.rc1.1.gbec44491f096

