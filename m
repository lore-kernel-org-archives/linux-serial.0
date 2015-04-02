From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
Date: Thu, 02 Apr 2015 11:36:40 -0400
Message-ID: <551D6208.2060009@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Kevin,

On 03/28/2015 03:28 PM, Kevin Cernekee wrote:
> On Sat, Mar 28, 2015 at 10:01 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>>>> I know these got ACKs already but as you point out in the commit log,
>>>> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
>>>> distinction between early_init_dt_scan_chosen_serial() and
>>>> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
>>>> taught to properly decode of_serial driver bindings instead of a
>>>> stack of parameters to of_setup_earlycon().
>>>>
>>>> In fact, this patch allows a mis-defined devicetree to bring up a
>>>> functioning earlycon because the 'big-endian' property is directly
>>>> associated with UPIO_MEM32BE, which will create incompatibility problems
>>>> when DT earlycon is fixed to decode the of_serial DT bindings.
>>>
>>> That's a good point. This hasn't been merged yet, so there isn't any
>>> impact on addressing this. I would propose that for consistency, the
>>> earlycon code should always default to 8-bit access. if big-endian
>>> accesses are required, then reg-io-width + big-endian must be specified.
>>>
>>> Something like the following would do it and would be future-proof. We
>>> can add support for 16 or 64bit big or little endian access if it ever
>>> became necessary.
>>
>> I was planning on adding MEM32BE support to OF earlycon on top of my
>> patch series 'OF earlycon cleanup', which adds full support for the
>> of_serial driver DT properties (among other things).
> 
> Hi Peter,
> 
> This is my latest work-in-progress, incorporating the feedback from
> you and Grant:
> 
> https://github.com/cernekee/linux/commits/endian
> 
> Not sure if this code plays nice with your recent cleanups?  If we're
> touching the same files/functions we should probably coordinate.

Ok, I'll look over your git tree and add whatever's required to
earlycon.

> Also, it is untested, as I do not currently have access to BE systems.
> If I get desperate I can try it on an LE system, adding the big-endian
> properties in DT and then hacking the 8250 driver to swap LE accesses
> for BE accesses.

Ok.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
