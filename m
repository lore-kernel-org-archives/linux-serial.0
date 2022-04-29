Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B87DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 12:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358942AbiD2MPb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358940AbiD2MP3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 08:15:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26937B7C79
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 05:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4027B83465
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 12:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FEBC385A7;
        Fri, 29 Apr 2022 12:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651234328;
        bh=uN0fz742Tw98hyDlFricUb69AX0MR9uGe1tUmSBXOy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0P6e0T8Dff8rsQR1aif09EVoFV7Y7+NRmhauKs5bQNGGe0ytHLMaxcF5u9Xf5Vs51
         +oDdpFdPXaK8Xf5JqKPDMT/VA4QbX5vpUCaCnvX/tI9RR5c9dgkZqz2825awETSQIx
         P13ImINZKJulXNTnOKNciTGbSFMVTFH6fzz/dyOs=
Date:   Fri, 29 Apr 2022 14:12:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Nuno =?iso-8859-1?Q?Gon=E7alves?= <nunojpg@gmail.com>,
        Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
Message-ID: <YmvWFQultpccovgb@kroah.com>
References: <d4f254ec-b73-786c-dc47-629aab8a49df@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4f254ec-b73-786c-dc47-629aab8a49df@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 29, 2022 at 02:57:16PM +0300, Ilpo Järvinen wrote:
> The driver must provide throttle and unthrottle in uart_ops when it
> sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> enable_interrupts functions.
> 
> Compile tested (w/o linking).

That shouldn't be here at all, put it below the --- line if its needed.


> 
> Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
> 		     RTS status)

Nit, this should be all in one line.

> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Any reason why you are not cc:ing all the needed people as per
scripts/get_maintainer.pl?

thanks,

greg k-h
