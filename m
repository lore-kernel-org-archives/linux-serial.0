From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: jsm_tty: Fix a possible null pointer dereference in two functions
Date: Wed, 29 Nov 2017 19:19:05 +0100
Message-ID: <089a4b85-64e8-cb4a-c5f8-9abb2556e5e5@users.sourceforge.net>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com> <20171129173504.GA20581@kroah.com>
 <1511977896.19952.69.camel@perches.com> <20171129180528.GA24705@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129180528.GA24705@kroah.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

>> It's pretty unlikely, but it is an actual defect.
> 
> No it is not, those variables will never be set to NULL,
> so this can never be triggered.  Walk up the call chain.

If the involved software developers are convinced about the validity
of this pointer:

How do you think about to delete the following condition check
instead in the discussed function implementations?

	if (!ch)
		return;


Regards,
Markus
