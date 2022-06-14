Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C6C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jun 2022 07:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiFNHzR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiFNHzO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jun 2022 03:55:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936035F78
        for <linux-serial@vger.kernel.org>; Tue, 14 Jun 2022 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655193313; x=1686729313;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dWXzZMG7eRYLZLUHynIbDZOE5AhRi6UdvLnLlXcyUuQ=;
  b=EX2OdDdBBAL/PYxPQIrCmiQ+9CbjedX4EkB0heA/vi/30oAbS8ohoM7k
   L/tlPU5L1Ib+G4ZNCGWua5G4enhlOU8IyZZ98VXD88KpZErnkpwARbK4K
   9aBbzak23i+IRu9I85j3nh0iUgQgwFTftPa5CpNjh01dQoPrRfwwmmnvV
   Rt+LqSTBCGW3GO9r4Wgdtcx2ZAFn5VDW66UiPqOA6eRWbEiGN9MKIiRa/
   qrI4laQ5ltoCnHPrgy79mm7HfuZZpgOYoaGdv6NDikBy9nS3Vt41nSIvB
   aVVxUSVuY+/A8j8ER3aAEGDbclKGe22xOfg4Dr2r7awJ4FKIvmgCZ+rf3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277323038"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="277323038"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:55:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640204425"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:55:11 -0700
Date:   Tue, 14 Jun 2022 10:55:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>
cc:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
In-Reply-To: <CAEXMXLTTefeVh3otDL1R0jV0dQh5+S4tfV_zKhZ985V-w1hFLw@mail.gmail.com>
Message-ID: <3b62aed8-7476-2ac8-21a4-1bd3b857851@linux.intel.com>
References: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com> <CAEXMXLRrysT_+RUZ4sg6DGT8Hzdv2jrzX2eZ2Z0mPu39y3-m7g@mail.gmail.com> <ea30fbc2-6535-9fdd-6691-9bb7baa56ec2@linux.intel.com>
 <CAEXMXLTTefeVh3otDL1R0jV0dQh5+S4tfV_zKhZ985V-w1hFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1082420513-1655193312=:1605"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1082420513-1655193312=:1605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jun 2022, Nuno Gonçalves wrote:

> > [PATCH v3] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
> >
> > The driver must provide throttle and unthrottle in uart_ops when it
> > sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> > enable_interrupts functions.
> >
> > Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> > Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto RTS status)
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >
> > ---
> >  drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> 
> Works great, thanks.
> 
> Tested-by: Nuno Gonçalves <nunojpg@gmail.com>

Thanks a lot for testing!

-- 
 i.

--8323329-1082420513-1655193312=:1605--
