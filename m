Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA9C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC99615A0
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhFOPm4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPm4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 11:42:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5B926157E;
        Tue, 15 Jun 2021 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623771652;
        bh=R1lzwn4EZIxPO8oXEuZ8VG4LT9RGo6Ard6iLzIwP2JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wtSYN8r4q4/Zh9esQibVqaHKRkX3DVgXjNRldozHsT/EVhQ055clIl3CJfZYA6fzN
         Wqr0powO7agvpY3Z5FBfWHxUdxFqst1muSBbxFsna3jy5XOdURGB5rrceNHye7NGR3
         WSgYuU2gdcHIway1QrotrDDPSNW6D3hwWkjN3IvA=
Date:   Tue, 15 Jun 2021 17:40:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jason Li <jason.li@cortina-access.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Message-ID: <YMjKAhP19Q53jsnC@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com>
 <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 15, 2021 at 02:39:08PM +0000, Alex Nemirovsky wrote:
> 
> 
> > On Jun 15, 2021, at 7:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> >> MAINTAINERS modification was made in the initial version 1.  We made no changes to it since then,
> >> thus not sure what we could at to  Changelog which would add value or clarity for others
> >> from the v1.
> >> 
> >>> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >>> 
> >>> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> >>>> From: Jason Li <jason.li@cortina-access.com>
> >>>> 
> >>>> Convert the Cortina-Access UART binding to DT schema format.
> >>>> 
> >>>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> >>>> ---
> >>>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
> >>>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >>>> MAINTAINERS                                   |  6 +++
> >>> 
> >>> You are also adding a MAINTAINERS entry here, which is not listed in the
> >>> changelog text, so I couldn't take it anyway :(
> > 
> > Add the maintainers entry in the first patch, with the driver please.
> 
> The change to MAINTAINERS here add a new file into the DT documentation. 
> Should it not be grouped into the dt-binding portion and reviewed by the DT time for which this patch
> is CC’ed to? Why would moving the DT documentation file that is introduced be into the first patch, which is the 
> serial driver itself be the correct approach?

Add it as a stand-alone patch at the end of the series, that just adds
the MAINTAINERS entry.

thanks,

greg k-h
