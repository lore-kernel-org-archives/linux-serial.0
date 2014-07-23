From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
Date: Wed, 23 Jul 2014 07:30:33 +0100
Message-ID: <CAD8Lp47GpiRabx56u5F+qrY=mx_OOj2dOqfQ6_=4TBe=JskDkQ@mail.gmail.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
	<20140626113939.GP32514@n2100.arm.linux.org.uk>
	<53AC0BCC.1010608@samsung.com>
	<CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
	<20140709142333.503a9e39@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140709142333.503a9e39-mUKnrFFms3BCCTY1wZZT65JpZx93mCW/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 9, 2014 at 2:23 PM, One Thousand Gnomes
<gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> I like the sound of going to the standard ttyS notation and only
>> providing ports for ones that exist, but is this userspace-visible
>
> ttyS is 8250 compatible UARTS.
>
> If the Samsung is not an 8250 compatible UART then it doesn't belong as
> ttyS from the kernel perspective.

OK, thanks for pointing that out.

So we stick with the ttySAC namespace. And by doing that, and sticking
to the existing and documented behaviour, it seems like we have
already addressed Russells's concern:

> The problem you're raising is very much the same problem you have when
> there are multiple USB serial devices connected to the machine - you
> just get a bunch of /dev/ttyUSB* devices which are unordered (they can
> change on each boot, or change order if you disconnect and reconnect
> them.)

In this case, we have a dedicated namespace and the path information
is already fully encoded in the device name. The order and number of
ports are fixed, they can't be disconnected and reconnected. There is
no real risk of an additional serial controller driver coming to play
in the ttySAC namespace.

So I think Tomasz's approach is good - although I haven't looked at
the code in detail.

Thanks
Daniel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
