Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E70C43461
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94981208DB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgINQIM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 12:08:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:20121 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgINQHQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 12:07:16 -0400
IronPort-SDR: Q95QUSTE79/pFCwBScfYGYrVMaY3/mlLbcxl+E6wE8B3F/k4P14GpEiRn+fzPJgtec3IXRTj/5
 w+0Q+4P6idSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="177163241"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="177163241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 09:06:41 -0700
IronPort-SDR: QSuTLZPYyEx/9A4qq6SZEnLbfXsDH2Pdk9RcBl+P4oAtC0CPqqKrHLwbet1Df3Vp1mqEj+9ZMD
 kN0OORP71wCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335327535"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 09:06:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kHqzy-00Gda8-Gs; Mon, 14 Sep 2020 19:06:34 +0300
Date:   Mon, 14 Sep 2020 19:06:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 1/2] tty: serial: print earlycon info after match->setup
Message-ID: <20200914160634.GL3956970@smile.fi.intel.com>
References: <20200911093927.608024-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911093927.608024-1-hsinyi@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 11, 2020 at 05:39:26PM +0800, Hsin-Yi Wang wrote:
> 8250 devices may modify iotype in their own earlycon setup. For example:
> 8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
> after match->setup to reflect actual earlycon info.

But this means you do something which user didn't ask for...

> +static void __init earlycon_info(struct earlycon_device *device)

Can it be earlycon_pr_info() or earlycon_print_info() ?

-- 
With Best Regards,
Andy Shevchenko


