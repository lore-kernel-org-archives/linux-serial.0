Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918A1547C3;
	Fri, 18 Oct 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223047; cv=none; b=AbwvIkBYbaNNpPxvGK4zeh+X3R194TxDLf1XG6gpHKCudnhR3/2IwNcRjz7SEGk9U1ekuFBRW0/u8QHu0C8qjVdoKowCuTEOVc/LA0gifD0nR4Wio7dxMKWJkNLZBBgqbayqHzCg+X0KVfT75fw7mpFMq/zQ0NwsXPIZUrM5tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223047; c=relaxed/simple;
	bh=H8vlp8zt5LbQ3oWxLa0uGme6oWHI5mjpEIFX+GssDMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piCuaTL1AyGNF+gVfQud32NWznlR9I+sq/GKMw8pWANVGIYepWW/+csddIoLhF/a2Ay+h25suyJgl6DJiw3/tTiknEgQaGlWutPtA7lgtCIn4XrJ5r/YOLYo5s2WLyRRuBvHVtU4AL/dZ/gX8UjF3XJNEQcMXGhs0RMQdTTm1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdtA5bR9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdtA5bR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729223046; x=1760759046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8vlp8zt5LbQ3oWxLa0uGme6oWHI5mjpEIFX+GssDMg=;
  b=mdtA5bR9/t1B3Rq4jR+GpLUfc8QBAbwUpOD5JRiPG4aB2w+DWrZy8biZ
   yCF6tybKjpkBE9Q971Ytr6ViLIhs7ueP4tcIhyI7bGsicyx43LOIzZOPS
   vyD/b5GxOfv/jcneVS4ZNKGYgc2PNz/MJlEgfB89dmGpw1R1d+9qKUK9g
   G/Sw7iYN3hHryEGfyXSc7ujqMuTWjwPfH7EvQFx+nVkzXUJe4Sm6ddpdw
   1iIZ8WbwkIkWd1f7ZSypAiHxk+5Hn5r8qEk8RuUPxHpg3ftCko9wVUfWi
   DsOwx668s94yYXE+57MlkYhUl/0iB6jvMdGaP7nVBZn6dZq/Jjzz0AVbU
   g==;
X-CSE-ConnectionGUID: Q938H+syTreSLBdPfWJUcg==
X-CSE-MsgGUID: q4uwlzcKS3Gc1LUXGXiUFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32424429"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32424429"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:44:06 -0700
X-CSE-ConnectionGUID: pC1GArHgTHG590frpVmg/Q==
X-CSE-MsgGUID: voGyqymqQIq48f+iQT2jLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78355491"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2024 20:44:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1duC-000NEJ-2T;
	Fri, 18 Oct 2024 03:44:00 +0000
Date: Fri, 18 Oct 2024 11:43:59 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 2/2] tty: sysrq: Use printk_loud_console context on
 __handle_sysrq
Message-ID: <202410181116.WA27FpBB-lkp@intel.com>
References: <20241016-printk-loud-con-v1-2-065e4dad6632@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-printk-loud-con-v1-2-065e4dad6632@suse.com>

Hi Marcos,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-Introduce-LOUD_CON-flag/20241017-010521
base:   1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
patch link:    https://lore.kernel.org/r/20241016-printk-loud-con-v1-2-065e4dad6632%40suse.com
patch subject: [PATCH 2/2] tty: sysrq: Use printk_loud_console context on __handle_sysrq
config: x86_64-buildonly-randconfig-004-20241018 (https://download.01.org/0day-ci/archive/20241018/202410181116.WA27FpBB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181116.WA27FpBB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181116.WA27FpBB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/sysrq.c: In function '__handle_sysrq':
>> drivers/tty/sysrq.c:600:9: error: implicit declaration of function 'printk_loud_console_enter' [-Werror=implicit-function-declaration]
     600 |         printk_loud_console_enter();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/sysrq.c:610:25: error: implicit declaration of function 'printk_loud_console_exit' [-Werror=implicit-function-declaration]
     610 |                         printk_loud_console_exit();
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/printk_loud_console_enter +600 drivers/tty/sysrq.c

   582	
   583	void __handle_sysrq(u8 key, bool check_mask)
   584	{
   585		const struct sysrq_key_op *op_p;
   586		int orig_suppress_printk;
   587		int i;
   588	
   589		orig_suppress_printk = suppress_printk;
   590		suppress_printk = 0;
   591	
   592		rcu_sysrq_start();
   593		rcu_read_lock();
   594		/*
   595		 * Enter in the console_loud context so that sysrq header is shown to
   596		 * provide the user with positive feedback.  We do not simply emit this
   597		 * at KERN_EMERG as that would change message routing in the consumers
   598		 * of /proc/kmsg.
   599		 */
 > 600		printk_loud_console_enter();
   601	
   602		op_p = __sysrq_get_key_op(key);
   603		if (op_p) {
   604			/*
   605			 * Should we check for enabled operations (/proc/sysrq-trigger
   606			 * should not) and is the invoked operation enabled?
   607			 */
   608			if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
   609				pr_info("%s\n", op_p->action_msg);
 > 610				printk_loud_console_exit();
   611				op_p->handler(key);
   612			} else {
   613				pr_info("This sysrq operation is disabled.\n");
   614				printk_loud_console_exit();
   615			}
   616		} else {
   617			pr_info("HELP : ");
   618			/* Only print the help msg once per handler */
   619			for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
   620				if (sysrq_key_table[i]) {
   621					int j;
   622	
   623					for (j = 0; sysrq_key_table[i] !=
   624							sysrq_key_table[j]; j++)
   625						;
   626					if (j != i)
   627						continue;
   628					pr_cont("%s ", sysrq_key_table[i]->help_msg);
   629				}
   630			}
   631			pr_cont("\n");
   632			printk_loud_console_exit();
   633		}
   634		rcu_read_unlock();
   635		rcu_sysrq_end();
   636	
   637		suppress_printk = orig_suppress_printk;
   638	}
   639	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
