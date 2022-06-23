Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4FCCA47C
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jun 2022 16:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiFWQ3d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiFWQ3a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jun 2022 12:29:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72446B3E;
        Thu, 23 Jun 2022 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656001769; x=1687537769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shSMQSjp0om7znr1pZFQg0KFLkYI8bsl3XjfCXpVkk4=;
  b=ir7TMXTJtFrLNXMajO3vlX2ht+HQ/kPoPEGb2QdrPnw5nLtwvn+azo7h
   wyIqygesm+fPIWx8fLtug5WBCirk80rR4un6FiU73ws7Hqh1fFrBXY0Kb
   v61t34HAvReWFhkTieNuAV7wH5sy3oKuNNkV0TZJwyhif+1b8Rt73jvY0
   D5laRS5AUx/8EFNaI/PF3Z/+P+Z/wI1pBMnG7UaVQfT990qsXMAdgagmG
   9YOu5HlWCVt73bpzOkbJQKq6zplmebH8+p22j5o/Pb7knICy2gxhX6N4W
   P+g2PvWIY5mlK3+MLS/vQX+Rs5Jkv0XZMsPU5xdH5Jy3d7vpTyDVl/22f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281498539"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="281498539"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:29:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="615634196"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:29:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o4Php-000tCz-QO;
        Thu, 23 Jun 2022 19:29:21 +0300
Date:   Thu, 23 Jun 2022 19:29:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
Message-ID: <YrSU4eL9hgISg3Y1@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-6-LinoSanfilippo@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The maximum allowed delay for RTS before and RTS after send is 100 ms.
> Adjust the documentation accordingly.


Is it only documentation issue? If the code allows this to be set higher
than 100, we may not change the documentation since this an ABI (from
firmware <--> kernel perspective) we need to support old variants.

If the above is true and limit is dictated by the spec, we may issue a
warning in the code and drop it to the allowed maximum, otherwise we
can't do much here.

-- 
With Best Regards,
Andy Shevchenko


