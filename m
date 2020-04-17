Return-Path: <SRS0=oPkf=6B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F9C2D0EF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954132083E
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 12:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgDQMxz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:53:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:51413 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgDQMxx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 08:53:53 -0400
IronPort-SDR: Y/UTyZzJekMNpK4B9aEkLXm8r6MrNc+tolooeNYnMMbMY+n7Hvcol9ZZ/iMIOjx/rIO+246SEe
 7oZaIw0HIqCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:53:50 -0700
IronPort-SDR: IF9FvVYYRsALomR7JBJYD4OrD7z1TD+jkZkjtMbWkbL2Y+K9fLy7iBbf/C7fbLqZdQ4wR8Ku3+
 Jv1Nnuhi9vNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="257569830"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2020 05:53:47 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jPQVC-001VLK-J5; Fri, 17 Apr 2020 15:53:50 +0300
Date:   Fri, 17 Apr 2020 15:53:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     rishi gupta <gupt21@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        robh+dt@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tty: documentation: document how to use ttyvs
 driver
Message-ID: <20200417125350.GW185537@smile.fi.intel.com>
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
 <1587012974-21219-4-git-send-email-gupt21@gmail.com>
 <20200416092441.4216ffe3@coco.lan>
 <CALUj-gtwKiV_CQYLkncX0v2fNNAyfTfzut+BgXmgzKLW7tMLOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALUj-gtwKiV_CQYLkncX0v2fNNAyfTfzut+BgXmgzKLW7tMLOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 17, 2020 at 10:46:40AM +0530, rishi gupta wrote:
> Thanks Mauro and Randy, I will spin v4 with above suggestions soon.

Give some more time to review actual code. It's 1000 LOCs!
I suggest wait at least few days.


-- 
With Best Regards,
Andy Shevchenko


