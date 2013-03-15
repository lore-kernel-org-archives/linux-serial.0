From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] tty/serial: Fix uninitialized variable warning
Date: Fri, 15 Mar 2013 21:24:38 +0000
Message-ID: <CACxGe6twB3fSkQ97Jq-+zSn7wen9axS=5fB4uSs08etfREJaPQ@mail.gmail.com>
References: <1362360907-4439-1-git-send-email-grant.likely@secretlab.ca> <20130315203010.GA25081@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45657 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab3COVY7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Mar 2013 17:24:59 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so4969563iea.10
        for <linux-serial@vger.kernel.org>; Fri, 15 Mar 2013 14:24:59 -0700 (PDT)
In-Reply-To: <20130315203010.GA25081@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 15, 2013 at 8:30 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 04, 2013 at 09:35:07AM +0800, Grant Likely wrote:
>> drivers/tty/serial/8250/8250.c: In function 'serial_unlink_irq_chain':
>> drivers/tty/serial/8250/8250.c:1676:19: warning: 'i' may be used uninitialized in this function
>>
>> There isn't an actual bug here since the function tests the condition
>> that would cause i to be uninitialized before dereferencing i. However,
>> at least some versions of GCC complain as shown above. (in my case,
>> powerpc gcc 2.5.2). Initializing i to NULL makes it clear to GCC and the
>> casual code reviewer that i will not be dereferenced to a random
>> address.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>> Greg, some may argue that this is a tool problem, not a kernel problem,
>> but it is useful to me. If anyone objects I'm not going to spend any
>> time championing for this patch.
>
> Upgrade your tools to ones that work properly :)

FWIW, it's still a toolchain that a lot of people use for embedded
powerpc development.

g.
