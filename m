From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Mon, 11 Jan 2016 14:57:46 +0100
Message-ID: <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org> <10159898.8xe3rmYdEi@wuerfel> <175E89CE-581C-48AB-B7FF-6E9A41B033D5@martin.sperl.org> <4288762.bCLxQBDvy4@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4288762.bCLxQBDvy4@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


> On 11.01.2016, at 13:21, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> 
> Please just add another patch to rename the existing uarts appropriately
> first, then add this one on top with the correct name.

I can do that with the next incarnation of the patch.

But would that not break dt-source files, that refer to uart0?
Is this not considered an API change as well or does this only apply
to the binary files?



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
