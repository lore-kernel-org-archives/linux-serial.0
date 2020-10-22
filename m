Return-Path: <SRS0=OWvP=D5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00FC2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 02:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BCF2227F
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 02:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DeS/8oEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442842AbgJVCxQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Oct 2020 22:53:16 -0400
Received: from ozlabs.org ([203.11.71.1]:49667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442728AbgJVCxQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Oct 2020 22:53:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CGsP14c7Vz9sSn;
        Thu, 22 Oct 2020 13:53:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603335192;
        bh=fW5FipmXYxyEiBCHMu/Sd0mLJUNgkUEv7kKEvoc29V0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DeS/8oEhEaeq235MxQgaLDc0dL8ank/k+UdrfESwGHS+oQacrPHsm2SnK/uhn8UJ0
         SuOqEbOVVsdXOCtnLZsRAzOvMwTx/miCuRrzfqM29KieQ6ERBMklEkPOk1fPpXCvIX
         pg2UCUi0cpL4cC0PNw2Uz/B/HrQa6QxqIq+6+BSUGucoZNa6wl5iieZrtXAP99+w34
         up9Kr9xMjz4IPptPv893Cq3n0BXmLyhXE8WHX3sbImziGehjfTczl87VVjyYH0qEz0
         RL26T9lFD1uA77TzLX9k6uEsxkPOjSAlVToeVm34D3ucgM7DK0qB3ugaXLSpV5nBwp
         h8Vn7kiDKIogw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Vivier <laurent@vivier.eu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial: pmac_zilog: don't init if zilog is not available
In-Reply-To: <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
References: <20201020162303.1730562-1-laurent@vivier.eu> <20201020162844.GA865546@kroah.com> <468bbbef-4745-3b16-b6f4-30b46ebcdc33@vivier.eu> <20201020173745.GA882703@kroah.com> <387fd2aa-b181-c41f-0581-0a7e79a44e41@vivier.eu> <20201020183246.GA912431@kroah.com> <b52e7fde-8874-3c53-ca13-7709656b69fb@vivier.eu>
Date:   Thu, 22 Oct 2020 13:52:56 +1100
Message-ID: <87o8kvx987.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> writes:
> Le 20/10/2020 =C3=A0 20:32, Greg KH a =C3=A9crit=C2=A0:
>> On Tue, Oct 20, 2020 at 08:19:26PM +0200, Laurent Vivier wrote:
>>> Le 20/10/2020 =C3=A0 19:37, Greg KH a =C3=A9crit=C2=A0:
>>>> On Tue, Oct 20, 2020 at 06:37:41PM +0200, Laurent Vivier wrote:
>>>>> Le 20/10/2020 =C3=A0 18:28, Greg KH a =C3=A9crit=C2=A0:
>>>>>> On Tue, Oct 20, 2020 at 06:23:03PM +0200, Laurent Vivier wrote:
>>>>>>> We can avoid to probe for the Zilog device (and generate ugly kerne=
l warning)
>>>>>>> if kernel is built for Mac but not on a Mac.
>>>>>>>
>>>>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>>>>> ---
>>>>>>>  drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
>>>>>>>  1 file changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/p=
mac_zilog.c
>>>>>>> index 063484b22523..d1d2e55983c3 100644
>>>>>>> --- a/drivers/tty/serial/pmac_zilog.c
>>>>>>> +++ b/drivers/tty/serial/pmac_zilog.c
>>>>>>> @@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver =3D=
 {
>>>>>>>  static int __init init_pmz(void)
>>>>>>>  {
>>>>>>>  	int rc, i;
>>>>>>> +
>>>>>>> +#ifdef CONFIG_MAC
>>>>>>> +	if (!MACH_IS_MAC)
>>>>>>> +		return -ENODEV;
>>>>>>> +#endif
>>>>>>
>>>>>> Why is the #ifdef needed?
>>>>>>
>>>>>> We don't like putting #ifdef in .c files for good reasons.  Can you =
make
>>>>>> the api check for this work with and without that #ifdef needed?
>>>>>
>>>>> The #ifdef is needed because this file can be compiled for PowerMac a=
nd
>>>>> m68k Mac. For PowerMac, the MACH_IS_MAC is not defined, so we need the
>>>>> #ifdef.
>>>>>
>>>>> We need the MAC_IS_MAC because the same kernel can be used with sever=
al
>>>>> m68k machines, so the init_pmz can be called on a m68k machine without
>>>>> the zilog device (it's a multi-targets kernel).
>>>>>
>>>>> You can check it's the good way to do by looking inside:
>>>>>
>>>>>     drivers/video/fbdev/valkyriefb.c +317
>>>>>     drivers/macintosh/adb.c +316
>>>>>
>>>>> That are two files used by both, mac and pmac.
>>>>
>>>> Why not fix it to work properly like other arch checks are done
>>> I would be happy to do the same.
>>>
>>>> Put it in a .h file and do the #ifdef there.  Why is this "special"?
>>>
>>> I don't know.
>>>
>>> Do you mean something like:
>>>
>>> drivers/tty/serial/pmac_zilog.h
>>> ...
>>> #ifndef MACH_IS_MAC
>>> #define MACH_IS_MAC (0)
>>> #endif
>>> ...
>>>
>>> drivers/tty/serial/pmac_zilog.c
>>> ...
>>> static int __init pmz_console_init(void)
>>> {
>>>         if (!MACH_IS_MAC)
>>>                 return -ENODEV;
>>> ...
>>=20
>> Yup, that would be a good start, but why is the pmac_zilog.h file
>> responsible for this?  Shouldn't this be in some arch-specific file
>> somewhere?
>
> For m68k, MACH_IS_MAC is defined in arch/m68k/include/asm/setup.h
>
> If I want to define it for any other archs I don't know in which file we
> can put it.
>
> But as m68k mac is only sharing drivers with pmac perhaps we can put
> this in arch/powerpc/include/asm/setup.h?

It doesn't really belong in there.

I'd accept a patch to create arch/powerpc/include/asm/macintosh.h, with
MACH_IS_MAC defined in there.

cheers
