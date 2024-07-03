Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A913D2BE;
	Wed,  3 Jul 2024 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001221; cv=none; b=MaeHggiomQyU0NxhHL0dX2jUPte3BQgIYslkv9MT3GqSO9TvHCSmB5GZBLvSXk2oLBxoFbjfBSESeJt7wQKp3lv47QHwzQLiIshjoPpKpkBPPcPMgKCl3L/cTUI5EiD4m320a9dkR6PtM79BwpQVzeC1TAHfwqA1cC3jRa/+avQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001221; c=relaxed/simple;
	bh=rHqj2+9yyU2VfMNq/WPw7KMf59lGUZushdRJEvkQB6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGPOzXHl4y3BH1miyjxotpw8hs4iSSN375WhIE7HAaCx5vl+h0VESX4Gk6eMxBQsyRuZ5eKQVEM++vn5SiiCYnKZtkHt8bI1ew1pJEmST12HBu83qqwUgrdozRqJ//AYEe6Ox82gZR2ZJjfe5SJGJKaefwFzwF6fAXUkoe+VIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+rwr+3k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+rwr+3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720001219; x=1751537219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rHqj2+9yyU2VfMNq/WPw7KMf59lGUZushdRJEvkQB6k=;
  b=S+rwr+3k84e8Ds2WD6MObcxSlwSnEDIC8t1jzgiyp9t+YBze9MGdiELr
   a9XqB6N62H6l7G84dZnKyR2W9nI9FKYOYFb8jsbneJQRA2IO9t6fdnjAZ
   RVR6iE6gzjt2X2REw8xw/LlHJjhqqb4UPCUE1hNl8zEzTTgUeVi1T5wPO
   t2bOkNSKZwTjh/Nlp57ZG22MdJdDSF1dDiGDFOeLcn1EpnfpS/KThfzRz
   QMCShCW8SsBGKq48xfjXDdhJ8+sQCN+v0pgy9jE+wQ1k/IrxEKYw9GZyo
   o60GmCMbumkl212NfOPwxcNXGu1dqP4LPEx/elHS83f/dZG8sjW4byTo2
   Q==;
X-CSE-ConnectionGUID: 5SHhZ/MuTCmumY3j3QC90w==
X-CSE-MsgGUID: mYrqUQw1SMO6KPqGE0GuAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21093822"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="21093822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:58 -0700
X-CSE-ConnectionGUID: PRqUHEISR/yJdM+cxhi1FQ==
X-CSE-MsgGUID: vOOBazGXRnKeWTewb70QuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="69385059"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO tlindgre-MOBL1.intel.com) ([10.245.244.185])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:06:53 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports
Date: Wed,  3 Jul 2024 13:06:10 +0300
Message-ID: <20240703100615.118762-4-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Lindgren <tony@atomide.com>

Document the console option for DEVNAME:0.0 style addressing for serial
ports.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 27ec49af1bf2..11e57ba2985c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -788,6 +788,25 @@
 			Documentation/networking/netconsole.rst for an
 			alternative.
 
+		<DEVNAME>:<n>.<n>[,options]
+			Use the specified serial port on the serial core bus.
+			The addressing uses DEVNAME of the physical serial port
+			device, followed by the serial core controller instance,
+			and the serial port instance. The options are the same
+			as documented for the ttyS addressing above.
+
+			The mapping of the serial ports to the tty instances
+			can be viewed with:
+
+			$ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
+			/sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
+
+			In the above example, the console can be addressed with
+			console=00:04:0.0. Note that a console addressed this
+			way will only get added when the related device driver
+			is ready. The use of an earlycon parameter in addition to
+			the console may be desired for console output early on.
+
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
 		uart[8250],mmio16,<addr>[,options]
-- 
2.45.2

