Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDEEC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB5360FC2
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhJANIm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 09:08:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:17831 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhJANI0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 09:08:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="204912002"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="204912002"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:05:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480441231"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:05:34 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWIED-007RlM-PB;
        Fri, 01 Oct 2021 16:05:29 +0300
Date:   Fri, 1 Oct 2021 16:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        kernel test robot <lkp@intel.com>,
        gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de
Subject: Re: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <YVcHmUopUmvyw2UQ@smile.fi.intel.com>
References: <20210204161158.643-2-etremblay@distech-controls.com>
 <202102050539.ILyUUHHw-lkp@intel.com>
 <20211001123033.l7ivfm35knnp3j5s@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001123033.l7ivfm35knnp3j5s@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 02:30:33PM +0200, Uwe Kleine-König wrote:
> On Fri, Feb 05, 2021 at 05:36:44AM +0800, kernel test robot wrote:

> > >> ERROR: modpost: "uart_get_byte_size" [drivers/tty/serial/8250/8250_base.ko] undefined!
> 
> FTR: This is a missing EXPORT_SYMBOL_GPL for uart_get_byte_size().

It seems we don't need that function anymore since we have similar one already.

-- 
With Best Regards,
Andy Shevchenko


