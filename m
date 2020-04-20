Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F7C3815B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AC205C9
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTKq2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:46:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:17454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTKq2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 06:46:28 -0400
IronPort-SDR: /Nt/pPBYax6XACvcySdd9KYshcUep/va6JxsjgMex5BQVvUiYJe1TKE6j7nGKQjdtexzXRtbv6
 D0ZGpPUKki6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 03:46:27 -0700
IronPort-SDR: gqUa2NhFFBxpA+ZVLvhBn8RJ1hvpe6GB49JVUbOyEeRIcPXjthoaV+XHMwtDv7/Aw2elwXYQsb
 57n4HI9A7boQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="456343723"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2020 03:46:22 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQTwW-0020d9-Vj; Mon, 20 Apr 2020 13:46:24 +0300
Date:   Mon, 20 Apr 2020 13:46:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     sean.wang@mediatek.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de,
        joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com,
        heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v2] tty: serial: don't do termios for BTIF
Message-ID: <20200420104624.GM185537@smile.fi.intel.com>
References: <8c47aea3aa3cce4d7484b840ddb117cd16bcf1cc.1587347988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c47aea3aa3cce4d7484b840ddb117cd16bcf1cc.1587347988.git.sean.wang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 20, 2020 at 10:06:38AM +0800, sean.wang@mediatek.com wrote:
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
> So adding a new capability 'UART_CAP_NMOD' for the unusual unsupported
> case.

...

> +#define UART_CAP_NMOD	(1 << 18)	/* UART doesn't do termios */

I would rather spell it as NTIO or NO_TIO (as TIO is a well established prefix
for termios IOCTLs).


-- 
With Best Regards,
Andy Shevchenko


