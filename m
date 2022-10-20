Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E71C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJTOPy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJTOPu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 10:15:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443112E0D9
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666275344; x=1697811344;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ry57aGj5YdtTU8/u3mCuvaspkv0RvdmaAl58S3PuHvY=;
  b=Fne7KP701WKT16HSbrZaMjZDnIVakuDyzFlxz9r97OKUDh1kcV3Tqp5H
   SRnw1MMvzrEcMOWXkhg/SrsRiCkFjwk2SvPTfKduVwLU/Dlf7Azf/nQUN
   gbe0QM2NofJ30u1QtpVxHdXiOXbDeIjKH4KJ+aILFwsC/5jujdG9aHTf/
   rbC71KEM6OWyEiO5xrC1p4IAjtqysmq0WuVdvqd4RgMz5evbSiA/d65ns
   64Lwb/angocURL0E45Zqjxzx6oTZaas381NEvkM4BxSmbpRWVCM6jtLv/
   7lIXMZoo81kdWvzTSwdchLNtoV0rheCsNIpWClu6STxR8nX8j3G7onbDG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="307815591"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="307815591"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:14:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632273029"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="632273029"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.33])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 07:14:54 -0700
Date:   Thu, 20 Oct 2022 17:14:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] serial: 8250: allow use of non-runtime configured
 uart ports
In-Reply-To: <0B4E8D8F-8E89-4951-9B5C-AFDF6667A1CC@geanix.com>
Message-ID: <4ecaa152-3fdc-be46-61a3-b026f4b36a61@linux.intel.com>
References: <20221018133419.134110-1-martin@geanix.com> <7baa90-e168-4bbe-5ce1-12c7de2ee04e@linux.intel.com> <0B4E8D8F-8E89-4951-9B5C-AFDF6667A1CC@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1880355535-1666275295=:1542"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1880355535-1666275295=:1542
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 20 Oct 2022, Martin Hundebøll wrote:

> 
> 
> On October 20, 2022 2:34:14 PM GMT+02:00, "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> wrote:
> >On Tue, 18 Oct 2022, Martin Hundebøll wrote:
> >
> >> The logic to find unused ports when registering new 8250 uart ports
> >> searches only up to CONFIG_SERIAL_8250_RUNTIME_UART, which forces users
> >> of external 8250 ports to increase the number of runtime ports
> >> artificially.
> >> 
> >> Fix this by initializing each allocated port structure with basic
> >> settings like line number and uart operation callbacks, and by searching
> >> the entire array of allocated ports to find an unused one.
> >
> >So nr_uarts no longer means "Maximum number of UARTs supported." ?
> >Perhaps it should be reworded too.
> >
> 
> It never did. Confusingly, the module parameter name (nr_uarts) 
> corresponds to CONFIG_SERIAL_8250_RUNTIME_UARTS, and controls the number 
> of built-in (non-discoverable) ports. The other config, 
> CONFIG_SERIAL_8250_NR_UARTS, controls the maximum number of ports. 
> 
> We cannot change the module parameter name, so I'm not sure if we should 
> map it to another static variable in the source?

I meant that its description should be changed to match what it really 
does.


-- 
 i.

--8323329-1880355535-1666275295=:1542--
