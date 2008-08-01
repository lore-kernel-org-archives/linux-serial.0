From: "Paul Gortmaker" <paul.gortmaker@gmail.com>
Subject: Re: [RFC] suggested fix for 83xx/85xx PowerPC UART break bug
Date: Thu, 31 Jul 2008 21:43:50 -0400
Message-ID: <7d1d9c250807311843j58246eeco4411ad9e5deda78a@mail.gmail.com>
References: <20080731152616.GA14248@windriver.com>
	 <EF0F4B21-1612-445C-AEBF-CD7B72762AD1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:25345 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbYHABnw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jul 2008 21:43:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so134535and.103
        for <linux-serial@vger.kernel.org>; Thu, 31 Jul 2008 18:43:50 -0700 (PDT)
In-Reply-To: <EF0F4B21-1612-445C-AEBF-CD7B72762AD1@kernel.crashing.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 31, 2008 at 4:31 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 31, 2008, at 10:26 AM, Paul Gortmaker wrote:
>
>>
>> This is something I'd tripped over earlier, and wanted to follow up on
>> to get an acceptable fix in for everyone's benefit before it falls through
>> the cracks again.
>>
>> There seems to be an issue with recent 83xx/85xx SOC UARTs, in which a
>> break
>> triggers a short lived IRQ storm (hence killing any hope of using SysRQ).
>> The only fix I found to work was to just ignore the bogus events that
>> had the associated signature bit set.
>>
>> This fix is what I was using against earlier kernels, but I hate to add
>> more
>> board/arch specific ifdefs to files like 8250.c, so I'm wondering if
>> anyone has any other suggestions before I simply end up cleaning up the
>> boardlist (now ppc is dead) and respinning the patch much as it is now
>> and resending.
>
> How did you test this or generate it?  I was thinking about this the other
> day and figured we need to try and track this down with the HW guys.  If we
> can generate a simple test I can try and run it through the various
> boards/parts we have and see which ones show the issue and which dont.

Actually, it is dead easy to reproduce.  The obvious symptom is that you'll
get a random complaint that SysRQ doesn't work.  You send the break via
whatever comm program you use, and 9 out of 10 times, you get the SysRQ
help menu pop up immediately, before you've even entered another character.

Once you dig a bit deeper, then you see that simply sending the break via
the comm program (and nothing else) will result in roughly 300 to 2000 events
as reported via "cat /proc/interrupts" on the UART in question.

I've tested with at least 5 different boards, with minicom, ckermit and even
with a commercial digiport in the path, and in all cases it came up the same.

Paul.

>
> - k
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
