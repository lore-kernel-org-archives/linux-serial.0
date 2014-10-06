From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: add sysrq support
Date: Mon, 6 Oct 2014 08:38:12 -0300
Message-ID: <CAOMZO5B94UjrpcksXeMRLZ_sV-GPv252xGs8E+y7NLXtMKOxVg@mail.gmail.com>
References: <20140929014129.GA8687@kroah.com>
	<1411999905-27044-1-git-send-email-j.uzycki@elproma.com.pl>
	<CAOMZO5Cctk4UNvK2=MC9tf2Fzi1r0+qdn-SXfC-=W9n3T=a+VA@mail.gmail.com>
	<54327E41.9070607@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:57655 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJFLiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2014 07:38:14 -0400
In-Reply-To: <54327E41.9070607@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 6, 2014 at 8:34 AM, Janusz U=C5=BCycki <j.uzycki@elproma.co=
m.pl> wrote:
> Hi,
>
> W dniu 2014-10-04 18:19, Fabio Estevam pisze:
>
>> Janusz,
>>
>> On Mon, Sep 29, 2014 at 11:11 AM, Janusz Uzycki <j.uzycki@elproma.co=
m.pl>
>> wrote:
>>>>
>>>> So I'm deleting all of these now, please resend the latest
>>>> versions you have, with properly versioning
>>>> and order information.
>>>
>>> Sure. If you don't want to comment dirty patches
>>> I will not send you them.
>>> I can send you only the final version, commented before.
>>>
>>> On the moment this patch is ready to apply.
>>>
>>> [PATCH RESEND] serial: mxs-auart: add sysrq support
>>> The patch is resent to apply.
>>
>> What Greg is asking you to do is to provide a proper version
>> annotation in your patches.
>>
>> For example: [PATCH v2] serial: mxs-auart: add ...
>>
>> Then if you need to submit it again you should do:
>>
>> [PATCH v3] serial: mxs-auart: add ...
>
>
> I will resend the rest of patches (as v4) this week.
> This simple patch is independent from the previous patchset so
> I decided to resubmit it alone ([PATCH RESEND] header used)
> to apply.
>
> I rather shouldn't resend the patch again I guess.
> I sent the same initial version of the patch twice
> after Greg's email so I did mess enough I think.
>
>> Also, always explain below the --- line what changed from one versio=
n to
>> another
>
> I thought composing cover letter is the only solution for resent patc=
h or
> series.
> As I understood this way is appropriate for single patch only (not pa=
tch
> set).
> "Below" - it means between the line and diffstat?
> Should I add new/second '---' line before diffstat?

Just do something like:

When using mxs-auart based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there,
this patch just simply enable it.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
Changes since v3:
- bla bla bla
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
