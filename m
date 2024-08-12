Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E3183CD9;
	Mon, 12 Aug 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477748; cv=none; b=hUXPn64xMz8qdupixTNREJfrDrSw7lQFWRr/7JzH9FSkx2j/Jq/Fhh8FbQ8X2+2uxQMBqv8XwpVI8nVw3mPLQwXfW2S9CIpp8D88nBtrYai1EyFy5KRaVGQT8P/0KQpIg38O8Py3I2ilERm9Ip3oE5Uhl8+KBES9cxaJBCtqn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477748; c=relaxed/simple;
	bh=yLC9qQqhhWTVpWQnhEgp8s0w6ejSMIbfw0GAFvs1yFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAqfu5l6Bpt6tDYRc/mNTnHOdv4WDeMPJIbUr0wwIijYPrPeiWixQjbM/32SfsM+uWHrNycVf91nKywecuBcoaV4Yqsu3MRldVN16hddqu9IvsZg/RtXoGbOAzMaW0sWu+p+P6afCOyPPcf4kyY1dQik9WwaXxYypcsNJjDrNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLtr3Wls; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLtr3Wls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477747; x=1755013747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yLC9qQqhhWTVpWQnhEgp8s0w6ejSMIbfw0GAFvs1yFY=;
  b=gLtr3Wls0gZwS/Fd72VqZzqQxi8VVBDep5sBZ89e7FPrJWhO+muHDq6o
   sJuV8Avx/gjk5y7BB4jBIZmKHWT+4G198GP32oYf2wkF/0lJy/5FffV3x
   ZyvBAjTY10RoazKdBGC0oskYJGyZY/dk7ApjmeqrcAQgx7UGLxstn8EEW
   nTVs/6fVpDn6ZUeMI0YpGXZ8AgjQvy+SDo/1DnfI8l3rD2pZyFjmshi1j
   K8mSApDgNeSBv1bov8fhJhqmYcScLU3DGcSnfn859oGiT4HCKCM5By7bq
   zD2Cc/dDwolsYR7FI2AtZ/0v6G/Z/PDmWqaDst3vkFGhJ3DpA2iuRNvlK
   g==;
X-CSE-ConnectionGUID: KlAEuSdRRf2Wvm/hv5x0Yw==
X-CSE-MsgGUID: ztURLMtKT4CeCQu2//2ISw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21160801"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21160801"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:49:06 -0700
X-CSE-ConnectionGUID: onPHd04KQ82aCrN0UZaUGA==
X-CSE-MsgGUID: vLQqeI/yQvaF4UB119Jliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58187003"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 12 Aug 2024 08:49:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A84C5178; Mon, 12 Aug 2024 18:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 0/7] serial: 8250_platform: refactor and clean up a bit
Date: Mon, 12 Aug 2024 18:47:02 +0300
Message-ID: <20240812154901.1068407-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent patch against this driver has been added without my review.
It was technically my fault, however I was on long vacation.
So, instead of blaming anyone, this small series to tidy up the things
as I think would look and be maintainable better.

Andy Shevchenko (7):
  serial: 8250_platform: Remove duplicate mapping
  serial: 8250_platform: Don't shadow error from
    serial8250_register_8250_port()
  serial: 8250_platform: Use same check for ACPI in the whole driver
  serial: 8250_platform: Tidy up ACPI ID table
  serial: 8250_platform: Switch to use platform_get_mem_or_io()
  serial: 8250_platform: Refactor serial8250_probe()
  serial: 8250_platform: Unify comment style

 drivers/tty/serial/8250/8250_platform.c | 107 +++++++++++++-----------
 1 file changed, 58 insertions(+), 49 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac

