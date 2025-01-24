Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CBB196D9D;
	Fri, 24 Jan 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735346; cv=none; b=tDRuAHQ14lHUPDz/YYiGKP8Q2MzvWtMtXgfhjmfxJsZHIIkRGUVLpzxiBhKhi+5BtD8dcQmxr7ijpsJTMRMyCnl++3D1+skOBxKZaTwMnakKSEQgqc2vnmkq298MrIE1gFgmSi6EnY/dIovJftlnQFc6UzBgmmdi1hxALl5UJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735346; c=relaxed/simple;
	bh=lfGMuTjEl1E5ktlY5BVqbetwgkValpruAzZQWjEGGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgTI62RHuONMBdV+ld6S29KQJs0Xc8+uitnB+Y9SAldcIiALBvPrIjESQwknwbSooAdsrGLCJACPg92Dn6ezaM4mETURpzyPQoziDu85B0VOtyx5joH+C7CqVESUD7rVsKs/RwPy80w0FdEWJubEmoPb96mL0kOKkFkWCa4pfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtUeMR4W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtUeMR4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737735345; x=1769271345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfGMuTjEl1E5ktlY5BVqbetwgkValpruAzZQWjEGGW8=;
  b=QtUeMR4WWoSEhDxgnYJbKeAnjwLgjaBtfrWgGvhFymDdI5P8dh9gawbJ
   VwmHD9/eSKDkCqXobV/Q04tzCw56Gw1/BzehUkyOq8D9pC4gAxyoN24Ck
   dkDeusa5iyao++nMK7SIJB6pj+mM10+oPbVuL8ZTDhVPQAKTcOiAka3uE
   f7PDagfFkDs3KrnXL6/fpLzqkX+2qNDHAP8QHBmzY2DlSSd9boo3Y/Vv9
   i80QKPdOBwk0ZmTIO+k4ggY3Zeix9fqj0UnQu++7h8VKwqwF/IBjiBsAs
   LZtzg7SEP6trgMTIcPd3zvY6qU8uAUVAX44ZIynBnZEEfmVPYjp7kFRdb
   A==;
X-CSE-ConnectionGUID: ceKDKv+dT/24+msMeZkjOw==
X-CSE-MsgGUID: KXjBkkJnRXi2knPH94bLeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38152896"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38152896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:15:41 -0800
X-CSE-ConnectionGUID: YyawNv1DTWaDfH6ExY/SYg==
X-CSE-MsgGUID: YW03/YX+Q3mhZdhaGp10tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107612357"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2025 08:15:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BBA4F2AC; Fri, 24 Jan 2025 18:15:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 3/6] serial: port: Make ->iotype validation global in __uart_read_properties()
Date: Fri, 24 Jan 2025 18:10:48 +0200
Message-ID: <20250124161530.398361-4-andriy.shevchenko@linux.intel.com>
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

In order to make code robust against potential changes in the future
move ->iotype validation outside of switch in __uart_read_properties().
If any code will be added in between that might leave the ->iotype value
unknown the validation catches this up.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_port.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 85285c56fabf..2fc48cd63f6c 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -229,14 +229,15 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 			break;
 		default:
 			port->iotype = UPIO_UNKNOWN;
-			if (!use_defaults) {
-				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
-				return -EINVAL;
-			}
 			break;
 		}
 	}
 
+	if (!use_defaults && port->iotype == UPIO_UNKNOWN) {
+		dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
+		return -EINVAL;
+	}
+
 	/* Read the address mapping base offset (default: no offset) */
 	ret = device_property_read_u32(dev, "reg-offset", &value);
 	if (ret)
-- 
2.43.0.rc1.1336.g36b5255a03ac

