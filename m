Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A7C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36F20714
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgBKNrc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:47:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:35531 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgBKNrc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 08:47:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="433683707"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2020 05:47:30 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1Vsy-000kvm-36; Tue, 11 Feb 2020 15:47:32 +0200
Date:   Tue, 11 Feb 2020 15:47:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= serial:
 8250_pnp: pass IRQ shared flag to UART ports
Message-ID: <20200211134732.GC10400@smile.fi.intel.com>
References: <1581223347-31534-1-git-send-email-lirongqing@baidu.com>
 <20200210100943.GR10400@smile.fi.intel.com>
 <09a4fa15c8ae4a7391787e4b4af30399@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09a4fa15c8ae4a7391787e4b4af30399@baidu.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 10, 2020 at 12:54:47PM +0000, Li,Rongqing wrote:
> > -----邮件原件-----
> > 发件人: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> > 发送时间: 2020年2月10日 18:10
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: gregkh@linuxfoundation.org; jslaby@suse.com;
> > haolee.swjtu@gmail.com; linux-serial@vger.kernel.org
> > 主题: Re: [PATCH] serial: 8250_pnp: pass IRQ shared flag to UART ports
> > On Sun, Feb 09, 2020 at 12:42:27PM +0800, Li RongQing wrote:
> > > On some systems IRQ lines might be shared between multiple devices.
> > > If so, the irqflags have to be configured accordingly. The reason is:
> > > The 8250 port startup code performs IRQ tests *before* the IRQ handler
> > > for that particular port is registered.
> > 
> > Thanks for the report.
> > 
> > Before we proceed with it, can we have more information about the device in
> > question?
> > How is it enumerated? What is in resources (ACPI / or ...?) for this device?
> > Also how IPMI is being involved to all this and why?
> > 
> 
> This is arm server, resource is from dsdt, and detail is

> And I think we has the same issue.
> 
> Author: Kurt Kanzenbach <kurt@linutronix.de>
> Date:   Fri Mar 16 12:31:58 2018 +0100
> 
>     tty: serial: 8250: pass IRQ shared flag to UART ports

Thanks for sharing additional information.

Funny that the mentioned commit describes everything and had done a symptomatic
healing instead of fixing it properly.

So, I will send a patch later Cc'ing you. I would like to be informed if it
helps (in form of Tested-by tag).

-- 
With Best Regards,
Andy Shevchenko


