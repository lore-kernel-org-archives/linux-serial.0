Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80920C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiDSKOK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDSKOJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 06:14:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9261BE85
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 03:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E20B81603
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 10:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EFCC385A7;
        Tue, 19 Apr 2022 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650363084;
        bh=XqqslBq9xcjVIQennfQ7HTbh7vDBFtV+G9xhPhE9Bs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulJWwJVnUnmcRMI6oh9CYzHQyraSa8d9OKEazPCyqhXSEBGVg0TtAeiJ9VNq3XZ9S
         hzSCOe1Jpq+YpxNccOsLCEr//K3zhhiqL1b7oVcbhUOB+Qm7Yfo10tt9mgpotkisuk
         FmqvUC/jjrqvewtw352xbr/uQ8FKl3/GpuPHQgWw=
Date:   Tue, 19 Apr 2022 12:11:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
Message-ID: <Yl6KyWGmB5+KOAKU@kroah.com>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
 <20220330104642.229507-2-u.kleine-koenig@pengutronix.de>
 <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com>
 <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
 <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
 <893fcf29-20da-2a4-5951-d956472f85f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <893fcf29-20da-2a4-5951-d956472f85f@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 19, 2022 at 11:09:56AM +0300, Ilpo Järvinen wrote:
> Hi Greg,
> 
> This change now appears in your tty-next tree.

What change?  Please never top-post.

> As you seem to have missed 
> there is an obvious problem with it, I'm asking which direction I should 
> take to fix it.

Send a fix!  You don't need my permission to do so.

greg k-h
