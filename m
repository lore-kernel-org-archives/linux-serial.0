Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4892DC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 15 Dec 2022 17:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLORo2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLORo1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 12:44:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A344411C0E;
        Thu, 15 Dec 2022 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671126266; x=1702662266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MoLYUv/vRcgWjgEVHol3uf+9CH27suckkdQFhykR8hc=;
  b=Az3DUrCoqaz7QkqGWNoFDkdzGdiYvRUpSTJm/K/LjQTJhPR0nqL7+FOo
   2Jr/BcQVol6gXHcUKWxv5npVPSYtQQPHG/pRyqKqpI/13UAe5kD5q4VM8
   PbZA0ZbVPqt9IV4imjq6xtxifXBbZrdc2yJEprj724EcFzT5JLy890gzy
   /HNnHmCzRuxL8IDV2jHi7pINEK1kqrddq1BWbp2Qo8QZSV75mqjnv+Q3B
   xP4O71usDBKT11Yz9Zene6S/QpuaUwiQTUOkKq9zBEZ8Q4YCbP3zXooaw
   4L51bUzIeunttXS+gWguFc0SgQsEvp+BWEcgfy8a3BQJK/2jCqD1jZZhN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299093776"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299093776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="738212377"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="738212377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Dec 2022 09:44:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p5sHK-00ASOL-2U;
        Thu, 15 Dec 2022 19:44:18 +0200
Date:   Thu, 15 Dec 2022 19:44:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, cang1@live.co.uk,
        colin.i.king@gmail.com, phil.edworthy@renesas.com,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5tc8mjvxdphtgzj@smile.fi.intel.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 15, 2022 at 07:42:32PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 16, 2022 at 10:56:54AM +0530, Kumaravel Thiagarajan wrote:

...

> > +static unsigned int pci1xxxx_get_max_port(int subsys_dev)
> > +{
> > +	int i = 0;
> 
> What the point to assign this one?
> 
> Actually, better is
> 
> 	unsigned int = MAX_PORTS;
> 
> > +	if (subsys_dev < ARRAY_SIZE(logical_to_physical_port_idx))
> 
> > +		for (i = MAX_PORTS - 1; i >= 0; i--)
> 
> while (i--) {
> 
> > +			if (logical_to_physical_port_idx[subsys_dev][i] != -1)
> > +				return logical_to_physical_port_idx[subsys_dev][i] + 1;
> 
> }
> 
> (Note missinng {} in the above code. Does checkpatch complain on this?)
> 
> > +	if (subsys_dev != PCI_SUBDEVICE_ID_EFAR_PCI11414)
> > +		return 1;
> > +
> > +	return 4;

Also you can consider the positive check here:

	if (subsys_dev == PCI_SUBDEVICE_ID_EFAR_PCI11414)
		return 4;

	return 1;

> > +}

-- 
With Best Regards,
Andy Shevchenko


