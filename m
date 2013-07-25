From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 6/9] n_tty: Process echoes in blocks
Date: Wed, 24 Jul 2013 21:33:04 -0400
Message-ID: <51F08050.40207@hurleysoftware.com>
References: <1371303376-5028-1-git-send-email-peter@hurleysoftware.com> <1371305069-5366-1-git-send-email-peter@hurleysoftware.com> <1371305069-5366-7-git-send-email-peter@hurleysoftware.com> <20130723235329.GA14499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:45504 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753484Ab3GYBdI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Jul 2013 21:33:08 -0400
In-Reply-To: <20130723235329.GA14499@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 07/23/2013 07:53 PM, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2013 at 10:04:26AM -0400, Peter Hurley wrote:
>> Byte-by-byte echo output is painfully slow, requiring a lock/unlock
>> cycle for every input byte.
>>
>> Instead, perform the echo output in blocks of 256 characters, and
>> at least once per flip buffer receive. Enough space is reserved in
>> the echo buffer to guarantee a full block can be saved without
>> overrunning the echo output. Overrun is prevented by discarding
>> the oldest echoes until enough space exists in the echo buffer
>> to receive at least a full block of new echoes.
>
> I'm a bit worried about this, I wonder if anything is expecting the
> echos to not come in "bursts" like this, but I really can't think of why
> they would want that.

The block size for echoes is trivially settable so if you'd prefer a
smaller value than every 256 chars, I could send a patch for a value
you are more comfortable with - 64 chars, 32 chars, whatever.

I picked that value from casual performance testing and that it
coincides with the smallest possible flip buffer; ie., echo blocks are
retired at the same rate as flip buffers when receiving is not
saturated.

> So let's apply it and see what breaks!  :)

I'm ready :)

Regards,
Peter Hurley

