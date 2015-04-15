From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 0/5] Add big-endian MMIO support to serial8250
Date: Wed, 15 Apr 2015 07:51:12 -0500
Message-ID: <CAL_JsqKz_8Zb2DX0Yvg-Oh-26hKDMR4RzUagFtsGauGVdH9RqA@mail.gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
 <CAL_Jsq+-Yr3oB2=7X2a9XDU_-b+08WfJRJUqVsCHAaQEQxQ1Mg@mail.gmail.com>
 <5527DE27.8060700@hurleysoftware.com> <20150413170912.GA802@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150413170912.GA802-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 13, 2015 at 12:09 PM, Greg Kroah-Hartman
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Fri, Apr 10, 2015 at 10:28:55AM -0400, Peter Hurley wrote:
>> On 04/10/2015 09:52 AM, Rob Herring wrote:
>> > On Thu, Apr 9, 2015 at 3:05 PM, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >> V3->V4:
>> >>
>> >> Rebase on Linus' head of tree
>> >>
>> >> Tweak documentation per Grant's request
>> >>
>> >> Drop the of_earlycon patches in favor of Peter's series
>> >
>> > Are there conflicts with Peter's stuff?
>>
>> No.
>>
>> It adds the required pieces so that a trivial patch on top of
>> both series will enable mmio32be for earlycon.
>>
>> > The series looks good to me.
>>
>> Same.
>>
>> Reviewed-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
>
> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

I've applied the series for 4.1. I took it since it got dropped last time.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
