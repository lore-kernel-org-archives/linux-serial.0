From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: jsm_tty: Fix a possible null pointer dereference in two functions
Date: Wed, 6 Dec 2017 14:16:21 -0200
Message-ID: <8ae240fa-7f77-8f4c-225c-853cdda73a67@linux.vnet.ibm.com>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com> <20171129173504.GA20581@kroah.com>
 <1511977896.19952.69.camel@perches.com> <20171129180528.GA24705@kroah.com>
 <089a4b85-64e8-cb4a-c5f8-9abb2556e5e5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <089a4b85-64e8-cb4a-c5f8-9abb2556e5e5@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 11/29/2017 04:19 PM, SF Markus Elfring wrote:
>>> It's pretty unlikely, but it is an actual defect.
>>
>> No it is not, those variables will never be set to NULL,
>> so this can never be triggered.  Walk up the call chain.
> 
> If the involved software developers are convinced about the validity
> of this pointer:
> 
> How do you think about to delete the following condition check
> instead in the discussed function implementations?
> 
> 	if (!ch)
> 		return;
> 
> 
> Regards,
> Markus
> 

Thanks for the fix.
I was on vacation - but now seeing all the analysis made here, if "ch"
can't be NULL then please go ahead and remove the check =)
I observed that this check comes from before Git, so really ancient code...

Cheers,


Guilherme

