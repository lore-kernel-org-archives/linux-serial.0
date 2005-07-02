From: Roman Kurakin <rik@cronyx.ru>
Subject: Re: development of serial driver
Date: Sun, 03 Jul 2005 01:53:25 +0400
Message-ID: <42C70CD5.1040808@cronyx.ru>
References: <MFEBKNPNJBEAJEICJEJNAEAGCLAA.matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hanoi.cronyx.ru ([144.206.181.53]:52478 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id S261306AbVGBWGX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 2 Jul 2005 18:06:23 -0400
Received: (from root@localhost)
	by hanoi.cronyx.ru (8.13.0/vak/3.0) id j62M3Jwp028828
	for linux-serial@vger.kernel.org.checked; Sun, 3 Jul 2005 02:03:19 +0400 (MSD)
	(envelope-from rik@cronyx.ru)
In-Reply-To: <MFEBKNPNJBEAJEICJEJNAEAGCLAA.matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: matts@commtech-fastcom.com
Cc: linux-serial@vger.kernel.org

Hi,

You may do like Cronyx did. This probably is not the best way in general,
but if for device is enough a generic support and in case the driver is 
not a
part of the system (e.q. need to support different kernel branches) this 
is I
am sure the best way.

The driver is available from www.cronyx.ru:
http://www.cronyx.ru/software/omega.html

rik

Matt Schulte:

>Wednesday, June 29, 2005 12:02 PM Matt Schulte wrote:
>  
>
>>I am a developer for a line of multiport PCI serial cards.  I
>>have received
>>enough requests that it is time to make the cards work with the 2.6.x
>>kernels.  I see that serial.c has been deprecated and I am wondering if
>>anyone can tell me exactly how the serial is supposed to work in the new
>>kernel?
>>
>>How can I modify the existing stock driver to include my card as well?  Is
>>there a CVS version somewhere that I could checkout?  Do I send patches
>>somewhere?
>>    
>>
>
>I have been painfully digging through the linux kernel mailing list archive
>and I have a pretty good idea of how I can submit patches that I come up
>with to make my driver operate in the new serial driver.
>
>In the past (2.4.x days) I have just hacked the serial.c code to do what I
>needed and then recompiled it as something else.
>
>I would like for someone to explain to me exactly how a guy like me is
>"supposed" to use this new driver.  Let's say that I have submitted a patch
>to 8250_pci.c that inserts my cards' device and vendor ids and my cards'
>.initialize and .setup routines (if I need them).  Now they can be
>recognized by the driver and will initialize correctly as 16550A type ports.
>Now I need to be able to write a few routines that can configure my card's
>special features.  In my hijacked serial.c I just added these routines as
>IOCTL's and life was good.  How should I write these routines now?
>
>Many Thanks,
>
>Matt Schulte
>Commtech, Inc.
>http://www.commtech-fastcom.com
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-serial" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>


