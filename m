Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F6143867;
	Mon,  6 May 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997534; cv=none; b=OjJOVTMbxuRxQGxZp3EPtDh8NnE/r9yv/oHFb1vWwAYfqfn0zP1YSTR0B2Y2GnWXv3KcB7jd4urFiDR6aKhyidvIzIL7Z3bjcSDY/10WWvtSHaPjZFLuqEDEx5kE2F2KADvS4nUnBw78CydAZIGJJ3rZUGiAgcX22j7c8jzPFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997534; c=relaxed/simple;
	bh=pR0A0OFnPbzgIVFB96xhdR9NeOvLHx9NayqjbsRWiKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pvz5z8hQFjHhdVWmiJXZERruu8kYq52miml8iAEpiEnJvqCOCjpmOpvLiR+aR7/3cFnhpXq4eEij1wnYiUczvT/6Ps6v/S0mP+bYpQVM0DgXxfvp+UEPLxLXKigfm39NprWk0EyKDNANyD2LKVdJpnGTHCvaiyQP0W5g+0yNUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSsFY31n; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSsFY31n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714997533; x=1746533533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pR0A0OFnPbzgIVFB96xhdR9NeOvLHx9NayqjbsRWiKQ=;
  b=BSsFY31nW061A/YxhnnNcRN4C2+dsP8pCCeLCR5fPPANPghbn5FKpBP5
   abtJiv/fbyQvBd5usSk8J2z4iUCtXx5C0gICTvQHJN3FICNCfectsTehL
   dAh2OwH4Kk3g+hMCyeCtGp01z9cLHnoHq+4E7YkNo0oWyoWtXw8vtdRya
   j31NeqjcipRAJ09bt026BTxa5+Wa5vE48sqHr/L04CmE3ZNMBGgz4T9vp
   8EI1Qm/1A8ZaYc/827yGXz9Ivk2MtRSJFS7tsJ1lisULOHjnZeil0prc/
   ByJ6p9RAYPj4heXxCqc6+2+bVYVzIRyymErryVpKb48jm7UnRG2hLa5yw
   Q==;
X-CSE-ConnectionGUID: g01XFkDIRFy7vdumNXeIhw==
X-CSE-MsgGUID: q3evOQYwR6Sk7fJAFoNWjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21416122"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="21416122"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:12:12 -0700
X-CSE-ConnectionGUID: dHT+7mFiTtWP9PmxJXUe3w==
X-CSE-MsgGUID: 8jbSaK/PT7ORwp5u80o83Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28241035"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:12:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: 8250_pnp: Simplify "line" related code
Date: Mon,  6 May 2024 15:12:02 +0300
Message-Id: <20240506121202.11253-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

8250_pnp sets drvdata to line + 1 if the probe is successful. The users
of drvdata are in remove, suspend and resume callbacks, none of which
will be called if probe failed. The line acquired from drvdata can
never be zero in those functions and the checks for that can be
removed.

Eliminate also +/-1 step because all users of line subtract 1 from the
value.

These might have been leftover from legacy PM callbacks that could
be called without probe being successful.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Rebased on top of tty-next
- Added historical information Andy provided about legacy PM CBs
  into commit message

 drivers/tty/serial/8250/8250_pnp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 9188902fa5b3..7c06ae79d8e2 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -435,8 +435,9 @@ static int
 serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
-	int ret, line, flags = dev_id->driver_data;
+	int ret, flags = dev_id->driver_data;
 	unsigned char iotype;
+	long line;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -494,7 +495,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	if (uart_console(&port->port))
 		dev->capabilities |= PNP_CONSOLE;
 
-	pnp_set_drvdata(dev, (void *)((long)line + 1));
+	pnp_set_drvdata(dev, (void *)line);
 	return 0;
 }
 
@@ -503,17 +504,14 @@ static void serial_pnp_remove(struct pnp_dev *dev)
 	long line = (long)pnp_get_drvdata(dev);
 
 	dev->capabilities &= ~PNP_CONSOLE;
-	if (line)
-		serial8250_unregister_port(line - 1);
+	serial8250_unregister_port(line);
 }
 
 static int serial_pnp_suspend(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
-	if (!line)
-		return -ENODEV;
-	serial8250_suspend_port(line - 1);
+	serial8250_suspend_port(line);
 	return 0;
 }
 
@@ -521,9 +519,7 @@ static int serial_pnp_resume(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
-	if (!line)
-		return -ENODEV;
-	serial8250_resume_port(line - 1);
+	serial8250_resume_port(line);
 	return 0;
 }
 
-- 
2.39.2

