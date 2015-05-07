From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Thu, 07 May 2015 17:13:17 -0400
Message-ID: <554BD56D.9010800@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org> <554B9F43.6000702@hurleysoftware.com> <alpine.LFD.2.11.1505071942110.1538@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1505071942110.1538@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/07/2015 04:14 PM, Maciej W. Rozycki wrote:
> On Thu, 7 May 2015, Peter Hurley wrote:
> 
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
>  Good point.  If you want to disable the handover, then it has to be 
> handled by the early console driver somehow.  Perhaps an option for 
> `earlycon=' (e.g. `nohandover') would be required for that.  In that case 
> the default selection would apply for the regular console, depending on 
> the available drivers.
> 
>  Your concern appears to me unrelated to `earlycon=' vs `console=' 
> parameter aliasing though.  The same observation about the handover 
> applies whether the parameters are aliased to each other or not.  Have I 
> missed anything?
> 
>>> Why do you want to support `console=blah...' too (a question to be asked 
>>> back in 2007, but better late than never)?
>>
>> Command line is considered to be userspace, so it doesn't really matter
>> what I think about whether console= should have been overloaded like that.
>>
>> The fact is, it was.
> 
>  The change has not been cast in stone, it can always be reverted if on 
> the second thoughts it is concluded to have been wrong.
> 
>  How does this overload interact with multiple `console=' options being 
> present BTW, which one is considered the early console?  Or do we support 
> driving multiple early consoles in parallel just as we do with regular 
> consoles?

Please familiarize yourself with the existing 'console=' and 'earlycon='
command line options documented in Documentation/kernel-parameters.txt
These have not changed with 4.1-rc

Regards,
Peter Hurley
