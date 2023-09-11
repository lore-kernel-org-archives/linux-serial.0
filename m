Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D5CA0EC7
	for <linux-serial@archiver.kernel.org>; Tue, 12 Sep 2023 00:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjILA6y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjILA6u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 20:58:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B31F4C9C
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694474457; x=1726010457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8uYbImBu2ebl3N9iziigCi/avdQEHta2la3g104smQw=;
  b=inmOCzQLaNC9B/HPn4Z9FWTBLZef9Qij43kGO33uUDZibuu170/VQaea
   kEYdGIqXwdsRKsrsz6XzV41lrEmYynPAJE0MA8SfWcRLZ2OJ1l2KxgiCx
   D9w3ChOWn+TBwJ+d7M/MD7bwp36vjo6t5WpwYkzI4rsaR7DoJDskzKl/2
   JXjECRj+7CkdIUwh8sCr6dfLYkzf/y+Kr0Z8pTWyEKUDGWLUajW2Zg7Vz
   H4nzi8Pv4OceD1zHrDPq5cS/BWu27FNFynAqyZapxx3rbH7TMwazpsiEP
   MMYPF8B96g9uH7EhhQsCSD3IjLmWXW1KzIKeovgREv2XNnk1vDzmBryu2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444660098"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444660098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778564151"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="778564151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 15:53:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qfpmq-008RRZ-2u;
        Tue, 12 Sep 2023 01:53:44 +0300
Date:   Tue, 12 Sep 2023 01:53:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART
 register tracing
Message-ID: <ZP+aeNyQ5N9q8Z3L@smile.fi.intel.com>
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
 <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
 <ZPEbacIuZv+116AE@smile.fi.intel.com>
 <e0b46e9e-30ee-1ca7-b39c-89480de60009@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b46e9e-30ee-1ca7-b39c-89480de60009@foxvalley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Sep 11, 2023 at 04:14:48PM -0600, Dan Raymond wrote:
> >>>> Implement a UART register tracing facility using the debugfs.  This can be
> >>>> used as a "serial port sniffer" to monitor UART traffic and line settings
> >>>> with timestamps at microsecond granularity.  This can be useful for general
> >>>> serial port debugging or to debug the UART driver itself.
> >>>
> >>>>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
> >>>
> >>> My gosh. Why trace points and trace events can't be used for that?
> >>
> >> I don't understand your post.  Are you saying there is already a way to
> >> trace UART register reads/writes without this patch? Can you elaborate?
> > 
> > Besides what Greg an I were telling you (another type of infrastructure),
> > as a matter of fact you may trace any IO on some architectures (at least x86),
> > it's called mmiotracer (I have used it like 5 years ago or so to trace UART).
> > 
> > Below is the excerpt from my old shell script
> > 
> > rebind() {
> > 	local drvdir="/sys/bus/$1/drivers/$2"
> > 	local devdir="/sys/bus/$1/devices/$3"
> > 	[ -d "$drvdir" -a -d "$devdir" ] || return
> > 	echo "$3" > "$drvdir/unbind"
> > 	echo "$3" > "$drvdir/bind"
> > }
> > 
> > mmiotrace() {
> > 	echo mmiotrace > /sys/kernel/tracing/current_tracer
> > 	echo 1 > /sys/kernel/tracing/tracing_on
> > 
> > 	rebind platform 'dw-apb-uart'   '80860F0A:00'   # BYT ttyS1 (ACPI)
> > 	rebind platform 'dw-apb-uart'   '8086228A:00'   # BSW ttyS1 (ACPI)
> > 	rebind pci      '8250_mid'      '0000:00:04.2'  # Edison ttyS1
> > 	rebind pci      'intel-lpss'    '0000:00:18.1'  # BXT LH ttyS1
> > 	rebind pci      'intel-lpss'    '0000:00:1e.0'  # SKL ttyS1
> > 	rebind pci      '8250_lpss'     '0000:00:1e.3'  # BSW ttyS1 (PCI)
> > }
> 
> Correct me if I'm wrong but I don't think mmiotrace will work for me.  My
> environment comprises an Intel Celeron M connected to an 852GM north bridge,
> an ICH4 south bridge, and a SCH3114 Super I/O controller.  My UART device
> is ttyS1 and it uses port I/O not memory-mapped I/O.

Correct, mmiotrace (as suggested by its name) works only on MMIO.
For IO there is no such mechanism as there are no exceptions when
you access IO ports.

So, in such case the only instrumentation can help, but I suggest
to do it generally as you may miss the writes or reads that are
not going via serial_*() APIs.

Look how lib/trace_readwrite.c is done.

-- 
With Best Regards,
Andy Shevchenko


