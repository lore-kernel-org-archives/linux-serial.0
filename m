Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1DFC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiFGNVJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiFGNVJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:21:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786069290;
        Tue,  7 Jun 2022 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608065; x=1686144065;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=7M5Zbf6hRRdvfgbssy0k9CPN3f/nvfC3XOcth6rYGQk=;
  b=FHXsuwGpLGZWha5LbKRCDBbsq1MM68THXH+D+IVm6uo8+NwjPA0NFLo1
   b5lRFgvwyiLwIj5tTeg5yaj1TynWY494DgU/Ci/OlBwSFEfKI8dqfGyEe
   f6har4NkwRD52rrDTAJlq7F9OPWO8tiGQjuisCxk0PbTBYnzX3jPGjZTa
   yxDCdirecVN2wRv4wSbBAlxjwmxFPxGNHImu5VRuqQul0QRedwmhF7OMm
   sLHbCc32NuwbH3TQBxjbxyFpR3GuccOmJe6vhj5agjSdZ/D6RgdalwoWn
   AUiWkvFuC2Cew1xTrTylxGrpI9Hq225mSYllvzZiA5dWlidP3+8qYyk7G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277508732"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277508732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:21:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636122037"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:21:03 -0700
Date:   Tue, 7 Jun 2022 16:21:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/36] tty/vt: consolemap: define UNI_* macros for
 constants
In-Reply-To: <20220607104946.18710-3-jslaby@suse.cz>
Message-ID: <59e0ae93-c7b-2087-75f8-4da0de918250@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1534695395-1654607902=:1622"
Content-ID: <7e28987a-6395-d443-4367-a4e8891c480@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1534695395-1654607902=:1622
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <de645f70-e7af-dfeb-4ac2-646eea40a368@linux.intel.com>

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The code uses constants for sizes of dictionary substructures on many
> places. Define 3 macros and use them in the code, so that loop bounds,
> local variables and the dictionary always match. (And the loop bounds
> are obvious now too.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> -			for (k = 0; k < 64; k++) {
> +			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
>  				glyph = p2[k];
>  				if (glyph >= 0 && glyph < MAX_GLYPH
>  					       && q[glyph] < 32)

Probably unrelated to this change but what's that < 32? It seems to appear 
twice related to the inverse mapping (and you didn't end up naming it).


-- 
 i.
--8323329-1534695395-1654607902=:1622--
