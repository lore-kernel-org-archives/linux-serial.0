Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68BCC433F5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Oct 2022 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiJFLAQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJFK7x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Oct 2022 06:59:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB7F25
        for <linux-serial@vger.kernel.org>; Thu,  6 Oct 2022 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665053975; x=1696589975;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZMqrBHvqNV58hteeylXDzcWuIjXWnAUh4Oywy/3PET8=;
  b=Bfx3OGp4zQD69q7WgGrj/yRAZgwh1OdGB9A0lY2/VF3LLVHoPs1uMzg8
   2cYnGcK1/5SPPr/lR6a5dK4RTTC5fnO/pJO+Bes28HTxD4BsiTzFUgicj
   zFASWCvqANKBpyZQJymvYqcVabzf32LYsMo+Wiv31nj6HN9cwTL0bBdlf
   dBoE+4mLepE0IjIUY+zFbW7LfpmW3ETCDmatBv0Qal+v3t3q0yJ2uCltg
   0j7jITowX+FKhYeTvAUFu7WDsb7pfyHKaH4T2O6sT3Zsv71Nn9ZNvoOcM
   BMdK2L+A6yndlmGc+qa8Uo4vXnvVTXdqPfUp/mDeDSmt8e89dplSgvnsG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="283130231"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="283130231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 03:59:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="767107575"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="767107575"
Received: from pandeyma-mobl1.ger.corp.intel.com ([10.249.35.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 03:59:12 -0700
Date:   Thu, 6 Oct 2022 13:59:01 +0300 (EEST)
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
In-Reply-To: <20221006062126.GA26272@wunner.de>
Message-ID: <80d9c8f9-bb20-6792-7c7-544e6bf8a899@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de> <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com> <20221003195459.GA11858@wunner.de> <89a1308-d325-ba17-7e8c-5a7f4a38f58d@linux.intel.com>
 <20221006062126.GA26272@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1837207576-1665053954=:1749"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1837207576-1665053954=:1749
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 6 Oct 2022, Lukas Wunner wrote:

> On Tue, Oct 04, 2022 at 12:06:21PM +0300, Ilpo Järvinen wrote:
> > On Mon, 3 Oct 2022, Lukas Wunner wrote:
> > > On Wed, Sep 28, 2022 at 02:38:40PM +0300, Ilpo Järvinen wrote:
> > > > 
> > > > I guess .rs485_supported shouldn't be equal in both cases?
> > > 
> > > I contemplated whether it should be different for hardware-assisted
> > > RS485 but came to the conclusion that it shouldn't:
> [...]
> > Core is not handling just flags but also delay_rts_before_send and 
> > delay_rts_after_send sanitization. See 
> > uart_sanitize_serial_rs485_delays().
> > 
> > Btw, you can also get rid of this line once you provide separate 
> > rs485_supported:
> > 	rs485->delay_rts_before_send = 0;
> > 
> > What to do with delay_rts_after_send seems bit trickier though. Looking 
> > the code, it cannot be configured to arbitrary values by the user but it 
> > might not be zero either after the driver touches it. Maybe it safer to 
> > have it supported (set to 1) to avoid spuriously triggering the warning in 
> > uart_sanitize_serial_rs485_delays() (e.g., during init if non-zero delay 
> > is provided).
> 
> If I understand Figure 12-276 on page 8783 of the AM65 TRM correctly,
> there appears to be a 1 bit clock delay between writing to the THR register
> and transmission of the start bit:
> 
>   https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> I intend to respin the patch with the following addition:
> 
>   fixed_delay_rts_before_send = 1 * MSEC_PER_SEC / baud;
> 
> As a result, both delay_rts_before_send and delay_rts_after_send should be
> set to 1 in the rs485_supported struct for hardware-controlled RTS.

Ok. I was just commenting what the code did but of course if you change 
it the situation is different then.

> The resulting struct is identical to serial8250_em485_supported.

Please note it down somewhere (either commit message or comment at the
rs485_supported assignment) so that somebody else after us doesn't need 
to dig up this thread.


-- 
 i.

--8323329-1837207576-1665053954=:1749--
