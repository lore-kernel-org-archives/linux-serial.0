From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Connecting serial ports back to back.
Date: Tue, 20 Dec 2011 11:13:52 +0000
Message-ID: <20111220111352.32e82ce3@pyramind.ukuu.org.uk>
References: <CAMFeL9JMTo_ms6TUVeA3imqB0iymPONOGk=hBPmmGM2gY1ZArg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47948 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1LTLNH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Dec 2011 06:13:07 -0500
In-Reply-To: <CAMFeL9JMTo_ms6TUVeA3imqB0iymPONOGk=hBPmmGM2gY1ZArg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <nijsure.subodh@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, 19 Dec 2011 16:15:43 -0800
Subodh Nijsure <nijsure.subodh@gmail.com> wrote:

> I have hardware where we have two ports that need to be connected back
> to back.  One serial port is /dev/ttyAPP2 and other is /dev/ttyUSB0
> 
> Basically what I want to make happen is data coming from /dev/ttyUSB0
> should be sent to /dev/ttyAPP2 and vice versa.
> 
> It appears that I should be able to do this using the n_tracesink and
> n_tracerouter line discipline drivers.
> 
> Has anyone been successful in hooking up serial ports back-to-back
> using these two line discipline drivers?

tracerouter/sink are a bit more specialist than that. But for general
data copying you can just run an application to do it.

Alan
