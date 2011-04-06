From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 19:20:49 +0000 (UTC)
Message-ID: <inieeh$2d5$1@dough.gmane.org>
References: <ini5hh$7s3$1@dough.gmane.org>
 <20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
 <ini6in$gno$1@dough.gmane.org>
 <20110406201457.1a5402ba@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56398 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888Ab1DFTVC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 15:21:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Q7YHk-0003sC-FZ
	for linux-serial@vger.kernel.org; Wed, 06 Apr 2011 21:21:00 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 21:21:00 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 21:21:00 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2011-04-06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I could tell them to go the SPD_CUST route to get 921600, but I was
>> hoping to provide an option that would support 921600 the same way
>> that 57600, 230400, and 460800 are supported.
>
> And no doubt in time other speeds as well.
>
> ASYNC_SPD_xxx is legacy, it remains simply because we provided it as a
> historic interface to some drivers and we don't want to break stuff
>
> So please use SPD_CUST if you must do this.

I don't understand: what's the non-legacy alternative to using SPD_CUST?

-- 
Grant Edwards               grant.b.edwards        Yow! I'm having a
                                  at               tax-deductible experience!
                              gmail.com            I need an energy crunch!!

