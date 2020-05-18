Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE5C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65193207ED
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 17:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgERRR1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 13:17:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:20607 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERRR0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 13:17:26 -0400
IronPort-SDR: JLIKhrEF337eTps4szGdoq643geK3z6RP8ZDnqZjlegwUPBcARIZJKq9yS5vwzDuQzGjfo2y8F
 oj6K4dNwmWGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 10:17:26 -0700
IronPort-SDR: GuRlUgewN1BJf4G2FSzoLvih3E3Ux4CmiLj2lgnXndxIo/H9owYp0NlWzjTfbPg7S4yXnnk0OM
 mT3LvxMNmoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="252959485"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2020 10:16:44 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jajNe-007TXc-Nt; Mon, 18 May 2020 20:16:46 +0300
Date:   Mon, 18 May 2020 20:16:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Heiko Stuebner <heiko@sntech.de>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518171646.GO1634618@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518151241.GG1634618@smile.fi.intel.com>
 <20200518152247.slenjeiiplps7mcd@wunner.de>
 <33547f6a596df2ca2ee8e647111e5fa1@vanmierlo.com>
 <20200518163522.GK1634618@smile.fi.intel.com>
 <f7d408a0ca747086c01999fc0db905da@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d408a0ca747086c01999fc0db905da@vanmierlo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 18, 2020 at 07:05:11PM +0200, Maarten Brock wrote:
> On 2020-05-18 18:35, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 06:13:16PM +0200, Maarten Brock wrote:
> > > On 2020-05-18 17:22, Lukas Wunner wrote:
> > > > On Mon, May 18, 2020 at 06:12:41PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:

...

> > > But "High" on a gpio would disable the receiver when connected to !RE.
> > 
> > No, that's exactly the point of the terminology (asserted means active
> > whatever
> > polarity it is). You need to define active-low in GPIO description.
> 
> Is there anything wrong with defining GPIOD_OUT_ACTIVE or GPIOD_OUT_ASSERTED
> for this very purpose? May I suggest to deprecate GPIOD_OUT_HIGH and replace
> it?

Please, ask GPIO maintainers, I'm not one.

-- 
With Best Regards,
Andy Shevchenko


