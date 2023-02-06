Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F7C61DA4
	for <linux-serial@archiver.kernel.org>; Mon,  6 Feb 2023 11:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBFLhy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Feb 2023 06:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBFLhx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Feb 2023 06:37:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCC10D;
        Mon,  6 Feb 2023 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675683471; x=1707219471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4fiUvEDXtHvBywbFr8s/V78U5nf7cb8MGn1nEwwVaA=;
  b=b8KaKwcHjh95G7eb5yLTmzoKMoA+/aY309d7JJ2Bp9ygEyzgJSpyGdqL
   SMQJ3MtBVG7vKocCTCt/7VbRzcg+RLxIX5v+u67OLAI+PnzfIJJ4k/KTi
   1pYPsbi9risQdSavULtqTJxkMvbg9fRSP1opPSkER3GYRY1VGva+Y7NsW
   TiHWi97h5rJCV2HGrWiiaz1YZlvcke1rCMfSYOKFrEFWCSqAUcrJVSxaC
   4m91IHPdkiJ5hdbBNjPr+g6uhrgm94oiFg+0HrD4B4XLaC99PsNgaBs4/
   nni7JGdu1MZBOOZAgckc9t8xjEg/I29a1Gzj3j0z+lkPWGS+ugcVjy51G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309517502"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309517502"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659823727"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659823727"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 03:37:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pOzoc-0039OU-2P;
        Mon, 06 Feb 2023 13:37:42 +0200
Date:   Mon, 6 Feb 2023 13:37:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, lukas@wunner.de,
        cang1@live.co.uk, matthew.gerlach@linux.intel.com, deller@gmx.de,
        phil.edworthy@renesas.com, geert+renesas@glider.be,
        marpagan@redhat.com, u.kleine-koenig@pengutronix.de,
        etremblay@distech-controls.com, wander@redhat.com
Subject: Re: [PATCH v11 tty-next 0/4] serial: 8250_pci1xxxx: Add driver for
 the pci1xxxx's quad-uart function
Message-ID: <Y+DmhnNJQQ+h1wwc@smile.fi.intel.com>
References: <20230204053138.2520105-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204053138.2520105-1-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Feb 04, 2023 at 11:01:34AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the multi-function
> endpoint. This patch adds device driver for the quad-uart function and
> enumerates between 1 to 4 instances of uarts based on the PCIe subsystem
> device ID.
> 
> The changes from v1->v2->v3->v4->v5->v6->v7->v8->v9->v10->v11 are mentioned
> in each patch in the patchset.
> 
> Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
> Uytterhoeven, Greg KH, Jiri Slaby for their review comments.

LKP is not happy, perhaps you forgot to use --base.

-- 
With Best Regards,
Andy Shevchenko


