Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760A176AB5;
	Fri, 18 Oct 2024 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226230; cv=none; b=I1reBNQjbvZvCiBB9T+jcRt2SnV1tzc+rrjeJR2mSCwJB9U7DeFDoW3I3vKqcZQ0g/pSiCivlRV2jljk+NLuCN08fqeRXmJ8+FFczTsZZaQWuYVXbf0stO55gUyO5g5M28v/ZTCp9xy15tjdZKxXTp3sQDBCAPebm+AX2BKVUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226230; c=relaxed/simple;
	bh=U1fgLhH6lmdomPuzPUhhgaMswZjBn491Xqqurfw0z7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cko8iAiRR0l99ldPecypTFZPKB7Uq5JLCv3Khg2QGnbmpwB50KAbmKIrXiIN1T2p6ollf83f4ZJxZCTpxOb9pvejKJfztUH+3pHXX1by36SDKqWcGKd4vPHTFbiZhJ/yug/YHlA6Jcw+DJ2mPfRJneTUjyJUEKpGldm/DMUCRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/SDwm3A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/SDwm3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729226227; x=1760762227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1fgLhH6lmdomPuzPUhhgaMswZjBn491Xqqurfw0z7o=;
  b=A/SDwm3Aom81pH0hvNFoSZVpNdQr5rY/g/1SBExa1cFAM09MAXGIihUH
   u4AwPszTxX+P9TKdpFCC882i3TZ49Rr3aONXsFNIUUdbXLRCHQXfgABon
   iWUPvm4o7wB7ax/X500j/NRgPb1nRNR5t5oU8IzJzMb8K/EM20rGH0xOV
   BQ85dMV5Zgpxx0jkHeZcwzV887DOMd4s2Q3B12hsZlLbk/8WZe2rxPR3Q
   KQxrnYvNC8xXwB6GiLDP12AWX0EBgE4wYI0usziUoaEL9e/7kEOXSMGq9
   eojJhMsdfY/LeN+qZePt7Nw9SQ8NCCZX+gqeJMoXCnLYZ459BbiewfpXJ
   g==;
X-CSE-ConnectionGUID: eHivP1OSQICbO06CLktUnA==
X-CSE-MsgGUID: /BD00JnMTEqEYDk1WACUyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28875673"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28875673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:37:07 -0700
X-CSE-ConnectionGUID: 1rr+7d3USUqhm9O0KJNYpw==
X-CSE-MsgGUID: c2UWR/ciRdmAVsTJmFOJgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83394723"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 21:37:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1ejW-000NGr-1J;
	Fri, 18 Oct 2024 04:37:02 +0000
Date: Fri, 18 Oct 2024 12:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 2/2] tty: sysrq: Use printk_loud_console context on
 __handle_sysrq
Message-ID: <202410181205.VT06PKmP-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20241018 (https://download.01.org/0day-ci/archive/20241018/202410181205.VT06PKmP-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181205.VT06PKmP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181205.VT06PKmP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/sysrq.c:600:2: error: call to undeclared function 'printk_loud_console_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     600 |         printk_loud_console_enter();
         |         ^
>> drivers/tty/sysrq.c:610:4: error: call to undeclared function 'printk_loud_console_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     610 |                         printk_loud_console_exit();
         |                         ^
   drivers/tty/sysrq.c:614:4: error: call to undeclared function 'printk_loud_console_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     614 |                         printk_loud_console_exit();
         |                         ^
   drivers/tty/sysrq.c:632:3: error: call to undeclared function 'printk_loud_console_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     632 |                 printk_loud_console_exit();
         |                 ^
   4 errors generated.


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
