Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F29C6FA91
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 10:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIWK3O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIWK2x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Sep 2022 06:28:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98AA128A37;
        Fri, 23 Sep 2022 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663928928; x=1695464928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZsIBuKNgLub+auoIS69rq+B1ncorMSEq0WWo4jjZ2c=;
  b=CNbqh7rBMzULRwx+JWwBDrmdeR02ed+Yj65XB5l0Ihs7E6aQMvrKbzBn
   wV7YFFvdArnrvZGLLX2KbFVLiJ4J283EZITY5jmpscCO/zAApJX6QmDbS
   PAjXbFUeuA7LVx57L3fRTPoy4CeEWnZu0s0gWoyIidYFifEycCvkHqnuw
   3VXj8FiQdgXzTOVgWsQmNdLN9X73iApfB/eoBjaCGwCnx9/LfuEx2DW8H
   npoQxSTrCOtRrMXMXLMGsyy7UV1RBSYmACLzResIzWMnm7bIcZdy+0r1u
   JM6uwnFtzJby/iFLpUGwmzRyBOmNMtPVVkTb3/VOiFQR7ADHTp5YBXz2Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="302010087"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="302010087"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948974907"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 03:28:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obfvJ-0005Zk-01;
        Fri, 23 Sep 2022 10:28:45 +0000
Date:   Fri, 23 Sep 2022 18:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [tty:tty-next 37/45] htmldocs: Warning: MAINTAINERS references a
 file that doesn't exist:
 Documentation/devicetree/bindings/mfd/atmel-usart.txt
Message-ID: <202209231815.jXlxs0vj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   adafbbf6895eb0ce41a313c6ee68870ab9aa93cd
commit: b9e947fbf008769ffda1028f627d604757e62265 [37/45] dt-bindings: serial: atmel,at91-usart: convert to json-schema
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=b9e947fbf008769ffda1028f627d604757e62265
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-next
        git checkout b9e947fbf008769ffda1028f627d604757e62265
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mfd/atmel-usart.txt

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
