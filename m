From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [GIT PATCH] TTY/serial driver patches for 3.2
Date: Wed, 26 Oct 2011 17:01:39 +0200
Message-ID: <4EA820D3.7010100@atmel.com>
References: <20111026114236.GA22180@kroah.com> <CA+55aFycM+nHxJNnFSjEXQvZkeBfHu161ePC0=7sWKZR1toQNA@mail.gmail.com> <20111026133438.GA26336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:42991 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103Ab1JZPB5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 11:01:57 -0400
In-Reply-To: <20111026133438.GA26336@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, cavokz@gmail.com

On 10/26/2011 03:34 PM, Greg KH :
> On Wed, Oct 26, 2011 at 03:18:21PM +0200, Linus Torvalds wrote:
>> On Wed, Oct 26, 2011 at 1:42 PM, Greg KH <gregkh@suse.de> wrote:
>>>
>>> The one in 8250_pci.c is trivial to fix, the atmel_serial one isn't as
>>> easy, but I'm sure you can figure it out :)  If you want me to do the
>>> merge for it, I'll be glad to do so, just let me know.
>>
>> So I figured it out, but please double-check, especially since it
>> seems to be some arm-only driver that I can't even compile-test my
>> resolution.
> 
> I think it looks correct, but yeah, as I can't build it either, it's
> tough to tell.
> 
> Nicolas, can you verify that Linus's merge was done correctly?  If not,
> can you send a patch?  It is commit
> efb8d21b2c6db3497655cc6a033ae8a9883e4063 in Linus's tree right now.

Yes, I have verified Linus's merge and it is correct.

Stephen hit this merge conflict in linux-next yesterday and I sent the
fixup as "[PATCH] tty/serial: atmel_serial: fixup merge conflict".
Anyway, sorry for the noise it has produced...

For the functions and macros that has been highlighted by Domenico in
his attempt to compile the atmel_serial driver, they shall come with
"device tree" git tree pull.

Best regards,
-- 
Nicolas Ferre
