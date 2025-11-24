Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36823270ED7
	for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979964; cv=none; b=KBwy70getEuerBxbyzAXdVKbhjhvYXytgXZw8pPdJ2L+2+JMisREEYsCy+qJoVbevAnujPlmkU4etNogO3fOTTQOi6ZGYUcqmcT9X6ONHaC9ot734O97+VOccEmZvznWZVTkUpAdncpO8/1C/87bsEasMEpQpgAD2600J2Lcsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979964; c=relaxed/simple;
	bh=Wcgqb/bStxt0QivTfmpKbkj5LmEvovo7f5/zQ1a5Fws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0FdfSl6AmvEiBCZi5SqTeWAjUTXTh6nLLH4GiBK9EM5BnJJ01chQpSoxgSL3sCq7fsc7UcPVYVZ8Gzyp48hgHy4f0H4b/vKxDPXJ/067Zq7IURd/38UMcIqS2B7PxU2CPtjJ2+Yt6Zpwl8+dNGTOl9oPF5KH5PEGEk5nMI9ews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZb70UfH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZb70UfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763979962; x=1795515962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wcgqb/bStxt0QivTfmpKbkj5LmEvovo7f5/zQ1a5Fws=;
  b=EZb70UfHsqEV37EUO7MLVrXRYCjaGKTyK/64oHPjixpQkC6pPG4zGRfS
   3vpZBEpOBd9Vt/MKRGhfrkn21kcKhP7DawUMVdbhGXW0l08hX09cEUMRL
   PJ7e120J1pVsRsejG2TsLqtIz6zlbnSPJkA3Uttzh/fKsO2cry1+7K9i0
   8g0S+DKznYjGT28pyO57P/0/hP1w/oB4vDmVArKOvAwyDbDEOnlozWgWq
   6dYzQdgTXrKYFKUsvg15iRSlqvcjnhl58oyH3ZaxoIfhVLPPRFWwmiOTl
   0/Z1tFt8zipGQXJuMcVn4WCH6CU8cpMsnN5vg69e7uFxGQISnS7Zjo3YR
   w==;
X-CSE-ConnectionGUID: H858GaSwQtyikA8I1FRVQw==
X-CSE-MsgGUID: eBuJMMjBS/itSWW3d1PHpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91461576"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91461576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:26:01 -0800
X-CSE-ConnectionGUID: OUPtAsvWR7+4XxFqAluNyA==
X-CSE-MsgGUID: Va3ykgHoR7O0p+sequb97w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="229579446"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2025 02:26:00 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNTld-000000000bf-1mAG;
	Mon, 24 Nov 2025 10:25:57 +0000
Date: Mon, 24 Nov 2025 18:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 27/37] drivers/tty/vt/keyboard.c:1712:7: error: cannot
 jump from this asm goto statement to one of its possible targets
Message-ID: <202511241835.EA8lShgH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   da218406dd50e0ac96bb383de4edd208286efe70
commit: bfb24564b5fd8625ce5c007f274cabdc3b570969 [27/37] tty: vt/keyboard: use __free()
config: powerpc-randconfig-002-20251124 (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/vt/keyboard.c:1712:7: error: cannot jump from this asm goto statement to one of its possible targets
                   if (put_user(asize, &a->kb_cnt))
                       ^
   arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
                     __put_user(x, _pu_addr) : -EFAULT;                    \
                     ^
   arch/powerpc/include/asm/uaccess.h:49:3: note: expanded from macro '__put_user'
                   __put_user_size_goto(__pu_val, __pu_addr, __pu_size, __pu_failed);      \
                   ^
   arch/powerpc/include/asm/uaccess.h:127:10: note: expanded from macro '__put_user_size_goto'
           case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;        \
                   ^
   arch/powerpc/include/asm/uaccess.h:87:2: note: expanded from macro '__put_user_asm_goto'
           asm goto(                                       \
           ^
   drivers/tty/vt/keyboard.c:1736:7: note: possible target of asm goto statement
                   if (put_user(asize, &a->kb_cnt))
                       ^
   arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
                     __put_user(x, _pu_addr) : -EFAULT;                    \
                     ^
   arch/powerpc/include/asm/uaccess.h:53:9: note: expanded from macro '__put_user'
                                                                   \
                                                                   ^
   drivers/tty/vt/keyboard.c:1692:33: note: jump exits scope of variable with __attribute__((cleanup))
                   struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
                                                 ^
   drivers/tty/vt/keyboard.c:1722:23: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
                                       ^
   drivers/tty/vt/keyboard.c:1736:7: error: cannot jump from this asm goto statement to one of its possible targets
                   if (put_user(asize, &a->kb_cnt))
                       ^
   arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
                     __put_user(x, _pu_addr) : -EFAULT;                    \
                     ^
   arch/powerpc/include/asm/uaccess.h:49:3: note: expanded from macro '__put_user'
                   __put_user_size_goto(__pu_val, __pu_addr, __pu_size, __pu_failed);      \
                   ^
   arch/powerpc/include/asm/uaccess.h:127:10: note: expanded from macro '__put_user_size_goto'
           case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;        \
                   ^
   arch/powerpc/include/asm/uaccess.h:87:2: note: expanded from macro '__put_user_asm_goto'
           asm goto(                                       \
           ^
   drivers/tty/vt/keyboard.c:1712:7: note: possible target of asm goto statement
                   if (put_user(asize, &a->kb_cnt))
                       ^
   arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
                     __put_user(x, _pu_addr) : -EFAULT;                    \
                     ^
   arch/powerpc/include/asm/uaccess.h:53:9: note: expanded from macro '__put_user'
                                                                   \
                                                                   ^
   drivers/tty/vt/keyboard.c:1722:23: note: jump exits scope of variable with __attribute__((cleanup))
                   void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
                                       ^
   drivers/tty/vt/keyboard.c:1692:33: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
                                                 ^
   2 errors generated.


vim +1712 drivers/tty/vt/keyboard.c

247ff8e610cb63 Alan Cox              2012-02-24  1671  
247ff8e610cb63 Alan Cox              2012-02-24  1672  /**
247ff8e610cb63 Alan Cox              2012-02-24  1673   *	vt_do_diacrit		-	diacritical table updates
247ff8e610cb63 Alan Cox              2012-02-24  1674   *	@cmd: ioctl request
9d329c1c68d2cc Mark Rustad           2014-09-05  1675   *	@udp: pointer to user data for ioctl
247ff8e610cb63 Alan Cox              2012-02-24  1676   *	@perm: permissions check computed by caller
247ff8e610cb63 Alan Cox              2012-02-24  1677   *
247ff8e610cb63 Alan Cox              2012-02-24  1678   *	Update the diacritical tables atomically and safely. Lock them
247ff8e610cb63 Alan Cox              2012-02-24  1679   *	against simultaneous keypresses
247ff8e610cb63 Alan Cox              2012-02-24  1680   */
9d329c1c68d2cc Mark Rustad           2014-09-05  1681  int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
247ff8e610cb63 Alan Cox              2012-02-24  1682  {
247ff8e610cb63 Alan Cox              2012-02-24  1683  	unsigned long flags;
247ff8e610cb63 Alan Cox              2012-02-24  1684  	int asize;
247ff8e610cb63 Alan Cox              2012-02-24  1685  
247ff8e610cb63 Alan Cox              2012-02-24  1686  	switch (cmd) {
247ff8e610cb63 Alan Cox              2012-02-24  1687  	case KDGKBDIACR:
247ff8e610cb63 Alan Cox              2012-02-24  1688  	{
9d329c1c68d2cc Mark Rustad           2014-09-05  1689  		struct kbdiacrs __user *a = udp;
247ff8e610cb63 Alan Cox              2012-02-24  1690  		int i;
247ff8e610cb63 Alan Cox              2012-02-24  1691  
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1692) 		struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
247ff8e610cb63 Alan Cox              2012-02-24  1693  								  GFP_KERNEL);
9d329c1c68d2cc Mark Rustad           2014-09-05  1694  		if (!dia)
247ff8e610cb63 Alan Cox              2012-02-24  1695  			return -ENOMEM;
247ff8e610cb63 Alan Cox              2012-02-24  1696  
247ff8e610cb63 Alan Cox              2012-02-24  1697  		/* Lock the diacriticals table, make a copy and then
247ff8e610cb63 Alan Cox              2012-02-24  1698  		   copy it after we unlock */
247ff8e610cb63 Alan Cox              2012-02-24  1699  		spin_lock_irqsave(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1700  
247ff8e610cb63 Alan Cox              2012-02-24  1701  		asize = accent_table_size;
247ff8e610cb63 Alan Cox              2012-02-24  1702  		for (i = 0; i < asize; i++) {
9d329c1c68d2cc Mark Rustad           2014-09-05  1703  			dia[i].diacr = conv_uni_to_8bit(
247ff8e610cb63 Alan Cox              2012-02-24  1704  						accent_table[i].diacr);
9d329c1c68d2cc Mark Rustad           2014-09-05  1705  			dia[i].base = conv_uni_to_8bit(
247ff8e610cb63 Alan Cox              2012-02-24  1706  						accent_table[i].base);
9d329c1c68d2cc Mark Rustad           2014-09-05  1707  			dia[i].result = conv_uni_to_8bit(
247ff8e610cb63 Alan Cox              2012-02-24  1708  						accent_table[i].result);
247ff8e610cb63 Alan Cox              2012-02-24  1709  		}
247ff8e610cb63 Alan Cox              2012-02-24  1710  		spin_unlock_irqrestore(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1711  
247ff8e610cb63 Alan Cox              2012-02-24 @1712  		if (put_user(asize, &a->kb_cnt))
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1713) 			return -EFAULT;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1714) 		if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1715) 			return -EFAULT;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1716) 		return 0;
247ff8e610cb63 Alan Cox              2012-02-24  1717  	}
247ff8e610cb63 Alan Cox              2012-02-24  1718  	case KDGKBDIACRUC:
247ff8e610cb63 Alan Cox              2012-02-24  1719  	{
9d329c1c68d2cc Mark Rustad           2014-09-05  1720  		struct kbdiacrsuc __user *a = udp;
247ff8e610cb63 Alan Cox              2012-02-24  1721  
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1722) 		void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
247ff8e610cb63 Alan Cox              2012-02-24  1723  							GFP_KERNEL);
247ff8e610cb63 Alan Cox              2012-02-24  1724  		if (buf == NULL)
247ff8e610cb63 Alan Cox              2012-02-24  1725  			return -ENOMEM;
247ff8e610cb63 Alan Cox              2012-02-24  1726  
247ff8e610cb63 Alan Cox              2012-02-24  1727  		/* Lock the diacriticals table, make a copy and then
247ff8e610cb63 Alan Cox              2012-02-24  1728  		   copy it after we unlock */
247ff8e610cb63 Alan Cox              2012-02-24  1729  		spin_lock_irqsave(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1730  
247ff8e610cb63 Alan Cox              2012-02-24  1731  		asize = accent_table_size;
247ff8e610cb63 Alan Cox              2012-02-24  1732  		memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
247ff8e610cb63 Alan Cox              2012-02-24  1733  
247ff8e610cb63 Alan Cox              2012-02-24  1734  		spin_unlock_irqrestore(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1735  
247ff8e610cb63 Alan Cox              2012-02-24  1736  		if (put_user(asize, &a->kb_cnt))
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1737) 			return -EFAULT;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1738) 		if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1739) 			return -EFAULT;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1740) 
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1741) 		return 0;
247ff8e610cb63 Alan Cox              2012-02-24  1742  	}
247ff8e610cb63 Alan Cox              2012-02-24  1743  
247ff8e610cb63 Alan Cox              2012-02-24  1744  	case KDSKBDIACR:
247ff8e610cb63 Alan Cox              2012-02-24  1745  	{
9d329c1c68d2cc Mark Rustad           2014-09-05  1746  		struct kbdiacrs __user *a = udp;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1747) 		struct kbdiacr __free(kfree) *dia = NULL;
247ff8e610cb63 Alan Cox              2012-02-24  1748  		unsigned int ct;
247ff8e610cb63 Alan Cox              2012-02-24  1749  		int i;
247ff8e610cb63 Alan Cox              2012-02-24  1750  
247ff8e610cb63 Alan Cox              2012-02-24  1751  		if (!perm)
247ff8e610cb63 Alan Cox              2012-02-24  1752  			return -EPERM;
247ff8e610cb63 Alan Cox              2012-02-24  1753  		if (get_user(ct, &a->kb_cnt))
247ff8e610cb63 Alan Cox              2012-02-24  1754  			return -EFAULT;
247ff8e610cb63 Alan Cox              2012-02-24  1755  		if (ct >= MAX_DIACR)
247ff8e610cb63 Alan Cox              2012-02-24  1756  			return -EINVAL;
247ff8e610cb63 Alan Cox              2012-02-24  1757  
247ff8e610cb63 Alan Cox              2012-02-24  1758  		if (ct) {
e651faa2fba4d3 Philipp Stanner       2023-11-03  1759  			dia = memdup_array_user(a->kbdiacr,
e651faa2fba4d3 Philipp Stanner       2023-11-03  1760  						ct, sizeof(struct kbdiacr));
1051937d465665 Saurabh Sengar        2015-10-28  1761  			if (IS_ERR(dia))
1051937d465665 Saurabh Sengar        2015-10-28  1762  				return PTR_ERR(dia);
247ff8e610cb63 Alan Cox              2012-02-24  1763  		}
247ff8e610cb63 Alan Cox              2012-02-24  1764  
247ff8e610cb63 Alan Cox              2012-02-24  1765  		spin_lock_irqsave(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1766  		accent_table_size = ct;
247ff8e610cb63 Alan Cox              2012-02-24  1767  		for (i = 0; i < ct; i++) {
247ff8e610cb63 Alan Cox              2012-02-24  1768  			accent_table[i].diacr =
9d329c1c68d2cc Mark Rustad           2014-09-05  1769  					conv_8bit_to_uni(dia[i].diacr);
247ff8e610cb63 Alan Cox              2012-02-24  1770  			accent_table[i].base =
9d329c1c68d2cc Mark Rustad           2014-09-05  1771  					conv_8bit_to_uni(dia[i].base);
247ff8e610cb63 Alan Cox              2012-02-24  1772  			accent_table[i].result =
9d329c1c68d2cc Mark Rustad           2014-09-05  1773  					conv_8bit_to_uni(dia[i].result);
247ff8e610cb63 Alan Cox              2012-02-24  1774  		}
247ff8e610cb63 Alan Cox              2012-02-24  1775  		spin_unlock_irqrestore(&kbd_event_lock, flags);
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1776) 
247ff8e610cb63 Alan Cox              2012-02-24  1777  		return 0;
247ff8e610cb63 Alan Cox              2012-02-24  1778  	}
247ff8e610cb63 Alan Cox              2012-02-24  1779  
247ff8e610cb63 Alan Cox              2012-02-24  1780  	case KDSKBDIACRUC:
247ff8e610cb63 Alan Cox              2012-02-24  1781  	{
9d329c1c68d2cc Mark Rustad           2014-09-05  1782  		struct kbdiacrsuc __user *a = udp;
247ff8e610cb63 Alan Cox              2012-02-24  1783  		unsigned int ct;
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1784) 		void __free(kfree) *buf = NULL;
247ff8e610cb63 Alan Cox              2012-02-24  1785  
247ff8e610cb63 Alan Cox              2012-02-24  1786  		if (!perm)
247ff8e610cb63 Alan Cox              2012-02-24  1787  			return -EPERM;
247ff8e610cb63 Alan Cox              2012-02-24  1788  
247ff8e610cb63 Alan Cox              2012-02-24  1789  		if (get_user(ct, &a->kb_cnt))
247ff8e610cb63 Alan Cox              2012-02-24  1790  			return -EFAULT;
247ff8e610cb63 Alan Cox              2012-02-24  1791  
247ff8e610cb63 Alan Cox              2012-02-24  1792  		if (ct >= MAX_DIACR)
247ff8e610cb63 Alan Cox              2012-02-24  1793  			return -EINVAL;
247ff8e610cb63 Alan Cox              2012-02-24  1794  
247ff8e610cb63 Alan Cox              2012-02-24  1795  		if (ct) {
e651faa2fba4d3 Philipp Stanner       2023-11-03  1796  			buf = memdup_array_user(a->kbdiacruc,
e651faa2fba4d3 Philipp Stanner       2023-11-03  1797  						ct, sizeof(struct kbdiacruc));
9b6519009dbe2b Muhammad Falak R Wani 2016-05-20  1798  			if (IS_ERR(buf))
9b6519009dbe2b Muhammad Falak R Wani 2016-05-20  1799  				return PTR_ERR(buf);
247ff8e610cb63 Alan Cox              2012-02-24  1800  		} 
247ff8e610cb63 Alan Cox              2012-02-24  1801  		spin_lock_irqsave(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1802  		if (ct)
247ff8e610cb63 Alan Cox              2012-02-24  1803  			memcpy(accent_table, buf,
247ff8e610cb63 Alan Cox              2012-02-24  1804  					ct * sizeof(struct kbdiacruc));
247ff8e610cb63 Alan Cox              2012-02-24  1805  		accent_table_size = ct;
247ff8e610cb63 Alan Cox              2012-02-24  1806  		spin_unlock_irqrestore(&kbd_event_lock, flags);
247ff8e610cb63 Alan Cox              2012-02-24  1807  		return 0;
247ff8e610cb63 Alan Cox              2012-02-24  1808  	}
247ff8e610cb63 Alan Cox              2012-02-24  1809  	}
bfb24564b5fd86 Jiri Slaby (SUSE      2025-11-19  1810) 	return 0;
247ff8e610cb63 Alan Cox              2012-02-24  1811  }
079c9534a96da9 Alan Cox              2012-02-28  1812  

:::::: The code at line 1712 was first introduced by commit
:::::: 247ff8e610cb63c015de19191db9666754c2ed79 vt: lock the accent table

:::::: TO: Alan Cox <alan@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
