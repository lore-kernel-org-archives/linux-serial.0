From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 19 Oct 2010 14:29:48 +0000 (UTC)
Message-ID: <i9ka0s$4ua$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
 <4BBDD71D.1010700@evidence.eu.com> <4BFD1FB6.8050405@atmel.com>
 <4BFE2F38.8050200@evidence.eu.com> <4BFE41FD.2080804@atmel.com>
 <20100527102917.GB31253@pengutronix.de> <4C626CBF.9020609@evidence.eu.com>
 <20100811083214.21d2919e.randy.dunlap@oracle.com>
 <4C669120.8080707@evidence.eu.com> <4C686411.3060500@oracle.com>
 <20100815221906.GA24153@n2100.arm.linux.org.uk>
 <4CBD8EE4.5040808@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46136 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0JSO36 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Oct 2010 10:29:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1P8DCP-0002cy-W1
	for linux-serial@vger.kernel.org; Tue, 19 Oct 2010 16:29:57 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 19 Oct 2010 16:29:57 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 19 Oct 2010 16:29:57 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 2010-10-19, Claudio Scordino <claudio@evidence.eu.com> wrote:

> +2. HARDWARE-RELATED CONSIDERATIONS
> +
> +   Some CPUs (e.g., Atmel AT91) contain a transceiver capable of working both
> +   as RS232 and RS485.

Pardon my curiosity, but I've looked at a few AT91 parts, and I've
never seen on with an internal transceiver -- nor does Google seem
able to find any.

Frankly, I'd be pretty surprised, since it would be very difficult
(fab-wise), to build a mircoprocessor with I/O cells capable of
withstanding the voltage levels specified in RS232.

Can you specify to which parts you're referring?

-- 
Grant Edwards               grant.b.edwards        Yow! I have the power to
                                  at               HALT PRODUCTION on all
                              gmail.com            TEENAGE SEX COMEDIES!!

