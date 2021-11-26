Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714CC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 16:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhKZQdK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:33:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:32889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233028AbhKZQbJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 11:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637944063;
        bh=2FuWrYm0oF6CCTDO60vNNKc1zTVcBTvOrclycCWWDE4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TKH/iqvWKZyjEM14QQmgMoqp3jr+up1Nc5ceiwA3snuisiB+iZAaUB5q52xEqjevK
         lppP1Y6e2SKlgus8Ra7q3bSB96NtjuzWiIEiagne/87XXrQ9avvFVCSTIceE58FQb/
         FEGz3MGMZ+lN1VAcJn3TQLIfnaXHQ7XiSJgQB1yA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.59] ([46.223.119.124]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1mIxkO17MV-00bOIM; Fri, 26
 Nov 2021 17:27:43 +0100
Subject: Re: [PATCH] serial: amba-pl011: do not request memory region twice
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
 <YaEGvkBl8YT33YAR@shell.armlinux.org.uk>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <7e7dae62-ac66-e5cd-f801-add3a9f81dc6@gmx.de>
Date:   Fri, 26 Nov 2021 17:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YaEGvkBl8YT33YAR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MNEMVyXWJGSzM0kpMnSE9zv4C/1vRByDyEWd0A6PULjzOV3IV/v
 S+GY3Z4V/EtQOVieSs972iC3RBwnA7oEk6lgFfF/nx6JcTu7d1TAWU2ZVIGTfrCnXunaBpo
 igRPNTqrUQn4tsr8DTGFSrsAy0zF7ShXzS4gsrJ0d3GcLfSNQyOH7q+dSDDKNZWoZJAs1hL
 vi9wd+CSvOH+ueftn/3zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jqO3TJzYf8U=:Wskog9aFVnEa/8Isw3TSLN
 c8OxzJudhsMVVrYzAdUpGJ6wiyX189aDRonrlw0r0HLfbzR2eq85agKVV0IRxkWTeTB6KhaJS
 2ibHuDFo7M7PisNnLe7f4SC5I4hzpup9UqkA3bIDbMA0TBrUmGXbsquuORzLMPUiBpOSMp8cG
 gf0tUgfLRuFdNoEXuCo577LNaNZ+BjDHK5LbVZn3H74eAGMFF2pcyb8VRg6PiMxXQFtnUuRNo
 u8lP+6Aq0zKQ+7wOw/i3Yi7pmBn1UuXxS7lfUpKWDraWoIpNCxkbrUea8p83XGrSbDXqZHp9b
 VVLTUJyJpWi2t66cNcpYr3l0iiWA9HgiV7NcUQd+bJUnL4WzNJ4aFgpsRs3XT5wgNZh9jP7Gx
 BrEIJteK6OBbLJ3ppwwM2OizWhNNhMkMdn4VJxNzSJsGmp0UWpXjXhG6J4Ov8RVWYVds/4WA9
 Nja7/lhh/kuf+v9bIt/DXPk+LvKWPjYY9Mr738IWMnn0XA7m++kOQUl9F36gZmDdeNTHKSAo3
 HVTGZdpoXgsBfwQRNOmXW/ijAtxaqfVdtL/93gptwiYPrU1JoN1EIy+NKMERrpBs0Fz8bnL+2
 C/rCiMgXC6zI9un5f2PY+ksZKFkeisqfWjDfrL8z7mKoOlQj4EwIhbmmCkqFg2G6xB5nU+pT4
 8pEclYBn37rQyarQHD7OMxgKxAWDarFzPH0LlJzQwFpuaB1rZeL8A1zhIUCfL4NNc/x5UPC9B
 /sz/mB52eFytYrp0oJe/3Yap2hzw5jKW8LhBqatZlM2noozK2DDnTZ/DQp1t6lTDtslTaNp1w
 rDmGG4u5jN14MJ9KIX/67gtBvHkzU89pr45//hX7al02P3UER4spcivXv3C7d9bsrJYibZakW
 Z/IknUG9qKHI5TWLq6P/MzVjNMlyfGxBcyIHaV9kpRU2uTlcfYSGl+/JSIqCu2VdAtGxrULuF
 TTx0fnshH91k3ZSc1wDHpn0hPl3bsos/agX/Qxhww1q8RfwpQPY0M0aejhnKFh8rXhoAqooaR
 60che63bUnYxJpQ0P4HnuaQekDSXquCy7Q0hWIMeMNKFguUmMwJcDiK3cdFNOBcTgav7WgwsL
 hLChDe9kAJUnM0=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 26.11.21 at 17:09, Russell King (Oracle) wrote:
> On Fri, Nov 26, 2021 at 03:39:25PM +0100, Lino Sanfilippo wrote:
>> The driver attempts to request and release the IO memory region for a u=
art
>> port twice:
>>
>> First during the probe() function devm_ioremap_resource() is used to
>> allocate and map the ports memory.
>> Then a combo of pl011_config_port() and pl011_release_port() is used to
>> request/release the same memory area. These functions are called by the
>> serial core as soon as the uart is registered/unregistered.
>>
>> However since the allocation request via devm_ioremap_resource() alread=
y
>> succeeds, the attempt to claim the memory again via pl011_config_port()
>> fails. This failure remains unnoticed, since the concerning return valu=
e is
>> not evaluated.
>> Later at module unload also the attempt to release the unclaimed memory
>> in pl011_release_port() fails. This time the failure results in a =E2=
=80=9CTrying
>> to free nonexistent resource" warning printed by the serial core.
>>
>> Fix these issues by removing the callbacks that implement the redundant
>> memory allocation/release.
>
> I think you will also need the verify_port method to also deny changing
> port->mapbase.
>


Right, I will add this, thanks for the hint!

Regards,
Lino

