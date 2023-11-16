Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED90C54FB9
	for <linux-serial@archiver.kernel.org>; Thu, 16 Nov 2023 11:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKPL7O (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Nov 2023 06:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPL7O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Nov 2023 06:59:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2EC4;
        Thu, 16 Nov 2023 03:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700135951; x=1731671951;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yfjwvutV3fWRMCledUt71e/FG844u9FWetQGI9rtK0c=;
  b=a5e0wJwpFW1Hlpf+iNbU1FJQ3Afpo0bHh+jVIcVPKJFGrOD+iH02dJ3U
   Tc7wwLGhAOKnyYwOieftw1EiV27mE41ypJB7BM/VNtxy0JGKytFO8dCH9
   ZAj7XNbZjf0V7SKTbDBLkH/df7qszaLD8Ya19flw5M0m2ZBuID857a74w
   w8nKLlaxyKmTMK+1I3f4CKR5fMyCFt12qG//kb5vrBUccpS4AJoegXkBs
   pCmiiUSvwz0HcRnJvmc1drHDEHtLdLLubRM2sWwa7Cu4C701XHyK7klLy
   VtVQ/gy+cn9xPFCMJl1TepELvEssqQna4cJ5a1TGdCSvOAVthG9b3bSiM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4201731"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="4201731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765281699"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="765281699"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:59:07 -0800
Date:   Thu, 16 Nov 2023 13:59:04 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 5/5] tty: serial: amba-pl011: unindent pl011_console_get_options
 function body
In-Reply-To: <20231116-mbly-uart-v2-5-863f665ce520@bootlin.com>
Message-ID: <25fd6fe9-5ac3-69e9-81e8-ca7a37efcdc9@linux.intel.com>
References: <20231116-mbly-uart-v2-0-863f665ce520@bootlin.com> <20231116-mbly-uart-v2-5-863f665ce520@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1334176037-1700135950=:1886"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1334176037-1700135950=:1886
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Nov 2023, Théo Lebrun wrote:

> The whole function body is encapsulated inside an if-condition. Reverse
> the if logic and early return to remove one indentation level.
> 
> Also turn two nested ifs into a single one at the end of the function.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  

> -		if (uap->vendor->oversampling) {
> -			if (pl011_read(uap, REG_CR)
> -				  & ST_UART011_CR_OVSFACT)
> -				*baud *= 2;
> -		}
> +	if (uap->vendor->oversampling &&
> +	    (pl011_read(uap, REG_CR) & ST_UART011_CR_OVSFACT)) {
> +		*baud *= 2;
>  	}
>  }

Braces are no longer necessary for this block.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1334176037-1700135950=:1886--
