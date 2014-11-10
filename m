From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date: Mon, 10 Nov 2014 22:01:29 +0300
Message-ID: <54610B89.4080004@cogentembedded.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com> <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:59672 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaKJTBd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2014 14:01:33 -0500
Received: by mail-la0-f44.google.com with SMTP id gf13so8355718lab.17
        for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2014 11:01:32 -0800 (PST)
In-Reply-To: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org

On 11/10/2014 05:14 PM, Rob Herring wrote:

>> __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
>> it will never be NULL.  Checking it against NULL causes the match loop to
>> run past the end of the array, and eventually match a bogus entry, under
>> the following conditions:

>>   - Kernel command line specifies "earlycon" with no parameters
>>   - DT has a stdout-path pointing to a UART node
>>   - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
>>     driver is compiled out)

>> Fix this by checking to see if match->compatible is a non-empty string.

>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> Cc: <stable@vger.kernel.org> # 3.16+

> Thanks. I'll queue this up.

> BTW, you should not add stable CC when submitting for review, but
> rather add a note for the maintainer to apply to stable. Only if a
> commit is in mainline already and not flagged for stable, then you
> send the patch with the stable tag to get the commit added to stable.
> It's a bit confusing...

    It's actually OK to tag the patch for stable (not really send to stable), 
so that that list gets automatically notified when the comment lands in the 
mainline. Unless the maintainer doesn't have his own rules about stable 
patches (like e.g. DaveM). Do you have alike rules?

> Rob

WBR, Sergei

