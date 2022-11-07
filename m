Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0A5C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKGLc4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 06:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGLcz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 06:32:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF551A066;
        Mon,  7 Nov 2022 03:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820774; x=1699356774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=odzs7zeOOpfUhcx0bV+2S53eN2Moo+JLWp6BFvbr59g=;
  b=OMwBPNugYqiIMnr6U8ZlxjCCVfrOsnNvcRWlS66cJUEvFmUGpM1bXtxU
   Ww21I9P3Tp44viTrko9XlG3xCdB2tArQKz9nkJQ1GC2nc6tbC02fs+J0J
   6D5LT5VHVLzw6FD9PGsNIZPic6b3xETAjPgj36BBUc4GFPpe7jL61mCqy
   MAWhHjbrmcotiPPUNZZ6VTyoj++k/zCpN9V9S9/LkctaMZZgyVIvznzcJ
   Av1WWeYAe+N3GgWFsVbyQ12xCZjHjkZtoLUvQa9OiWx1c+EUY1QqhAYb9
   23mzI3NZfIwSf/mRX1xik1WmFkLHrGAarczSLobfjoVs6l9Hz+VlyizUe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290112012"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290112012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="667141114"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="667141114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 03:32:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0Mv-008bqi-1f;
        Mon, 07 Nov 2022 13:32:45 +0200
Date:   Mon, 7 Nov 2022 13:32:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] 8250: DMA Fixes
Message-ID: <Y2js3Xsq1Fmz1mTq@smile.fi.intel.com>
References: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 07, 2022 at 01:07:04PM +0200, Ilpo Järvinen wrote:
> Here are a number of 8250 DMA related fixes. The last one seems the
> most serious problem able to corrupt the payload ordering.
> 
> Ilpo Järvinen (4):
>   serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs

8250_port?

>   serial: 8250_lpss: Configure DMA also w/o DMA filter
>   serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
>   serial: 8250: Flush DMA Rx on RLSI

8250_port?

> 
>  drivers/tty/serial/8250/8250_lpss.c | 18 +++++++++++++-----
>  drivers/tty/serial/8250/8250_port.c |  7 +++++--
>  2 files changed, 18 insertions(+), 7 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


