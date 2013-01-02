From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH] tty: Only wakeup the line discipline idle queue when
 queue is active
Date: Wed, 2 Jan 2013 16:21:53 +0100
Message-ID: <CAMSQXEHmDb5rUQnT1JNcMCzdaN+gAr+1hR=PyPiDMu7vK5ykxA@mail.gmail.com>
References: <1355842130-15482-1-git-send-email-meltedpianoman@gmail.com>
	<50E3FDFA.4070203@suse.cz>
	<20130102114311.66215bf5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50990 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab3ABP05 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jan 2013 10:26:57 -0500
In-Reply-To: <20130102114311.66215bf5@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>

Hi Jiri & Alan,

2013/1/2 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>
>> Looks good, but I would prefer the layer to provide us with
>> wake_up_if_active...
>
> Seconded - this is a problem for the wake up logic in the RT tree. Why
> would we ever do anything else ?

I don't understand your responses: do you suggest to implement this
"if active" behavior in:
* A new wake_up function called wake_up_if_active() that is part of
the waitqueue layer?
* Implement this behavior in the existing wake_up() function as part
of the RT patch?

Regards,
Ivo
