From: Ed Vance <EdV@macrolink.com>
Subject: RE: [OT(ish] Duplicate Character between modems
Date: Fri, 2 Aug 2002 15:54:33 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7922@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Neil Everton' <neil@gemini-it.com>
Cc: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>

On Fri, August 02, 2002 1:41 PM, Neil Everton wrote:
> Hi,

  [snip]

> 	I'm currently porting an application from DOS to Linux 
> (RH7.2 with Cyclades
> Cyclom-Y (hi henrique!!)).
> 
> 	My issue is this, if I send down the modem ;
> "ABCDEFGHI"
> 	the receiving end (very infrequently) receives
> "AABCDEFGHI"
> 	This is caught by the check digit routine and the line 
> is NAK'd ready for a
> re-transmit. It will usually work the second or third time. 
> This has found a
> bug in the 3rd party transmitting software, but they're 
> taking the attitude
> of the existing system works, so you fix your end !!! (the bug if your
> interested is after sending a NAK they drop the connection, instead of
> waiting for 5 retries)
> 
   [snip]

Hi Neil,

First thing I would check is to make sure that neither end is echoing. Check
both the systems' ports and the modems' digital side ports. 

Just a guess.

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
