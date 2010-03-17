From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2]: serial8250: Use native_io_delay on the x86
Date: Wed, 17 Mar 2010 11:25:46 -0700
Message-ID: <4BA11EAA.20506@zytor.com>
References: <20100317132849.7d49939b@marrow.netinsight.se> <20100317133050.54851ff8@marrow.netinsight.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52248 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab0CQS0s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 14:26:48 -0400
In-Reply-To: <20100317133050.54851ff8@marrow.netinsight.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Kagstrom <simon.kagstrom@netinsight.net>
Cc: x86@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, alan@linux.intel.com, akpm@linux-foundation.org

On 03/17/2010 05:30 AM, Simon Kagstrom wrote:
>   #ifdef __i386__
> -		outb(0xff, 0x080);
> +		native_io_delay();
>   #endif

There is something a lot more weird about this.  First of all, it's 
#ifdef'd out on all but __i386__ including x86-64; second, it looks like 
this is specific to synchronizing to the IER.

I'm wondering if the right thing isn't to add a dummy write to the SCR 
register (or similar.)

	-hpa
