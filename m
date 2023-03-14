Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525EC6FD1D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCNLNd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCNLNb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 07:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6FD9EF56
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678792295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkFOrLxvDsgE7J+80NELRMzqXPUi1ZsWUtFzSrHjiYE=;
        b=I11bQNmjkfSf8s4FbVB/wsmzHEa0jjCqudsaKo90QnT+zAyX6D6EVG9UIswlYTlv6Uz+9h
        L/0NqDePRVkhv8/GpG1Vjqogv8NHxH8xzzoIJd0A9LJn+bB4Eq85Y8BRtTz6zkOYWy7awX
        zVMhCh0E6Tkv7vi256F0WiZkzvQZm6Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-FOiki0GtM5iZHb0UHOhJ8w-1; Tue, 14 Mar 2023 07:11:34 -0400
X-MC-Unique: FOiki0GtM5iZHb0UHOhJ8w-1
Received: by mail-ed1-f72.google.com with SMTP id i42-20020a0564020f2a00b004fd23c238beso5456010eda.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 04:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792292;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9zMiJPhJ5GwK07ItmFmu2mkZYymSezTcZoCWgkwJ42Y=;
        b=jhuygYpaeoKORrJ62oakp5pzATrtfT33TBgXxw1VFyLuc6AICN72TyZImvJsXmv60w
         46uvd+UMhH4CDaIkd7P2fdsGS2la9RNSuq6b8LsmzOC6/mGdA0QufTtJkhMZH0okH/F+
         AMihMUvfPPTvU+znI3zZKA8EeLM88kOZWo5Pdp/Uj/6TjjGHo3gJRXJjDA4mH6blE559
         GayQnyTyVjvsF30WvAqswI8oD+6/YDf7d4o3xjlrMGYUwZVCZAlST/JRXZv4e/TjE8Cp
         lADUCOyKN6wxbD+s4uWTOHcjnHcWi9SCDudswUFZpoRE5cSl34SXzqe+mMDQcb5/EThM
         zp1A==
X-Gm-Message-State: AO0yUKUPSqT8S2tqBmTdgyRMum3XchtsYnwc6cYDQ+4ICniqg751Sjib
        lH3+kVZ1GelNa/8Mfm4iqbgDJcvg+A/jPV6WqMfYSKbzZcZHN1F3y7iwZQFDVuVbPSdwPb6IdNb
        Ao1qes/uizV7Wun64cenEF5q/ubp/Ts9v
X-Received: by 2002:a17:906:3394:b0:8b1:3f5b:af5f with SMTP id v20-20020a170906339400b008b13f5baf5fmr2042446eja.73.1678792292002;
        Tue, 14 Mar 2023 04:11:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set90NOl7oyklfjaGvIkcDBXXIXsqsgB7ouNRHq6EXWrhaINIvD56YLxzYbDH6sWYRNj9n+1QNw==
X-Received: by 2002:a17:906:3394:b0:8b1:3f5b:af5f with SMTP id v20-20020a170906339400b008b13f5baf5fmr2042430eja.73.1678792291719;
        Tue, 14 Mar 2023 04:11:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hb25-20020a170906b89900b009294524ac21sm1014650ejb.60.2023.03.14.04.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:11:31 -0700 (PDT)
Message-ID: <316ab583-d217-a332-d161-8225b0cee227@redhat.com>
Date:   Tue, 14 Mar 2023 12:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
 <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------xjyF2JNLJa1Gfxw1gxHHbyeU"
Content-Language: en-US, nl
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------xjyF2JNLJa1Gfxw1gxHHbyeU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/14/23 11:55, Ilpo Järvinen wrote:
> On Tue, 14 Mar 2023, Hans de Goede wrote:
> 
>> Hi Ilpo,
> 
> Hi,
> 
> Thanks for the report.
> 
>> I have spend the last couple of days debugging a problem with Bluetooth
>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
>> and Cherry Trail devices.
>>
>> After much debugging I found out that sometimes the first byte of
>> a received packet (data[0]) would be overwritten with a 0 byte.
>>
>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
>>
>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>
>> would sometimes turn into:
>>
>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>
>> Further investigation revealed that this goes away if I stop
>> the dw_dmac module from loading, leading to:
>> "dw-apb-uart 80860F0A:00: failed to request DMA"
>> and the UART working without DMA support.
>>
>> Testing various kernels showed that this problem was introduced
>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
>>
>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
>>
>> And reverting that on top of v6.3-rc2 indeed solves the problem.
> 
> You did something else too than just that because you cannot cleanly 
> revert just e8ffbb71f783. Please indicate what happened to:
>   f8d6e9d3ca5c ("serial: 8250: Fix __stop_tx() & DMA Tx restart races")
> 
> I guess you reverted that too and forgot to mention about it but I just 
> want to be sure we're on the same page?

I manually fixed up the revert, effectively
dropping the drivers/tty/serial/8250/8250_port.c part of f8d6e9d3ca5c
I did not revert f8d6e9d3ca5c in its entirety.

I've attached my manual fixed up revert as a patch here.

>> So it seems that that commit somehow interferes with DMA based
>> data receiving, causing the first byte of a received data transfer
>> to get replaced by 0.
> 
> Okay, and you're sure the problem/corruption occurs on the receiving side? 

What I am sure is that the first byte of a packet has been replaced by 0
by the time drivers/tty/tty_buffer.c: receive_buf() gets called.

I did not dive into the serial-port code side of this problem since
I'm unfamiliar with that.

> Maybe the the extra interrupt that the tx side change will trigger somehow 
> causes the confusion on the rx side. So that would be an extra call into 
> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
> would not occur w/o that tx side change.

That sounds like a likely candidate for causing this yes, as said
I'm unfamiliar with the serial-port code, but I did already suspect
that the change was causing some extra interrupt which somehow
interfered with the rx side.

>> The issue has been seen on and the revert has been tested on
>> the following HW:
>>
>> Asus T100TA
>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>
>> Lenovo Yoga Tablet 2 1051L
>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>
>> Lenovo Yoga Book X91F
>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
>>
>> I have more hw which I believe is affected but these are the models
>> where I have done detailed testing.
>>
>> I would be happy to test any patches, or run a kernel with some extra
>> debugging added, just let me know what you need to help fixing this.
> 
> How easy this is to trigger in general? (Mainly trying to gauge how 
> easy it will be to find the read and/or the irq that related to the 
> corrupted payload).

For the git bisect I did 10 consecutive "rmmod hci_uart; modprobe hci_uart"
calls, re-initializing and re-uploading the BT firmware 10 times and
then looked for "Frame reassembly failed" errors (+ more error caused
by this error) from the drivers/bluetooth/hci_bcm.c code.

This would usually trigger at least twice with the 10 rmmod + modprobe
calls and typically more often then twice.

With the revert (and with 5.18.y) I never see a single error even
with more rmmod + modprobe calls. Note it is not just the driver's
probe() which fails, sometimes there are also later errors, this
is just a somewhat convenient way to reproduce.

So this is somewhat easy to trigger, not trivial to trigger,
but it also does not take waiting many hours before hitting it
once.

Regards,

Hans


--------------xjyF2JNLJa1Gfxw1gxHHbyeU
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.patch"
Content-Disposition: attachment;
 filename*0="0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA1MzQzYmE0YTZmYWI4ZDkxMDIxNDAzMzE1ZDM2YTE3NWEwOTdjNWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgpE
YXRlOiBNb24sIDEzIE1hciAyMDIzIDIyOjMyOjE5ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gUmV2
ZXJ0ICJzZXJpYWw6IDgyNTA6IHVzZSBUSFJFICYgX19zdG9wX3R4IGFsc28gd2l0aCBETUEiCgpU
aGlzIHJldmVydHMgY29tbWl0IGU4ZmZiYjcxZjc4M2Y1NzdiMjRjMjViZDRkZDFjNzExOWQzNDQ5
MjQuCi0tLQogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kbWEuYyAgfCAzICsrLQogZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMgfCA5ICsrKy0tLS0tLQogMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9kbWEuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfZG1hLmMKaW5kZXggN2ZhNjY1MDE3OTJkLi44MGM3MGE1Y2ZhNGMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZG1hLmMKKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9kbWEuYwpAQCAtMzIsNyArMzIsNyBAQCBzdGF0aWMgdm9pZCBfX2RtYV90
eF9jb21wbGV0ZSh2b2lkICpwYXJhbSkKIAkJdWFydF93cml0ZV93YWtldXAoJnAtPnBvcnQpOwog
CiAJcmV0ID0gc2VyaWFsODI1MF90eF9kbWEocCk7Ci0JaWYgKHJldCB8fCAhZG1hLT50eF9ydW5u
aW5nKQorCWlmIChyZXQpCiAJCXNlcmlhbDgyNTBfc2V0X1RIUkkocCk7CiAKIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZwLT5wb3J0LmxvY2ssIGZsYWdzKTsKQEAgLTEwNCw2ICsxMDQsNyBAQCBp
bnQgc2VyaWFsODI1MF90eF9kbWEoc3RydWN0IHVhcnRfODI1MF9wb3J0ICpwKQogCiAJaWYgKHVh
cnRfdHhfc3RvcHBlZCgmcC0+cG9ydCkgfHwgdWFydF9jaXJjX2VtcHR5KHhtaXQpKSB7CiAJCS8q
IFdlIGhhdmUgYmVlbiBjYWxsZWQgZnJvbSBfX2RtYV90eF9jb21wbGV0ZSgpICovCisJCXNlcmlh
bDgyNTBfcnBtX3B1dF90eChwKTsKIAkJcmV0dXJuIDA7CiAJfQogCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUw
LzgyNTBfcG9ydC5jCmluZGV4IGZhNDNkZjA1MzQyYi4uNGUzNjA1YTQ5NGU4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYworKysgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX3BvcnQuYwpAQCAtMTk1MCwxMiArMTk1MCw5IEBAIGludCBzZXJpYWw4
MjUwX2hhbmRsZV9pcnEoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IGlpcikK
IAkJCXN0YXR1cyA9IHNlcmlhbDgyNTBfcnhfY2hhcnModXAsIHN0YXR1cyk7CiAJfQogCXNlcmlh
bDgyNTBfbW9kZW1fc3RhdHVzKHVwKTsKLQlpZiAoKHN0YXR1cyAmIFVBUlRfTFNSX1RIUkUpICYm
ICh1cC0+aWVyICYgVUFSVF9JRVJfVEhSSSkpIHsKLQkJaWYgKCF1cC0+ZG1hIHx8IHVwLT5kbWEt
PnR4X2VycikKLQkJCXNlcmlhbDgyNTBfdHhfY2hhcnModXApOwotCQllbHNlIGlmICghdXAtPmRt
YS0+dHhfcnVubmluZykKLQkJCV9fc3RvcF90eCh1cCk7Ci0JfQorCWlmICgoIXVwLT5kbWEgfHwg
dXAtPmRtYS0+dHhfZXJyKSAmJiAoc3RhdHVzICYgVUFSVF9MU1JfVEhSRSkgJiYKKwkJKHVwLT5p
ZXIgJiBVQVJUX0lFUl9USFJJKSkKKwkJc2VyaWFsODI1MF90eF9jaGFycyh1cCk7CiAKIAl1YXJ0
X3VubG9ja19hbmRfY2hlY2tfc3lzcnFfaXJxcmVzdG9yZShwb3J0LCBmbGFncyk7CiAKLS0gCjIu
MzkuMQoK
--------------xjyF2JNLJa1Gfxw1gxHHbyeU--

