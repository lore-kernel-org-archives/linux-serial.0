Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B6C38A02
	for <linux-serial@archiver.kernel.org>; Fri, 28 Oct 2022 09:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJ1JNv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJ1JNs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Oct 2022 05:13:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E7BBE33
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666948427; x=1698484427;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O3WcB4szOwU58ClFZrwbd8OcTMBVIkMG0Gc9Dx2NLK8=;
  b=jOowp0fhzcBs2/Mjg1uuYiraMjlqJRK3z6qNwnDkQy97bbHK4MgDHQX4
   t48J1UVfn8uIh6DvRaDRQTY2rSek7cumSDCuakIcXl1d1l6SXdIdfhsV6
   le6+729j4YCk85th0/GX51GsZuZDB8CFL4ygmoyOsYtf8pFVcOiZqQlgH
   JKzOdXHzMBBJQpK6j8IdNmJtMNzYzdx0ttQ0rbkNUPnGt0UoPXI0K4Flh
   WnZOZMqqcdO++rjfuexG0gv6bATHkuo91EGN8AZOy0gDd/+0CzAzrfw/q
   KOPPn5UV0IFOEABtHbmlgMW6/Yc4SB7BMI/xiNtUTJ2gpudohfvS1X56t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="306059047"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="306059047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 02:13:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="610682788"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="610682788"
Received: from amilburn-mobl.ger.corp.intel.com ([10.252.47.223])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 02:13:45 -0700
Date:   Fri, 28 Oct 2022 12:13:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com>
Message-ID: <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-3-martin@geanix.com> <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-424166638-1666948427=:1762"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-424166638-1666948427=:1762
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Oct 2022, Ilpo Järvinen wrote:

> On Tue, 25 Oct 2022, Martin Hundebøll wrote:
> 
> > Skip registration of the platform device used for built-in ports, if no
> > such ports are configured/created.
> > 
> > Signed-off-by: Martin Hundebøll <martin@geanix.com>
> 
> For patches 1-3:
> 
> Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Please include these tags into the next version of your submission.
> Thank you.

Actually, I just found out that some set of cmdline parameters do no 
longer work the same. So I'm retracting both of my tags for now.

=0 did work as expected due to this change which I tested and some other 
values >4 but there now seems to be problem of the console not showing up 
like previously when I don't give nr_uarts at all.

-- 
 i.

--8323329-424166638-1666948427=:1762--
