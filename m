From: Corey Minyard <minyard@acm.org>
Subject: Re: Serial port redirection
Date: Thu, 04 Dec 2003 11:49:50 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FCF73BE.1010707@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1101.40502@columbia.edu> <3FCDDEE6.4070905@acm.org> <3FCF6B4D.2050103@columbia.edu> <3FCDE3B8.3000609@acm.org> <3FCF70E0.4000302@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43938 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261898AbTLDRtx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Dec 2003 12:49:53 -0500
In-Reply-To: <3FCF70E0.4000302@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>
Cc: Peter Astrand <peter@cendio.se>, ltsp-discuss@lists.sourceforge.net, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

It would be fairly trivial to write such a program, though.  You could 
pass it the actual program you want, and it could make the protocol 
transparent.

-Corey

Jeffrey Altman wrote:

> Ideally that would be true.  However, the mechanisms for doing so are 
> not portable to all platforms on which C-Kermit still compiles.  
> Please remember that C-Kermit works on platforms that existed before 
> "select()" was invented.
>
> Jeffrey Altman
>
>
> Corey Minyard wrote:
>
>> Ah, I missed that.  Ideally, something (i would think kermit) should 
>> sit between the program and the socket to make it transparent.  But 
>> yes, I see what you are saying.
>>
>> Thanks,
>>
>> -Corey
>>


