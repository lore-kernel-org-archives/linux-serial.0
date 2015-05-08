From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Fri, 08 May 2015 06:12:37 -0400
Message-ID: <554C8C15.4070404@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org> <554B9F43.6000702@hurleysoftware.com> <20150508063433.GA6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150508063433.GA6325@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/08/2015 02:34 AM, Sascha Hauer wrote:
> On Thu, May 07, 2015 at 01:22:11PM -0400, Peter Hurley wrote:
>> On 05/07/2015 01:09 PM, Maciej W. Rozycki wrote:
>>> On Mon, 4 May 2015, Peter Hurley wrote:
>>>
>>>>>> Since 2007, 'console=' is a early param synonym for 'earlycon='; IOW,
>>>>>> the message is new but not the behavior.
>>>>>
>>>>> "console=" had nothing to do with early param before.
>>>>
>>>> *Yes, it has* since the commit I referenced in the previous email and
>>>> the email before that when I noted that 'console=' and 'earlycon=' are
>>>> synonyms if CONFIG_SERIAL_EARLYCON=y, and it has been that way since
>>>> 2007.
>>>>
>>>> The only thing that has changed is that I added a diagnostic; _to repeat_,
>>>> the earlycon matching code has always run in this case, only the
>>>> diagnostic is new.
>>>
>>>  What's the point of having two parameters as synonyms whose syntax is not 
>>> compatible to each other in the general case?  I'd expect the following 
>>> cases to be handled:
>>>
>>> 1. Regular console only (no early console requested) => `console=foo...'.
>>>
>>> 2. Both early and regular console => `earlycon=blah... console=foo...'.
>>>
>>> 3. Early console handing over to regular console => `earlycon=blah...'.
>>
>>   4. Early console only => `earlycon=blah...'
>>
>> How to distinguish between 3 & 4?
> 
> Given that the aliasing only makes sense for console=uart, and
> console=uart8250, we can do the following. Not exactly the nicest
> code, but only slighty more ugly than what we have now in
> do_early_param()

I already sent Greg a patch to remove the egregious and unsightly
false positive warning. Thanks anyway.

Regards,
Peter Hurley
