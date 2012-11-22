From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] OF: Add helper for matching against linux,stdout-path
Date: Thu, 22 Nov 2012 21:21:02 +0000
Message-ID: <CACxGe6tD=1tL3dTXSnHusSVCh2T1UN86igNZBm=q3pL77nkJfA@mail.gmail.com>
References: <20121121155312.GX4398@game.jcrosoft.org> <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
 <CACxGe6tyPpjx4OtjHmhB9Cvnb7OwAjPEE4=K+wgWKYHcAV-ESQ@mail.gmail.com>
 <20121122054138.GY4398@game.jcrosoft.org> <20121122153152.2B9CB3E129E@localhost>
 <20121122193521.GA4398@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63046 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2KVXBJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Nov 2012 18:01:09 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6122551pbc.19
        for <linux-serial@vger.kernel.org>; Thu, 22 Nov 2012 15:01:09 -0800 (PST)
In-Reply-To: <20121122193521.GA4398@game.jcrosoft.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sascha Hauer <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Cox <alan@linux.intel.com>

On Thu, Nov 22, 2012 at 7:35 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 15:31 Thu 22 Nov     , Grant Likely wrote:
>> On Thu, 22 Nov 2012 06:41:38 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
>> > On 18:03 Wed 21 Nov     , Grant Likely wrote:
>> > > On Wed, Nov 21, 2012 at 3:57 PM, Jean-Christophe PLAGNIOL-VILLARD
>> > > <plagnioj@jcrosoft.com> wrote:
>> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
>> > > >
>> > > > devicetrees may have a linux,stdout-path or stdout-path property
>> > > > in the chosen node describing the console device. This adds a helper
>> > > > function to match a device against this property and retrieve the options
>> > > > so a driver can call add_preferred_console for a matching device.
>> > >
>> > > NIce. Looks like the right behaviour, but is a little inefficient.
>> > > Since the stdout property doesn't change this code could be called
>> > > once right after the tree is unflattened and then cache the pointer to
>> > > the node anarguments. Can you add the code to of_alias_scan()?
>> > do we assume that we can have only one stdout-path?
>> >
>> > I think we could have more serial, framebuffer console
>>
>> Nope. stdout-path as currently defined is only one device. Someone would
>> need to propose an extension for multiple stdout's before I'd bother
>> trying to support that.
> ok for this version I do not put it but I need it
>
> I want to have 2 console uart and framebuffer
>
> Personnaly I'd just allow multiple instance of stdout-path

Propose a binding extension.

g.
