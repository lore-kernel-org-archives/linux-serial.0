Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD1C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiKQG4D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Nov 2022 01:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQG4B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Nov 2022 01:56:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1ED5B588;
        Wed, 16 Nov 2022 22:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668668161; x=1700204161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/YiAsV6EgKMRnLVAn0TpDJukNZYyLzxN/mv8BzeD5w=;
  b=AhXt1mCdy4MC3PGjf0pPuBI87jcL8PjH05Jw8BSeCyMlueuX3upA6M1U
   adOgCJkFLDePqg4+ywEsHyBlTrpVOfCRdO3+mksm+P4xCk2LeahGlZPyV
   5tlY+rB2FfWlaVNfoH38BPqbRmHOBu6bLl+BHFcrbXfo1++m3DivlxNys
   mmGxSrGCMAbYPUeVJvpk6/VWi4dt5yENgfdeDUgIMYizPzrIHJyEWbwaL
   VzGR2+145uGaseaHAlECXiDxc1TbIAXmobXhzhX/jXY+axpSwcc0xxyof
   OQRl+Mef/MnJBMXb+VvcctkVBG/P6SAEk1ICmKWfSfyFfgtCRP/NiHw8N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296138245"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296138245"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884738990"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="884738990"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 22:55:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovYoQ-00DT8H-0T;
        Thu, 17 Nov 2022 08:55:50 +0200
Date:   Thu, 17 Nov 2022 08:55:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 17, 2022 at 10:31:24AM +0530, Kumaravel Thiagarajan wrote:
> Move implementation of setup_port API to serial8250_pci_setup_port

Don't you have a dependency issue here?

The subject also wrong. This should be 'serial: 8250_pci: ...'.
And for your code something like 'serial: 8250_pci1xxxx: ...'
in the rest of the series.

-- 
With Best Regards,
Andy Shevchenko


