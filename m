Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE2C43219
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354602AbhKXOKV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354590AbhKXOI0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A7B761880;
        Wed, 24 Nov 2021 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637759661;
        bh=HUZjbZ07z+J96RzxS4xQNPBqLVI2Wp8Kk6ALtMXb0i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxbsJIEbsw8/PVCHOx4qPxmhfxv6joedRMHAlwltIqbS0/rqR84sd/PHeWs+qpfwX
         3VFkMiNwl6L2mwWUvwmskzDB5KVgzDa/DLrsDgGceeMbUQjnhpXDNRKfjE0fkHcbpH
         MAEJ6UT7+WucOZtiHBX7END2mtqgliGuyLk/BcI4=
Date:   Wed, 24 Nov 2021 13:45:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jacmet@sunsite.dk" <jacmet@sunsite.dk>, git <git@xilinx.com>
Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
Message-ID: <YZ4z8Z1yjvJVgw9z@kroah.com>
References: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
 <YZ4O+qnkVyhGzuDy@kroah.com>
 <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 24, 2021 at 12:37:00PM +0000, Shubhrajyoti Datta wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, November 24, 2021 3:38 PM
> > To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> > Cc: linux-serial@vger.kernel.org; jirislaby@kernel.org; jacmet@sunsite.dk; git
> > <git@xilinx.com>
> > Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of control
> > register
> > 
> > On Tue, Nov 23, 2021 at 06:43:48PM +0530, Shubhrajyoti Datta wrote:
> > > The control register is a writeonly register that's why reading it
> > > doesn't make any sense.
> > > The manual states "This is a write-only register. Issuing a read
> > > request to the control register generates the read acknowledgment with zero
> > data."
> > 
> > Are you sure this is ok to remove?  Usually you have to do a read after a write to
> > ensure that the write succeeded.
> > 
> > What ensures that the write succeeded now if you remove this read?
> 
> I do not find the mention of a read requirement in the manual. 

Look at your hardware bus documentation.

> Also in the current code in ulite_console_write and in ulite_startup we are writing without a 
> read. 

So is that a bug there?

I am _very_ loath to remove reads like until you can guarantee that it
will not break anything.  Please work with your hardware designers to
ensure this.

thanks,

greg k-h
