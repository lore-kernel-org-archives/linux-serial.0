Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48CDC43334
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbiFGNcl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiFGNck (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:32:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7846A27B19;
        Tue,  7 Jun 2022 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608757; x=1686144757;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=535L1jI1nPmXoCMEC1TyzG0h9F+iwaHcjFYWul2Vn3w=;
  b=ViiGPncK1J2bURoJRLwAVJwYeQmisFepc/dqw5/axtuvDHfH0ZI+/QlL
   rrRKkg3kYnvTt2NpaR2vZkdNyp0n2nEsLZ+sFyXxdX+VgTQtdVbXo70r+
   YOQ/HZscmqqbWisT8147oJv2qcRPCaRfCdg6Recgf2i5rVNwkqSoxQwg1
   yXAS1BX4/MvJSvdYuUB32NSxePjooXoz5C+DMAJAR5mgZXnDmaEfpgvJO
   Q3bOmvc6xvf/izaXEQfQACQfOvWqvFNkDWJjzGjM7Hs6EqAjL9zwQ5tHH
   u0g33Gda6X/kOJmpT97NLn0RdzE2Z/PYVzUkUeOmlyJN7wY0N2GM9a+ix
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276762499"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="276762499"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:32:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584199696"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:32:35 -0700
Date:   Tue, 7 Jun 2022 16:32:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/36] tty/vt: consolemap: make parameters of
 inverse_translate() saner
In-Reply-To: <20220607104946.18710-7-jslaby@suse.cz>
Message-ID: <83d6e90-c9f4-883c-285f-9ba7f85e937b@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1506534093-1654608756=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1506534093-1654608756=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> - int use_unicode -> bool: it's used as bool at some places already, so
>   make it explicit.
> - int glyph -> u16: every caller passes a u16 in. So make it explicit
>   too. And remove a negative check from inverse_translate() as it never
>   could be negative.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1506534093-1654608756=:1622--
