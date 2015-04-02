From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT properties
Date: Thu, 2 Apr 2015 08:46:12 -0500
Message-ID: <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com>
 <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5516DE64.6000104-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 28, 2015 at 12:01 PM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
> Hi Grant,
>
> On 03/27/2015 09:36 PM, Grant Likely wrote:
>> On Sun, 01 Mar 2015 17:23:11 -0500
>> , Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
>>  wrote:

[...]

>> Something like the following would do it and would be future-proof. We
>> can add support for 16 or 64bit big or little endian access if it ever
>> became necessary.
>
> I was planning on adding MEM32BE support to OF earlycon on top of my
> patch series 'OF earlycon cleanup', which adds full support for the
> of_serial driver DT properties (among other things).
>
> Unfortunately, that series is waiting on two things:
> 1. libfdt upstream patch, which I submitted but was referred back to me
> to add test cases. That was 3 weeks ago and I simply haven't had a free
> day to burn to figure out how their test matrix is organized. I don't
> think that's going to change anytime soon; I might just abandon that patch
> and do the string manipulation on the stack.
>
> ATM, earlycon is still broken if stdout-path options have been set.

Given David was okay with the patch itself, I suppose we could go
ahead and apply it to the kernel copy. If you're going to require
testcases, it should be trivial and/or documented on how to add...

> 2. Rob never got back to me on my query [1] to unify the OF_EARLYCON_DECLARE
> macro with the EARLYCON_DECLARE macro so that all earlycon consoles
> are named.

Sorry about that. I had thought about doing the same thing. At least
unifying the macros, but not necessarily the tables. If it is also
extendable to other firmware interfaces like ACPI perhaps that would
be good.

Rob

>
> Regards,
> Peter Hurley
>
> [1] https://lkml.org/lkml/2015/3/6/571
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
