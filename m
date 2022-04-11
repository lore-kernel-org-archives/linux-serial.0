Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79834C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiDKLK5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiDKLIu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 07:08:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15B45512
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 04:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649675147; x=1681211147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yAppc6Ztsez8rdpk2ailFKGasT65dhH9BJ8eR7JdX7s=;
  b=mN12XZw87RKGoESf+gyj323O+cyBkkv1as+1unKK7vatSd5py5fCqt61
   0py6xr+mE85JNq28umsNSMNUL72ulUS6WlpM7riK5TwK11is0vkkQ/TQg
   b33mP4cHPpLQxEBW7kUG/9W56AMB+JRfPETVnM07lYnijTTbdokppipJE
   N+uERwAnJNgLp1Lt8u8Obr/FhA5GH6Kebuz9S9G58b9oBaW1wAVXuwqfE
   OEC8SWt/ke5UChqd3kLulKCQMSWh+j60kCOoVcbgq6YoF9/cuF4m0nbrz
   4N12tIH0KQz30VHyS059bn/8M6ndH1ARIxDYlaN4veoYMuE0jBcqJzWoN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322533410"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322533410"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:05:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="660003216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:05:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndro4-001Bgi-OS;
        Mon, 11 Apr 2022 14:02:04 +0300
Date:   Mon, 11 Apr 2022 14:02:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 06/12] ACPI / property: Document RS485 _DSD properties
Message-ID: <YlQKrMXPrARXJTFG@smile.fi.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220411083321.9131-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411083321.9131-7-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 11, 2022 at 11:33:15AM +0300, Ilpo Järvinen wrote:
> Document RS485 related properties returned from ACPI _DSD
> as device properties.

...

> +				Package () {"rs485-rts-active-low", Zero},
> +				Package () {"rs485-rx-active-high", Zero},
> +				Package () {"rs485-rx-during-tx", Zero},

				Package () { "rs485-rts-active-low", Zero },
				Package () { "rs485-rx-active-high", Zero },
				Package () { "rs485-rx-during-tx", Zero },

-- 
With Best Regards,
Andy Shevchenko


