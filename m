Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA3C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Nov 2022 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKYSE2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Nov 2022 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKYSE1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Nov 2022 13:04:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D32CDC5;
        Fri, 25 Nov 2022 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669399467; x=1700935467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cvo+wdxbGI7eQfNrQ+AeWW9IagbEwD8A5SKG0BtPBIQ=;
  b=OqWNJLCJTXLk51LoCe7y9h5tt0APhBjUQR7lwHs2jaJjcLPocPKGLB/V
   Km5kb/cjd0ZevrXiMlKrTLalEkXEqkeVm07aa40v9fzgoEpmI0+e4+P0E
   x/11LA8I3Br7SeFZyqtCgx4/1BZDs356CNEiM/3b9PWF85X6q6nptcCLO
   jfyLgeDvWD2qn9BfG5UD3AQL/1bS2KxA/ii7R1iM0Auczche0LYM6N1NN
   vPg3cXzbhk7vQnt48PMfwmktNWP9YAiREAGi1Nnl74P8rNer0220P0+Gq
   8nAEv7qhuF7eU9Y/+jMnDT3oMRE+hUzfUz32dXGYkVHZRG7/VOLyMkuZ6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="316345438"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="316345438"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 10:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="675445123"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="675445123"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2022 10:03:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyd3K-00HLRW-2S;
        Fri, 25 Nov 2022 20:03:54 +0200
Date:   Fri, 25 Nov 2022 20:03:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com
Subject: Re: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y4EDinQApvqheyZC@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
 <Y3Xv6XOwddNq6Gmr@smile.fi.intel.com>
 <PH7PR11MB595813B2AB661CD50517DEB89B0E9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB595813B2AB661CD50517DEB89B0E9@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 25, 2022 at 03:45:01PM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, November 17, 2022 1:55 PM

...

> > > +     case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> > > +             irq_idx = idx;
> > > +             break;
> > 
> > Try to make this entire switch-case more compact. It's possible.
> 
> I am planning to use look-up table for this in-order to avoid computation
> within switch case. Does this approach sound good?

Maybe, it's you who decides, just show us the result and we will see.

-- 
With Best Regards,
Andy Shevchenko


