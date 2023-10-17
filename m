Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C279CDB465
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 02:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjJQC7w (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 22:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjJQC7v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 22:59:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EB93
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697511590; x=1729047590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AmfMhTo9RynZx1wSLsz1oLYkq65cA39gkWfkYPS8GmA=;
  b=R9N5sBVanPYrWzliQIqhsbGdoXzN+Ibj4iGRs3ruA1vPQCKjcgalXMGH
   LT17ff3sF247tMq6duohxyOD+L7VxsOrbVlSCOvg6UVtKhUv9EA+afeCs
   Kq7b3zjU+2nmXg/2CEn7vi8bqlCkMW9ufyo6z/ANqtpi/y8xyKLggSqsi
   3JldOwaB4MpdhOWFXkPRIvBBSOL4BfqTDFLoig8j/icrrBZTfuWYxgXdK
   H0hLfvcYKSVmkFhMkpS2WGaBELq/6wbgIR54vJr2pCFcJJEjUJsgj4MJ1
   2e0rD2yUtLeyU+ZIUd00iDUoWUvzoPOJTnxNutx61vsZwpjUikqsD6QDp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7252119"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="7252119"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 19:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821794627"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="821794627"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2023 19:59:47 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsaJ7-0008tv-1f;
        Tue, 17 Oct 2023 02:59:45 +0000
Date:   Tue, 17 Oct 2023 10:58:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [tty:tty-testing 22/24] efi.c:undefined reference to `screen_info'
Message-ID: <202310171049.aNxOKhUY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   6271f1e8c4cb9a46273ae01ff9cb86a022063f75
commit: 934d62223da320b3ec012c85b63a6c250f507096 [22/24] efi: move screen_info into efi init code
config: loongarch-randconfig-001-20231017 (https://download.01.org/0day-ci/archive/20231017/202310171049.aNxOKhUY-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171049.aNxOKhUY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171049.aNxOKhUY-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: arch/loongarch/kernel/efi.o: in function `.L6':
>> efi.c:(.init.text+0x1ac): undefined reference to `screen_info'
>> loongarch64-linux-ld: efi.c:(.init.text+0x1b0): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/sysfb.o: in function `.L2':
>> sysfb.c:(.init.text+0x60): undefined reference to `screen_info'
>> loongarch64-linux-ld: sysfb.c:(.init.text+0x68): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/sysfb.o: in function `.L7':
   sysfb.c:(.init.text+0x74): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/sysfb.o:sysfb.c:(.init.text+0x78): more undefined references to `screen_info' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
