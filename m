Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD43C38142
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 09:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBAJ17 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBAJ17 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 04:27:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69786587;
        Wed,  1 Feb 2023 01:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D13161723;
        Wed,  1 Feb 2023 09:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B2C433D2;
        Wed,  1 Feb 2023 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675243677;
        bh=eTmxy+fQ3CapAdxgxRocAgiDcADfaJKCN4N8iMW4OIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xO1YHaCTzzVrlWlXX3kfHoWq6pCFsj1Di7enpaQi6IZ2XJTLnHILyRMku+xmfjKFp
         H1pc3SYUcNUS0mhc3Mss+nXADPrCCn1sxUFx9Q8d8NSn9V/HwsN4gt+OCIKLDJP5+N
         gEaIOlqZbKcKAzNLGyh8Zbu7tQrBlpt692tSKJBU=
Date:   Wed, 1 Feb 2023 10:27:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: n_gsm: add keep alive support
Message-ID: <Y9owmfZwKn9+1xBf@kroah.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <Y9olcm0PiSCSikri@kroah.com>
 <DB9PR10MB58814F4711FC3403F7AF089BE0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58814F4711FC3403F7AF089BE0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 01, 2023 at 09:17:31AM +0000, Starke, Daniel wrote:
> > > index cb8693b39cb7..b64360aca1f9 100644
> > > --- a/include/uapi/linux/gsmmux.h
> > > +++ b/include/uapi/linux/gsmmux.h
> > > @@ -19,7 +19,8 @@ struct gsm_config
> > >  	unsigned int mtu;
> > >  	unsigned int k;
> > >  	unsigned int i;
> > > -	unsigned int unused[8];		/* Padding for expansion without
> > > +	unsigned int keep_alive;
> > > +	unsigned int unused[7];		/* Padding for expansion without
> > 
> > "unsigned int" is not really a valid uapi variable type.
> > 
> > Shouldn't this be __u32 instead?
> 
> I know but changing it to a fixed size data type may break compatibility
> as this may change the overall size of the structure.

Will it?  It shouldn't that's why using the correct data types is
essencial.

> This is why I
> took a field out of the "unused" array for the "keep_alive" parameter.
> A value of zero disables keep-alive polling.
> 
> > Should you document this field as to what the value is and the units as
> > you are creating a new user/kernel api here.
> 
> I will add a comment here. Comments for the other fields remain subject to
> another patch.
> 
> > And finally, "unused" here is being properly checked to be all 0, right?
> > If not, then this change can't happen for obvious reasons :(
> 
> This was not the case until now. I assumed there was some coding guideline
> that unused fields need to be initialized to zero. Obviously, checking it
> prevents misuse here. I will add relevant checks for this.

If the value was not checked previously, then you can not use the field
now, otherwise things will break, sorry.  Those are useless fields and
should be marked as such :(

sorry,

greg k-h
