From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Serial: sc26xx device name
Date: Sat, 21 Nov 2009 23:24:40 +0000
Message-ID: <20091121232440.68e9f68f@lxorguk.ukuu.org.uk>
References: <4B07F068.1090801@gmail.com>
	<20091121140911.0e7ef3fd@lxorguk.ukuu.org.uk>
	<4B07F7E4.1070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36175 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753211AbZKUXWk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 18:22:40 -0500
In-Reply-To: <4B07F7E4.1070207@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: mfuzzey@gmail.com
Cc: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org

On Sat, 21 Nov 2009 15:23:32 +0100
Martin Fuzzey <mfuzzey@gmail.com> wrote:

> Alan Cox wrote:
> >> 2) How are device name conflicts handled?
> >>     
> >
> > Badly - they should never occur but if someone didn't properly reserve
> > the namespace they can and then whoever forgot to reserve the namespace
> > loses.
> >   
> Currently this can't happen because the sc26xx driver uses ttySC205
> in contradiction to ttySC0 shown in devices.txt

I'd suggest that someone fixes it when it happens in that case. I doubt
it ever will.
