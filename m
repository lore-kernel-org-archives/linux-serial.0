Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE9C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F186137C
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 08:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhJEIu2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:50:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25522 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhJEIuY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 04:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633423714; x=1664959714;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAHa3Ext8eq1O+ssgw3md3aIV7iiyLnSkSOZaV8PZeI=;
  b=QSqOhE8t9FRJjYDqmEdlkCeqG5osD10JD/sf6g/IA9hOVd4xnJ+1jqSF
   xd+BVapw+UYvAC/1tx25De5HQS4U5CcHNLySLW/fmevIM0+0IaN/ATeGu
   tFsFAhEq84obHGbDvWbGkxrtnu/2gqKrd0mdIY12dwIGOJsmeAGjGNxV8
   AosTaM64ZCQW4qvYEOnPOSlDuWe3b8vA6+cTG5r884JLVPkwyWBIDCw6q
   B5w9t6tPzqKR7uTlSbk9G/xtQTvgZYFR3p6OG8z5aN1GFVrDAP3W/g7xf
   FE1pBKLPoQk9tUKwX/lI1ascMRSUb7vyQbW/vFBMGctjQ9l3tG7TDeTlB
   Q==;
IronPort-SDR: rb/8TfmN5pmN4fC5pLb6sECmyZcjdwWR6g9vR/6BsqF3614M5OB3ZocAItHetrfENe+t71cZKG
 OlOVz3G1ZfYPLBxUgeXK9OUN1aHzNpZTgPFXyK+TaJQSVKMCOKCBxVui3q5g2r1Sbdzggkco7R
 +BoKLZAuHNhDw1wnqBIf3Luzj/x0u0j7WHuZtQmVXG5JEmwm/YrznO0a96nwCIGG+n3yvIe2QN
 PiW4S9e795v7/qT+lDqMkGOBNw6NrU6XYWUi8bMM0YrqozI/0YC4D78TVdCS7llBq/sUIgJJ0T
 Yvf9RWVbN5HYyIQ2r97NGbr/
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="146790060"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 01:48:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 01:48:34 -0700
Received: from CHE-LT-I41642.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 01:48:30 -0700
Message-ID: <2b37141fcb1067f9322bca5f6d83818d380b7c6a.camel@microchip.com>
Subject: Re: [PATCH v1 0/3] serial:8250:Add driver support for MCHP PCI1XXXX
 UART module
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <macro@orcam.me.uk>, <zev@bewilderbeest.net>, <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Date:   Tue, 5 Oct 2021 14:18:29 +0530
In-Reply-To: <YVSY8L6A6H71DvM5@smile.fi.intel.com>
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
         <YVSY8L6A6H71DvM5@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 2021-09-29 at 19:48 +0300, Andy Shevchenko wrote:
> [Some people who received this message don't often get email from
> andriy.shevchenko@linux.intel.com. Learn why this is important at 
> http://aka.ms/LearnAboutSenderIdentification.]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> On Wed, Sep 29, 2021 at 05:00:46PM +0530, LakshmiPraveen Kopparthi
> wrote:
> > PCI1XXXX UART is a PCIe to UART module. It has 5 SKUs, each is
> > differentiated by the device IDs in the PCIe config space. Each
> > SKU supports a maximum of 4 UART ports(UART0,1,2,3) with fixed
> > offests.Based on the sub device ID, the combinations of UART
> > ports shall be enumerated.
> > 
> > The UART port is compatible with the standard 16550A, but has some
> > modifications.The modifications includes a change in the baud rate
> > settings,auto control of RTS signal for RS485 feature and an
> > increase of TX & RX FIFO size to 256 Bytes.Also, it has a
> > capability
> > to wake up the CPU.
> > 
> > These patches adds the support to enumerate and exercise all the
> > combinations of UART ports in all the SKUs.
> >  drivers/tty/serial/8250/8250_pci.c  | 384
> > ++++++++++++++++++++++++++++
> 
> Please, do not add this to 8250_pci.c. Use separate quirk driver as
> it's done
> in plenty of examples:
> 
>         8250_lpss.c, 8250_mid.c, 8250_exar.c, ...

Thanks for pointing the examples. I have looked into these examples and
the required functionality can be achieved with a separate driver. But
I would like to know the reason for not adding this to 8250_pci.c. 

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

