Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22018C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhKWJ3J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:29:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:55499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhKWJ3I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 04:29:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215016639"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215016639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:26:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="508929417"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:25:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpS3f-009jMP-NQ;
        Tue, 23 Nov 2021 11:25:47 +0200
Date:   Tue, 23 Nov 2021 11:25:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
Message-ID: <YZyzmzjVH35U05Wj@smile.fi.intel.com>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZuRV8ipjcly26HB@smile.fi.intel.com>
 <YZuRnSaZz04KJIDk@smile.fi.intel.com>
 <ede18fd7-266e-406d-0c9c-570d95ab3673@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede18fd7-266e-406d-0c9c-570d95ab3673@accesio.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 09:19:09PM -0800, Jay Dolan wrote:
> On 11/22/21 4:48 AM, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 02:47:20PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
> > > > On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> > > > > Split Pericom driver to a separate module.
> > > > > While at it, re-enable high baud rates.
> > > > > 
> > > > > Jay, can you, please, test this on as many hardware as you have?
> > > 
> > > ...
> > > 
> > > > * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
> > > > stick.
> > > 
> > > Can't find an evidence that this is the case. Can you recheck this (reading
> > > flags back via sysfs or so)? So, for v2 I'll leave my approach.
> > 
> > Otherwise how the other drivers which are using that flag survive? If it's
> > indeed an issue, it should be fixed on generic level.
> > 
> 
> I modified pericom_do_startup to log when the UPF_MAGIC_MULTIPLIER flag was
> present. Then tried to set the port to 3000000 a few times. The port
> stayed at 9600. It looks like pericom_do_startup() is getting called twice
> per port on boot, and the flag is gone with the second one.
> 
> [    4.925577] [J4D] flag present
> [    4.926121] [J4D[ flag not present
> [    4.926843] [J4D] flag present
> [    4.927415] [J4D[ flag not present
> [    4.928106] [J4D] flag present
> [    4.928673] [J4D[ flag not present
> [    4.929419] [J4D] flag present
> [    4.930447] [J4D[ flag not present
> 
> [   49.528504] [J4D[ flag not present
> [   51.675240] [J4D[ flag not present
> [   59.617954] [J4D[ flag not present
> 
> Then I modified it to log when it was adding the flag in. The port was set
> to 3000000. Also the flag only needed to be added in once. It sticks after
> the first time.
> 
> [    4.647546] [J4D] flag present
> [    4.648119] [J4D] flag not present(adding)
> [    4.648778] [J4D] flag present
> [    4.649330] [J4D] flag not present(adding)
> [    4.650001] [J4D] flag present
> [    4.650537] [J4D] flag not present(adding)
> [    4.651192] [J4D] flag present
> [    4.651718] [J4D] flag not present(adding)
> 
> [   96.025668] [J4D] flag present
> [  100.130626] [J4D] flag present
> [  116.435436] [J4D] flag present
> 
> I mostly just guessed at do_startup() being the place to set the magic
> multiplier flag after it didn't stick in quirk in 8250_pci.c.

Can you share `dmesg` and output of `lspci -nk -vv` on the machine with the
kernel with patches applied and running?

-- 
With Best Regards,
Andy Shevchenko


