From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP4430ES2 UART garbage on v3.5-rc4
Date: Thu, 28 Jun 2012 02:28:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206280222230.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com, govindraj.raja@ti.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Hi,

On 4430ES2 Panda, the serial port prints garbage at the end of long 
transmissions from the board when dynamic idle is enabled.  Here's an 
example (search for "Minicom2.6.1"):

http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/pm/4430es2panda_log.txt

My recollection is that this used to happen on some earlier kernels after 
the OMAP serial Ragnarok a few months ago, but it was masked by some other 
issue up until v3.5-rc4..

Who is looking after the OMAP UART driver these days?


- Paul
