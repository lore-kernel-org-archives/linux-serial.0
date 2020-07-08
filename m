Return-Path: <SRS0=q01k=AT=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31767C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jul 2020 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C0E20720
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jul 2020 14:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgGHO6S (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:58:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:54394 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgGHO6R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jul 2020 10:58:17 -0400
IronPort-SDR: ItNlxMO4N6NFzkLUzKIzJTKj+/rPBNB2N2fEThqdQ4ZfnFaBhLekkzMDGpnaA9WEFYO2K1NCUx
 4jZkNgkDLoOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="165921741"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="165921741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 07:58:17 -0700
IronPort-SDR: id16Q0uJtbOwrtqSPDTWmtvVUzlkhQZprKMISQjsDMxp0dUVrEX7FPeAtyajoU+9ZFd/GiqnvE
 KR9Em0UU8CYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="427862028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2020 07:58:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtBWY-000gwo-3z; Wed, 08 Jul 2020 17:58:14 +0300
Date:   Wed, 8 Jul 2020 17:58:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     sean.wang@mediatek.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        mika.westerberg@linux.intel.com, sr@denx.de, arnd@arndb.de,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v5] tty: serial: don't do termios for BTIF
Message-ID: <20200708145814.GN3703480@smile.fi.intel.com>
References: <7c67171728cdcc4ccc10adfaea1a14bfbcf8375a.1594163304.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c67171728cdcc4ccc10adfaea1a14bfbcf8375a.1594163304.git.sean.wang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 08, 2020 at 07:11:22AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> BT in order to be instead of the UART interface between BT module and Host
> CPU, and not exported to user space to access.
> 
> As the UART design, BTIF will be an APB slave and can transmit or receive
> data by MCU access, but doesn't provide termios function like baudrate and
> flow control setup.
> 
> Even LCR on offset 0xC that is just a FAKELCR
> a. If FAKELCR[7] is equaled to 1, RBR(0x00), THR(0x00), IER(0x04)
>    will not be readable/writable.
> 
> b. If FAKELCR is equaled to 0xBF, RBR(0x00), THR(0x00), IER(0x04),
>    IIR(0x08), and LSR(0x14) will not be readable/writable.
> 
> So adding a new capability 'UART_CAP_NTIO' for the unusual unsupported
> case.
> 
> The bluetooth driver would use BTIF device as a serdev. So the termios
> still function would be called in kernelspace from ttyport_open in
> drivers/tty/serdev/serdev-ttyprt.c.

...
>  	up->port.quirks |= skip_txen_test ? UPQ_NO_TXEN_TEST : 0;
> +
> +	if (up->port.type == PORT_MTK_BTIF)
> +		up->port.quirks |= UPQ_IGNORE_TERMIOS;

I don't like to see this in core.

Can we have this inside 8250_port.c? Something like extending struct
serial8250_config to carry quirks and assign them when you add a port or start
it (wherever it's appropriated)?

-- 
With Best Regards,
Andy Shevchenko


