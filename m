Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970722D7B0;
	Fri, 21 Mar 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581290; cv=none; b=nB6IqQR1HQolB7pCIQKycQWNg664ugGHzLizC7ZwfrZiYa5vxy6DwcmO1yhAfaAG/eWhk1a0Ik1sveobWaVdGKtn/V2VxiEqFQx5bqf1jujtaky5fPN56kCzjvEuoV87L6iZsNWJWeb5hdWLF/j2ybefyVXJBRiTZ9TuZK5JfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581290; c=relaxed/simple;
	bh=b7hSK+tLsTrKDr4s5J6R0wfJukC3Y0neukCsiqoG/vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXA7XOl3FNurp2jWQ++Bqn0QLY+fCG7IankGB/+H7O1rpg2Jh535FtvfH4yG8/ZTiO3y8qxHv/W4Znd1/Y6osEldXovmcukHVRlk3x4zYfxFeD2GjP/mQW0lzxgOo9cUj/sSZCVPSr3mY+wHOyuGSZxwbE2gObz8ooy/PiBrhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIvY5MWs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIvY5MWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742581288; x=1774117288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7hSK+tLsTrKDr4s5J6R0wfJukC3Y0neukCsiqoG/vA=;
  b=ZIvY5MWsjTwzCJU40OLW9TL/RtI3Ej3siwS90lsh7twqslFYBsFna3UZ
   JqV8b1XLLDhBOlqMInRK500u4HXZuun9TxfNNLOyC8iaLrHNWfpSGnK18
   srCl7OpgFerzRzHdFs034fXQCwreQubHksXJB2THupxDFM92wpTok1K/v
   rBJBJG+vnuajuTKoKsiCnLicaoAlE4T+erJDi1PsWInYQzXYGxkoCtw6W
   /CPCbc4nxPUpnDFcsLUEYqo+8orGBfHqT03jy1tBOXxxAP5kRByMAJBXC
   G0cNUGOY3vl4cfRX/1sAx8GrHgDqSENsK1GnVNLts80GQxwcAQPfIimGj
   Q==;
X-CSE-ConnectionGUID: XNEU8AxWTcm+CDHpBLomkA==
X-CSE-MsgGUID: 4nKLR875S9iTtQ/OSQ9E3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44046746"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="44046746"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:21:28 -0700
X-CSE-ConnectionGUID: X3b8qrLRSP6AT4Ft886ceg==
X-CSE-MsgGUID: VEzlbH03RfSpgVgKnbjW1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123433902"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 11:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BAF7225B; Fri, 21 Mar 2025 20:21:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/7] serial: 8250_ni: Remove duplicate mapping
Date: Fri, 21 Mar 2025 20:20:13 +0200
Message-ID: <20250321182119.454507-3-andriy.shevchenko@linux.intel.com>
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

UPF_IOREMAP is for serial core to map the resource on behalf of the
driver. No need to perform this explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ni.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index 03e838f440be..562f7f29e209 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -239,11 +239,6 @@ static int ni16550_get_regs(struct platform_device *pdev,
 		port->mapsize = resource_size(regs);
 		port->flags |= UPF_IOREMAP;
 
-		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
-					     port->mapsize);
-		if (!port->membase)
-			return -ENOMEM;
-
 		return 0;
 	}
 
-- 
2.47.2

