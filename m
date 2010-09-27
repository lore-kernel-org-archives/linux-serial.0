From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [RESEND PATCH] serial: samsung: fix device name
Date: Mon, 27 Sep 2010 01:17:01 +0100
Message-ID: <4C9FE27D.80407@fluff.org>
References: <20100923190212.18863.25678.stgit@darius-desktop>	<4C9BE577.4050504@fluff.org>	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com> <20100924073453.GA3840@richter>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dsl78-143-211-26.in-addr.fast.co.uk ([78.143.211.26]:37789 "EHLO
	ben-laptop" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754486Ab0I0ARG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 Sep 2010 20:17:06 -0400
In-Reply-To: <20100924073453.GA3840@richter>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Darius Augulis <augulis.darius@gmail.com>, kgene.kim@samsung.com, Ben Dooks <ben-linux@fluff.org>, paulius.zaleckas@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 24/09/10 08:34, Simon Richter wrote:
> Hi,
> 
> On Fri, Sep 24, 2010 at 09:57:19AM +0300, Darius Augulis wrote:
> 
>> It does - now devices are named /dev/s3c2410_serial, and patch changes
>> its name to /dev/ttySAC
> 
> I wonder if it'd make sense to name them ttyS[0-9]. I've never
> understood why the platform standard fixed serial ports on any device
> should have a different name.

Different driver. And yes, we've built systems with both this and
an 8250 base chip.
