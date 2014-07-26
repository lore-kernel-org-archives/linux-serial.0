From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: ARC fails to boot on linux-next of 20140711
Date: Sat, 26 Jul 2014 06:53:29 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4B7DE0@IN01WEMBXA.internal.synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA230753C4B67CF@IN01WEMBXA.internal.synopsys.com>
	<CAL_JsqJ2q0RSvXQW03RqwwBi_TKQ7Zt6DsUbsUruzh5oqYi5Cg@mail.gmail.com>
 <20140726053344.95800C40C93@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-next <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Kolesov <Anton.Kolesov-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Saturday 26 July 2014 11:03 AM, Grant Likely wrote:
> On Fri, 25 Jul 2014 09:15:22 -0500, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Fri, Jul 25, 2014 at 6:02 AM, Vineet Gupta
>> <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote:
>>> Hi Grant,
>>>
>>> linux-next has a series for arc_uart (via tty tree) which converts it to generic
>>> earlycon and specifies console via /chosen/stdout-path vs.  an explicit param in
>>> /chose/bootargs
>>>
>>> 2014-06-24 9da433c0a0b5 ARC: [arcfpga] stdout-path now suffices for earlycon/console
>>>
>>> This relied on prev commit of yours (from linux next of 20140711), which seem to
>>> have disappeared now.
>>>
>>> 2014-03-27 a9296cf2d0b6 of: Create of_console_check() for selecting a console
>>> specified in /chosen
>>> 2014-03-27 cfa9cacc5dd3 of: Enable console on serial ports specified by
>>> /chosen/stdout-path
>>>
>>> Is there a specific reason for dropping these patches (or perhaps a merge to be
>>> merged). I cherry-picked both but still doesn't work.
>>>
>>> Can you please advise next step forward, before I go off debugging with those
>>> patches in.
>> There's an issue that if you have stdout-path and "earlycon" on the
>> command line, the kernel will switch to tty0 and disable the earlycon.
>>
>> This is the "fix", but I don't like adding the DT dependency into generic code:
> Yes, I'm not fond of it either. I've not been able to test it though and
> work out a proper bug fix. As far as I can understand, the earlycon code
> only works on aarch64, correct? I haven't been able to get an aarch64
> boot working in QEMU yet.
>
> g.

Well generic earlycon works on ARC too (as it stands today in linux-next). std-out
based console is broken because the relevant core/of fixes from you are no longer
present there. Can we get those back please !

-Vineet

>
>> @@ -2382,7 +2386,7 @@ void register_console(struct console *newcon)
>>                 if (newcon->setup == NULL ||
>>                     newcon->setup(newcon, NULL) == 0) {
>>                         newcon->flags |= CON_ENABLED;
>> -                       if (newcon->device) {
>> +                       if (newcon->device  && !of_stdout) {
>>                                 newcon->flags |= CON_CONSDEV;
>>                                 preferred_console = 0;
>>                         }
>>
>> Rob
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
