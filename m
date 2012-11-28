From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Wed, 28 Nov 2012 13:24:19 +0000
Message-ID: <20121128132419.1094d2d3@pyramind.ukuu.org.uk>
References: <20121114060724.GN30156@marvin.atrad.com.au>
	<20121114121222.3e42860f@pyramind.ukuu.org.uk>
	<20121114231054.GC4505@marvin.atrad.com.au>
	<20121114235719.794a9bdc@pyramind.ukuu.org.uk>
	<20121115001110.GE4505@marvin.atrad.com.au>
	<20121115155347.4be3dce8@pyramind.ukuu.org.uk>
	<20121128022917.GD28558@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44008 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab2K1NTB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 08:19:01 -0500
In-Reply-To: <20121128022917.GD28558@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: linux-serial@vger.kernel.org

> So far as getting something working for our case, the patch below is all
> that is required.  I do know the QMCR and QOPR bit map details for at least
> the DSC-200/300 card as it's more or less described in the manual.  I will
> try to prepare a second patch which at least creates the necessary defines
> for these in the next few days.

Thanks.

> With regard to the ioctl, should this be an implementation of the ioctl
> provided by the old out-of-tree driver, or is there an established
> standard/example which I should write against instead?

We have a standard (if possibly needing a few bits adding) ioctl for
basic RS422/485 features. That's TIOCG/SRS485 (which for all the naming
is also kind of 422 and other related bits as well)

Can we get a Signed-off-by: for the first patch so we can try and get it
into 3.8 ?

Alan
