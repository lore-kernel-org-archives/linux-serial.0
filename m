Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A19C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 14:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiFGOp1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbiFGOpG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 10:45:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D51433350
        for <linux-serial@vger.kernel.org>; Tue,  7 Jun 2022 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654613103; x=1686149103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fqk+TTEw8HThSSmeMKm+Uy2V47gx4k3BB22Tw6OyZLM=;
  b=gDns3L/F4P39y//aIxoQRu2Z3jG9DLg6evRfbZltSSJHiFCHH6WjmuY6
   /9An2uryC8lSQ0FVtre1kLpJctqjG6ji9NabVVtTxs5xizB5nN0GrHSQO
   YLEb9abhaN3254zLWTPkUg84trRgkhnyvQ3m8JJTTmgG1Iz7xwb93MS6M
   W38tfUEdHNxs7EMa3bTHnLyiR3RWnRcO4wAY3QH0siscezGhkA1pEnlCC
   on/2LUCqUSa4z0gzNm9sY/j6NFnVCWtrXUEhxSBMe4ZcQK2fRALKNie8C
   QUUwt2BVOdWf+EXGzsoS6rB4ZCK6pNiaR737xqjqQP80cjkbs851rAVBU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274260237"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274260237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:45:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="669998661"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:45:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyaS2-000VmA-R8;
        Tue, 07 Jun 2022 17:44:58 +0300
Date:   Tue, 7 Jun 2022 17:44:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/6] LSR flag preservation improvements
Message-ID: <Yp9kaoQyq91/lNhA@smile.fi.intel.com>
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 07, 2022 at 11:29:28AM +0300, Ilpo Järvinen wrote:
> Improve LSR flag preservation. Not all devices preserve all LSR flags
> on read. Therefore, the non-permanent flags must be stored until
> consumed. 8250_port has handled this for some of the reads (but not
> all). Drivers not so much but it's unclear to me which of the devices
> actually clear flags on read so this series only does per driver fixes
> for DW.
> 
> I've just put Uwe as Co-dev-by and SoB according to Andy's suggestion
> in order to allow forward progress (Uwe indicated he's OK with any
> sensible combination of tags anyway). I agree with Uwe's position
> though that it would be nice to be able to record Acked-by in some
> (probably quite rare) cases even if the person is already SoB but I
> don't want to keep dragging this issue on and on over a single line
> patch :-).
> 
> v2:
> - Added more patches
> 
> v3:
> - Fix Uwe's email and convert it to Co-developed-by

For the non-commented patches:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Ilpo Järvinen (6):
>   serial: 8250: Store to lsr_save_flags after lsr read
>   serial: 8250: Create serial_lsr_in()
>   serial: 8250: Get preserved flags using serial_lsr_in()
>   serial: 8250: Adjust misleading LSR related comment
>   serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()
>   serial: 8250_dw: Store LSR into lsr_saved_flags in
>     dw8250_tx_wait_empty()
> 
>  drivers/tty/serial/8250/8250.h      | 20 ++++++++++++++++++++
>  drivers/tty/serial/8250/8250_core.c |  3 +--
>  drivers/tty/serial/8250/8250_dw.c   |  7 +++++--
>  drivers/tty/serial/8250/8250_port.c | 24 +++++++++++-------------
>  4 files changed, 37 insertions(+), 17 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


