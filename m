From: Ed Vance <EdV@macrolink.com>
Subject: RE: port speeds >115k
Date: Mon, 24 Feb 2003 12:28:40 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DB0@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Steven Bradley' <steven@sgb.dyndns.org>
Cc: 'linux-serial' <linux-serial@vger.kernel.org>

On Mon, Feb 24, 2003 at 11:20 AM, Steven Bradley wrote:
> Sorry to intrude, but ...
> 
> I suspect the interest in 230K is due to the 25 Mhz Courer USRobotics
> modems or similar species of modem.  Well, I would like to ask what is
> wrong with 115.2Kbps?
> 
> Let me be more specific with an example:
> 
> Assuming you have a 53Kbps connection, fastest available under 
> FCC current regulations limited power output, you would need a 
> throughput of 212Kbps if your data will compress 4:1 ratio 
> between computer and modem.  

I think 56kb is limited by the possibility of routing on a T-system
link that uses robbed-bit signaling. Anybody know for sure?

> In the earlier days before PPP and TCP/IP, data would 
> compress this much
> if it were certain combinations of ASCII or repetitive sequences of
> characters, such as binary empty sectors, for example.  
> 
> However, in practice, using TCP/IP over PPP, you rarely see this level
> of compression and 2:1 is more likely closer to what you will see.  If
> you are using 2:1, you would only need 106Kbps to achieve full
> efficiency because the mix of characters between modem and computer do
> not usually compress to 4:1 when using a PPP connection due to headers
> and control data which does not compress.
> 
> Even if you did have data which would benefit from the higher speed,
> the hardware flow control (CTS/RTS) would throttle it down for the
> RARE instances where this case may exist.  In most it would not.
> 
> Now that was assuming a full 53K connection, in practice, 44-50K are
> more common, assuming you have a 45K connection, it would only be
> 90Kbps throughput needed between computer and modem for a 2:1
> compressable data stream.
> 
> I thought this information may be of some interest, Steven

yep. Glad to hear from you. If 230kb has little throughput benefit 
over 115kb, I would use 115kb to minimize the number of data overruns.
I would be interested in hearing from anybody that has experience of
running at both digital side speeds with these modems under the
2.4 kernel. 

Cheers,
Ed

>  [ snip ]
> 
> -- 
> Steven Bradley / KG4UZR   121 Cambridge Drive, Longwood, FL  
> 32779-5707  USA
> steven@sgb.dyndns.org                 Home: (407) 862-7226 or 
> (407) 869-4598
> 
