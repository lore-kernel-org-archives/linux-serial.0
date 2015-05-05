From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Tue, 05 May 2015 06:39:47 -0400
Message-ID: <55489DF3.3070703@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <20150504215832.GW15254@pengutronix.de> <5547F350.7030405@hurleysoftware.com> <20150505045139.GY15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505045139.GY15254@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/05/2015 12:51 AM, Robert Schwebel wrote:
> Peter,
> 
> On Mon, May 04, 2015 at 06:31:44PM -0400, Peter Hurley wrote:
>>> You say it is a diagnostics message that indicates a misspelling.
>>> I fail to see what is misspelled, so what does it diagnose?
>>
>> Ok, so this is only about the diagnostic message, and not about some
>> other failure.
>>
>> I don't typically describe harmless diagnostics that didn't appear before
>> as "broken", so I was having trouble believing what I was reading.
>>
>> Now that I understand that this is _only_ about a diagnostic message that
>> didn't appear in previous kernels, I will direct to what I have written
>> previously multiple times.
>>
>> Further, I would ask how _you_ would programmatically distinguish
>> misspellings amongst the following console strings?
>>
>> 	console=pl012,...
>> 	console=_pl011,...
>> 	console=pl,...
>> 	console=ttyAMA0,...
> 
> Only the last line gives me output, but with the warning. All others are
> misspellings but output nothing. The last one gives me a misspelling
> warning, but it is the one that makes the output work.
> 
> Obviously this was not tested on an ARM device with a serial console,
> because it doesn't work there.

The primary test platform was a ARM device with a serial console.
And yes, it does work there.

> There should be an intended variant where *nothing* is misspelled in my
> oftree+kernel commandline.
> 
> In that case, the system should come up, console comes out of the serial
> line and earlycon is available. Then I should not get a diagnostic
> message, becasue I did everything right.

On 05/04/2015 05:27 PM, Peter Hurley wrote:
> Since the set of possible console names is not a closed set, there's
> simply no way to differentiate a misspelled name from a name that
> has not been added because a console driver has not yet loaded.


> Case A: consoleo=ttyAMA0
> 
>   Result: - system boots with output on intended serial console
>           - warning about having the earlycon misspelled
>           - earlycon not operational, although driver supports it
> 
> Case B: console=pl011
> 
>   Result: - no output at all, because system doesn't output to its
>             intented serial console.
> 
> Case C: ...?
> 
>   Are there other things I'm supposed to do in order to do it right?
> 
> So both cases A+B are not fully working as intented, right?
> 
> I'd like to fix it, but in order to do so, I want to learn how it is
> actually *intended* to work.

What do you want to "fix"?

Please stop using the indefinite pronoun, "it". I have no idea to what
you are referring, because I already supplied you with a patch to "fix"
the loglevel of the message.

Regards,
Peter Hurley
