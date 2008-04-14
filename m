From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Date: Mon, 14 Apr 2008 09:04:24 -0600
Message-ID: <fa686aa40804140804q6950b206sd7dc5475b348e618@mail.gmail.com>
References: <20080311171045.GB4684@localhost.localdomain>
	 <82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	 <20080411160654.GA25506@polina.dev.rtsoft.ru>
	 <47FF9665.7020403@freescale.com>
	 <20080411170657.GA15270@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.247]:62036 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbYDNPEZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2008 11:04:25 -0400
Received: by hs-out-0708.google.com with SMTP id 4so430921hsl.5
        for <linux-serial@vger.kernel.org>; Mon, 14 Apr 2008 08:04:25 -0700 (PDT)
In-Reply-To: <20080411170657.GA15270@polina.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, linux-serial@vger.kernel.org, netdev@vger.kernel.org

On Fri, Apr 11, 2008 at 11:06 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Apr 11, 2008 at 11:48:37AM -0500, Timur Tabi wrote:
>  > Anton Vorontsov wrote:
>  > > On Fri, Apr 11, 2008 at 09:13:36AM -0500, Kumar Gala wrote:
>  > >> On Mar 11, 2008, at 12:10 PM, Anton Vorontsov wrote:
>  > >>> - get rid of `model = "UCC"' in the ucc nodes
>  > >>>  It isn't used anywhere, so remove it. If we'll ever need something
>  > >>>  like this, we'll use compatible property instead.
>  > >>> - replace cell-index and device-id properties by fsl,ucc.
>  > >>>
>  > >>> Drivers are modified for backward compatibility's sake.
>  > >> I'd prefer we use cell-index and not introduce "fsl,ucc".  I'm ok with
>  > >> dropping device-id and model (its implied in the compatiable).
>  > >
>  > > Ok. Here it is. netdev and linux-serial Cc'ed.
>  >
>  > Do we want the first UCC to have a cell-index of 1?  Maybe we should fix this
>  > off-by-one error once and for all, and number all UCCs from 0?
>
>  Isn't documentation numbers UCC from 1? Then I believe we should stick
>  with it for device tree, since off by one is Linux implementation details.

Plus making such a change will break deployed device trees.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
