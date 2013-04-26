From: Mark Hounschell <markh@compro.net>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 13:58:14 -0400
Message-ID: <517AC036.7000009@compro.net>
References: <51781A19.5030707@compro.net> <1366926071.3452.17.camel@thor.lan> <517A79E1.8060504@compro.net> <1366983913.3452.33.camel@thor.lan> <517A8EF1.8040006@compro.net> <20130426143526.GA15132@kroah.com> <517A98D6.2020701@compro.net> <20130426151905.GA27340@kroah.com> <1366990765.3452.50.camel@thor.lan> <20130426160348.GA28863@kroah.com>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:2049 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385Ab3DZR6P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 13:58:15 -0400
In-Reply-To: <20130426160348.GA28863@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On 04/26/2013 12:03 PM, Greg KH wrote:
> On Fri, Apr 26, 2013 at 11:39:25AM -0400, Peter Hurley wrote:
>> On Fri, 2013-04-26 at 08:19 -0700, Greg KH wrote:
>>> On Fri, Apr 26, 2013 at 11:10:14AM -0400, Mark Hounschell wrote:
>>>>> Also, any reason why these drivers aren't in the main kernel tree?  If
>>>>> they were, all of this work would have been done for you :)
>>>>>
>>>>
>>>> Yes, I wish they were in the kernel. I've had to maintain them since
>>>> the 2.6 days because Digi just won't do it and their cards do what
>>>> we need quite well and are still current products. Ya, you can buy a
>>>> brand new one but the latest kernel supported is 2.6. I think Digi
>>>> at one point long ago may have tried the "in kernel" route but you
>>>> probably know more about that than I do.
>>>>
>>>> Since 2.6, the maintenance on these hasn't been to bad, until udev
>>>> came along. But I guess after 3.4 the tty layer is going through
>>>> quite some changes that I have yet to understand.
>>>
>>> And there will be lots more changes happening to it in the future.  Why
>>> not submit the drivers now (after you get them working)?
>>
>> Probably not Mark's (or Compro's) code to submit.
>
> If it's a GPL driver, anyone can submit it.
>
> However, if the original copyright owner doesn't want it to be
> submitted, we will be glad to take that under consideration.
>
> Mark, what's the reason this has never been submitted?
>

Greg,

As for the Digi card driver/drivers, I can't say why not. There is a 
remnant of the actual one this thread is pertaining to in 
./Documentation/serial/digiepca.txt. I've never submitted it or any of 
their others I have to maintain because I didn't know I could nor would 
know how to start. I thought that Digi would have had to do it.

As far as Compro's drivers go, I think we have just been a little 
wary/unknowing of what it would take and what the results of the effort 
would actually be. Would they still do what _we_ needed them to do? Are 
we kernel savvy enough to get them to a state you would accept? etc... 
We do understand that if they were in the kernel that the best qualified 
people would be the ones that "kept them current" with the latest kernel 
changes. It's certainly something that no one here would object to 
doing. Are you the man to talk to? What is the actual process?


Regards
Mark

