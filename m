From: Corey Minyard <minyard@acm.org>
Subject: Re: Serial port redirection
Date: Wed, 03 Dec 2003 07:21:40 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3FCDE364.1080005@acm.org>
References: <Pine.LNX.4.44.0312031557190.12826-100000@maggie.lkpg.cendio.se> <3FCE1267.3040204@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.202.64]:63635 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263205AbTLDRWo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Dec 2003 12:22:44 -0500
In-Reply-To: <3FCE1267.3040204@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>
Cc: Peter Astrand <peter@cendio.se>, ltsp-discuss@lists.sourceforge.net, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

Jeffrey Altman wrote:

> Peter Astrand wrote:
>
>> * ser2net is totally incompatible with cyclades-serial-client. This is
>> because ser2net interprets RFC2217 a bit differently. sredird sends
>> command "101" as ack for command "1", while ser2net sends "1". 
>> RFC2217 is
>> not very explicit about which way is most correct. The ser2net approach
>> looks better to me, but the sredird one is probably more widely used
>> (since Cyclades terminal server uses it, for example.) Probably, RFC2217
>> software needs to handle both cases.
>>
>>  
>>
> ser2net is wrong
>
>
Umm, no.  Cyclades and sredird are wrong.  And it's pretty clear.  From 
RFC2217:

                   Client to Access Server   Access Server to Client
       SIGNATURE            text                      text
       SET-BAUDRATE            1                      101
       SET-DATASIZE            2                      102
       SET-PARITY              3                      103
       SET-STOPSIZE            4                      104
       SET-CONTROL             5                      105
       NOTIFY-LINESTATE        6                      106
       NOTIFY-MODEMSTATE       7                      107
       FLOWCONTROL-SUSPEND     8                      108
       FLOWCONTROL-RESUME      9                      109
       SET-LINESTATE-MASK     10                      110
       SET-MODEMSTATE-MASK    11                      111
       PURGE-DATA             12                      112
                                                                               
   Discussion: As initially proposed, com port configuration
               commands are only sent from the client to the access
               server.  There is no current vision that the access
               server would initiate the use of a com port configuration
               command, only the notify commands. However, to allow for
               access server initiated com port configurations different
               command values have been established.

That last sentence of the discussion says it.  The 1xx commands are 
there to allow the access server to *initiate* com port configuration 
changes.  Not to ack the changes.  Unless you can point me to something 
in the manual to say that I am wrong.

I am willing to change this in the spirit of keeping things consistent, 
though.

-Corey

