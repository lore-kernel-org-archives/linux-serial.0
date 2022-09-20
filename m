Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A3ECAAD8
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 12:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiITMCb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiITMCa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 08:02:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A128614E
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663675349; x=1695211349;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Soaz5yLXpAUwuoQU/VWIbRMgIEbmH1TeN8KsnMeqr8k=;
  b=f6SU4LAEVpnlOCNoSimHPLI9HNooptlT3+JcX8TJCAVob+2mswJVu4p+
   RN4P10+k0fzSiPgHV3BomCnWQ91MWHJf1g02TXEckXyMDsQrKao2t04rM
   bqtDi3bKwUzWxvqXOTC4nXC2LKjpjLfkWGjvqvjUEL0ahw0/lnUZ0kFUd
   T11BPQsoPnO9ajXJZCzQmDmNoI5746Iwbq7W7WcuDTZGHG0qRoF1oAXms
   pvLgUx/3bRuyw4SP7bAF5ahLaTHlQbVRRNvllidsHU6CzwAMrzKfmSvuM
   d/V83mnPYxoJK9fAURn0ZntwH9BqBS+XxliU51Rukaj+/D2P4VUu9a9rs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="301052334"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301052334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:01:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="614369341"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:01:55 -0700
Date:   Tue, 20 Sep 2022 15:01:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        heiko@sntech.de, giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4 04/13] serial: 8250_dwlib: RS485 HW half & full duplex
 support
In-Reply-To: <20220920113704.GA12014@wunner.de>
Message-ID: <64fb5487-76c6-f6ed-d110-c98bde2f7917@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com> <20220425143410.12703-5-ilpo.jarvinen@linux.intel.com> <20220920113704.GA12014@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1958180296-1663675318=:1766"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1958180296-1663675318=:1766
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Lukas Wunner wrote:

> On Mon, Apr 25, 2022 at 05:34:01PM +0300, Ilpo Järvinen wrote:
> > +	/* Reset to default polarity */
> > +	tcr |= DW_UART_TCR_DE_POL;
> > +	tcr &= ~DW_UART_TCR_RE_POL;
> > +
> > +	if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
> > +		tcr &= ~DW_UART_TCR_DE_POL;
> > +	if (device_property_read_bool(p->dev, "rs485-rx-active-high"))
> > +		tcr |= DW_UART_TCR_RE_POL;
> 
> Something that only occurred to me after this got merged:
> 
> You're using "identity" polarity for hardware-driven Driver Enable,
> i.e. if SER_RS485_RTS_ON_SEND is set, then DE is driven high on send.
> 
> The em485 software-driven Driver Enable on the other hand uses the
> opposite polarity for historical reasons.
> 
> So if someone has been using RS485 with software emulation so far on
> a DesignWare 4.0 UART, they'll have to change their ACPI tables or
> DeviceTree once they move to a kernel which includes the above-quoted
> patch.  Such users probably don't exist because the DesignWare 4.0 UART
> was introduced relatively recently.

I don't think you can just move from one to another like that because DE 
and RTS are not the same signal on these UARTs. So it's not going to be 
compatible w/o additional effort anyway.

Initially, I tried to add a flag for selecting between the HW one and 
emulation but got overruled (you were among the opposing people ;-)).
...IIRC, I tried to explain back then that those signals are not the
same with this HW.

-- 
 i.

> Personally I'm in favor of the polarity you've chosen.  It's too late
> to change now anyway.
> 
> Thanks,
> 
> Lukas
> 

--8323329-1958180296-1663675318=:1766--
