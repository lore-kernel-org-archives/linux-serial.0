Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC1C48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56330613F3
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFXMsd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXMsd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 08:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D9C613EC;
        Thu, 24 Jun 2021 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624538773;
        bh=nC8A/O7w7HXv3o9pRB0mvbO1lJjk3ZH6cIfZZjwrzeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8PTOVXpfQ+ZhDtOYoAoQcAsCBHgG4m46P8u7tKG5fZUx8Burakc8onMSCLKu7X8E
         ysMyAlBH8OCwyQ73zg2oG1SIoMx4ng776ma1G8gFOXhGTWE+MqIR7Vs3WpqkwEjPp5
         GpEoS9+9uw5tKBMFgdMPZ1V7PeQCfW74UHtYdEnw=
Date:   Thu, 24 Jun 2021 14:46:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Message-ID: <YNR+k9SXHDSsVjjN@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com>
 <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
 <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com>
 <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
 <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 22, 2021 at 01:28:06PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 15, 2021 at 6:21 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Jun 15, 2021 at 10:06 AM Alex Nemirovsky
> > <Alex.Nemirovsky@cortina-access.com> wrote:
> > > > On Jun 15, 2021, at 8:44 AM, Rob Herring <robh+dt@kernel.org> wrote:
> > > > On Tue, Jun 15, 2021 at 8:39 AM Alex Nemirovsky
> > > > <Alex.Nemirovsky@cortina-access.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >>> On Jun 15, 2021, at 7:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >>>
> > > >>> On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> > > >>>> MAINTAINERS modification was made in the initial version 1.  We made no changes to it since then,
> > > >>>> thus not sure what we could at to  Changelog which would add value or clarity for others
> > > >>>> from the v1.
> > > >>>>
> > > >>>>> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >>>>>
> > > >>>>> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> > > >>>>>> From: Jason Li <jason.li@cortina-access.com>
> > > >>>>>>
> > > >>>>>> Convert the Cortina-Access UART binding to DT schema format.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> > > >>>>>> ---
> > > >>>>>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
> > > >>>>>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> > > >>>>>> MAINTAINERS                                   |  6 +++
> > > >>>>>
> > > >>>>> You are also adding a MAINTAINERS entry here, which is not listed in the
> > > >>>>> changelog text, so I couldn't take it anyway :(
> > > >>>
> > > >>> Add the maintainers entry in the first patch, with the driver please.
> > > >>
> > > >> The change to MAINTAINERS here add a new file into the DT documentation.
> > > >> Should it not be grouped into the dt-binding portion and reviewed by the DT time for which this patch
> > > >> is CC’ed to? Why would moving the DT documentation file that is introduced be into the first patch, which is the
> > > >> serial driver itself be the correct approach?
> > > >
> > > > The binding doesn't actually need a MAINTAINERS entry (though having
> > > > one is fine). get_maintainers.pl will also pull emails from the
> > > > binding schema.
> > > >
> > > > Rob
> > >
> > > Hi Rob,
> > > It sounds like you are find with patch 2/3 from a DT point of view.  Could we review the rest from the DT point of view
> > > to get either feedback for changes or ACK these, so we can unblock this series?
> >
> > Can't say I've seen it as I only see replies in my mail. Did this
> > originally go to the DT list? If not, it's never in my queue[1].
> >
> > Rob
> >
> > [1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
> 
> None of the patches in this series ended up on a mailing list or on
> lore, so no one could comment on them, except for people CCed directly.

Ugh, I never noticed that I as I just applied one patch of the series,
my fault.  I'll go revert them from my tree now...

thanks,

greg k-h
