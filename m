Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F02FE048
	for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986629; cv=none; b=ISE7gjz6LV91YYLXGhhixuiU5KonERg6xjbyea++X4Q3QcX6VGSyAydS4Llicl7gkyaI6O5dm8B3amYXd6VpUHp5XpZhgfTRtU4vUMerWu0DGpHJJ3DDilmCoM/cbqH26nfNJ2//G5wsDvLkAZwWM6QOVICuhIYRNp3GI7gainA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986629; c=relaxed/simple;
	bh=9TjbvmANRJMTl5s+uWyk8ISEFMdrszLierEKWYDbRbg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C6/Ai6ORK4mpGde/+6U2GgTFynHaNAZuXZF8YRiqr2oaE2xsg/ZP296cfv7Q8Wm3b41Mj9zf5WP8hy8GtSRJJSEPoT2d71T+NtizXzYucTgAA8tLVcWbU7DolZikB4JvFGzV3xqtYg58liNV3Jjt/Sic+fqL+dpSvB/STsw5+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4LeE9yY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4LeE9yY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986627; x=1795522627;
  h=date:from:to:cc:subject:message-id;
  bh=9TjbvmANRJMTl5s+uWyk8ISEFMdrszLierEKWYDbRbg=;
  b=h4LeE9yY0EFCj0nSp4dLYyqxvSLGVkP48Jfr1onT9rO7dsdh+ntahv6I
   pnUoGWx/cra2hWyGyeQf0+04yUjaMX/fgRKLZyKyWAdTYeT/4JNFTLS0A
   M+auaOU/xzmmx6DFFlMdQfAtrH7/dF1Ww69ZRsIhoR78Vc97WdqH2x4kg
   /kIQ8pCZnfWl8e8OGB8RY7bH7v0Tt59afOVgPoA7YjoVVgQvsOMwzbVe7
   PN66sHx/YWAvjPqEPkbGEdLRPC7/B/DZBnYsTSiWS84FbQ7ZlhoGU1TcF
   0J1Ra/W8X7dBc5IjvdWXP1aF8WWYs0JiNO0G9F5dcR8Zlu55FSJBDZfIA
   w==;
X-CSE-ConnectionGUID: C3MdVcEDQ5GxKL9FDjL2Gw==
X-CSE-MsgGUID: zIi7AaeCShKSSMJvXzp9tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="64984835"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="64984835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:17:06 -0800
X-CSE-ConnectionGUID: i0BRK7xZQveJ/C6uw/sk+A==
X-CSE-MsgGUID: jpEsecWYSnqOFakoaDvYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="191987635"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Nov 2025 04:17:05 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNVV9-000000000i3-0N5u;
	Mon, 24 Nov 2025 12:17:03 +0000
Date: Mon, 24 Nov 2025 20:16:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 da218406dd50e0ac96bb383de4edd208286efe70
Message-ID: <202511242022.atyJS5Lm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: da218406dd50e0ac96bb383de4edd208286efe70  serial: 8250_platform: simplify IRQF_SHARED handling

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202511230751.YoaUZr5b-lkp@intel.com

    drivers/tty/vt/keyboard.c:1712:7: error: cannot jump from this asm goto statement to one of its possible targets

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/tty/moxa.c:1044 moxa_board_deinit() warn: sleeping in atomic context

Error/Warning ids grouped by kconfigs:

recent_errors
|-- parisc-randconfig-r072-20251123
|   `-- drivers-tty-moxa.c-moxa_board_deinit()-warn:sleeping-in-atomic-context
`-- powerpc-randconfig-002-20251124
    `-- drivers-tty-vt-keyboard.c:error:cannot-jump-from-this-asm-goto-statement-to-one-of-its-possible-targets

elapsed time: 3937m

configs tested: 46
configs skipped: 0

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251123    gcc-15.1.0
arc         randconfig-002-20251123    gcc-12.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251123    clang-22
arm         randconfig-002-20251123    clang-22
arm         randconfig-003-20251123    gcc-10.5.0
arm         randconfig-004-20251123    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251123    gcc-8.5.0
arm64       randconfig-002-20251123    gcc-11.5.0
arm64       randconfig-003-20251123    clang-22
arm64       randconfig-004-20251123    clang-22
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251123    gcc-15.1.0
csky        randconfig-002-20251123    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251122    clang-22
hexagon     randconfig-002-20251122    clang-17
i386                    allnoconfig    gcc-14
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251122    gcc-12.5.0
loongarch   randconfig-002-20251122    gcc-14.3.0
m68k                    allnoconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251122    gcc-11.5.0
nios2       randconfig-002-20251122    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251123    clang-20
riscv       randconfig-002-20251123    gcc-8.5.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251123    gcc-8.5.0
s390        randconfig-002-20251123    clang-22
sh                      allnoconfig    gcc-15.1.0
sh          randconfig-001-20251123    gcc-12.5.0
sh          randconfig-002-20251123    gcc-14.3.0
sparc                   allnoconfig    gcc-15.1.0
um                      allnoconfig    clang-22
x86_64                  allnoconfig    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
