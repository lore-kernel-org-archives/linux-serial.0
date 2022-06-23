Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA92C43334
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jun 2022 16:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiFWQZW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiFWQZS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jun 2022 12:25:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC0C46CBF;
        Thu, 23 Jun 2022 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656001515; x=1687537515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YBcyDm3+c63sXYAdzt+59szqAftpblBOv3+86OdD4RA=;
  b=XHJYgpf/yfI3tJuogK4n2XuPtBS8UROwjEN/04HUUrO4L6pR6v9R4wDR
   GQmnTrDdl/9Oo/B7UpLrQLFYuqfXKAbBlDk1ys5I6dwsgollfsZg/MXRG
   RYn7q3JYnWzNrnOsinRFE8ztMiWuU3WtNRbOGEn+p8Km4w5Ijt+aFuOnB
   ooKeMUpuG5IjrPYGTqUq9asKZb8UEzl3SgLWpbsYu7OqHW7yxL4hwAT24
   qdoV7c0X5cljqVCW5bj4DGQTmstccCL29qX4D05FVh5GLXudbTpZllDnL
   ZtY5fNA3bIsh+rFvpJjh7lmydoMFxbrJbg7GVnJEfQSb6eOnv9zTFMsE2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280814532"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="280814532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:25:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="691094949"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:25:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o4Pdj-000tCq-Le;
        Thu, 23 Jun 2022 19:25:07 +0300
Date:   Thu, 23 Jun 2022 19:25:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 3/8] serial: core: move sanitizing of RS485 delays into
 own function
Message-ID: <YrST4zDJjSo5aNZh@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-4-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622154659.8710-4-LinoSanfilippo@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jun 22, 2022 at 05:46:54PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Move the sanitizing of RS485 delays out of uart_sanitize_serial_rs485()
> into the new function uart_sanitize_serial_rs485_delays().

...

> +	/* pick sane settings if the user hasn't */

Be consistent with the style (capitalization) of one-line comments. It might
require another patch to make it all consistent.

(Below is left for a context)

>  	/* Return clean padding area to userspace */

-- 
With Best Regards,
Andy Shevchenko


