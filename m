Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24FC38142
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 12:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAWMig (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 07:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjAWMif (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 07:38:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BF1115C
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 04:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674477506; x=1706013506;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zoQZj/lTw5ujwTSQro8NimFwJFxnD3Al26m4qfo2Ctg=;
  b=F+PpTPU127Oa9xfHpWtckx7Cc0sgSw2oNyu7eF4YPuqzk+wW39fhAiWV
   UQNK0RosMws3BvbMsAtzUi7F6449rU9QZaeZHZe2WgQqIXk+sUg/F5BCs
   79TUcFURziWNgvYIW/EGcKfl7vHkEji/CPX93862UdhbMT+gjNsDH282+
   zTuH76mOOZbzhC/GT+PSgQUuoe4S/c2pf20hXU3a4UynGp4qDl6Ecqj8M
   jrAShLOLfEnjlZzlGdA66PilyAcBpHT9u9JGeXgMyfNf9W6UVSxv23hI7
   nprVC81u4HIiD1M1kll7T7gEfUBmwwsJZQxtBt1nPQXzrEM/aY6A+8Z79
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="323720791"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="323720791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:38:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="750306400"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="750306400"
Received: from giangiac-mobl1.amr.corp.intel.com ([10.249.47.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:38:21 -0800
Date:   Mon, 23 Jan 2023 14:38:15 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergey Organov <sorganov@gmail.com>
cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
In-Reply-To: <87fsc3wqdl.fsf@osv.gnss.ru>
Message-ID: <34438e1a-1978-7c66-26b-311258a86e30@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230121153639.15402-1-sorganov@gmail.com> <20230121153639.15402-4-sorganov@gmail.com> <6dc81996-6ffc-c1bc-6c3f-ca65055c94a2@i2se.com> <87fsc3wqdl.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 22 Jan 2023, Sergey Organov wrote:

> Hi Stefan,
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Sergey,
> >
> > Am 21.01.23 um 16:36 schrieb Sergey Organov:
> >> Do not call uart_handle_sysrq_char() if we got any receive error
> >> along with the character, as we don't want random junk to be
> >> considered a sysrq.
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >
> > this looks like a bugfix to me. Since the relevant code is pretty old,
> > i'm not sure about the fixes tag here:
> >
> > Fixes: 279a9acc9b72 ("2.6.11 import") ?
> 
> Dunno. I've checked a few drivers, and it seems that they don't care
> either, e.g., look at atmel_serial.c, or mpc52xx_uart.c.
> 
> Either it doesn't matter, or a few drivers need similar fix? What's
> going on here, I wonder?

Usually when one finds a bug from one of the drivers, the other drivers 
indeed turn out to have the same/similar bug(s).  It's not something 
uncommon.

So just fix them all, it's very much appreciated. :-) I understand it 
might not be possible to test all such fixes on those other HWs but 
usually such bugs are simple enough to fix that it isn't be a big problem.


-- 
 i.

