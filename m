Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527223594A;
	Tue, 30 Sep 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263344; cv=none; b=VFBg+B4rQ8zFTpA+G5T3NAmS2hRNNZAHvHD9x4d+2e5W9p4rnOORxOlGLXWCbBNe+1p+JpKXY/jbKvu8VCob/EseJ6G679mCwby/Ic+fPKWBz2VEyRdrYuyzRI0R/BTuhyzYLx8ssI85fXY6CBeNedUNvXDFRTn1cLFJmE6wZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263344; c=relaxed/simple;
	bh=3x7jog6xs+wclsw8f6u6GaV72x3hAyzwQQtqOYgaEUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1xhrV8nJjn6ufY19yo6fAMsLnXASgDPx6I0LepBVjbJja6+au3HQ7ktu06yDQASbB5dQ7EhxH3MKkn81RgpOSsaMx+GGodsr81rzu75zMVhq/iOidGHjRYuzvmA95F29X6w/3R4WMFJwJ8/Djqw3V1MPbf6Ckanl8l7vMf7jLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUGjYF/Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUGjYF/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759263342; x=1790799342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3x7jog6xs+wclsw8f6u6GaV72x3hAyzwQQtqOYgaEUA=;
  b=JUGjYF/QeHVhMwvR3ZJME5UFNXhewp96pobwv+mz3MxG4TahbVa1O7BS
   m3xSy5r+GKs7YisO+MGdwTrUDQH4fNYx69dFDIorsEAUV6HNiDloMpBd9
   Nrq06otPEbPv+IqiD9xnIkfhjC92NWY57l4w0I7/LNNxLMhicmgax5LWk
   03ajH1YVXtrxIuJe/aX/13yUvp5YYSjOkg0lf2qJo0crdK4Uj7MuB6XXL
   7dN52uNL2Rj33Bbu86+JhSo83Q6mmNVaGgsGUuOp3M8wuNWLacAqPKF/K
   WPUiS8qkY2+NvpVssNA47qQh4Ge8OjBp0G4md7jSAtVYbYtzLRCXQPSQj
   Q==;
X-CSE-ConnectionGUID: bjKRMzWtRQ+h7FwxRCuRwg==
X-CSE-MsgGUID: 6AipJ7TVR860gHBJvozrAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79181965"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="79181965"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 13:15:41 -0700
X-CSE-ConnectionGUID: hfbcjST4T8a2+E5u67ptvw==
X-CSE-MsgGUID: w3tgJ9PbR+6tHH3YPTAhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182629826"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Sep 2025 13:15:37 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3gl4-0002Sd-0n;
	Tue, 30 Sep 2025 20:15:34 +0000
Date: Wed, 1 Oct 2025 04:15:20 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is
 in an emergency context
Message-ID: <202510010320.jV84a9vM-lkp@intel.com>
References: <20250926124912.243464-2-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926124912.243464-2-pmladek@suse.com>

Hi Petr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Mladek/printk-nbcon-Block-printk-kthreads-when-any-CPU-is-in-an-emergency-context/20250926-205414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250926124912.243464-2-pmladek%40suse.com
patch subject: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is in an emergency context
config: arc-randconfig-r131-20251001 (https://download.01.org/0day-ci/archive/20251001/202510010320.jV84a9vM-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251001/202510010320.jV84a9vM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510010320.jV84a9vM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/printk/nbcon.c:121:10: sparse: sparse: symbol 'nbcon_cpu_emergency_cnt' was not declared. Should it be static?

vim +/nbcon_cpu_emergency_cnt +121 kernel/printk/nbcon.c

     4	
     5	#include <linux/atomic.h>
     6	#include <linux/bug.h>
     7	#include <linux/console.h>
     8	#include <linux/delay.h>
     9	#include <linux/errno.h>
    10	#include <linux/export.h>
    11	#include <linux/init.h>
    12	#include <linux/irqflags.h>
    13	#include <linux/kthread.h>
    14	#include <linux/minmax.h>
    15	#include <linux/percpu.h>
    16	#include <linux/preempt.h>
    17	#include <linux/slab.h>
    18	#include <linux/smp.h>
    19	#include <linux/stddef.h>
    20	#include <linux/string.h>
    21	#include <linux/types.h>
    22	#include "internal.h"
    23	#include "printk_ringbuffer.h"
    24	/*
    25	 * Printk console printing implementation for consoles which does not depend
    26	 * on the legacy style console_lock mechanism.
    27	 *
    28	 * The state of the console is maintained in the "nbcon_state" atomic
    29	 * variable.
    30	 *
    31	 * The console is locked when:
    32	 *
    33	 *   - The 'prio' field contains the priority of the context that owns the
    34	 *     console. Only higher priority contexts are allowed to take over the
    35	 *     lock. A value of 0 (NBCON_PRIO_NONE) means the console is not locked.
    36	 *
    37	 *   - The 'cpu' field denotes on which CPU the console is locked. It is used
    38	 *     to prevent busy waiting on the same CPU. Also it informs the lock owner
    39	 *     that it has lost the lock in a more complex scenario when the lock was
    40	 *     taken over by a higher priority context, released, and taken on another
    41	 *     CPU with the same priority as the interrupted owner.
    42	 *
    43	 * The acquire mechanism uses a few more fields:
    44	 *
    45	 *   - The 'req_prio' field is used by the handover approach to make the
    46	 *     current owner aware that there is a context with a higher priority
    47	 *     waiting for the friendly handover.
    48	 *
    49	 *   - The 'unsafe' field allows to take over the console in a safe way in the
    50	 *     middle of emitting a message. The field is set only when accessing some
    51	 *     shared resources or when the console device is manipulated. It can be
    52	 *     cleared, for example, after emitting one character when the console
    53	 *     device is in a consistent state.
    54	 *
    55	 *   - The 'unsafe_takeover' field is set when a hostile takeover took the
    56	 *     console in an unsafe state. The console will stay in the unsafe state
    57	 *     until re-initialized.
    58	 *
    59	 * The acquire mechanism uses three approaches:
    60	 *
    61	 *   1) Direct acquire when the console is not owned or is owned by a lower
    62	 *      priority context and is in a safe state.
    63	 *
    64	 *   2) Friendly handover mechanism uses a request/grant handshake. It is used
    65	 *      when the current owner has lower priority and the console is in an
    66	 *      unsafe state.
    67	 *
    68	 *      The requesting context:
    69	 *
    70	 *        a) Sets its priority into the 'req_prio' field.
    71	 *
    72	 *        b) Waits (with a timeout) for the owning context to unlock the
    73	 *           console.
    74	 *
    75	 *        c) Takes the lock and clears the 'req_prio' field.
    76	 *
    77	 *      The owning context:
    78	 *
    79	 *        a) Observes the 'req_prio' field set on exit from the unsafe
    80	 *           console state.
    81	 *
    82	 *        b) Gives up console ownership by clearing the 'prio' field.
    83	 *
    84	 *   3) Unsafe hostile takeover allows to take over the lock even when the
    85	 *      console is an unsafe state. It is used only in panic() by the final
    86	 *      attempt to flush consoles in a try and hope mode.
    87	 *
    88	 *      Note that separate record buffers are used in panic(). As a result,
    89	 *      the messages can be read and formatted without any risk even after
    90	 *      using the hostile takeover in unsafe state.
    91	 *
    92	 * The release function simply clears the 'prio' field.
    93	 *
    94	 * All operations on @console::nbcon_state are atomic cmpxchg based to
    95	 * handle concurrency.
    96	 *
    97	 * The acquire/release functions implement only minimal policies:
    98	 *
    99	 *   - Preference for higher priority contexts.
   100	 *   - Protection of the panic CPU.
   101	 *
   102	 * All other policy decisions must be made at the call sites:
   103	 *
   104	 *   - What is marked as an unsafe section.
   105	 *   - Whether to spin-wait if there is already an owner and the console is
   106	 *     in an unsafe state.
   107	 *   - Whether to attempt an unsafe hostile takeover.
   108	 *
   109	 * The design allows to implement the well known:
   110	 *
   111	 *     acquire()
   112	 *     output_one_printk_record()
   113	 *     release()
   114	 *
   115	 * The output of one printk record might be interrupted with a higher priority
   116	 * context. The new owner is supposed to reprint the entire interrupted record
   117	 * from scratch.
   118	 */
   119	
   120	/* Counter of active nbcon emergency contexts. */
 > 121	atomic_t nbcon_cpu_emergency_cnt;
   122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
