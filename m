Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360433FE09;
	Fri, 14 Aug 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706688; cv=none; b=f2OnEiUIbJa9abd8vTh2K/4YDlJ49AeV+YfdT4uX00PkZ4w7VC2QD1U/PvPfeWX/eT1ElOyC29VXDY3HkQ6kGVL6hx2Aogsxn5le2yXoXPXDyu9Rv8LETBhbWdgEbXpVCbvXwisx6xjweMc2LW0iC4oTeiQepw5OueLiZ1jEdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706688; c=relaxed/simple;
	bh=ACPu7W2YQAokPwP5OL7bhaDKjiXXVSh9221S7+ShHtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REy0IP+k4KHgZLcplnxzun0sGFGef88AfG2D9kwVmlX/Vc97u8P5uRK5P8dJ+HgS7Q8PuMSVQkulBjwu+6i+Qy6xHcLbsNIYQjxDfzlBUPJ26FmM/mn5hrhsnFLZnb+3BnGFbq2YRFNUGa31WfLikTwHXGkl869kwqYX7kk6eZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUBsmVgM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUBsmVgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786706685; x=1818242685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACPu7W2YQAokPwP5OL7bhaDKjiXXVSh9221S7+ShHtQ=;
  b=KUBsmVgMgXweRPysNr4jbBzEUlFrBbU9L4pNIqYA9f3KLn1WLAgIjqGO
   I2rpQWAjWGPiBvqwch6N81EGLt4zmUACbugzjSHMDfOqJtab/qRizomPA
   +k8ZA5LwGMYjAK1UtvYN/mxjhThpZhv2HeCvVkYNKSiYUE8wS5nh9kUAU
   /W5peDE9StbEo3hYdrjk4Z+rJeqDAL6CVVBtCAOMdsKfiBy4w/kHoft6W
   PQEwg4TY/9GOL6i2SGLmkuZs3UP4TIZBpsfg3/W2gnfk0MLs9UnRsHWnM
   P947Uos+aoVn+GgLBVF34J4IvtnIE2BZL5FD29PVOnj4jdnLVA51QTyer
   Q==;
X-CSE-ConnectionGUID: wOc6u4s9QT+sljP1hDNXGA==
X-CSE-MsgGUID: pSfV8cF3SVa9fyRnCuoesg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86403721"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="86403721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:24:39 -0700
X-CSE-ConnectionGUID: VPFo2WkYScmYHQV+EnnhTA==
X-CSE-MsgGUID: SoGAGmdpRQiSQzw9VP7Ewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266187691"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 14 Aug 2026 04:24:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 559D499; Fri, 14 Aug 2026 13:24:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] serial: 8250_port: Update runtime PM flow
Date: Fri, 14 Aug 2026 13:16:28 +0200
Message-ID: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (2):
  serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
  serial: 8250_port: properly handle runtime PM in IRQ

 drivers/tty/serial/8250/8250_port.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.50.1

