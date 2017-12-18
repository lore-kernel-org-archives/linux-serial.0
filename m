From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: jsm_tty: Deletion of a null pointer check in two functions?
Date: Mon, 18 Dec 2017 12:36:15 -0200
Message-ID: <533d608d-c502-824f-9c79-880e387f4d09@linux.vnet.ibm.com>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com> <20171129173504.GA20581@kroah.com>
 <1511977896.19952.69.camel@perches.com> <20171129180528.GA24705@kroah.com>
 <089a4b85-64e8-cb4a-c5f8-9abb2556e5e5@users.sourceforge.net>
 <8ae240fa-7f77-8f4c-225c-853cdda73a67@linux.vnet.ibm.com>
 <817fcf72-cd9d-bf5b-ce83-ce2844e3e901@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <817fcf72-cd9d-bf5b-ce83-ce2844e3e901@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12/16/2017 04:27 AM, SF Markus Elfring wrote:
>> Thanks for the fix.
> 
> Thanks for your positive feedback.
> 
> 
>> I was on vacation - but now seeing all the analysis made here,
> 
> I assume that special communication settings could trigger
> corresponding consequences for the discussed source code adjustment.
> 
> 
>> if "ch" can't be NULL then please go ahead and remove the check =)
> 
> Would you dare to convert this request into a concrete patch?

For me, it's OK if you send the patch or I can do it myself.
It's a minor patch...but it's correct the way I see it.

So, what do you prefer? Send it yourself, or want me to send
it with your sign-off too? (since was your idea).

Thanks,


Guilherme


> 
> Regards,
> Markus
> 

