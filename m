Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7061AC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 14:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245575AbiFGOeh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiFGOeg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 10:34:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989761572F;
        Tue,  7 Jun 2022 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654612468; x=1686148468;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CSqAyQ69YMjsKUi4kQA7lQgbvG8ZQTQdDHQjX4aMF7s=;
  b=E62gmmpIonnNqoca7U0Jev2upPq16gaTrX0GTMGWqhaEDLeojiVHWhjW
   eR4GW8m+sKuBUtX9O4/Y32O1Dg3Q6rs4KkUQ2ySP3FCJAyzzDMlG9fZM4
   Gc6RxRK1TH58hXPkoXsYMjX2mpZ+R8LtFGc1rPA0bEg3sDj+lOTIdSELu
   DQHb2Axk2cDAABE2DqcYebhvZFxHVOUjY8c3evNHnhDVZtAroArp7hwWw
   MQK/TqGALfIR9hyARwJNFBaMlBjqVG9j2Ma9fgkfyoIv3QKHzeghnbu07
   ZCYGrgKVZPrQGfJ/589wruq/eNGhdhKHWH/0xFLqJOrJfrL2SCXRWpHC7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="302085551"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="302085551"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:34:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636149557"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:34:25 -0700
Date:   Tue, 7 Jun 2022 17:34:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/36] tty/vt: consolemap: saner variable names in
 set_inverse_trans_unicode()
In-Reply-To: <20220607104946.18710-20-jslaby@suse.cz>
Message-ID: <afd36ee7-1e8-38cc-d0c5-b82325f1b2ca@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-20-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-886879419-1654612467=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-886879419-1654612467=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The function uses too vague variable names like i, j, k for iterators, p,
> q, p1, p2 for pointers etc.
> 
> Rename all these, so that it is clear what is going on:
> - dict: for dictionaries.
> - d, r, g: for dir, row, glyph iterators -- these are unsigned now.
> - dir, row: for directory and row pointers.
> - glyph: for the glyph.
> - and so on...
> 
> This is a lot of shuffling, but the result pays off, IMO.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-886879419-1654612467=:1622--
