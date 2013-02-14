From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] serial/arc-uart: Urgent DT related update
Date: Thu, 14 Feb 2013 11:25:04 +0530
Message-ID: <511C7C38.7030009@synopsys.com>
References: <201302090928.43929.arnd@arndb.de> <1360572101-12744-1-git-send-email-vgupta@synopsys.com> <511B88F8.6010907@synopsys.com> <20130213163833.GA3465@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us02smtp1.synopsys.com ([198.182.60.75]:49604 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3BNFzS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Feb 2013 00:55:18 -0500
In-Reply-To: <20130213163833.GA3465@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org

On Wednesday 13 February 2013 10:08 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 13, 2013 at 06:07:12PM +0530, Vineet Gupta wrote:
>> On Monday 11 February 2013 02:11 PM, Vineet Gupta wrote:
>>> Hi Greg,
>>>
>>> Here's an update to arc-uart driver given Grant's recent review comments.
>>> As discussed in the thread, can you consider this a bug fix and apply to
>>> tty-next for 3.9. If you don't, please let me know as the corresponding DT file
>>> change would have to be to be seperately applied to arch/arc/boot/*.
>>>
>>> Patch is Based off linux-next of today.
>>>
>>> Thx,
>>> -Vineet
>>>
>>> Vineet Gupta (1):
>>>   serial/arc-uart: Miscll DT related updates (Grant's review comments)
>>>
>>>  .../devicetree/bindings/tty/serial/arc-uart.txt    |    4 ++--
>>>  drivers/tty/serial/arc_uart.c                      |   10 ++++------
>>>  2 files changed, 6 insertions(+), 8 deletions(-)
>>>
>> Greg, I'm assuming this won't make into tty until 3.9-rc1 and hence I need to drop
>> the platform patch from arc-next.
> I've taken this now, it will be sent to Linus for 3.9-rc1.

Thanks greg. I understand the tree closing rules' purpose, to let things stabilize
ahead of merge window - both from mechanical conflicts perspective as well as
runtime conflicts. However I'm slightly confused here about the process, specially
as a n00b maintainer and was hoping you could clarify it.

Your announcement of Feb 9th said

>With the release of the 3.8-rc7 kernel, I think it's time to close the
>TTY/serial tree for new features / cleanups for 3.9.  So I'm closing my
>tree, and will only be applying obvious bugfixes or regressions to it
>until 3.9-rc1 comes out.

So a bug fix sent on say Feb 11th would have been be applied to your tree to end
up in 3.9 merge-window pull to Linus- correct or no ? So in that sense, since
Arnd/Grant are deeming this patch as bug fix, shouldn't it make into 3.9
merge-window merge. So maybe, it's the criticality of the bug which warrants
that.  Please note that I'm just trying to understand the process here and not
arguing about patch itself.

>You can keep sending me patches for the tree that don't fit the "bugfix"
>category, but note that I'll be storing them away to wait for 3.9-rc1
>comes out, which might be a few weeks, so please be patient.

And once 3.9-rc1 hits, everything becomes 3.10 merge material anyways except for
bug fixes.

TIA,
-Vineet




