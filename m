From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding documentation for bcm2835-aux-uart
Date: Mon, 11 Jan 2016 15:40:20 +0100
Message-ID: <4799423.86Gz9JKjiK@wuerfel>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org> <4288762.bCLxQBDvy4@wuerfel> <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6035A0DD-AD61-48F7-B641-272BB23F3CD8-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Monday 11 January 2016 14:57:46 Martin Sperl wrote:
> > On 11.01.2016, at 13:21, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > 
> > Please just add another patch to rename the existing uarts appropriately
> > first, then add this one on top with the correct name.
> 
> I can do that with the next incarnation of the patch.
> 
> But would that not break dt-source files, that refer to uart0?
> Is this not considered an API change as well or does this only apply
> to the binary files?

To clarify: I meant you should change the node name, not the label.

The label is not part of the dtb data that gets passed to the kernel
and can have any value, including "uart0".

The node name is part of the dtb and should follow common naming
conventions (per ePAPR), but the kernel doesn't actually care, so
it won't break anything.

There are cases where a bootloader relies on a particular node name
in order to find a device node and patch its properties, but I don't
think this is the case here.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
