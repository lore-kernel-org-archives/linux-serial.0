Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF147C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Oct 2022 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDJGa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDJG3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Oct 2022 05:06:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F02CC9E
        for <linux-serial@vger.kernel.org>; Tue,  4 Oct 2022 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664874388; x=1696410388;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=VJ5YEzCmI1/fbFvmF44a2Hg+qHx3s75NM7V1tc/Qfeg=;
  b=ZoAzaukHSLjm9RMwqBJkUaqUU4pTrBL5W9t+uAsebvsrcTBR40X6zXkP
   ZMXMD1NORM3tcwkh+6YFAZDFoggypiB8b/5OZ4zfVIwvsRlQSiagIRrNB
   3aTWsB6v1Td+rmvrSwPNFQQPytfzGpdfjQvKvACVdwk7PZy+rCCI+/vnP
   HznRRU50cmfzraagORI79kPB4e0l/iLnkoK5pN6Q9DDbGvBwKSPTng5YU
   vXTysuKElCd0SrIX7hPy2J7ZKqS7UMSpaUXp8FrMCNTqqpIjOY+2dLGcB
   ZsoQ9hTFJcC7ncwKmXsCOCPDO4bZ46UBLNJNsVoEg0swXjUmT7EegSn/O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="329266885"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="329266885"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:06:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="626112763"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="626112763"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:06:24 -0700
Date:   Tue, 4 Oct 2022 12:06:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
In-Reply-To: <20221003195459.GA11858@wunner.de>
Message-ID: <89a1308-d325-ba17-7e8c-5a7f4a38f58d@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de> <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com> <20221003195459.GA11858@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-875741195-1664873001=:1585"
Content-ID: <d2854b4c-2f6d-d6d0-9dde-a4c298bb4024@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-875741195-1664873001=:1585
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <16bf6e4e-b4fb-df4b-9ea-aaec5fa7c031@linux.intel.com>

On Mon, 3 Oct 2022, Lukas Wunner wrote:

> On Wed, Sep 28, 2022 at 02:38:40PM +0300, Ilpo Järvinen wrote:
> > On Tue, 27 Sep 2022, Lukas Wunner wrote:
> > > Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> > > automatically assert RTS when data is transmitted, obviating the need
> > > to emulate this functionality in software.
> > > 
> > > The feature is controlled through new DIR_EN and DIR_POL bits in the
> > > Mode Definition Register 3.  For details see page 8783 and 8890 of the
> > > AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> [...]
> > > @@ -1335,10 +1387,7 @@ static int omap8250_probe(struct platform_device *pdev)
> > >  	up.port.shutdown = omap_8250_shutdown;
> > >  	up.port.throttle = omap_8250_throttle;
> > >  	up.port.unthrottle = omap_8250_unthrottle;
> > > -	up.port.rs485_config = serial8250_em485_config;
> > >  	up.port.rs485_supported = serial8250_em485_supported;
> > > -	up.rs485_start_tx = serial8250_em485_start_tx;
> > > -	up.rs485_stop_tx = serial8250_em485_stop_tx;
> > >  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> > >  
> > >  	ret = of_alias_get_id(np, "serial");
> > > @@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
> > >  			 DEFAULT_CLK_SPEED);
> > >  	}
> > >  
> > > +	if (priv->habit & UART_HAS_NATIVE_RS485) {
> > > +		up.port.rs485_config = omap8250_rs485_config;
> > > +	} else {
> > > +		up.port.rs485_config = serial8250_em485_config;
> > > +		up.rs485_start_tx = serial8250_em485_start_tx;
> > > +		up.rs485_stop_tx = serial8250_em485_stop_tx;
> > > +	}
> > 
> > I guess .rs485_supported shouldn't be equal in both cases?
> 
> I contemplated whether it should be different for hardware-assisted
> RS485 but came to the conclusion that it shouldn't:
> 
> The polarity may be chosen both for hardware- and software-controlled RTS.
> 
> Whether RX_DURING_TX is possible depends on how the RS485 transceiver
> is wired to the UART:  If RTS asserts !RE on the transceiver when sending,
> the UART cannot receive data, regardless whether hardware- or software-
> controlled RTS is used.
> 
> TERMINATE_BUS works independently from RTS control.
> 
> And ADDRB doesn't seem to be supported in either mode AFAICS.
> 
> Am I missing something?

Core is not handling just flags but also delay_rts_before_send and 
delay_rts_after_send sanitization. See 
uart_sanitize_serial_rs485_delays().

Btw, you can also get rid of this line once you provide separate 
rs485_supported:
	rs485->delay_rts_before_send = 0;

What to do with delay_rts_after_send seems bit trickier though. Looking 
the code, it cannot be configured to arbitrary values by the user but it 
might not be zero either after the driver touches it. Maybe it safer to 
have it supported (set to 1) to avoid spuriously triggering the warning in 
uart_sanitize_serial_rs485_delays() (e.g., during init if non-zero delay 
is provided).

-- 
 i.
--8323329-875741195-1664873001=:1585--
