From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/7] tty: Add lock/unlock ldisc pair functions
Date: Mon, 20 May 2013 17:44:00 -0400
Message-ID: <519A9920.3010702@hurleysoftware.com>
References: <20130415201411.GA27360@kroah.com> <1366107356-7699-1-git-send-email-peter@hurleysoftware.com> <1366107356-7699-2-git-send-email-peter@hurleysoftware.com> <20130520193403.GA14340@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:50162 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758411Ab3ETVoF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 May 2013 17:44:05 -0400
In-Reply-To: <20130520193403.GA14340@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/20/2013 03:34 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 16, 2013 at 06:15:51AM -0400, Peter Hurley wrote:
>> Just as the tty pair must be locked in a stable sequence
>> (ie, independent of which is consider the 'other' tty), so must
>> the ldisc pair be locked in a stable sequence as well.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>   drivers/tty/tty_ldisc.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>
> This patch breaks the build :(

Sorry about that.

> I've taken the first one, care to mush this one with the 7/7 patch, so
> there are no build breaks, and resend the 5 resulting patches so I can
> apply these?

Maybe it would be better to reorder 7/7 to be 1/6, if that's ok?
More work for me but the history will be cleaner.

Regards,
Peter
