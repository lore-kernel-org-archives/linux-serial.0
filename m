Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE6C04A95
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJYKVU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiJYKUz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 06:20:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FAC171CF1;
        Tue, 25 Oct 2022 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666693056; x=1698229056;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U1KoYFF/icq9KjKxIKGx99Qx9TPUDJo/UOlkG3I0mNg=;
  b=SW1ufyga0AqrhIULz0ypBeiqAv0SL6d9jDQl1iDnJxSif0t4L+/cSx9R
   ZanR2h5CC9I/3YeKq1yoZwLUwnNumB/vMW3O59rKBlIXXvWTxPYJtc5Ou
   yWkREmvPBIrRHV7n5rrQrYt/8mHMiU3mBGx+bjRu4fyBPb0JEzjjZ5S4S
   lUSmpcftMRw67lf31buqk19JpBTk5n9YHsbX1PFiHsFM8e4/9iG5IJIwu
   qHB4vZzgCW/Lr0/ipVfJJ0xhjwYxKMLO5+03OWDyoK2rutgjgIWZ1Oxrq
   kjjQp34ZaWvEnn+V2Bp+ZAOP9albUKKpSLdX4RbiOSAT0RXg7emwgWe/g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334234736"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="334234736"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 03:17:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626377430"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626377430"
Received: from pweidel-mobl.ger.corp.intel.com ([10.252.44.62])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 03:17:34 -0700
Date:   Tue, 25 Oct 2022 13:17:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: introduce macro for minimal unit
 size
In-Reply-To: <20221024130114.2070-1-daniel.starke@siemens.com>
Message-ID: <fa9b8796-b0cd-d6e4-12d3-e0acd570d633@linux.intel.com>
References: <20221024130114.2070-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-170580793-1666693056=:1638"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-170580793-1666693056=:1638
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 24 Oct 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm has a minimal protocol overhead of 7 bytes. The current code already
> checks whether the configured MRU/MTU size is at least one byte more than
> this.
> 
> Introduce the macro MIN_MTU to make this value more obvious.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-170580793-1666693056=:1638--
