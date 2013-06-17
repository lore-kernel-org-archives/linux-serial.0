From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4 00/24] lockless n_tty receive path
Date: Mon, 17 Jun 2013 16:32:10 -0400
Message-ID: <51BF724A.505@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com> <1371302076-4688-1-git-send-email-peter@hurleysoftware.com> <20130617200138.GA8199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:34442 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486Ab3FQUcR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 16:32:17 -0400
In-Reply-To: <20130617200138.GA8199@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 06/17/2013 04:01 PM, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2013 at 09:14:12AM -0400, Peter Hurley wrote:
>> Greg,
>>
>> As before, this patchset is dependent on the 'ldsem patchset'.
>> The reason is that this series abandons tty->receive_room as
>> a flow control mechanism (because that requires locking),
>> and the TIOCSETD ioctl _without ldsem_ uses tty->receive_room
>> to shutoff i/o.
>>
>> It is also dependent on 'n_tty fixes' which I recently resent
>> to you.
>
> Thanks for rebasing all of this, and resending it.  It's late in the
> 3.11 development cycle, so I'm going to wait unto 3.11-rc1 is out to
> queue it up for 3.12, to get it lots of testing in linux-next.

Thanks Greg. I actually meant to suggest these be held until after
the merge window but I got distracted by the VT1 deallocation bug
report.

Regards,
Peter Hurley
