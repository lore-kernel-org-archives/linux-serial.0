Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B826282F34;
	Thu, 15 Oct 2026 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027569; cv=none; b=Aa+PYNgYgrwzM5n5rYPz2f4WunLmDdAYtSyIhxe0+qVUww4MF20PkMhHH8L8fFg2itaGxFb18EC5TcrtQB9a46y0qEoIbLI1HESwQO2gFHsu9ebdU2eyUmF1uH9nU8STeotkveglrly2VIdpt7XrbKYFFtQJYfhjtOBCMw5Aayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027569; c=relaxed/simple;
	bh=aARRQkKeZqCI8RoUsnyZ/pmuEQMAh/Nvzrz6WlyENj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXPnQIMo0tLhV4LWieolHKkRC1Co4oIzcFp2/M5yZbBFemL63+AQqnALV7S4cE3TGwBQWRv9Y4JZeftXgSJNxNJLt96AAZ1WZDgjmOlUZn6QiN4tGlRG1wbeVYwZBchMatUVtkBY66LmHAmATx7rlOOC4D33cfQjVEy+1oz7Z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlbsqdDY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlbsqdDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027568; x=1823563568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aARRQkKeZqCI8RoUsnyZ/pmuEQMAh/Nvzrz6WlyENj0=;
  b=hlbsqdDYy6x7cZhKfbCt1j3NsuBGMUt1ELOALhVsYfgBT0/K2KamhtRw
   WfB5DSn6GwwntVixs7FzIF4HnCau9H6yro8G9Cb7C+7xj+oCxkXfE/KjY
   Dq8X1Jtd9ASXKdpgQ/0xL8j6b48JFG71xH6bGWQyhY4La91h7IYraN7hN
   PWO2zxCpQok18zjxTHmZMjJ+Y/3tHT+zMvaHiToyLLXwhPANSI3xuBgwY
   bvLzaBwMS46tyqbBOeE6HD3Jnv/1ATMl6wmf3Uw2ysA4V2le7WRPVWEN9
   Ut16OO4mAMDsIiKM2gvzq06zli9dcO1e2Nv4HqarAVdv+SIxXDI4JgPXk
   g==;
X-CSE-ConnectionGUID: spX60e+PQnOE7UYn4BHRVw==
X-CSE-MsgGUID: pFj3lQ1/TyWny/OH7EO5fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="694767"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="694767"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:26:07 -0700
X-CSE-ConnectionGUID: sBsw+8WWRdeSx+jswklIyw==
X-CSE-MsgGUID: 4P0rxJFlQ9qBS2jErxIH1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1536954"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Oct 2026 18:26:04 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHAEL-00000000FUN-1kv7;
	Thu, 15 Oct 2026 01:26:01 +0000
Date: Thu, 15 Oct 2026 09:25:36 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Donald Shannon <donalds@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Message-ID: <202610150927.WhzTb6WS-lkp@intel.com>
References: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on bbf6b99a57b2479bf51c3c8ad0946f4b8c33ed69]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Ambrozewicz/dt-bindings-gpio-Add-NVIDIA-LSTP-GPIO/20261012-203559
base:   bbf6b99a57b2479bf51c3c8ad0946f4b8c33ed69
patch link:    https://lore.kernel.org/r/20261012-lstp-usb-adapter-v1-10-aambrozewicz%40nvidia.com
patch subject: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20261015/202610150927.WhzTb6WS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150927.WhzTb6WS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150927.WhzTb6WS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/lstp_tty.c:167:60: error: use of undeclared identifier 'B2500000'
     167 |                 { 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
         |                                                                          ^
>> drivers/tty/lstp_tty.c:168:14: error: use of undeclared identifier 'B3000000'
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                            ^
>> drivers/tty/lstp_tty.c:168:37: error: use of undeclared identifier 'B3500000'
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                                                   ^
>> drivers/tty/lstp_tty.c:168:60: error: use of undeclared identifier 'B4000000'
     168 |                 { 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
         |                                                                          ^
>> drivers/tty/lstp_tty.c:171:25: error: invalid application of 'sizeof' to an incomplete type 'const struct (unnamed struct at drivers/tty/lstp_tty.c:155:15)[]'
     171 |         for (size_t i = 0; i < ARRAY_SIZE(map); i++)
         |                                ^~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   5 errors generated.


vim +/B2500000 +167 drivers/tty/lstp_tty.c

   151	
   152	/* clang-format off */
   153	static speed_t lstp_baud_to_speed(u32 baud)
   154	{
   155		static const struct {
   156			u32     baud;
   157			speed_t speed;
   158		} map[] = {
   159			{      50, B50      }, {      75, B75      }, {     110, B110     },
   160			{     134, B134     }, {     150, B150     }, {     200, B200     },
   161			{     300, B300     }, {     600, B600     }, {    1200, B1200    },
   162			{    1800, B1800    }, {    2400, B2400    }, {    4800, B4800    },
   163			{    9600, B9600    }, {   19200, B19200   }, {   38400, B38400   },
   164			{   57600, B57600   }, {  115200, B115200  }, {  230400, B230400  },
   165			{  460800, B460800  }, {  500000, B500000  }, {  576000, B576000  },
   166			{  921600, B921600  }, { 1000000, B1000000 }, { 1152000, B1152000 },
 > 167			{ 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
 > 168			{ 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
   169		};
   170	
 > 171		for (size_t i = 0; i < ARRAY_SIZE(map); i++)
   172			if (map[i].baud == baud)
   173				return map[i].speed;
   174	
   175		return B0;
   176	}
   177	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
