Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C35C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Mar 2022 13:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiCRNw2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiCRNw1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Mar 2022 09:52:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B304E0D9;
        Fri, 18 Mar 2022 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647611455; x=1679147455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjbDKBS7kb8HLR3kyQSzHMONMtObEHvlnqKqgDL0Bts=;
  b=gWCh0r8Av/kVx4YfxwKDc0DSmTcN5UgB049IwLD1fDOlK5ea1j7xFjYO
   UUAaDOEvJQZPxlkaCbh8vcr95NnlvHKlJqjVuF0uXnfqEeMFq028wshll
   5/RV11ud7eiDNP/VQ2Z1g7uxy7IkTo6jyaI+VATvLuXcurJaEh253DQnC
   XPWIIz0k3H5bVcINJBhcS9GS01mhKfckvPJZXaVP+ELa/uJsIOXqg/5Kc
   e4Zqem798FYkL3SsgRsp6xZTVH5/m9V/6+3ZF+H81p9AT1LByqxnFluKS
   8PXdaU4PSheskHPCCRTkKQE+v/2NUm1wRyW/CQnVtHZ0w491fSsDUNZpA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343573624"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343573624"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:50:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="635758455"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:50:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVCzc-002FyR-Ja;
        Fri, 18 Mar 2022 15:50:12 +0200
Date:   Fri, 18 Mar 2022 15:50:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 05/10] serial: 8250: dw: Check when possible if DMA is
 effectively supported
Message-ID: <YjSOFII3l+vz0q8L@smile.fi.intel.com>
References: <20220317174627.360815-1-miquel.raynal@bootlin.com>
 <20220317174627.360815-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317174627.360815-6-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 17, 2022 at 06:46:22PM +0100, Miquel Raynal wrote:
> The CPR register can give the information whether the IP is DMA capable
> or not. Let's extract this information when the CPR register is valid
> and use it to discriminate when the DMA cannot be hooked up.
> 
> We assume existing designs either provide a valid CPR register or do not
> provide any.

...

> +	if (!(reg & DW_UART_CPR_DMA_EXTRA))
> +		data->no_dma = 1;

My question still remains: Does this bit is _guaranteed_ to be set when this IP
is integrated on all possible DMAs?

-- 
With Best Regards,
Andy Shevchenko


