Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70173C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbiDSKjX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiDSKjU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 06:39:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D22B19F
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650364598; x=1681900598;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7WsIcPWidi2H/jOzyuJecU5DNLUakP0DsuMIJCHNWDk=;
  b=AbWy/RaxxtcoNK/otjLwYYj3gX2J3z5iCIYR+FU1yo3g4gYIQwtoctmZ
   7a7pJKM7P25IwG5VxY7p65Yru3ec6OV+SbaB94MvfwB0ikLXBqDRpkfxd
   yoimRF+SHrBQqSq1DEP48NfUeo1/EZFTefIkS1oQRBKOP+eCm+Ty8Ksij
   wXVI9NnlU6i5CeQ1wbR2ZCj3REgMqigMBpTI8hzu89xnbQLk+V4Y6YqrA
   ogFyuHLi4S389M2CD+EeqRvRioTUbiRIzLfAIQe20X9vz7jwYIwYIvQln
   toJTiOBuPHJ5+KbyrjC6rFDh5uGdsWmMw+ZAXocxbrzxm0LXouVBMsqcy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262592483"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262592483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 03:36:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576038417"
Received: from dbenelli-mobl.ger.corp.intel.com ([10.252.56.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 03:36:34 -0700
Date:   Tue, 19 Apr 2022 13:36:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
In-Reply-To: <Yl6KyWGmB5+KOAKU@kroah.com>
Message-ID: <de499011-16e2-1ef5-5cb6-ae6dcdc3f2de@linux.intel.com>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de> <20220330104642.229507-2-u.kleine-koenig@pengutronix.de> <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com> <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de> <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
 <893fcf29-20da-2a4-5951-d956472f85f@linux.intel.com> <Yl6KyWGmB5+KOAKU@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1915478063-1650364597=:1610"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1915478063-1650364597=:1610
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 19 Apr 2022, Greg Kroah-Hartman wrote:

> On Tue, Apr 19, 2022 at 11:09:56AM +0300, Ilpo Järvinen wrote:
> > Hi Greg,
> > 
> > This change now appears in your tty-next tree.
> 
> What change?  Please never top-post.

f6f586102add59d57bcc6eea06fdeaae11bb17a1 (serial: 8250: Handle UART 
without interrupt on TEMT using em485).

> > As you seem to have missed 
> > there is an obvious problem with it, I'm asking which direction I should 
> > take to fix it.
> 
> Send a fix!  You don't need my permission to do so.

Yes, I know I don't need permission :-).

What I asked is whether I should provide:
  a) a minimal fix to the issue in this particular change
or
  b) send patches that replace this notemt approach with the another
     that I believe is better than this one (*)
?

(*) In case you want to see the another approach before answering, it's 
part of my RS485 patchset (patches 1-2) [1]. My solution doesn't need
the extra notemt timer and also allows drivers easy access to frame
timing information (rather than them storing it per purpose).


-- 
 i.

[1] https://lore.kernel.org/linux-serial/20220411083321.9131-3-ilpo.jarvinen@linux.intel.com/T/#u
--8323329-1915478063-1650364597=:1610--
