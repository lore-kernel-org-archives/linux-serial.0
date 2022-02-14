Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230EC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiBNSpN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:45:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBNSpN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 13:45:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B646E2AB
        for <linux-serial@vger.kernel.org>; Mon, 14 Feb 2022 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644864244;
        bh=XY5ZWnZvUHBRCFSdMYdlfBTZB4KKA6S7EhwJTQMpBuo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NnI0Kzv+jFbijb2GmqUoZ8nNCdMSjKwKSYFOxH70mG6EY1bbzmyKTBQrW+JwHvkea
         AORbwm/dp/SvmFKg9aThtXvOO6nRsa8C83XTQqxZ6U4K7QdL61Gzf4Zar2t44OIqSv
         h4VExZ/uaauc/qQcEK3YO0LFkmq55/eu+iXTbRHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1oHXPx3CBi-013fLl; Mon, 14
 Feb 2022 19:38:35 +0100
Message-ID: <5d710a45-1924-1a52-fe48-097deb12cb1c@gmx.de>
Date:   Mon, 14 Feb 2022 19:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] serial: parisc: GSC: fix build when IOSAPIC is not set
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220214180019.20384-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220214180019.20384-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:egCZaBxnkD9Tc7+dELp3P4BzdSFTt1jByG9kWcU2NDGK/MsWf0B
 wOSrH28Hacb+LzLoSzCfBM3AMbdybWiKiHN0adPQYHrBocu8vXcBy7J4WRHWOCQADmLVH2A
 P/hGe/tj8XQXoviHRQ41yuvmm4OYPeKHeH9ZxwBzxnWwtE7YVeyQGCHywWiY9i5YPUPY2+5
 3njKxCFO2lu45JlRx5RSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAnWi6p+m+I=:t2WRxtjmWoEC6QlNMFnHfP
 tmhJo2PX4auMomJr74oXb/ZF9gMsNa0ooyMM7U1Gd2s5wNPaFECzbOwhIFbKaE6f5nW/hL1HR
 3vsyIHrOhFEYM3YeWytyNzdj376/cXva6Zy/xWDaxiBwo2WXWDGeUYnDLsBFfkQ3hiV2dltME
 X8h6JAacWPS+SIRubSafF2P3k7qIuXnvnqHyCr/+HDZ82/L993TgnvTsom0ORvgq7z35YNgHw
 /guE6H+kJjXQ0AuQY3qJu+otsIPy7Jg5Gzvs29UDG/1sQ1IfVPTIGOZ/ygBXgQjvc1qwPLLQ2
 fcOBJlfoi4T8lE+LnvuPIzTWSnPxhD5Q+UuGaifwpEIHry5hV20A9RJows1h84XBTJTdhXqw9
 VtlDsSGQq0Cyreti272h318Z4EyCZ+viE+ut+TiOgh5+wQi0/CTBR/Pu5kIBI53xu3bK1bScO
 bQmTOHXfcNGvmy+W/yxbDxWlXrwznmlKi2KDb3zSHjwYxYp/O2dtbkFY0KA+tznVwTeyvqS4c
 lHCjkNZXXJtO1d7JdOBXNnFuTtZeXZvZGAIHbMX7Krca6rBIgy8WmVUAfPysxgypdmX8Y0IiX
 zEF2Bc2v2R8iOQeF7WaXP5zxZCxtZYzA9H6VPayt0yLfXCFYr5PWz4C6HLGpvuCjKXzuEHRbD
 JxKnIudDUV/ILNg8kHGn4BC5po3FpgAcfayPhWLz9iHzRAq25R+kGkyn+sgkOjRMDphwKxhKe
 eoWpOxDeHIJOUBaIPHxysF994119Oag5VrefXWzQ9WNdd21Cnmoi5tP8+Snpus0fK4VoT2ret
 aJp9+Sb2igFp5eIC71zcrfrMtVPsfxWDB4nAa9FpJH6hMGr9LNraz31kDaO7IKIJlxCKvK/Q9
 zaCRuUkSrbsiOqWPaX+pnauCRGli9OiyafwFsSa8DM/g60zoblvBj+gRj6xJlzWLIjsu+855z
 ZX7CuYam9wuMGPpvADHhwfWLeOmP11e3e1Hmk/YkQ8yKWQky6pl6kyJrNTqXlJr4W2sdmxMNX
 udLGQkwO2I2najdXaqwKYMuMCf493Ouik21iCRkeT5jB7BVyucVRB1Tme64nnHfBwkLO/hPRE
 hcv1G/OElC/W58=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/14/22 19:00, Randy Dunlap wrote:
> There is a build error when using a kernel .config file from
> 'kernel test robot' for a different build problem:
>
> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>
> when:
>   CONFIG_GSC=3Dy
>   CONFIG_SERIO_GSCPS2=3Dy
>   CONFIG_SERIAL_8250_GSC=3Dy
>   CONFIG_PCI is not set
>     and hence PCI_LBA is not set.
>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>
> Make the use of iosapic_serial_irq() conditional to fix the build error.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Suggested-by: Helge Deller <deller@gmx.de>

Thank you Randy!

Acked-by: Helge Deller <deller@gmx.de>

Since this patch only affects the parisc platform, I've added it
to the parisc for-next tree (with a stable tag), unless people want it
to go through another subsystem tree...

Helge

> ---
> v2: make the call to iosapic_serial_irq() conditional based on
>     CONFIG_ settings (thanks, Helge)
>
>  drivers/tty/serial/8250/8250_gsc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220211.orig/drivers/tty/serial/8250/8250_gsc.c
> +++ linux-next-20220211/drivers/tty/serial/8250/8250_gsc.c
> @@ -26,7 +26,7 @@ static int __init serial_init_chip(struc
>  	unsigned long address;
>  	int err;
>
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
>  	if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>  		dev->irq =3D iosapic_serial_irq(dev);
>  #endif
>

