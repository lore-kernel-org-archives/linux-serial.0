Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3935C1B2;
	Thu, 24 Sep 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252755; cv=none; b=b4NsKCwRzcF8GVA5WADO3INECUr5ARSUD+MBPm6HrVbFvoU+USgN3fD4x34uVzCwiYhHPkWCKDAl46x42PbTHCLp31ZXWEtohxLa/d5cvzWyGdx3agp72CG6oLYQooSSxMzZXEHtBHhbgKdk9vCi/0gL1HlvUzCCnnW5qY5FJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252755; c=relaxed/simple;
	bh=FuZDq2+k5cGP3GesRChzPtShawIBgzXZyGMbUjG8VXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQOUaIEMV7jFRuqmCNhGl8L1Ge0Pd5R1j5fr7kU600B3dhygDseHAIOMmzQVLXxMbKSD9Bi/hfRMd2TuVSpjqHA2RxpCOKyc3xiGply8IwwjUaLMDFsjDnxYpiH6BNP48jTcjxuwsd2TWw/GcHEYhg3wsRhaju2yEDX7KzS641Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DM8B/aT2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DM8B/aT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790252754; x=1821788754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FuZDq2+k5cGP3GesRChzPtShawIBgzXZyGMbUjG8VXY=;
  b=DM8B/aT2rUxivGXt5ABznWaA/B/379WlOtcbsoe8j5l27DX0zgag2cgd
   H4ZIkIHK3rnxd75b9BvVCAbMo8Hm4i261pOhY2VW3xs+0hknKV2OLG0NH
   yQiPLEd9j1IczevmqBo+c1+M7d/qYVrD+V5hhhk9wxLbZRMRacG159R8x
   VaLLz6+xOiK1nbf8Y5QxjTFzMG2z/pA+cqTv2MxbnyIcDbVJolZzeDDC3
   39lNmDEpj1ND6DyakalRYf9LXJX1B1+MN35BliAnAG6cOsuRy7hUScn0X
   SfDsDFJPjSOpje2UpI/Pd++yOFc5LOSRi6RLDZBQtkFY1XJI1WsPSZERX
   A==;
X-CSE-ConnectionGUID: L7fwtDnpTjKzfxsXSAuA/Q==
X-CSE-MsgGUID: cN0WceC9QUq5zMacIApprQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89926555"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89926555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:25:53 -0700
X-CSE-ConnectionGUID: GbtaVBN4RYusOg8ue3SUTw==
X-CSE-MsgGUID: 1fpEsyNwQdKzwOqt/crTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311926428"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:25:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BB49F99; Thu, 24 Sep 2026 14:25:50 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] serial: 8250_port: Update runtime PM flow
Date: Thu, 24 Sep 2026 14:24:18 +0200
Message-ID: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two changes, one is a straightforward drop of the duplicate
runtime PM call (which is idempotent and hence it's harmless to call,
but practically no need to do so) and the other addresses long standing
problem with potentially sleeping PM calls on some system in IRQ context.
Also the latter might lead to unneeded resume-suspend cycle when IRQ is
shared and interrupt is not ours. This mini-series to update runtime
PM flow to make sure this won't happen.

In v2:
- removed now unused local variable (Greg)

v1: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>

Andy Shevchenko (2):
  serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
  serial: 8250_port: properly handle runtime PM in IRQ

 drivers/tty/serial/8250/8250_port.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.50.1

