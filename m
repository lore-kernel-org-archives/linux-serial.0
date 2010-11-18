From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 20:05:56 +0000 (UTC)
Message-ID: <ic40v4$ghm$1@dough.gmane.org>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com> <E1PJAfx-0000gW-8e@palantir.moria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50182 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755902Ab0KRUGK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 15:06:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PJAkD-0004si-32
	for linux-serial@vger.kernel.org; Thu, 18 Nov 2010 21:06:09 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2010 21:06:09 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 18 Nov 2010 21:06:09 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2010-11-18, Michael Haardt <michael@moria.de> wrote:
>> > I miss a way to disable the transmit FIFO.
>>
>> From userspace or from within a kernel driver?
>
> From userspace.

$ man setserial

-- 
Grant Edwards               grant.b.edwards        Yow! FEELINGS are cascading
                                  at               over me!!!
                              gmail.com            

