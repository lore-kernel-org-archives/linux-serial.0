From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: Only wakeup the line discipline idle queue when
 queue is active
Date: Wed, 02 Jan 2013 20:06:54 +0100
Message-ID: <50E4854E.8060801@suse.cz>
References: <1355842130-15482-1-git-send-email-meltedpianoman@gmail.com> <50E3FDFA.4070203@suse.cz> <20130102114311.66215bf5@pyramind.ukuu.org.uk> <CAMSQXEHmDb5rUQnT1JNcMCzdaN+gAr+1hR=PyPiDMu7vK5ykxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:39599 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab3ABTL7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jan 2013 14:11:59 -0500
In-Reply-To: <CAMSQXEHmDb5rUQnT1JNcMCzdaN+gAr+1hR=PyPiDMu7vK5ykxA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>

On 01/02/2013 04:21 PM, Ivo Sieben wrote:
> I don't understand your responses: do you suggest to implement this
> "if active" behavior in:
> * A new wake_up function called wake_up_if_active() that is part of
> the waitqueue layer?

Sounds good.

-- 
js
suse labs
