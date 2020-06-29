Return-Path: <SRS0=FCDA=AK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C442C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33941208DB
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgF2VXa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:23:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:63956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbgF2SvT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:19 -0400
IronPort-SDR: 6tz/aK0mFFjsu6H6gRYNe7UNCe03xG7aMFSa1UMK77M7EhZPp12gJ70IXm9mHXkVQvQlBP04yx
 t2nIO0oFgi3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145924785"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="145924785"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:29:33 -0700
IronPort-SDR: Yje5pJtHisKCnMm9oaXwD3WOMepqsjCYESgdEHBWDtl9I+QL0Q7N0Oz6cvmmd8a5TR8Zpr/IjD
 nBi8NdHXLoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="480704639"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 01:29:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jppAN-00Gcni-K1; Mon, 29 Jun 2020 11:29:27 +0300
Date:   Mon, 29 Jun 2020 11:29:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sean.wang@mediatek.com, robh+dt@kernel.org, jslaby@suse.com,
        robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de,
        joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com,
        heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v4] tty: serial: don't do termios for BTIF
Message-ID: <20200629082927.GA3703480@smile.fi.intel.com>
References: <78efa2b1e2599deff4d838b05b4054ec5ac2976a.1592595601.git.sean.wang@mediatek.com>
 <20200627141222.GC1901451@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627141222.GC1901451@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 27, 2020 at 04:12:22PM +0200, Greg KH wrote:
> On Sat, Jun 20, 2020 at 03:59:14AM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> > BT in order to be instead of the UART interface between BT module and Host
> > CPU, and not exported to user space to access.
> > 
> > As the UART design, BTIF will be an APB slave and can transmit or receive
> > data by MCU access, but doesn't provide termios function like baudrate and
> > flow control setup.
> > 
> > Even LCR on offset 0xC that is just a FAKELCR
> > a. If FAKELCR[7] is equaled to 1, RBR(0x00), THR(0x00), IER(0x04)
> >    will not be readable/writable.
> > 
> > b. If FAKELCR is equaled to 0xBF, RBR(0x00), THR(0x00), IER(0x04),
> >    IIR(0x08), and LSR(0x14) will not be readable/writable.
> > 
> > So adding a new capability 'UART_CAP_NTIO' for the unusual unsupported
> > case.
> > 
> > The bluetooth driver would use BTIF device as a serdev. So the termios
> > still function would be called in kernelspace from ttyport_open in
> > drivers/tty/serdev/serdev-ttyprt.c.

> > +#define UART_CAP_NTIO	(1 << 18)	/* UART doesn't do termios */
> 
> Naming is hard.  I will never remember what "NTIO" is, how about we make
> it explicit:
> 	define UART_CAP_IGNORE_TERMIOS
> 
> And the _CAP_ name is getting out of hand, this isn't a "capability",
> it's a "quirk for this port" but that's a battle to worry about later...

For quirks we have a separate field in struct uart_port. Perhaps that can be used?

-- 
With Best Regards,
Andy Shevchenko


