From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] staging: evict abandoned 68360serial.c driver from 3.4
Date: Wed, 28 Mar 2012 13:02:29 -0400
Message-ID: <4F734425.9010204@windriver.com>
References: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com> <20120328150528.GD19862@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:34317 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab2C1RDA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Mar 2012 13:03:00 -0400
In-Reply-To: <20120328150528.GD19862@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@linux.intel.com>

On 12-03-28 11:05 AM, Greg KH wrote:
> On Tue, Mar 27, 2012 at 07:07:11PM -0400, Paul Gortmaker wrote:
>> commit 3a0db7215c88077b61a673215756ec4a0dc0c7a5
>>
>>     "TTY: serial, move 68360 driver to staging"
>>
>> did so because the driver had remained broken since 2008.  It also
>> added this text to the TODO file:
>>
>>    "If no one steps up to adopt any of these drivers, they will
>>     be removed in the 3.4 release."
>>
>> A quick search on the internet doesn't reveal anyone actively
>> trying to update/fix this driver, so follow through on the above
>> and remove it from the pending 3.4 release.
>>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Thanks for this, but as I missed the merge window for 3.4, I'll queue it
> up for 3.5 just to be safe.

Thanks Greg,

I only happened to stumble upon it last night or I would have
sent it earlier. No harm in it sitting there another release.
Feel free to prune the "from 3.4" off the end of the shortlog.

Paul.

> 
> greg k-h
