Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776521E0E14
	for <linux-serial@vger.kernel.org>; Sat, 11 Jul 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743851; cv=none; b=ZVImXvMFFybEmZAaqr+vUfxScnd6eFjvEVyYDquqAPagWVUAAEAX6B+xusX/KzeFv2bqhUEKXNngnNxQ2U8mD9LQ1v+Imq9WtBGFzT9XXzIE/jExLrXEEv/nbsYSyuIxMOpiLSpTyFtMeA19on0rBBLoPVz/cssRkqYe//T8jIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743851; c=relaxed/simple;
	bh=1Ovb6wlsIAggiSRasGT5lxNugcVqOLdLPgfOicKS5bM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KDt6hsudMHUtQub+MwDZCF7vtpXAlfKcxjBYxC8VJYQd9Rqi4ItHnfnTTRD0VVHUbKV+wI2S438ZxI3v/ABFu2L/zatiLZ3Xrii7THZkWCpZ5uvRj4X5FKY5rY/OfNgByEfzcItZRdfhrmjoamhSH4RCj0TKkXkAQVxLGV60+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjqpZHK2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjqpZHK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783743849; x=1815279849;
  h=date:from:to:cc:subject:message-id;
  bh=1Ovb6wlsIAggiSRasGT5lxNugcVqOLdLPgfOicKS5bM=;
  b=LjqpZHK22QSItKLj4RLk1m255P6/deytOZgqls5hCAAvsg3xxKLoq739
   F5DHMwdo6QgZgIdy39lHVkmjuN4lad0yb6ByPgfBqhRT/SCjcuhRjRYtQ
   Owuf0Z8oMUVmH6CWEgxDPaIruqkoWz/YB6kjtfzD6e/ie0L/g8sCxzu18
   0A5ocKLOSjrhWblSe4gV1nfge8c5jP/BYXDS6QOpLnvUidnM0wDN66pMy
   Vt0wqsuTSLV9n1VT/drj3FTtzuLJoOlkfswrRQC2EZca5dWqFPkF71moX
   khqBxRqKNVQNOwAtLSR4n21PD7qjMWUhiOeWQ4+3TmnQBzkGzGZ5SIxOW
   Q==;
X-CSE-ConnectionGUID: 4zEQNmqdSdmkvwztxV3JzQ==
X-CSE-MsgGUID: VwqkBdUOQzeyK+OI1jWrYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84488552"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84488552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 21:24:09 -0700
X-CSE-ConnectionGUID: GulTKIWUSwmG8rmfprYXEA==
X-CSE-MsgGUID: Yu8hrhwTRKikbj/Jj5S32A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258928948"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 10 Jul 2026 21:24:07 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiPG0-00000000Jj7-2I7i;
	Sat, 11 Jul 2026 04:24:04 +0000
Date: Sat, 11 Jul 2026 12:23:46 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 32/41]
 drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for
 function 'hub6_match_port'
Message-ID: <202607111219.QG9uOW8H-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   bef5e068b89b0f0cf974c987ebba9869a14b44c6
commit: 3d406299d8829747fe2e8692f4c29fe3dc1d101f [32/41] serial: 8250_hub6: add hub6_match_port()
config: i386-randconfig-053 (https://download.01.org/0day-ci/archive/20260711/202607111219.QG9uOW8H-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111219.QG9uOW8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111219.QG9uOW8H-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_hub6.c:44:6: warning: no previous prototype for function 'hub6_match_port' [-Wmissing-prototypes]
      44 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
         |      ^
   drivers/tty/serial/8250/8250_hub6.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      44 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
         | ^
         | static 
   1 warning generated.


vim +/hub6_match_port +44 drivers/tty/serial/8250/8250_hub6.c

    43	
  > 44	bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
    45	{
    46		return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
    47	}
    48	EXPORT_SYMBOL_GPL(hub6_match_port);
    49	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
