Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE6157472;
	Fri, 24 Jan 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735342; cv=none; b=eyklUROreVZWGaI5o1mxHG8agz/rxeGK0UfHvbzx/0ZwylrBl237r+AvvdrNf3S88yM6tnIUTMB4DWxCMywHVvEZOo+Fq5ioRmyMOZsVo5PPF4f2ZTUPRheup/a2oNMqVExf8z/VgOpxXDxFQCbJ9pgrnZDkO7Hzk+aFfjg3tpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735342; c=relaxed/simple;
	bh=RQHdOWZpVVUAK76uP+B5HKCTA/jWwwg+ROmi9FK2Bag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hadFZ+v5mORohhUi8dcZxoirVNeV8o0y3QMQfyhfsaK0WYOtAmBzaSejNkClIVVz5TA7+JJs4BUZcUmheQp8ljzHOMRs+sqWCnnP7bDs7Jc4+tG2fKOFjPn30FBjk1qrNKOFq5jdFUHoIW9mCOzBQorDbsjOSo0Iwwrrcd+/FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcrdrW6l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcrdrW6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735342; x=1769271342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQHdOWZpVVUAK76uP+B5HKCTA/jWwwg+ROmi9FK2Bag=;
  b=LcrdrW6lGMF/bXFRSsD4gi7HYc1o/u5i15MaylIxTTT6ijvT/O5IceKy
   kAEjED5bwkZ+yEl9PUeCrDfKOMp8fdiSRgSVkkzrsM2Q/dA20R4l+C3ng
   kbwqu6FBUlU5FHrkWlfPikvWdNz6Bkiny8XVDm1D5lQT31fEnALXBjLxg
   McTWkLHvzI6hdjXER/oJEBwzjwgBid9/fw6K0jCb1X7E6vSXxohugwT2Q
   hUpOtd+x1VcjjRDFwoMDpSGc6YsMdyXjACpFOWPLOizUfImv5cubTq6VC
   7O6O4LQw/roVTABRkDaRxc7jAUriejFnT9sym3qjoalRUgSk+TUmGiG5q
   w==;
X-CSE-ConnectionGUID: D/FiWiy+TFCdhP+SFUWcng==
X-CSE-MsgGUID: xO1bOSoKShWQn8YpwaahcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38152883"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38152883"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:41 -0800
X-CSE-ConnectionGUID: gvQ3NBD2SxC0q2uC+uxTlA==
X-CSE-MsgGUID: CShOXT7dQQWI80wkpy3+cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107612353"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 08:15:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C64AF2D4; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 4/6] serial: 8250_of: Remove unneeded ->iotype assignment
Date: Fri, 24 Jan 2025 18:10:49 +0200
Message-ID: <20250124161530.398361-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
References: <20250124161530.398361-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ->iobase is set the default will be UPIO_PORT for ->iotype after
the uart_read_and_validate_port_properties() call. Hence no need
to assign that explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_of.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 64aed7efc569..11c860ea80f6 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -110,7 +110,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	spin_lock_init(&port->lock);
 
 	if (resource_type(&resource) == IORESOURCE_IO) {
-		port->iotype = UPIO_PORT;
 		port->iobase = resource.start;
 	} else {
 		port->mapbase = resource.start;
-- 
2.43.0.rc1.1336.g36b5255a03ac

