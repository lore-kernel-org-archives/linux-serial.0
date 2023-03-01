Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE37C64ED6
	for <linux-serial@archiver.kernel.org>; Wed,  1 Mar 2023 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCAPyJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCAPyH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Mar 2023 10:54:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190551421A;
        Wed,  1 Mar 2023 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677686046; x=1709222046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/3E+985G2xlfVmxTJTqoiIQoMhioWvxaN/4LFZsnAE=;
  b=G3Oj2+VURjK9fS5sMNK8k/EzCRCTw9DRrsQ82jz3p1+0CNWOZKmQTfZz
   0aA6IFyF+mVAnJl+9miIIU8xPpF/J4ql+Xk3YH9ag/ue5GPm2NYEKedMi
   FwtsE+QlQCRSK9Nj39AwgbsSEQXo2jmWpHW0jpr3gTPzEmFQnE6AobV+d
   NyXzxloGCk/JzMlKAccigbKeqRV5WbhLssaNKOjOJOxAdOprtM4um9ov+
   I1apKiQQXPMvzKkT6Nkj2+wnAN3NRRZ0Q4l5LGKUCrKQ2PhPuYgZSIJa1
   ty2rreCpYGi6QEClxpyx8U/ByjdjP5K8J2rBNXipgfOrIq0JW+g9Rh+ec
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334476125"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="334476125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="704884970"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="704884970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2023 07:53:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXOlG-00Dorb-2Z;
        Wed, 01 Mar 2023 17:52:58 +0200
Date:   Wed, 1 Mar 2023 17:52:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, deller@gmx.de,
        geert+renesas@glider.be, phil.edworthy@renesas.com,
        matthew.gerlach@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty-next] serial: 8250_pci1xxxx: Disable
 SERIAL_8250_PCI1XXXX config by default
Message-ID: <Y/902nTSA05VY3i5@smile.fi.intel.com>
References: <20230301100930.3519883-1-kumaravel.thiagarajan@microchip.com>
 <Y/82Ehzj2+FgIRh3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/82Ehzj2+FgIRh3@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 01, 2023 at 12:25:06PM +0100, Greg KH wrote:
> On Wed, Mar 01, 2023 at 03:39:30PM +0530, Kumaravel Thiagarajan wrote:
> > Disable SERIAL_8250_PCI1XXXX config by default
> 
> Why?
> 
> Please read the kernel documentation for how to write a good changelog
> text.

Kumaravel, hint for you: Take what Linus had written in the discussion of
Greg's pull request. It mainly explains it all.

> > Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> What commit id does this fix?

Another hint: this lacks so called Fixes tag. You may read about it in the
documentation.

-- 
With Best Regards,
Andy Shevchenko


