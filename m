From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC 0/3] serial: sh-sci: SCIF FIFO exploitation
Date: Wed, 17 Sep 2014 12:49:56 -0400
Message-ID: <5419BBB4.5090802@hurleysoftware.com>
References: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:51331 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756194AbaIQQuK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Sep 2014 12:50:10 -0400
In-Reply-To: <1410511908-9282-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org
Cc: horms@verge.net.au, magnus.damm@gmail.com, Greg KH <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

[ +cc GregKH, Alan ]

Hi Uli,

On 09/12/2014 04:51 AM, Ulrich Hecht wrote:
> Hi!
> 
> The current sh-sci implementation doesn't exploit the RX FIFOs at all and
> has the chip issue an interrupt for every byte received.  This series
> implements the necessary changes to improve that.

Just a general note about the use of the words exploit and exploitation.
In common usage, 'exploit' has become synonymous with 'misuse'.

Perhaps a better choice would be 'utilize' and 'utilization'?

> It includes a sysfs interface for changing the FIFO trigger level; there
> seem to be few drivers that implement something like that (I only found
> one), so I'd like to know if this implementation is palatable.

The method to extend the sysfs interface for a specific device is in
linux-next. The original was proposed by Greg and reworked by
Yoshihiro YUNOMAE; see commit 266dcff03eed0050b6af11aaf2a61ab837d7ba3f,
'Serial: allow port drivers to have a default attribute group' and
commit aef9a7bd9b676f797dd5cefd43deb30d36b976a9,
'serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers'
for how to use the default attribute group.

OTOH, I like your sysfs attribute name, rx_trigger_level, better than
the new 8250 attribute name, rx_trig_bytes. In one sense Greg was right;
the coming explosion of different device attributes with different handling
behavior is going to suck.

Regards,
Peter Hurley

On a side note: why is there so little locking in the sh-sci driver?
Is it uniprocessor?

> CU
> Uli
> 
> 
> Ulrich Hecht (3):
>   serial: sh-sci: consider DR (data ready) bit adequately
>   serial: sh-sci: exploit RX FIFOs better
>   serial: sh-sci: make RX FIFO trigger tunable via sysfs
> 
>  drivers/tty/serial/sh-sci.c | 113 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/tty/serial/sh-sci.h |   5 ++
>  include/linux/serial_sci.h  |   2 +
>  3 files changed, 116 insertions(+), 4 deletions(-)
> 

