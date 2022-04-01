Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D657C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Apr 2022 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbiDARkw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiDARkv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Apr 2022 13:40:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520AF1B;
        Fri,  1 Apr 2022 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648834741; x=1680370741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z0dQ1kpXFo+5ugqbz/2Q0ztwOv4jf/rgKI47VO6yM7E=;
  b=bBj+Nbk0cQJSPNZD1HAjMDGpk5QD8+v8aPfj6e3Sbqapu49pIcrp3AJx
   dUYYaG2TmYzyHRo0xel/bQFb1BZJGjMmSNNkYQVXRtMxQDCC8eUn/U4nE
   5KcYJRKxIEQ60IvO1H52iqImSN+9O/mkSYdEBBUGaufJ9XjQLjCVsbzVn
   4BMT6xy9wtBmS/2VEDt2c4h1X5Id8RJPy9aP/BPNhhgGCDKQ/NGVfVtrn
   yqMNxqAKfV9MvI/FdAfARfA7lugjoMvZojN8sA+l540hXWZpnUMxvqT/M
   PtgoJMxnY/rbyaW6YnD/Vs2Qk87RW1UiduZLWgjOXlFlRqupvD6bSKTr6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260375614"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="260375614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:39:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="504244321"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:38:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1naLE8-00AqBV-QU;
        Fri, 01 Apr 2022 20:38:24 +0300
Date:   Fri, 1 Apr 2022 20:38:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v4 7/9] serial: 8250: dw: Add support for DMA flow
 controlling devices
Message-ID: <Ykc4kGLEnwdoUqZ6@smile.fi.intel.com>
References: <20220330132038.808679-1-miquel.raynal@bootlin.com>
 <20220330132038.808679-8-miquel.raynal@bootlin.com>
 <24becf8-82c5-5a12-690-5b9e067ec1c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24becf8-82c5-5a12-690-5b9e067ec1c@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 01, 2022 at 01:56:49PM +0300, Ilpo Järvinen wrote:
> On Wed, 30 Mar 2022, Miquel Raynal wrote:

...

> > +			writel(0, p->membase + RZN1_UART_RDMACR);
> > +			writel(1, p->membase + DW_UART_DMASA);
> 
> Currently there is serial_out(), dw8250_writel_ext(), and a few writel()s 
> too for writing to registers. It would be nice to move towards more 
> homogeneous approach rather than adding more writel()s.

Actually a good catch!

> I suggest dw8250_writel_ext() is moved to dwlib.h. Then it could be used 
> here (and dw8250_readl_ext() too should be moved but IIRC there wasn't 
> any reads added by this series).

I agree that for the sake of symmetry it's good to move both.

-- 
With Best Regards,
Andy Shevchenko


