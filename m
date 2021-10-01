Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D47C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8431661A8B
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 11:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354023AbhJALwr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:52:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:40365 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhJALwr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 07:52:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="223509792"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="223509792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="556263530"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:50:47 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWH3q-007Qno-W6;
        Fri, 01 Oct 2021 14:50:42 +0300
Date:   Fri, 1 Oct 2021 14:50:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v2 3/3] serial: 8250: add compatible for fsl,16550-FIFO64
Message-ID: <YVb2Ep9ZVoF/avZS@smile.fi.intel.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
 <20210204161158.643-4-etremblay@distech-controls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204161158.643-4-etremblay@distech-controls.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 04, 2021 at 11:11:58AM -0500, Eric Tremblay wrote:

Needs a commit message.

> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>

-- 
With Best Regards,
Andy Shevchenko


