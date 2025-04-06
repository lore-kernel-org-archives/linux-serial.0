Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB661BA3D;
	Sun,  6 Apr 2025 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743900504; cv=none; b=nqkeDZiBa+K7uKrtf5FBC7TifnJ/4/x3luTfZoLPCxVglQvj0Yt4+9ozTZR/djhYioPjXY/SNZDCBZGPvXnadgXM6EpTQOoepv68MTkOfO7O0zJqbBsJT7ZZ0KXhc+A4IZxXxLTs9whYjNPtk1DxIFapSltZggVX8Q7UoCLRHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743900504; c=relaxed/simple;
	bh=RJrdvsw7uqqwA7zJ6qMZB+2wurHbFcb+WAtKDoSw9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge662DoXA8W5rCHvQilFmPoobayazKbXU3LNN3Ao7X0kNIrv8PDcCHkeNaot8Yh2uM0c41BCtXpYlbxOsg64RX08yNzP7YGeaceS/wF7tvJD8gs0dvhpT9CiN+uworbd+23cswqaRsV1NCIJRfG8EPzIH5i+tHg10k/6k+8qJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Neo3YhaY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Neo3YhaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743900503; x=1775436503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJrdvsw7uqqwA7zJ6qMZB+2wurHbFcb+WAtKDoSw9X4=;
  b=Neo3YhaYP8wFm2DwPdYhVD3OlyZZwY0ofY6ATLFmohWhF14sZ/cjbwMP
   um8V0J02csGDntK96vTyJp8K8XUoyj1Lu05OebetH1CM54+CM0sBlVa9C
   qJ2jQHgIBQEesEtvtf1lso2UYaAt51RwXf7SHjdHRbRezT52mce6dyVz1
   eQNxf59/OAVr3QhlpbSNrOsVlIKxU62vlnraLxX6BYcATllhNbnh5qOkE
   EPIt1UMlEkZbwYhxAT83V54+GNFCu83XiKbfMt9d3FmN7YfQG+TWD8Oap
   RPsjiQodA2YhGpfIRbmaUD1UJ19x3PrMiU2h5Uehm3bBFioLt0eWAopJ1
   g==;
X-CSE-ConnectionGUID: xSqr83TeTwCYKS0fdIgCfw==
X-CSE-MsgGUID: qqtVsVhZQwiDS8ZXA31QRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45199364"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="45199364"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 17:48:20 -0700
X-CSE-ConnectionGUID: LR/a94YdQj6cF0zO347ilQ==
X-CSE-MsgGUID: SNZ8YTh2SNyTuVKI89Ubxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127499625"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Apr 2025 17:48:16 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1EBJ-0002NJ-1k;
	Sun, 06 Apr 2025 00:48:13 +0000
Date: Sun, 6 Apr 2025 08:48:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ryo Takakura <ryotkkr98@gmail.com>, alex@ghiti.fr,
	aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, u.kleine-koenig@baylibre.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: Re: [PATCH v2] serial: sifive: Switch to nbcon console
Message-ID: <202504060816.EWk91sJS-lkp@intel.com>
References: <20250405145915.493173-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145915.493173-1-ryotkkr98@gmail.com>

Hi Ryo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.14 next-20250404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryo-Takakura/serial-sifive-Switch-to-nbcon-console/20250405-230051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250405145915.493173-1-ryotkkr98%40gmail.com
patch subject: [PATCH v2] serial: sifive: Switch to nbcon console
config: arm-randconfig-002-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060816.EWk91sJS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060816.EWk91sJS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060816.EWk91sJS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/sifive.c:155: warning: Function parameter or struct member 'console_line_ended' not described in 'sifive_serial_port'


vim +155 drivers/tty/serial/sifive.c

45c054d0815b15 Paul Walmsley 2019-04-12  131  
45c054d0815b15 Paul Walmsley 2019-04-12  132  /*
45c054d0815b15 Paul Walmsley 2019-04-12  133   *
45c054d0815b15 Paul Walmsley 2019-04-12  134   */
45c054d0815b15 Paul Walmsley 2019-04-12  135  
45c054d0815b15 Paul Walmsley 2019-04-12  136  /**
180bb243de730c Lee Jones     2020-11-04  137   * struct sifive_serial_port - driver-specific data extension to struct uart_port
45c054d0815b15 Paul Walmsley 2019-04-12  138   * @port: struct uart_port embedded in this struct
45c054d0815b15 Paul Walmsley 2019-04-12  139   * @dev: struct device *
45c054d0815b15 Paul Walmsley 2019-04-12  140   * @ier: shadowed copy of the interrupt enable register
45c054d0815b15 Paul Walmsley 2019-04-12  141   * @baud_rate: UART serial line rate (e.g., 115200 baud)
180bb243de730c Lee Jones     2020-11-04  142   * @clk: reference to this device's clock
45c054d0815b15 Paul Walmsley 2019-04-12  143   * @clk_notifier: clock rate change notifier for upstream clock changes
45c054d0815b15 Paul Walmsley 2019-04-12  144   *
45c054d0815b15 Paul Walmsley 2019-04-12  145   * Configuration data specific to this SiFive UART.
45c054d0815b15 Paul Walmsley 2019-04-12  146   */
45c054d0815b15 Paul Walmsley 2019-04-12  147  struct sifive_serial_port {
45c054d0815b15 Paul Walmsley 2019-04-12  148  	struct uart_port	port;
45c054d0815b15 Paul Walmsley 2019-04-12  149  	struct device		*dev;
45c054d0815b15 Paul Walmsley 2019-04-12  150  	unsigned char		ier;
45c054d0815b15 Paul Walmsley 2019-04-12  151  	unsigned long		baud_rate;
45c054d0815b15 Paul Walmsley 2019-04-12  152  	struct clk		*clk;
45c054d0815b15 Paul Walmsley 2019-04-12  153  	struct notifier_block	clk_notifier;
328ee9dbff3941 Ryo Takakura  2025-04-05  154  	bool			console_line_ended;
45c054d0815b15 Paul Walmsley 2019-04-12 @155  };
45c054d0815b15 Paul Walmsley 2019-04-12  156  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
