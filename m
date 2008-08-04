From: Grant Edwards <grante@visi.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 17:46:01 +0000 (UTC)
Message-ID: <g77f8p$plq$1@ger.gmane.org>
References: <200808041637.02058.laurentp@cse-semaphore.com>
 <015301c8f651$cfea6cd0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48478 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbYHDRqO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 13:46:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KQ48I-0001vd-64
	for linux-serial@vger.kernel.org; Mon, 04 Aug 2008 17:46:10 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 17:46:10 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 17:46:10 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-08-04, Tosoni <jp.tosoni@acksys.fr> wrote:

> Last remark:
>
> Interestingly, the RTS envelope on the Oxford chips is
> implemented with... the DTR pin. On our cards we have a piece
> of hardware which redirect the uart DTR pin to the external
> RTS in this case.

Well, that's just plain wrong.  The RS-232 standard was quite
clear that RTS is what's used to enable transmission.  ;)

-- 
Grant Edwards                   grante             Yow! I have a VISION!  It's
                                  at               a RANCID double-FISHWICH on
                               visi.com            an ENRICHED BUN!!

