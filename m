From: Ed Vance <EdV@macrolink.com>
Subject: RE: [OT(ish] Duplicate Character between modems
Date: Mon, 5 Aug 2002 09:06:58 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7928@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Neil Everton' <neil@gemini-it.com>
Cc: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>

On Mon, August 05, 2002 at 2:05 AM, Neil Everton wrote:
> 
> 	Thanks for all the replies. Error correction was 
> originally disabled due to issues with new hardware 
> connecting to the existing system, and the fact that a lot 
> of the old hardware out there, will not connect to the 
> Couriers unless EC is disabled (it's true !!).
> 
> 	I appreciate the fact that EC is there to 'stabilise' a 
> connection and to filter out bad noise, but we have a check 
> digit routine for that (as indeed do the modems). The 
> problem I have though, it that if it is echo, I would
> expect it on most characters not just the odd one. If it was 
> line noise (which I expect is probably closer to the truth) 
> then the modems must STILL be providing some sort of 
> correction for them to resend the character again. If this 
> is the case then I cannot totally disable error correction, 
> which in turn means I cannot get rid of this problem.
> 
[snip]

Neil,
I'm not sure I can describe the situation accurately with Monday morning
brain, but I'll try. I have a weird double echo story. I have seen one case
of a local connection between a computer and a laser range finder box, where
both ends had echo turned on instead of just the box and it almost never
caused an error in the lab. They got one pulse for each character sent. In
the field test, with a much longer cable and a pair of limited distance
modems, they got parity errors or multiple pulses per character about half
the time. We found that echo was on at the computer and turned it off. Then
it all worked fine. 

I don't really understand the physics of what was happening. I suspect that
because the echo was analog and the lab cable was short, there was no
noticeable time offset between the transmitted bits and the retransmission
of the echoed same bits, and I make the wild guess that the computer end
transmitter turned off analog echo during transmission of a character. I
think the modem produced erratic short delays that occasionally separated
the bouncing echo signal in time from the original transmission of the
character so the echo could be bounced as a separate character. 

I guess the point is just that the problem was caused by echo being turned
on at both ends and it didn't cause the expected kind of problem. I hope
yours turns out to be less weird. Good luck with it. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
