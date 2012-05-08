From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: What's the rationale behind sending a Xoff character when the
 port is stopped ?
Date: Tue, 8 May 2012 14:11:39 +0000 (UTC)
Message-ID: <job9ir$uoc$1@dough.gmane.org>
References: <CAES2cWwz=JJY14rCX8_GwnD7Mgmweiz9xSUsw6z08YZ2zNHkqw@mail.gmail.com>
 <20120507215059.3111018f@pyramind.ukuu.org.uk>
 <CAES2cWxoxNG-L5hK67jH3uug9KScq=rvcqE_f+B3MaRNGDL1FA@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57500 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab2EHOL6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 May 2012 10:11:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1SRl8t-0008Vq-1d
	for linux-serial@vger.kernel.org; Tue, 08 May 2012 16:11:55 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 08 May 2012 16:11:55 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 08 May 2012 16:11:55 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2012-05-07, Karthik Manamcheri <karthik.manamcheri@gmail.com> wrote:

> In the case when I am flow controlled (meaning I received a Xoff from
> the other end) and my receive buffer fills up, sending a Xoff to the
> other end might overflow the buffer for the other guy, right?

Not really.  The Xoff doesn't go into the other guy's receive buffer.
It's processed by the flow-control software (or hardware) before it
gets to the receive buffer.

-- 
Grant Edwards               grant.b.edwards        Yow! I put aside my copy
                                  at               of "BOWLING WORLD" and
                              gmail.com            think about GUN CONTROL
                                                   legislation...

