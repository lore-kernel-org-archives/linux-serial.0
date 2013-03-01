From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Fri, 1 Mar 2013 10:21:27 -0600
Message-ID: <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
	<1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
	<20130301094205.GG27938@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:33303 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3CAQV3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Mar 2013 11:21:29 -0500
In-Reply-To: <20130301094205.GG27938@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

2013/3/1 Simon Horman <horms@verge.net.au>:
> On Tue, Feb 26, 2013 at 11:03:28AM -0600, Bastian Hecht wrote:
>> We can now use the Device Tree for bringing up our serial devices. We
>> need to add an alternative early_devices list in setup-r8a7740 without
>> the serial devices and move them into the Armadillo-reference .dts config file.
>
> Hi Bastian,
>
> could you please refresh this patch on top of the current topic/intc-of.
> In particular, it conflicts with changes made by:
>
> ARM: shmobile: r8a7740: Do not use early devices with DT reference

Sure.

I've prepared the patch - but I start to wonder if the DT
specification for the SCIF devices should go into r8a7740.dtsi rather
than r8a7740-armadillo-reference.dts. So far it's included in
setup-r8a7740.c and not in the board code - that's a strong indication
for it, no?
I want to post a patchset for the CMT timer soon. There it's the same.

Cheers,

 Bastian
