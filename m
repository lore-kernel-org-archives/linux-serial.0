Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F69C04A6A
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 05:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHDFia (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjHDFho (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 01:37:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C130C7
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691127456; x=1722663456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ATRg2I6YcJZHQvy/5TBYHzoe1vIGHoGn7h2QN9kKkSU=;
  b=Wdp0s1LJZHoHo+ju54xTqvDOBAdAiMWugd4iby/hAsM5mfw/t3nrly7D
   tOgK2BT5qAkWhM9cyuuwDkVaw0El5NqZdmNozTlWUZcRrqrX002+l5Yzz
   5OuJPPOyq2YO+sWEHdYFmE/iYqL3AkuQRyMeSsEr3K7tkxLWwon3QUO2N
   ZAVAryxwRklxxKjh0FXktgvAel3TGTDYcXeZrbTtmHpRQ6IrDLz+92nMI
   MEX21o/v0BgVzsJ1z8ZDivU2n15ugdX663dxG3cEoxUDaaD6xZgIKR7vE
   M2W2RQO8iBJaXIAf3e8KaUy/WFM1Jb4BoCVDvi1fsozvYIT+mBnCdE6yQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370060163"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370060163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723497911"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="723497911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 22:37:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnVE-00Bs1c-1g;
        Fri, 04 Aug 2023 08:37:32 +0300
Date:   Fri, 4 Aug 2023 08:37:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jorge.sanjuangarcia@duagon.com, JoseJavier.Rodriguez@duagon.com,
        yangyingliang@huawei.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH -next] 8250_men_mcb: Fix unsigned expression compared
 with zero
Message-ID: <ZMyOnBcbIDjNX4Aa@smile.fi.intel.com>
References: <20230803142053.1308926-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803142053.1308926-1-lizetao1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 03, 2023 at 10:20:53PM +0800, Li Zetao wrote:
> There is a warning reported by coccinelle:
> 
> ./drivers/tty/serial/8250/8250_men_mcb.c:226:6-19: WARNING:
> 	Unsigned expression compared with zero: data -> line [ i ]     <     0
> 
> The array "line" of serial_8250_men_mcb_data is used to record the
> registered serial port. When register a port failed, it will return
> an error code, but the type of "line" is "unsigned int", causing
> the error code to reverse. Modify the type of "data -> line" to solve
> this problem.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


