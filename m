From: Bahadir Karuv <bahkar@bcacademies.bergen.org>
Subject: Re: Newbie Problem: Program is working!
Date: Thu, 25 Apr 2002 15:39:11 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3CC85B5E.33B04682@bcacademies.bergen.org>
References: <11E89240C407D311958800A0C9ACF7D13A77C7@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>, linux-serial@vger.kernel.org

Hi Ed,

Funny you mention coupling between send and receive. TxD and RxD was
shorted in the original cable. That is why program was getting back
whatever it was sending. Thanks and regards.

Ed Vance wrote:

> Great!
>
> FYI, something else that happens with ~50 ft cables built on site
> (usually
> out of phone pairs) is sufficient capacitive coupling between transmit
> and
> receive to loop the data back. My favorite is twisted pair cable with
> transmit and receive twisted together. :-)
>
> Best regards,
> Ed
>
> -----Original Message-----
> From: Bahadir Karuv [mailto:bahkar@bcacademies.bergen.org]
> Sent: Thursday, April 25, 2002 11:08 AM
> To: linux-serial@vger.kernel.org
> Subject: Re:Newbie Problem: Program is working!
>
> Hi All,
>
> After receiving mails from Ed and Bob, I run the same program on both
> computers with different message being sent. Program worked! When I
> disconnected the cable both computers kept sending but one kept
> receiving its own message. I suspected the cable (RTS-CTS short) and
> changed the cable with a regular serial extension cable with null
> modem
> adapter. Finally the first computer stopped receiving its own message.
>
> Sorry I took up bandwidth and thanks for your help.
>
> Karuv
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> *** eSafe scanned this email for malicious content ***
> *** IMPORTANT: Do not open attachments from unrecognized senders  ***
>

