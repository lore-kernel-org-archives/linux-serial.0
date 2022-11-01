Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC46C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  1 Nov 2022 15:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKAPUO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiKAPT5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Nov 2022 11:19:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141EF20C
        for <linux-serial@vger.kernel.org>; Tue,  1 Nov 2022 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667315990; x=1698851990;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=2TDXAgwOU1OkerEPnUffcIJXn16FaeML2gAQzGbiGEw=;
  b=moSnCAw6742wKZlfFo7R3ELsPyazo0/ML5OhGKKJCyqWiSidwKovKQlP
   uiNkOKaa8zIDhuo5xY71I+F7SBM+mlsXsd9A6eYiVFgRzd5MY/g5VMtlJ
   lAcvXylxFWKL5S8udaS1/U4VqaPnkGi9VY1I7NA6gvBiGWwgiC1reR7H0
   7Q8k1ZaiwJvmWEl4AkX0nEozX57058zjZfkE7bU7YSK9Fyav7uFjxUY4E
   VCgANVM8HP1F0HZci/+abqNlv47x9zRrdZ1wQ5bJAdpw5IUkELISVrAsq
   wQDV2nuOBl7ViYkWXBbjowQIN7FlkYg/VXWP+Szx9mU7j4d1cmzDusApR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292467273"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292467273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:19:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="808930773"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="808930773"
Received: from mweigler-mobl.ger.corp.intel.com ([10.249.40.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:19:46 -0700
Date:   Tue, 1 Nov 2022 17:19:44 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <20221101141603.u4bqn5qx7y7tzzzr@xps.localdomain>
Message-ID: <e94891ba-a977-3a36-40af-1643ea918453@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-3-martin@geanix.com> <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com> <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com> <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
 <9320837b-1b8a-9ddf-7de8-d75816fb209b@geanix.com> <7ba1dd5b-7b9e-50a1-7539-41533c8d4c94@linux.intel.com> <b1a1680d-d226-e6b5-ac6e-25e0827dca25@geanix.com> <566134f-fd72-d8e6-f5ba-a97062b4189@linux.intel.com>
 <20221101141603.u4bqn5qx7y7tzzzr@xps.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-662377222-1667312594=:1608"
Content-ID: <4fb614ff-9964-e8e1-f5a2-8a6cdcc1ad8b@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-662377222-1667312594=:1608
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d7f07668-74c9-23c8-b129-523e90312be0@linux.intel.com>

On Tue, 1 Nov 2022, Martin Hundebøll wrote:
> On Tue, Nov 01, 2022 at 03:22:33PM +0200, Ilpo Järvinen wrote:
> > On Tue, 1 Nov 2022, Martin Hundebøll wrote:

> > In addition, to me n useless ports just sitting there doesn't sound that 
> > serious issue that it would warrant breaking setups that currently depend 
> > on certain ttyS numbers (I suppose you actually agree with this point).
> 
> Agreed. Although we have seen races between the DELETE and ADD uevents
> mentioned below, leading to non-deterministical device numbers.

No doubt there will be cases were the numbering is not as stable as we'd 
like but it seems an unrelated issue.

> > > If you look at uevents from 8250 when the designware ports are discovered,
> > > you'll see a DELETE of the built-in ttyS0 first, and then an ADD of the
> > > designware ttyS0. My understanding is that we should never have had that
> > > built-in ttyS0 in the first place?
> > 
> > I certainly suspect the built-in one really isn't there (in ACPI) but I 
> > don't want to spend my time on confirming the obvious.
> 
> >From a system booted with these patches, and 8250.nr_uarts=0, I get two
> ports from ACPI PNP:
> 
> # cat /sys/class/tty/ttyS0/port
> 0x3F8
> # cat /sys/class/tty/ttyS1/port
> 0x2F8
> 
> which matches the SERIAL_PORT_DNFS define in arch/x86/include/asm/serial.h

I was talking about the system I was testing with.

> > > > I'm not anymore sure about your goals really. Now it sounds one of the
> > > > goals is preserving the non-discoverable ports, whereas previously it was
> > > > just about allowing 0 of them.
> > > 
> > > My initial goal was to rely on discoverable ports only. Some of our systems
> > > have no built-in uarts, so the bash init script failed to even start, because
> > > the kernel command line had console=ttyS0, and bash tried to do set terminal
> > > attributes on it. I am only trying to fix the code "the right way", but that
> > > might not be possible without breaking numbering fo existing systems.
> > 
> > Again I don't follow the reasoning fully here. What is your end goal here 
> > in this scenario. You'd either want to have no ports to appear at all or 
> > have a non-discoverable (=bogus) port as ttyS0. Which way it is?
> > 
> > If you, on the other hand, would have a discoverable port that will take 
> > over ttyS0, I don't understand why it fails so it seemingly leaves only 
> > those two options I gave.
> 
> My endgoal is to avoid a bogus ttyS0, but a working driver (for the PCIe
> connected ports).
> 
> I still think it seems wrong to have non-working device nodes. They only
> confuse both people and software:
> 
> % sudo stty -F /dev/ttyS0
> stty: /dev/ttyS0: Input/output error

So simply add the maximum number of non-discoverable ports? Something 
which isn't reusing nr_uarts or its related CONFIG, and pick such a 
default which doesn't break existing cmdlines.

> > > That would work for me. But shouldn't we clean up the 
> > > SERIAL_8250_NR_UARTS vs. SERIAL_8250_RUNTIME_UARTS also?
> > 
> > I'm not convinced there's something wrong with it. It's legacy yes, but
> > the max ports compiled in vs max ports per boot is not wrong/buggy as is.
> 
> Your interpretation of those two makes sense, but I don't really see a
> usecase for setting 8250.nr_uarts at boot time though.

You might not but we shouldn't change it to mean something else.


-- 
 i.
--8323329-662377222-1667312594=:1608--
