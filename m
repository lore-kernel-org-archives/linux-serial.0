Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5AAC433FE
	for <linux-serial@archiver.kernel.org>; Thu,  5 May 2022 22:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386333AbiEEWhb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 May 2022 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiEEWha (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 May 2022 18:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF15EDEF
        for <linux-serial@vger.kernel.org>; Thu,  5 May 2022 15:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38C661F38
        for <linux-serial@vger.kernel.org>; Thu,  5 May 2022 22:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29517C385A8;
        Thu,  5 May 2022 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790029;
        bh=ylZNJ+UfWm/WIDhKmnOARmjJgtAKo1B2N9/vlDdYJ0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKiM85DLsyi4s1Hnx9a+ZaTo7lfIQXG+X1okg/BaXK74RUksh/i3rYlTRBN/PFNQL
         tQKECCyul+RHitPDSiQDMBQLblCWbfE9KrpB71DRXcX+5IbrAAFdxK81bLmNSkzxkv
         vlyr90JZzwaDu35WA19fFpRnNjMI1bRimBtKgOj8=
Date:   Thu, 5 May 2022 22:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Nuno =?iso-8859-1?Q?Gon=E7alves?= <nunojpg@gmail.com>,
        Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
Message-ID: <YnQykEbvqICyDWQq@kroah.com>
References: <d4f254ec-b73-786c-dc47-629aab8a49df@linux.intel.com>
 <YmvWFQultpccovgb@kroah.com>
 <3f44e8d-3d2d-db4e-6cfc-67ec5824c289@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f44e8d-3d2d-db4e-6cfc-67ec5824c289@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 29, 2022 at 03:33:00PM +0300, Ilpo Järvinen wrote:
> On Fri, 29 Apr 2022, Greg KH wrote:
> 
> > On Fri, Apr 29, 2022 at 02:57:16PM +0300, Ilpo Järvinen wrote:
> > > The driver must provide throttle and unthrottle in uart_ops when it
> > > sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> > > enable_interrupts functions.
> > > 
> > > Compile tested (w/o linking).
> > 
> > That shouldn't be here at all, put it below the --- line if its needed.
> > 
> > 
> > > 
> > > Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> > > Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
> > > 		     RTS status)
> > 
> > Nit, this should be all in one line.
> >
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Any reason why you are not cc:ing all the needed people as per
> > scripts/get_maintainer.pl?
> 
> Yes there is ;-). Around here I'm being told that I should generally
> avoid as much as possible bugging you unnecessarily. ...Or sending garbage
> to you which I feel a compile tested patch for hw I'm not particularly 
> familiar with surely could be. After all this should be tested first and 
> then I'd be resending another version with Tested-by: xx Cc'ing you
> and you would avoid all those intermediate garbage versions :-).

As you can tell, I do see these patches and get concerned when you don't
want the subsystem maintainers to review them.

And our tools can pick up the tested-by lines just fine.  If you don't
want us to apply them, then use RFC and I will gladly ignore it.

thanks,

greg k-h
