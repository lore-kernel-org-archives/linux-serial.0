Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB00C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 19 May 2022 08:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiESIma (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 May 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiESIm2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 May 2022 04:42:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C26AA55;
        Thu, 19 May 2022 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652949747; x=1684485747;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PgS8XNRf9GQ3vzLVLyP6y/ZH5DIQbtxz9BKblMVr4W8=;
  b=YAD1FcJHuwvxr9/9jIeTBzaRlfxn/cT53uFLYdJySETbpHVN/bKaTPRk
   6e2v/y41OXl+JL0hkXRByef8jGSVlSTBy+yFPK8s0BSZCihu/PiKKTSdr
   lsKI4FLShh7RAA1POZCDNVHDo5lTF3rV2nV5+h6erHB2PNORhzfiqsLvC
   KMOgZ2kfPaimxHJN3QwkheiwWhWUIgQ2dxJMueg8b2Q/a35393t1h/8mJ
   61YqCnSlPRrf1xo1g/Xn7pXxbR58fIhgq4OTM+t/rnnJxqDuYMfhR3yfk
   sCVso3eT2jkKSJmoPTH5PgqIsEFms5yxLJFqAgqxUZeCu2tYppMnEN5bi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259672438"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259672438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:42:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598441086"
Received: from ivanovbx-mobl1.ger.corp.intel.com ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:42:24 -0700
Date:   Thu, 19 May 2022 11:42:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] serial: amba-pl011: move header content to .c
In-Reply-To: <20220519075720.31402-1-jslaby@suse.cz>
Message-ID: <b57ed6c-29c5-8bb6-fe5b-7f936a2117@linux.intel.com>
References: <20220519075720.31402-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-479117058-1652949746=:1628"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-479117058-1652949746=:1628
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 19 May 2022, Jiri Slaby wrote:

> There is no point keeping the header content separated. In this case, it
> is only an enum. So move the enum to the appropriate source file.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-479117058-1652949746=:1628--
