From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 6/7] n_tty: Only perform wakeups for waiters
Date: Sat, 23 Nov 2013 21:29:17 -0500
Message-ID: <5291647D.2070703@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>	<1385135965-4235-7-git-send-email-peter@hurleysoftware.com> <20131124002324.2fe609d6@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:40055 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752781Ab3KXC3W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Nov 2013 21:29:22 -0500
In-Reply-To: <20131124002324.2fe609d6@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/23/2013 07:23 PM, One Thousand Gnomes wrote:
> On Fri, 22 Nov 2013 10:59:24 -0500
> Peter Hurley <peter@hurleysoftware.com> wrote:
>
>> Only wakeup the _waiting_ reader, polls and/or writer(s).
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>   drivers/tty/n_tty.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
>> index 8f2356e..aae28a6 100644
>> --- a/drivers/tty/n_tty.c
>> +++ b/drivers/tty/n_tty.c
>> @@ -275,7 +275,8 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
>>   			return;
>>   		n_tty_set_room(tty);
>>   		n_tty_write_wakeup(tty->link);
>> -		wake_up_interruptible_poll(&tty->link->write_wait, POLLOUT);
>> +		if (waitqueue_active(&tty->link->write_wait))
>> +			wake_up_interruptible_poll(&tty->link->write_wait, POLLOUT);
>
> Does this actually microbenchmark faster ?

Getting on and off the write_wait queue is actually pretty expensive for
the "other" pty (the writer), and the unnecessary wakeup from the reader
doesn't help.

The other chunks are gratuitous.

Regards,
Peter Hurley

PS - This came up because there is some worst-case behavior that I'm looking
into fixing.  When the userspace reader is very far behind (say because it's
reading char-by-char), it doesn't make sense to keep restarting the input
processing worker.

