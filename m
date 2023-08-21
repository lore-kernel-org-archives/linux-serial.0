Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A0EE4993
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 08:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjHUIWy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjHUIWx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 04:22:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD0A6;
        Mon, 21 Aug 2023 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606172; x=1724142172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MF+K5FtXhd2Nh8bzUxYkefoqtCY3roUh0+Vuw+iDpQM=;
  b=XOvW55/yMP4Gp9ZNoQu1YXlqtsTT3eVKjDOyHYcauOii2Lp1ksqX9/4A
   SWgmPbDYO4SH8G2SRPYihZ0DbRRyZH1XTdvr0kkQD6oSIeyF0BdL/6Orm
   aNfOmbE1QnG7+KCcanWs7Eo6rPbSoxlzyWeYGpUgS4yufuuPFn8Ma0cEz
   88SI7SEvAKVrFmw8mzhzrFP+d+zpcFNbX/E72ng9bLPbt19Z9bzN8eW0+
   9zKBT68UNRxKWKgmnovFccUajmUsKrMuuxBbSXgZH1L164KF1Nm4vzg2R
   HDOFlFPVL3hCK1U6OM50hy0RJnFWDYD3KvNaa0ULbtMuGOLSiuGL7uzws
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="459896175"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="459896175"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="850097931"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="850097931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2023 01:22:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0BV-005SOm-0m;
        Mon, 21 Aug 2023 11:22:49 +0300
Date:   Mon, 21 Aug 2023 11:22:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <ZOMe2NIMp+a8ShsX@smile.fi.intel.com>
References: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 18, 2023 at 02:12:29PM +0300, Andy Shevchenko wrote:
> For the last couple of years Linux kernel got rid of a few architectures
> and many platforms. Hence some PORT_* definitions in the serial_core.h
> become unused and redundant. Remove them for good.

Below are results via Debian Code Search.

Note, I excluded Linux kernel itself from the "user" and Hurd, which seems
to have Linux kernel v2.6 which is _provider_ of the definition(s).

...

> -#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */

ifdeffed, safe to remove.

> -#define PORT_S3C2410    55
> -#define PORT_LH7A40X	57
> -#define PORT_S3C2440	61
> -#define PORT_MPSC	63
> -#define PORT_S3C2400	67
> -#define PORT_M32R_SIO	68
> -#define PORT_S3C2412	73
> -#define PORT_BFIN	75
> -#define PORT_BFIN_SPORT		79
> -#define PORT_MN10300		80
> -#define PORT_MN10300_CTS	81
> -#define PORT_NWPSERIAL	85
> -#define PORT_TILEGX	106
> -#define PORT_CRIS	112

Unused.

-- 
With Best Regards,
Andy Shevchenko


