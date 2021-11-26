Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA096C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbhKZQQf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 11:16:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:48219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378268AbhKZQOd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 11:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637943072;
        bh=b4YFw+0lviZ5gjiIocUIVpjVYRhRWpQwEvX2hIhIf7k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JRvrh9XAnD9jpITcRyzRr8++6PNAC0kYVstKmzJBrGHGWI/QJSFckPLPSEoWktDkK
         ubtI/Yw87PzIU+xYMHP56YpRqytQ5isfcLZZeA/zCkLHYAvhwfVJEaaZxP9lAEMTHQ
         o/+hzI/6WBOfd1sO2zSr+EUU4ieP7OctFzVjs+yA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.59] ([46.223.119.124]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1n2qdg081E-00TjdX; Fri, 26
 Nov 2021 17:11:12 +0100
Subject: Re: [PATCH] serial: amba-pl011: do not request memory region twice
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        p.rosenberger@kunbus.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211126143925.18758-1-LinoSanfilippo@gmx.de>
 <YaD9JW8i9vxmWWhk@kroah.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <8bad0596-c983-6915-67d0-0cda9ac70e5c@gmx.de>
Date:   Fri, 26 Nov 2021 17:11:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YaD9JW8i9vxmWWhk@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oM+crlb5dF2zfFGXu0GtJ3xrshNlL0SNK2p6Up4bDM9CRQovALK
 UF6I0hcHX1V73vymxHGsKMnHf75hxCfOHFZywwaZmDJ63I1t00Qq/YBWa7XKIO5Pme0LYsg
 PkjH3WLw00CqkRm4+4DUK6tWT+saxe0F2Gltyq4N/vBEH5NgHxokI/3VJG6UqUNvRgWmDHH
 Qb1nA4i2YOcchGU9NaVnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u2u7o5Q1nI4=:FmcdA61A25nRlPd3EznTFu
 XwSJiEhhcNuWegrmNiI+yb40O9nfNeKyrBtcHYsvgBoHhBxxhBYvfP+h3/CyhE4Aaxzy0cyf3
 wrJXc8UoOLpHze30hjiWxzFCfx36DvCOpQ+sV1SoVqs7irgdf04LnNV/TRr60J/NeZc66Cq60
 11U13/ysvgT11YNcSARrVRaBIUtDIuLoDUjAZqV9AZOFmhWzq/zSRQfKvDB+hrTXcJJScD2Ht
 vZWZsdvH218k0Wpc9Z816Wg5s3X0g7XcXLi6dgaTj+A6ATP9t/EL1rzropSeu1+Veu7e1xuMI
 IRw+JrGFsbkNdpR6+JwA7eFAUrNIFHQrdhQ/+udMb9BkSyzVAxvyCdUchUH++EVtchYniu3xI
 JmD9VZ7s7eE5/Al9Taep7wImJ5Z9zbm7l3YivsEtkAOu0H4x/CQU/YLroPyNYJwnrjUNMlIh+
 MguoTh5EEDcCnY/68YqjChDVm23YZ0NWxkT66oAWAXZKV2cvDYEtBHtBrvD4zqJ3nIi7hM7DA
 jI6f0nFU/WcPV13jQfDWu7O8c+HjBHwiHHi6gL6NbHJHc2/TWGt/SiFn/81KBgPQQux7Xyfeh
 iZLhHymgC2iMYsXNCm/31yk+ikkN4BJfiHJBfrGGcmcFPyLOpEe5iyeb0Aj1pQlek8/q4MLTd
 1DgsKPLmKIV0s/UHo2uK6EQrmNUjiQ/U/JsUjPGT3tD1T7pznuMKkV2bl0yVRXcWI1mKDIYzQ
 /EUbwoFQYyKbNfDNySNpldCNjwcKkSsqUTjy7dcMXr0f1X9HEjFHswsV+f8/tyVGN5mZ2QIfX
 z5CP0m1D8g0/ZOzrKx4RQh5J6TFQPfpPB3q6XmVpHiJu9ZP0c8SLkifnPRgYUihE1K7mf+DV4
 mbL7/uX+GiBLiqmnPfDIMPSONyFsWoUnbBsXdnp+8sNG2VT4al4k0v94qjif/1WrYeyR+5uK6
 hc5L8hVp9SYrE/EypMSOuspYxziVEZzWLNR0xNKtlQU4x8MC0GlHgaCMehf6+1kWIJsKkbEJ/
 CHAQwSA0ji66EAYgHso4BZkfNH+UPLiV6C5W5wfROaaH6cjZ5h/UzM0xoWcIk9ukbjmLtdqJ/
 wiWU5aurTlqj00=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi,

On 26.11.21 at 16:28, Greg KH wrote:
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
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>> ---
>>
>> This patch was tested on a 5.10 Raspberry Pi kernel with a CM3.
>
> What commit id does this change fix?
>
> thanks,
>
> greg k-h
>

AFAICS its commit 3873e2d7f63a ("drivers: PL011: refactor pl011_probe()") =
which
changed  devm_ioremap() in pl011_setup_port() to  devm_ioremap_resource().
Since the latter not only remaps but also requests the memory region it
collides with the memory request in pl011_config_port(). I will add an app=
ropriate
Fixes tag for this.

Regards,
Lino
