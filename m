Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AB3B7B97
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676258; cv=none; b=JVAPaydHMLlQMyc6GYwY+UJY7tZifrEO1ig1aJ5lto86KtKJTvf/uqsLWe2jvDhhT5nLxn/w4WxMnyjiik0P2ym66V5bZXURFvENlLEDp4mTWUYa4XFa5Dn4atn/aCGOInLZywIutyag2oX1XoHs2vzh+xFEHvrv14HBTK9sqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676258; c=relaxed/simple;
	bh=/cQNEP8u2gP9w5bA9dCkkoabRjeOhuVGegYT3yK757Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GDgMBYO1wDQ0wP0kfn9tMJm472OpM200WCIHqSOIZEihewAkCwuNnwI+5G7cyP5P4Q9PvC+Gao1uJ6FlhdrSMgVMv9hyCvpnQtv3czwgJJfsvZ7zRNM1DkdtM79vLi6jAimUl5u79qXSjGI29h6GETtjQcqXBNwf5ZdjPSUHMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEPa+G9n; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEPa+G9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784676256; x=1816212256;
  h=date:from:to:cc:subject:message-id;
  bh=/cQNEP8u2gP9w5bA9dCkkoabRjeOhuVGegYT3yK757Q=;
  b=SEPa+G9nRAxByseFyHTYgoVOeO2lvoHoFXo8G8oK93NHt2BafuZEJGAZ
   69bdjZWY7uQF/BjMyPzUoE3Z7fh/Fji98sXUiAFHCReOxLBicl7RA6sID
   +I0p7yjHXe7Zj9R+nERpqQb91hLpzz/kLaj10a5Qjk5GT1XXq+mpAO7/i
   A3MSde/osLHd9x+ZC8sxsIYxv1oaICSYyBLK91sjLDygp3CQRr7Io28hA
   Y2Lx7q7QpRHbdi7hF6NxwJnuoLuQyXcFqXwNxXxMhgRy/s39JfjhEWtjd
   y1EQiwJQ4ITeAb/+ZCZ1H6iohBa4dWU4vXUAwMQUsGljQb8v8z0y/8b5D
   Q==;
X-CSE-ConnectionGUID: g/pADdHNSlydrR1B2BshZw==
X-CSE-MsgGUID: 90DxK5uLRBWKXlXAmIfZIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85149653"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85149653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 16:24:16 -0700
X-CSE-ConnectionGUID: OMi6P/8DRNOiwC5qi8n8FA==
X-CSE-MsgGUID: W3WBru6/TNCf7e87ezwG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="282422749"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jul 2026 16:24:14 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmJoq-00000000Y9q-1m8H;
	Tue, 21 Jul 2026 23:24:12 +0000
Date: Wed, 22 Jul 2026 07:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 782f4dbd1794b4f30dc116a7ca42c5962c409be8
Message-ID: <202607220746.tcrZjjA5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 782f4dbd1794b4f30dc116a7ca42c5962c409be8  tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64

elapsed time: 6070m

configs tested: 21
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
alpha                 defconfig    gcc-16.1.0
arc                allmodconfig    gcc-16.1.0
arc                allyesconfig    gcc-16.1.0
arm            ep93xx_defconfig    clang-24
csky               allmodconfig    gcc-16.1.0
i386               allmodconfig    gcc-14
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
parisc             allmodconfig    gcc-16.1.0
parisc             allyesconfig    gcc-16.1.0
parisc                defconfig    gcc-16.1.0
riscv   randconfig-001-20260722    gcc-13.4.0
riscv   randconfig-002-20260722    gcc-13.4.0
s390    randconfig-001-20260722    gcc-13.4.0
s390    randconfig-002-20260722    gcc-13.4.0
sh                    defconfig    gcc-16.1.0
sh      randconfig-001-20260722    gcc-13.4.0
sh      randconfig-002-20260722    gcc-13.4.0
x86_64             rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
