Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B7BCA0FE1
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 22:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjHaXAB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHaXAB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 19:00:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D182CF
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 15:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693522798; x=1725058798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WpY7rCoBEb6m/F2I1fg/T/dfO9hGr+cNgbuGsfrXfEQ=;
  b=D0IJkPyhEhPUdFOU56z8oXvNqwDT4Ovr+OFUPNtbIrdJF5e4Tfw6eD1Q
   pTglBHKpDYWU6JlLCnQ35itFV9gr+APMXoxVaYzAWFxLBjLwr2A2Zbufc
   UvdrrMbXbIjCiyAe8eUWAHc8njrhpEaW0/OlByD05E8ySBZXj26P+N7R3
   7mUNRXPeh4nrB+oW4bcbjVpv+afsB5As2npaONouVFLs9H5kSgdnwzrpS
   BZt9FJwx9FXm/k++jNrHBnuAB6JNTJ2xZy2yIJOjkrTODzn14KhWiuVdh
   XEExKC+1vxCT6ZqxkbfjqTFiIBmarHo8dKt1SlXCT5OJyIlBoHza4KK9n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356401033"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="356401033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829897232"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="829897232"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:59:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbqdl-005WX3-1T;
        Fri, 01 Sep 2023 01:59:53 +0300
Date:   Fri, 1 Sep 2023 01:59:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <ZPEbacIuZv+116AE@smile.fi.intel.com>
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
 <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 31, 2023 at 12:33:33PM -0600, Dan Raymond wrote:
> On 8/31/2023 12:08 PM, Andy Shevchenko wrote:
> > Warning: This email is from an unusual correspondent.
> > Warning: Make sure this is someone you trust.
> > 
> > On Thu, Aug 24, 2023 at 02:59:01PM -0600, Dan Raymond wrote:
> >> Implement a UART register tracing facility using the debugfs.  This can be
> >> used as a "serial port sniffer" to monitor UART traffic and line settings
> >> with timestamps at microsecond granularity.  This can be useful for general
> >> serial port debugging or to debug the UART driver itself.
> > 
> >>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
> > 
> > My gosh. Why trace points and trace events can't be used for that?
> 
> I don't understand your post.  Are you saying there is already a way to
> trace UART register reads/writes without this patch? Can you elaborate?

Besides what Greg an I were telling you (another type of infrastructure),
as a matter of fact you may trace any IO on some architectures (at least x86),
it's called mmiotracer (I have used it like 5 years ago or so to trace UART).

Below is the excerpt from my old shell script

rebind() {
	local drvdir="/sys/bus/$1/drivers/$2"
	local devdir="/sys/bus/$1/devices/$3"
	[ -d "$drvdir" -a -d "$devdir" ] || return
	echo "$3" > "$drvdir/unbind"
	echo "$3" > "$drvdir/bind"
}

mmiotrace() {
	echo mmiotrace > /sys/kernel/tracing/current_tracer
	echo 1 > /sys/kernel/tracing/tracing_on

	rebind platform 'dw-apb-uart'   '80860F0A:00'   # BYT ttyS1 (ACPI)
	rebind platform 'dw-apb-uart'   '8086228A:00'   # BSW ttyS1 (ACPI)
	rebind pci      '8250_mid'      '0000:00:04.2'  # Edison ttyS1
	rebind pci      'intel-lpss'    '0000:00:18.1'  # BXT LH ttyS1
	rebind pci      'intel-lpss'    '0000:00:1e.0'  # SKL ttyS1
	rebind pci      '8250_lpss'     '0000:00:1e.3'  # BSW ttyS1 (PCI)
}


-- 
With Best Regards,
Andy Shevchenko


