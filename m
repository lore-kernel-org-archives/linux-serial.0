Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C94C6369E
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237F722253
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgKSOve (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:51:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:38827 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgKSOve (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 09:51:34 -0500
IronPort-SDR: bPuaDOTW7MqGwkw8Dp9LoQ5xk3lU/4g0+g31UGOOwFGCHfEiG/Ntt7kTycXKGxxF8G49mim5jD
 XPli0vpJqPFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167787841"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="gz'50?scan'50,208,50";a="167787841"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 06:51:33 -0800
IronPort-SDR: oCWcfG9a7uzLYgU4UXUToeIVlvrFuaRcYeUCkbkNxwP3OBJrXm/nCIzOWGOysd7Oqzo1OuIaww
 y180dtmtJ6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="gz'50?scan'50,208,50";a="311653937"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2020 06:51:31 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kflHX-00004A-0Z; Thu, 19 Nov 2020 14:51:31 +0000
Date:   Thu, 19 Nov 2020 22:51:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 16/72] drivers/tty/vt/keyboard.c:2037:13: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202011192222.ba4Rnptc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   660beb0ffdc9fc0695321dde5e115cd8cc384c94
commit: 07edff9265204e15c9fc8d07cc69e38c4c484e15 [16/72] vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
config: sh-randconfig-s031-20201109 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-123-g626c4742-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=07edff9265204e15c9fc8d07cc69e38c4c484e15
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-next
        git checkout 07edff9265204e15c9fc8d07cc69e38c4c484e15
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1745:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1745:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1745:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1745:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1783:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1783:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1783:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1783:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1783:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1783:21: sparse:     got unsigned int const *__gu_addr
>> drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
>> drivers/tty/vt/keyboard.c:2037:13: sparse:     expected unsigned char const *__gu_addr
>> drivers/tty/vt/keyboard.c:2037:13: sparse:     got unsigned char [noderef] __user *
>> drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/tty/vt/keyboard.c:2037:13: sparse:     expected void const volatile [noderef] __user *ptr
>> drivers/tty/vt/keyboard.c:2037:13: sparse:     got unsigned char const *__gu_addr

vim +2037 drivers/tty/vt/keyboard.c

  2020	
  2021	/* FIXME: This one needs untangling */
  2022	int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
  2023	{
  2024		char *kbs;
  2025		u_char *q;
  2026		int sz, fnw_sz;
  2027		int delta;
  2028		char *first_free, *fj, *fnw;
  2029		int j, k;
  2030		int ret;
  2031		unsigned long flags;
  2032		unsigned char kb_func;
  2033	
  2034		if (!capable(CAP_SYS_TTY_CONFIG))
  2035			perm = 0;
  2036	
> 2037		if (get_user(kb_func, &user_kdgkb->kb_func))
  2038			return -EFAULT;
  2039	
  2040		kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
  2041	
  2042		switch (cmd) {
  2043		case KDGKBSENT: {
  2044			/* size should have been a struct member */
  2045			ssize_t len = sizeof(user_kdgkb->kb_string);
  2046	
  2047			kbs = kmalloc(len, GFP_KERNEL);
  2048			if (!kbs)
  2049				return -ENOMEM;
  2050	
  2051			spin_lock_irqsave(&func_buf_lock, flags);
  2052			len = strlcpy(kbs, func_table[kb_func] ? : "", len);
  2053			spin_unlock_irqrestore(&func_buf_lock, flags);
  2054	
  2055			ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
  2056				-EFAULT : 0;
  2057	
  2058			goto reterr;
  2059		}
  2060		case KDSKBSENT:
  2061			if (!perm)
  2062				return -EPERM;
  2063	
  2064			kbs = strndup_user(user_kdgkb->kb_string,
  2065					sizeof(user_kdgkb->kb_string));
  2066			if (IS_ERR(kbs))
  2067				return PTR_ERR(kbs);
  2068	
  2069			fnw = NULL;
  2070			fnw_sz = 0;
  2071			/* race aginst other writers */
  2072			again:
  2073			spin_lock_irqsave(&func_buf_lock, flags);
  2074			q = func_table[kb_func];
  2075	
  2076			/* fj pointer to next entry after 'q' */
  2077			first_free = funcbufptr + (funcbufsize - funcbufleft);
  2078			for (j = kb_func + 1; j < MAX_NR_FUNC && !func_table[j]; j++)
  2079				;
  2080			if (j < MAX_NR_FUNC)
  2081				fj = func_table[j];
  2082			else
  2083				fj = first_free;
  2084			/* buffer usage increase by new entry */
  2085			delta = (q ? -strlen(q) : 1) + strlen(kbs);
  2086	
  2087			if (delta <= funcbufleft) { 	/* it fits in current buf */
  2088			    if (j < MAX_NR_FUNC) {
  2089				/* make enough space for new entry at 'fj' */
  2090				memmove(fj + delta, fj, first_free - fj);
  2091				for (k = j; k < MAX_NR_FUNC; k++)
  2092				    if (func_table[k])
  2093					func_table[k] += delta;
  2094			    }
  2095			    if (!q)
  2096			      func_table[kb_func] = fj;
  2097			    funcbufleft -= delta;
  2098			} else {			/* allocate a larger buffer */
  2099			    sz = 256;
  2100			    while (sz < funcbufsize - funcbufleft + delta)
  2101			      sz <<= 1;
  2102			    if (fnw_sz != sz) {
  2103			      spin_unlock_irqrestore(&func_buf_lock, flags);
  2104			      kfree(fnw);
  2105			      fnw = kmalloc(sz, GFP_KERNEL);
  2106			      fnw_sz = sz;
  2107			      if (!fnw) {
  2108				ret = -ENOMEM;
  2109				goto reterr;
  2110			      }
  2111			      goto again;
  2112			    }
  2113	
  2114			    if (!q)
  2115			      func_table[kb_func] = fj;
  2116			    /* copy data before insertion point to new location */
  2117			    if (fj > funcbufptr)
  2118				memmove(fnw, funcbufptr, fj - funcbufptr);
  2119			    for (k = 0; k < j; k++)
  2120			      if (func_table[k])
  2121				func_table[k] = fnw + (func_table[k] - funcbufptr);
  2122	
  2123			    /* copy data after insertion point to new location */
  2124			    if (first_free > fj) {
  2125				memmove(fnw + (fj - funcbufptr) + delta, fj, first_free - fj);
  2126				for (k = j; k < MAX_NR_FUNC; k++)
  2127				  if (func_table[k])
  2128				    func_table[k] = fnw + (func_table[k] - funcbufptr) + delta;
  2129			    }
  2130			    if (funcbufptr != func_buf)
  2131			      kfree(funcbufptr);
  2132			    funcbufptr = fnw;
  2133			    funcbufleft = funcbufleft - delta + sz - funcbufsize;
  2134			    funcbufsize = sz;
  2135			}
  2136			/* finally insert item itself */
  2137			strcpy(func_table[kb_func], kbs);
  2138			spin_unlock_irqrestore(&func_buf_lock, flags);
  2139			break;
  2140		}
  2141		ret = 0;
  2142	reterr:
  2143		kfree(kbs);
  2144		return ret;
  2145	}
  2146	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
