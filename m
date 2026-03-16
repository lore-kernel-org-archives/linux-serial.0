Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14D3A1D2
	for <linux-serial@vger.kernel.org>; Mon, 16 Mar 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664023; cv=none; b=mrrI0MHTPi7duuhKWJwGhscfg37QHqoPlrzdHv4qbEribaQ8mHNj9NQ4H9zA23QBlE/GrXPVTThSGeRHRXTu1HK6t3uyuUxVId7ym/BLMBbIHXhBlSxsAu3IrS4PgToVuhiPh71LLhEfMLo4jLpqicXLmOtr0xWWlFHC8LGdZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664023; c=relaxed/simple;
	bh=cXPT4sfWAqX5SR6mqidTrwGUvj4q2YuWM62cB35mmek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fwNCbIdCDn0J6B+cgS5YfwYkWurDcDkA3q4P5v7oaSJVBxS0/9s+RJ92KOFMtcmOFfUe4iSdv7huNyJAWxPfDzjKGEhr/770J3tY9VfHEk6H1ZT6V0xyZVMWE3BtrCKduggobEJbC1xFTzqiHzleS5lEWEq+v5so9fQlp2EXKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGTbDfYv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGTbDfYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773664022; x=1805200022;
  h=date:from:to:cc:subject:message-id;
  bh=cXPT4sfWAqX5SR6mqidTrwGUvj4q2YuWM62cB35mmek=;
  b=IGTbDfYvvPdLFePHTE2rIa8v7ubr7ghL+o9LNnA/xRCs/zQ8z/X75n6T
   hlloOkIkyoo8UW08sQaTqf/ZIqmfJz8RyDKsxtBCqrtG+dyHdzUfyKDoF
   2e4yABB2J65StN6TQh3y3E7dJXeU0PEzEFs1lgQ/WfFzkKSRhJgAh2Cy5
   uKKrAVcK1xndYLfCfU3lCaVPLEhCmyr5aWBOVP5Eh9lNbrEdp6x3XvCq0
   Fyyb4R8yXangErB/PZx0CNw7MwY05aXB0eTbfEyhuTyQBvPdXd9HJUk+I
   Gb/UX87Ry7rrj8RkHguHXUUAACI+/O6zXDaK5rXSBcgShP6RjqSxNPlYL
   g==;
X-CSE-ConnectionGUID: 80IAqn2vTEWH4x5FfjF8bw==
X-CSE-MsgGUID: YxMFtti0TR2xVzcHTmhmjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92059509"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92059509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:27:01 -0700
X-CSE-ConnectionGUID: ZLoy7L58Svesx39Chc1upg==
X-CSE-MsgGUID: LGsFJxCwTGa5ucRVyolgkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221138799"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 05:27:00 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2729-000000000ec-1Uw8;
	Mon, 16 Mar 2026 12:26:57 +0000
Date: Mon, 16 Mar 2026 20:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 eb3b0d92c9c39890592cca6647601fe5c631efea
Message-ID: <202603162008.hdXr2h1O-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: eb3b0d92c9c39890592cca6647601fe5c631efea  tty: tty_port: add workqueue to flip TTY buffer

elapsed time: 1030m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
