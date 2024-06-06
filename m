Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC519580C;
	Thu,  6 Jun 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674164; cv=none; b=oWOu8qzEJAHO1+ctXG6M8Y0cGTjCobcTdAyEMRS94lThLmiz02bi1eki8tDT95nBGs6EdWdgaJASPToxMhse6uSWAUS09VP63rdAoc/ej2KBY7kEMwa4jzqJl3U+gMhSTlyChz83pJ03o+N1YbhpQN31yUBFgADofr3XicWhuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674164; c=relaxed/simple;
	bh=ZmU91IMTzL3EbILWOMUaRcnOPrsPyfbS4xQgTphHPZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkL/nyfAWnPdfuCF6nTv0P/iyrAwKcKEwBD7g2ihbBnsFAQTvpSWbPZL5l0Gj6XsM8oEoxqgAMoYlXPYQ9RWaysd55jYsuBQDye7eUuj163izKonauyLw1C/D9L5QsxAuwEcv9Y+D3FvzZwS/9zMPc0nMTb4u+aMaM9l4Exlhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJaPyw21; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJaPyw21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717674163; x=1749210163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmU91IMTzL3EbILWOMUaRcnOPrsPyfbS4xQgTphHPZQ=;
  b=EJaPyw21C7aRe6Ug78tGr4RzOG6CgtZ/9s84Lo+vJ2GsNXVJRt7/Bx4C
   Yqupz1pTDFzZMYPacXCX4PVVIhDtcF28vUK9rGHu5trDdsIan+WCXTaG+
   xFU2mryVGt/5K6oWHnrxV3FZ6fq2fgJ9vvBr6fCIArHjbiIptJo/mW7bt
   yWMtBREnX8RYfxg29JjiavcQB/Yaf3BRbEo3l6SKs30/Iyq86Gt38PsA0
   8olo4P9meW47b0OaPHMBJLgu2GeRiVniZIQyuRUptlGfyP6FAibCVPMGd
   HeEucTu0a4DrYAkw2Q3oN/9zOGLdAa5Oks4qZsiY1ciEQ2O5iUZKNlyUn
   Q==;
X-CSE-ConnectionGUID: ZDYwbEm6QOune/YGSsqiVg==
X-CSE-MsgGUID: NhNNbIYGT3KTgMJm3YGB9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14517465"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14517465"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:42:42 -0700
X-CSE-ConnectionGUID: KIvjY8cFQsG2VkZvGz6RLg==
X-CSE-MsgGUID: SbU9GlMET92bldHYUhbBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42514908"
Received: from unknown (HELO tlindgre-MOBL1.intel.com) ([10.245.247.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:42:38 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "printk: Flag register_console() if console is set on command line"
Date: Thu,  6 Jun 2024 14:41:47 +0300
Message-ID: <20240606114149.118633-2-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit b73c9cbe4f1fc02645228aa575998dd54067f8ef.

There is no need for this change now that we are reserving console_cmdline
slots for the DEVNAME:0.0 style consoles.

Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 kernel/printk/printk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 52bdd7dcdb6f..8b746eeb77fa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2541,9 +2541,6 @@ static int __init console_setup(char *str)
 	if (console_opt_save(str, brl_options))
 		return 1;
 
-	/* Flag register_console() to not call try_enable_default_console() */
-	console_set_on_cmdline = 1;
-
 	/* Don't attempt to parse a DEVNAME:0.0 style console */
 	if (strchr(str, ':')) {
 		reserve_deferred_console(str);
@@ -3578,7 +3575,7 @@ void register_console(struct console *newcon)
 	 * Note that a console with tty binding will have CON_CONSDEV
 	 * flag set and will be first in the list.
 	 */
-	if (preferred_console < 0 && !console_set_on_cmdline) {
+	if (preferred_console < 0) {
 		if (hlist_empty(&console_list) || !console_first()->device ||
 		    console_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
-- 
2.45.2

