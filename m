From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: [PATCH V6] tty/serial: add support for Xilinx PS UART
Date: Fri, 06 May 2011 14:12:27 +0200
Message-ID: <4DC3E5AB.9090905@petalogix.com>
References: <64601bfb-0904-4741-8fc8-075a262c988c@VA3EHSMHS024.ehs.local> <20110430002602.GA1818@kroah.com>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40590 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1EFMMa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 May 2011 08:12:30 -0400
In-Reply-To: <20110430002602.GA1818@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: John Linn <john.linn@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, joe@perches.com, grant.likely@secretlab.ca

Greg KH wrote:
> On Fri, Apr 29, 2011 at 06:13:07PM -0600, John Linn wrote:
>> The Xilinx PS Uart is used on the new ARM based SoC. This
>> UART is not compatible with others such that a seperate
>> driver is required.
>>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>> ---
>>
>> V6 
>>
>> Removed legal footer issues. My apologies Greg.
> 
> Nope, it's still there:
> 
>> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>>
> 
> {double sigh}
> 

Look at my email for V4 about NO_IRQ which I think should be also fixed.

Michal



-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
