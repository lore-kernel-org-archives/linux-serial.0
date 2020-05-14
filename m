Return-Path: <SRS0=CP5M=64=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB9C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C259F20671
	for <linux-serial@archiver.kernel.org>; Thu, 14 May 2020 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589464977;
	bh=iFCeZdSKnhQkYaUcqe+3Vv3aBZRpWF6Ur9i5E/3IwRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wih5afvjr44rFd0313GMos/4Cb7RBbYDzQgg5PCSBI7COxN1ilYvoHFBgngMUuIwT
	 lF0pN2RmqnySAGGgGQcIh9/laT1PkUv0+zCedms0h6brt6Rj+7kQpTXjwdiksadB0E
	 PsIcDxjgd2fLqQ36yQZzdjCby9ucqydxkXWC4pfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENOC5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 May 2020 10:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENOC5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 May 2020 10:02:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A998205CB;
        Thu, 14 May 2020 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589464976;
        bh=iFCeZdSKnhQkYaUcqe+3Vv3aBZRpWF6Ur9i5E/3IwRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3lQASjbxTx+z6ntusrngE+LlOCNGNik0M9YsFvf60rqmROce/D8XjFww5liBZIQi
         h45cvTymnGSiKMzdHeOtK35EMmOK8S5RuTmgXSOXc4J2X/cytzUFOBEaIuAP/wBVMl
         /oPGiTWQLUyKWJWPK0WRu0tY4JIgE5Ds77/NgVaU=
Date:   Thu, 14 May 2020 16:02:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     will@kernel.org, akashast@codeaurora.org,
        linux-serial@vger.kernel.org, saravanak@google.com,
        sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200514140253.GB2581983@kroah.com>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
 <20200506120237.GA3047211@kroah.com>
 <a66f2bdc-57e6-e155-26ce-5643bbc045ad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66f2bdc-57e6-e155-26ce-5643bbc045ad@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 14, 2020 at 07:02:49PM +0530, Mukesh, Savaliya wrote:
> 
> On 5/6/2020 5:32 PM, Greg KH wrote:
> > On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> > > +static void msm_geni_serial_wr_char(struct uart_port *uport, int ch)
> > > +{
> > > +	writel_relaxed(ch, uport->membase+SE_GENI_TX_FIFOn);
> > > +	/*
> > > +	 * Ensure FIFO write clear goes through before
> > > +	 * next iteration.
> > > +	 */
> > > +	mb();
> > Can't you just write the above two lines as:
> > 	writel(ch, uport->membase+SE_GENI_TX_FIFOn);
> > ?
> > 
> > Why put a mb() after a _relaxed() call?
> > 
> > Will, I know I asked you about this on irc a while ago, is the above
> > really correct?
> > 
> > This happens other places in the driver.
> Removed mb() calls due to _relaxed() APIs taking care of the same.
> > 
> > Also, Savaliya, please use checkpatch on your patch, you need some
> > whitespace fixes in this code before I could accept it at the very
> > least.
> 
> I ran the script now also on same patch, didn't any warning/error. Do you
> see the error ? Below is the output:
> 
> ./scripts/checkpatch.pl
> 0001-serial-msm_geni_serial_console-Add-Earlycon-support.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #58:
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 511 lines checked

You need ' ' around the '+' characters.  Odd that it didn't catch that.

Also, you added a file with no MAINTAINERS entry, please add your name
to it so we know who to bother over time :)

thanks,

greg k-h
