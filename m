From: Ed Vance <EdV@macrolink.com>
Subject: RE: 16850 automatic RTS/CTS
Date: Wed, 8 May 2002 09:58:54 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <abblr5$q9g$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Guennadi Liakhovetski' <gl@dsa-ac.de>
Cc: tytso@mit.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2002, Guennadi Liakhovetski wrote:
> 
> As of 2.5.6 there is some support in the serial driver for the 
> 16850 automatic hardware handshake feature, in particular the 
> automatic CTS is enabled, but not the automatic RTS. Nor are 
> the hysteresis levels set. Why? I tried enabling all these 
> features, it helps a good deal improving the reliability of the 
> data transfer, but still, at high baud-rates (460800, 921600) 
> and in the presence of user-space load data can be overwritten 
> in the driver's buffer. Why isn't this checked? 

Hi Guennadi,

Like so many other good ideas, this feature support is not already there
simply because nobody has submitted a patch for it, yet. (and
followed-up/lobbied with sufficient tenacity and grace) 

Also, be aware that there is in progress a rewrite of the serial driver
subsystem for 2.5. See Russell King's entry in the maintainers list. 

I'm only on the 2.4 side, but I would like to see a tested patch against
either 2.5 or 2.4 for fixup of 16850 support. Since you have the 16850
hardware (and I don't), please consider creating a patch to serial.c and
friends that adds this feature support and posting it for discussion to 
linux-serial@vger.kernel.org. Put enough comments at the top so anyone with
the datasheet can understand your intent. 

Thanks,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
