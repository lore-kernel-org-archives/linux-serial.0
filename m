Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37855C7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 15:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjFHP5c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 11:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbjFHP5N (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 11:57:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE9A2715
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686239821; x=1717775821;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SWxITp+aPgQ25DUcGbtB/s3kauHP7K7UncRcEWQ8+hU=;
  b=Vn58WASKyS0H3kqlUbOZBA9uYVKekpjflztDXqgltrwHItWXgQxJdzi4
   BpO+WKilyOLhnGMAgdEnz8NAl4l9FV43AlFd26PLkLSnsRHlhXQVnwdct
   U8HgWBWAjeFq47RbZmOJKmc4b5FuC8hhyDswdMeEGHpg1i2CcaDa/sET2
   WVjmWvdSoUbA+aB+Lh2JqWAn3X/MQuQsZh9SuFGax4dzTFX6e887Z2UBo
   KCCTdDRS1164xPeth1EexcZCES6LHUwz6322vCAwS67d7hwvcOxRSNW+N
   BEDwhOMBfTypZrApsDv7n6D1C/6AlRKS+ZgbZIrpNOWqsgU8JPbX0TmIW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443715960"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="443715960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="854396325"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="854396325"
Received: from dteodorx-mobl1.ger.corp.intel.com (HELO skhalil-mobl.ger.corp.intel.com) ([10.252.47.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:56:59 -0700
Date:   Thu, 8 Jun 2023 18:56:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Robert Hodaszi <robert.hodaszi@digi.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, sherry.sun@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on
 LS1028A
In-Reply-To: <94cae2c3-13c3-7c72-04d9-640a8ff1e7f7@digi.com>
Message-ID: <a050e754-e15e-5cde-e838-f4a79885f7a3@linux.intel.com>
References: <20230608111927.1808525-1-robert.hodaszi@digi.com> <2023060858-groove-riddance-0c09@gregkh> <94cae2c3-13c3-7c72-04d9-640a8ff1e7f7@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 8 Jun 2023, Robert Hodaszi wrote:

> On 2023. 06. 08. 13:52, Greg KH wrote:
> > What commit id does this fix?  Should it go to stable releases?
> >
> > thanks,
> >
> > greg k-h
> Basically this one caused the issue on my unit:
> 
>     9ad9df8447547febe9dd09b040f4528a09e495f0
> 
> Check this discussion for more info:
> 
>     https://www.spinics.net/lists/linux-serial/msg54555.html
> 
> Yes, I think, it should go to stable.

Please provide a new version of the patch with Fixes + Link tags then
(for Link tag, prefer to use lore archive links).

You can find out the correct format of those tags from the information 
under Documentation/process/.

-- 
 i.

