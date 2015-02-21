From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
Date: Sat, 21 Feb 2015 16:18:44 -0600
Message-ID: <CAL_JsqKCnD2-=pepcnianeVCw=Knn5Audt_EL0sHVszmTVc8KA@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <20141125151018.359EAC44343@trevor.secretlab.ca> <20141125173859.GA27287@kroah.com>
 <20141125211116.GA9997@kroah.com> <CACxGe6uifCPz6RM59MVODWo2WGoVBMWSFzmL9Uz3AVJ0C9-hig@mail.gmail.com>
 <CAJiQ=7AMG44h7d2Fuw_ZLynPP62EcD++_kttBymqZgcKK=V8Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJiQ=7AMG44h7d2Fuw_ZLynPP62EcD++_kttBymqZgcKK=V8Ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Feb 21, 2015 at 2:53 PM, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Nov 26, 2014 at 5:14 AM, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Nov 25, 2014 at 9:11 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
>>> On Tue, Nov 25, 2014 at 09:38:59AM -0800, Greg KH wrote:
>>>> On Tue, Nov 25, 2014 at 03:10:18PM +0000, Grant Likely wrote:
>>>> > On Mon, 24 Nov 2014 15:36:15 -0800
>>>> > , Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> >  wrote:
>>>> > > My last submission attempted to work around serial driver coexistence
>>>> > > problems on multiplatform kernels.  Since there are still questions
>>>> > > surrounding the best way to solve that problem, this patch series
>>>> > > will focus on the narrower topic of big endian MMIO support on serial.
>>>> > >
>>>> > >
>>>> > > V2->V3:
>>>> > >
>>>> > >  - Document the new DT properties.
>>>> > >
>>>> > >  - Add libfdt-based wrapper, to complement the "struct device_node" based
>>>> > >    version.
>>>> > >
>>>> > >  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>>>> > >    temporary variable, so it is easy to add more of_setup_earlycon()
>>>> > >    properties later.
>>>> > >
>>>> > >  - Make of_serial and serial8250 honor the new "big-endian" property.
>>>> > >
>>>> > >
>>>> > > This series applies cleanly to:
>>>> > >
>>>> > > git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
>>>> > >
>>>> > > but was tested on the mips-for-linux-next branch because my BE platform
>>>> > > isn't supported in mainline yet.
>>>> >
>>>> > For the whole series:
>>>> > Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> >
>>>> > Greg, which tree do you want to merge this through? My DT tree, or the
>>>> > tty tree?
>>>>
>>>> I can take these through my tty tree, thanks.
>>>
>>> I take that back, it doesn't apply to my tty tree due to changes in the
>>> of codebase.  So feel free to take all of these through your DT tree
>>> please:
>>>
>>> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>>
>> Applied all 7 patches. Thanks.
>
> Hi guys,
>
> I don't see these patches in devicetree-next or mainline.  Would you
> like me to rebase + resend?

Not sure what happened there, but since they conflicted for Greg, it's
probably best to rebase to 3.20-rc and resend them.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
