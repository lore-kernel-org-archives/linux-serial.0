From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 04 Aug 2008 15:59:06 -0500
Message-ID: <48976D9A.6020803@commtech-fastcom.com>
References: <200808041637.02058.laurentp@cse-semaphore.com> <015301c8f651$cfea6cd0$2e01a8c0@acksys.local> <g77f8p$plq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:31155 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYHDU7M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 16:59:12 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1351ugf.16
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 13:59:10 -0700 (PDT)
In-Reply-To: <g77f8p$plq$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

>> Interestingly, the RTS envelope on the Oxford chips is
>> implemented with... the DTR pin. On our cards we have a piece
>> of hardware which redirect the uart DTR pin to the external
>> RTS in this case.
> 
> Well, that's just plain wrong.  The RS-232 standard was quite
> clear that RTS is what's used to enable transmission.  ;)
> 
Believe it or not, it actually has a purpose.  That way you can use 
RTS/CTS hardware flow control AND have RS485 driver control using the 
DTR pin.

Matt Schulte
