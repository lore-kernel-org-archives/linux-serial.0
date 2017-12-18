From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: jsm_tty: Deletion of a null pointer check in two functions?
Date: Mon, 18 Dec 2017 18:14:30 +0100
Message-ID: <5e7d7252-16d8-0232-c78a-8e01f89e52d8@users.sourceforge.net>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com> <20171129173504.GA20581@kroah.com>
 <1511977896.19952.69.camel@perches.com> <20171129180528.GA24705@kroah.com>
 <089a4b85-64e8-cb4a-c5f8-9abb2556e5e5@users.sourceforge.net>
 <8ae240fa-7f77-8f4c-225c-853cdda73a67@linux.vnet.ibm.com>
 <817fcf72-cd9d-bf5b-ce83-ce2844e3e901@users.sourceforge.net>
 <533d608d-c502-824f-9c79-880e387f4d09@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <533d608d-c502-824f-9c79-880e387f4d09@linux.vnet.ibm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> So, what do you prefer? Send it yourself,

I became concerned that “my patch” would not get picked up because of
Greg's communication settings (for my initial messages when they do not get
resent by other contributors).


> or want me to send it with your sign-off too? (since was your idea).

I would prefer this variant because I assume that the chances for integration
are higher for the discussed small source code adjustment.
I guess that the tag “Suggested-by” would be sufficient in this case.

Regards,
Markus
