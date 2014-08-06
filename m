From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [request for help] tty: serial: kgdb: fix msm_serial for kgdb
Date: Tue, 05 Aug 2014 17:55:49 -0700
Message-ID: <53E17D15.3090900@gmail.com>
References: <53E02C7C.4090206@gmail.com> <53E03475.6070007@codeaurora.org> <53E03CEC.3060108@gmail.com> <53E12F04.3000509@codeaurora.org> <53E16E7C.8050302@codeaurora.org>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53E16E7C.8050302@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

On 8/5/2014 4:53 PM, Stephen Boyd wrote:
> On 08/05/14 12:22, Stephen Boyd wrote:
>>
>> I tried it and it doesn't work either. Typing lots of characters finally
>> unjams it like you see on 1.4 hardware.
>>
> 
> Can you try this? It seems to work for me on both 1.3 and 1.4 hardware

Yes, much better getting rid of the single character mode!  Works for me
on the dragonboard (1.4 hardware).

Reviewed-by: Frank Rowand <frank.rowand@sonymobile.com>
Tested-by: Frank Rowand <frank.rowand@sonymobile.com>

Thanks for figuring this out.

I'll send a patch to handle sysrq after I see this patch upstream.

-Frank
