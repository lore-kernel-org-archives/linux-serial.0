From: Michael Williamson <michael.williamson@criticallink.com>
Subject: Re: [PATCH 1/2] serial: Provide capability to disable modem status
 interrupts in 8250 driver
Date: Tue, 04 Jan 2011 09:10:50 -0500
Message-ID: <4D232A6A.1030307@criticallink.com>
References: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com> <20110104135621.56a4770e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63843 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1ADOKz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jan 2011 09:10:55 -0500
In-Reply-To: <20110104135621.56a4770e@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, linux-serial@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org

On 1/4/2011 8:56 AM, Alan Cox wrote:

>> This patch was tested using a MityDSP-L138F platform having a UART CTS pin
>> connected to a clock signal (and configured, via pinmux, as a clock input
>> for another peripheral function).
> 
> Please hide such horrors in your platform code. We are trying todrive all
> the quirks stuff we can out of the core code.
> 
> Instead provide your own I/O methods when registering the port and mask
> the appropriate bogus bits in the register.
> 


Got it.  Thanks for the guidance.

-Mike

