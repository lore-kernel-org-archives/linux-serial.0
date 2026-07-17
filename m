Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F763FD97F
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293691; cv=none; b=OTKVgsbdJCraodXq2yWD8u59ooMeDmoJ7vj3ljXgWjPdplUpakQ5QtpXzmG413i8TLzhCI3IxE3I4RsZ65XRvZvqt9uKUDCuoN3In1top36fandD1P/MINwf2Zn+iz6oqicnWXnsvEh7BhmKcUF5oIGj4L0B9V+ybuZUCR/qQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293691; c=relaxed/simple;
	bh=PNZuqRc1HF+1CO+XQWGPPYdyKXXwh5YmP3nLa1kjX0c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JssZg0WFjdixWxOt+ijrTym4pqwXoVZJRit3O0wrOMJNPaV4uEkz+XERJUjGdtCJLr8yg3SQtcW1zTRVxjQKEzVxJN8LZ3dtNVe4PmrFocv5c94SY8eqhF+M9YuQ9mP8K6/SXd6a18fm+2qC8dhF6VxrCIGBG7NRe47Jqg8/nGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYnjeY2b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYnjeY2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784293687; x=1815829687;
  h=date:from:to:cc:subject:message-id;
  bh=PNZuqRc1HF+1CO+XQWGPPYdyKXXwh5YmP3nLa1kjX0c=;
  b=dYnjeY2bJhXEEOsKGeiFKP84IKhN5DWna7+pHCZhyyZEO92WrXhAQGRq
   k2TxRN/ju4W+Y8w6YYzbKih2GkPKavNJhacdLGYqcrVSRz+eRooRsx7Fb
   9ealCyQAmyFCdEl4Uhim8vrTyhhfx5FjMl8/Y212wrvroIxPXpvCWeC8x
   tZ/3DQvScSBbaJMuQRAFeeZNQ9KM4hDFbozGYEZYupgwVcKTebdf331lY
   XjEPg3f3pKAgOhRd8P5aN29JTuZ/okxCQzcfyUuqheomU8QDvt2p8pVUM
   mgraCWFdekSiUJkL8696FoMV9DvvmvwzvvTi3vtSnB6DuYv3xY1NH1YVb
   A==;
X-CSE-ConnectionGUID: jIjnQOpHRmS0+u4hbEJ1PA==
X-CSE-MsgGUID: ajmdAeaIQaansivlTq8jqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96328668"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="96328668"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 06:07:41 -0700
X-CSE-ConnectionGUID: mFQfePblSKqnLPkXmZ0CAQ==
X-CSE-MsgGUID: WOuh1aZnST27fPq/FDLqeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="252384825"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jul 2026 06:07:39 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkiHx-000000005W9-0uJF;
	Fri, 17 Jul 2026 13:07:37 +0000
Date: Fri, 17 Jul 2026 15:07:34 +0200
From: kernel test robot <lkp@intel.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 11/13] error[E0425]: cannot find type
 `BoundInternal` in module `device`
Message-ID: <202607171517.ScFnGK4R-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   ec7dbdaa11c7be1806f0ea1a272ee6daee42a843
commit: cbc11f4e978d1ee0bc857a9c51d43bbae6966f1d [11/13] rust: add basic serial device bus abstractions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260717/202607171517.ScFnGK4R-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260717/202607171517.ScFnGK4R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607171517.ScFnGK4R-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find type `BoundInternal` in module `device`
   --> rust/kernel/serdev.rs:256:58
   |
   256 |         let sdev = unsafe { &*sdev.cast::<Device<device::BoundInternal>>() };
   |                                                          ^^^^^^^^^^^^^
   |
   ::: rust/kernel/device.rs:525:1
   |
   525 | pub struct CoreInternal<'a>(PhantomData<&'a ()>);
   | ------------------------------------------------- similarly named struct `CoreInternal` defined here
   |
   help: a struct with a similar name exists
   |
   256 -         let sdev = unsafe { &*sdev.cast::<Device<device::BoundInternal>>() };
   256 +         let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal>>() };
   |

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
