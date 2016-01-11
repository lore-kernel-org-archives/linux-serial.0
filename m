From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH V2 2/2] serial: bcm2835: add driver for bcm2835-aux-uart
Date: Mon, 11 Jan 2016 16:25:35 +0100
Message-ID: <87y4bw9lzk.fsf@dell.be.48ers.dk>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
	<1452344854-2576-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452344854-2576-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
	(kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org's message of "Sat, 9 Jan 2016 13:07:33
	+0000")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

>>>>> "kernel" == kernel  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> writes:

 > From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
 > The bcm2835 SOC contains an auxiliary uart, which is very close
 > to the ns16550 with some differences.

 > The big difference is that the uart HW is not using an internal divider
 > of 16 but 8, which results in an effictive baud-rate being twice
 > the requested baud-rate.

 > This driver handles this device correctly and handles the difference in
 > the HW divider by scaling up the clock ba a factor of 2.

s/ba/by/

-- 
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
