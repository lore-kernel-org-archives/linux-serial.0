Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79338EEC4;
	Wed,  7 Feb 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269670; cv=none; b=ulIEZGpzlB/v+ehS5LpZEoGi9LmrC0KXr6XkHnxNZ4NlGWXMMzsaiiS9rWWDM/g9RIi//npPySvXOC0XARmQCDyHYMAHWQzoD10vi3vrLdrtHndeCE7bbbpJueXKVeqn016SAbnwbzPSo5apRJHv0UVwe2a66U1gL/xA1WOE65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269670; c=relaxed/simple;
	bh=K5UqNYXECDU8B6qMO6ZrnzRU9Kj9go3KsOdjqpy1u60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OzMJRCPVMYCIrCkrVHAz56IAoZlrugvzhJWE/Cl0Nz29C/gMoFIp1IffPhx26Y78dpO9WG7Z/zOr6Du7zmaverw9fIHEo5T0Dx6lfHZYdL5jQp6D1UGUgg9N08xfbgO8ClAz1reQk3INAztYLf49NqGjBhOcPsSsPtZxRvmfJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXg0h28g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXg0h28g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707269668; x=1738805668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K5UqNYXECDU8B6qMO6ZrnzRU9Kj9go3KsOdjqpy1u60=;
  b=cXg0h28gZbUGKF6LLHWItBHl0VQdxBd2ZTgjNQyo4URkSKSiMU4OStfx
   eYcJlP8KDawcB+gE7lBBKVMTVeGa+nXnvMoFoK22C+EeRxgTFgUPgpsRm
   Ya4pAk2OJIYoR7WmrTFbvY92dHmOAPOW2pkfAS6l2U1WhIxrbZep7niM6
   7bDL3YV5iw4hUN6KAAVeIkBfGH57dT4OlGgSIlrG5Bvf1DHIyC4IkqI4R
   jH+TJNPwiHiVqR7d7KJfnYXqAls2rUPosFI9pDpTBr/d2oq9dBR8GlLz0
   6zzJzSUQJG0ottGUOXlitsCYBwVdGYt/cM5j1PPDbevVwGVaL7Uqz5fKC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11533440"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11533440"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1189312"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Feb 2024 17:34:26 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXWpT-0001xG-2t;
	Wed, 07 Feb 2024 01:34:23 +0000
Date: Wed, 7 Feb 2024 09:33:57 +0800
From: kernel test robot <lkp@intel.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	John Ogness <john.ogness@linutronix.de>, linux-doc@vger.kernel.org
Subject: [tty:tty-testing 28/29] kernel/printk/printk.c:4267: warning: This
 comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202402070957.NsPz3RBO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   014e10bea593b963574d607faa34e7eaaad3c02b
commit: 558367b641b3802572132e7ed865f5eb887c41ea [28/29] printk: Add function to dump printk buffer directly to consoles
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240207/202402070957.NsPz3RBO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070957.NsPz3RBO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070957.NsPz3RBO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/printk/printk.c:4267: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump the printk ring buffer directly to consoles


vim +4267 kernel/printk/printk.c

  4265	
  4266	/**
> 4267	 * Dump the printk ring buffer directly to consoles
  4268	 */
  4269	void dump_printk_buffer(void)
  4270	{
  4271		console_lock();
  4272		console_rewind_all();
  4273		console_unlock();
  4274	}
  4275	#endif
  4276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
