From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Wed, 28 Jan 2015 08:21:09 -0600
Message-ID: <CAL_JsqLvg9CA32oWVzxA5TxtPJxAJFf9K4N+RHJeefemr_88ug@mail.gmail.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
 <54C7AA2D.7080202@hurleysoftware.com>
 <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
 <54C7EA6A.4010805@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C7EA6A.4010805@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 27, 2015 at 1:43 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 01/27/2015 11:44 AM, Rob Herring wrote:
>> On Tue, Jan 27, 2015 at 9:09 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 01/27/2015 09:30 AM, Rob Herring wrote:
>>>> On Tue, Jan 27, 2015 at 6:44 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> Hi Rob,
>>>>>
>>>>> On 01/26/2015 11:50 PM, Rob Herring wrote:
>>>>>> Add mrvl,pxa-uart and mrvl,mmp-uart compatible strings for the of_serial
>>>>>> driver. These are 8250 variants which have a port type of PORT_XSCALE.
>>>>>>
>>>>>> There is also the serial driver pxa.c with these compatible strings
>>>>>> already. However, it can be replaced with the common 8250 driver. It has
>>>>>> some issues like it cannot coexist with the 8250 driver due to tty name
>>>>>> collision. That also means adding these compatible strings here should
>>>>>> not case a problem.
>>>>>
>>>>> So what determines which driver is controlling the port if both
>>>>> drivers are built-in?
>>>>
>>>> If both are built-in, whoever registers ttyS ports first wins. This
>>>> will be the 8250 driver due to link order.
>>>
>>> Ok, but then I think the commit log should reflect that this patch
>>> effectively replaces pxa2xx-uart driver with the 8250 driver for PXA/MMP uarts
>>> if both drivers are built-in or both drivers are modules.
>>
>> It doesn't always. It is only on DT enabled platforms. But I can be
>> more explicit about that.
>>
>> There is another patch to remove the PXA driver entirely which I'm
>> inquiring about why it was never merged [1]. This is why I went down
>> the path of getting the 8250 driver to work rather than trying to fix
>> the PXA driver.
>
> Ah. I had seen your inquiry but didn't grasp the significance.
> Greg acked that patch over 8 mos ago; it's still stuck somewhere?

It appears to me that this patch got added as a dependency to the rest
of the series which never got merged. Guess they lost interest.

> OTOH, I didn't realize that patch removed the PXA driver. That driver has
> errata workarounds which didn't get integrated into the 8250 core; it seems
> a shame to toss that away.

There was some discussion on errata in the prior versions. One of them
was deemed not needed. Another one is needed, but that's on certain
PXA2xx. So we'll need to pickup that work-around at some point, but it
is not yet needed here because PXA2xx is not enabled for DT.

> [ Sidebar: I did a trial split of 8250_core into a separate 8250 base module
>   and an 8250 universal driver. I keep having to rework the split but it's
>   pretty close now; the 8250 base module might be just the thing for simplifying
>   the pxa driver and getting console/earlycon/dma for free.
>
>   Let me see what I can do about getting that done.
> ]

Yes, it would be nice to split the legacy ISA parts from the proper
platform driver. There's way too many kconfig options for the 8250 as
well IMO.

BTW, It appears that the main motivator for a separate driver was to
add DMA support and that's what the out of tree driver adds. But now,
we would never add the PXA DMA API support and the 8250 driver has
learned DMA support.

Rob
