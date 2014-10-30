From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] serial: msm: Add magic SysRq support in dmmode
Date: Thu, 30 Oct 2014 12:00:52 +0000
Message-ID: <54522874.6040901@linaro.org>
References: <1414600712-20721-1-git-send-email-daniel.thompson@linaro.org> <54512B7B.905@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46259 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933129AbaJ3MBC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Oct 2014 08:01:02 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so4289316wiv.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2014 05:01:01 -0700 (PDT)
In-Reply-To: <54512B7B.905@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>

On 29/10/14 18:01, Stephen Boyd wrote:
> On 10/29/2014 09:38 AM, Daniel Thompson wrote:
>> Currently the _dm RX handler detects breaks but does not pass any
>> characters to uart_handle_sysrq_char().
>>
>> The _dm optimizations combined with the port's spin lock make if
>> difficult to pass all characters to the sysrq logic because we cannot
>> safely call uart_handle_sysrq_char() when the lock is held without
>> deadlock (the console handler also takes the lock).
>>
>> Rather than passing all characters via uart_handle_sysrq_char() this patch
>> only passes the last few characters in the FIFO. This should include all
>> characters typed as a slow (human) rate. This makes the problem much
>> simpler and allows us to move the handling of these characters outside
>> of the port lock. This makes magic SysRq work if there is a human at
>> the keyboard (or a short delay in a script).
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
> 
> I have a patch that I was going to send for this (Frank R. and I have
> been looking at it since a month or two ago). This patch doesn't look
> correct given that the SR register is not actually accurate and doesn't
> indicate that a break is there in the fifo. I'll Cc you on the patch,
> please test it.

Testing on IFC6410 is mostly OK.

Most sysrq actions work fine but resume from kdb is extremely
unreliable; in most cases is kills the serial RX ('echo g >
/proc/sysrq-trigger' shows that characters are still going into the FIFO
but never get to the interrupt handler).

However, this is not a regression versus my patch, resume was not
reliable with my patch either.
