Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13DEB64DC
	for <linux-serial@archiver.kernel.org>; Fri, 21 Jul 2023 10:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGUKUS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Jul 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjGUKUB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jul 2023 06:20:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC926BB;
        Fri, 21 Jul 2023 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934757; x=1721470757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+9uKkW1652pdDtSIzAM6usspcByNon/2FVbDBvuETk=;
  b=L6WrUTEC40UXzZkXTiXcH9E8mA4o26x/IP+qxYK9/bfb0qNuDc6rP5vy
   YG2n0OK1K63VqGRW2Bx9+HzRbGXIta5zRmKQ+nbOfcmJuNnZFsjl6h4zY
   RvXlCVexGNnWJGybIy3p7DK534KS2a5gczsRW1/XhFs7+IGCZhloNHUd3
   4MqYUGD+02U+owklNlPqiJ0lsdll+3bGQyfZnrAM3uT9TklMz5+JfADq0
   SmEoMbCd4ISFua4pS86LT+mMQBeSB94vkdM5S7H1Js26Zahw/W0IAcifW
   Lae3QEHJjVvVU15sGw7MW8i5NVh/4p9SHRgHXnV/zvmymK7q68fDOCvRr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433219852"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433219852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848786377"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="848786377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 03:19:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMnE9-00HJWD-2u;
        Fri, 21 Jul 2023 13:19:13 +0300
Date:   Fri, 21 Jul 2023 13:19:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Message-ID: <ZLpboaXKVOOjeGJ+@smile.fi.intel.com>
References: <20230721072334.59272-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721072334.59272-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> list the recently added files. This makes it easier for get_maintainer.pl
> to include linux-serial for patches.

Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?

-- 
With Best Regards,
Andy Shevchenko


