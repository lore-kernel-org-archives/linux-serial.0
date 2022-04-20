Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C328AC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 20 Apr 2022 08:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbiDTIUM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346267AbiDTIUM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Apr 2022 04:20:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F209237FF
        for <linux-serial@vger.kernel.org>; Wed, 20 Apr 2022 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650442647; x=1681978647;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Wz47dNMM3+AgPqYVOYzgjlrBhBG0+EI7sk9FMziUBtk=;
  b=YgrmhjsRNtDhfhaoJm/ehL/OSZPSXNBKHtgJP9NVlntgQ3CL5gbh/FmO
   TOBSjzzOceUARuP/0d5qLQaRqDZuNzRpkcAEe+bEVkaDcnV3ptm9ELe7T
   YmAusGJSukEDzXaSJSkkaiXnE171nIubdPHqhyB4CSs5P0nRB9XvHMS1O
   xLHIwWJDFtxMhU+dnv5ajGOBleAw5uk1su3T0oJ5nOt1JJ7qJUsrDfarE
   qQy82el9Dr5uo6sc7Dj18hZV/XQZSFnF1HHmdRH4suviKTna9HZDEzxcw
   IqJMxyTuxI6owNzDiQAFSLrbZTXSDuGOJKOcN/b00jQD1XZ51tGd5rTNF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324412493"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="324412493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:17:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="576478965"
Received: from isyrjala-mobl1.ger.corp.intel.com ([10.252.56.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:17:23 -0700
Date:   Wed, 20 Apr 2022 11:17:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/1] serial: 8250: revert UART_CAP_NOTEMT changes
In-Reply-To: <20220419142405.xpwzvgnmh3oyoxge@pengutronix.de>
Message-ID: <905f758d-1c93-1c6-10c4-adf9f4d59a88@linux.intel.com>
References: <db15ba9d-d914-53fa-23b8-870df7bb13@linux.intel.com> <20220419142405.xpwzvgnmh3oyoxge@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1052669640-1650441572=:1631"
Content-ID: <7947ba95-dabc-5cea-809-e374de7dfcf0@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1052669640-1650441572=:1631
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <743b8f0-ec96-a63-c6b3-8263cd549146@linux.intel.com>

On Tue, 19 Apr 2022, Uwe Kleine-König wrote:

> Hello,
> 
> On Tue, Apr 19, 2022 at 04:39:49PM +0300, Ilpo Järvinen wrote:
> > 
> > This reverts UART_CAP_NOTEMT commit and driver changes depending
> > on it:
> >   f6f586102ad1 (serial: 8250: Handle UART without interrupt on TEMT
> >                 using em485)
> >   296385fe1275 (serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64)
> >   bec1f1b66a6a (serial: 8250: add compatible for fsl,16550-FIFO64)
> > 
> > The UART_CAP_NOTEMT code added in f6f586102add1 (serial: 8250:
> > Handle UART without interrupt on TEMT using em485) containts math
> > overflow for 32-bit archs. In addition, the approach used in it
> > is unnecessarily complicated requiring a dedicated timer just for
> > notemt. A simpler approach for providing UART_CAP_NOTEMT already
> > exists (patches 1-2):
> >   https://lore.kernel.org/linux-serial/20220411083321.9131-3-ilpo.jarvinen@linux.intel.com/T/#u
> > Thus, simply revert the UART_CAP_NOTEMT changes for now.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Oh I wasn't aware that Greg picked that up. OK for me to revert.
> 
> I wonder however if it's nice to revert three patches in one commit. I
> would have just reverted f6f586102ad1 and kept the define
> UART_CAP_NOTEMT such that the other two patches are noops until your
> fixed series comes in. Just my 0.02¤.

I was thinking along the same lines but was a little worried Greg would
be against such a solution. ...I'll send v2 with only that single commit
reverted.

-- 
 i.
--8323329-1052669640-1650441572=:1631--
