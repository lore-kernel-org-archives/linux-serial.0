Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDA811FE
	for <linux-serial@vger.kernel.org>; Mon,  6 May 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006486; cv=none; b=TotC6LvMOUxKCWGqWWp1KfmXqpihpeMyR/ZwcEBtKczO9YH8cIoruix+ORnJDlGKjyDA9LnBp2IDny0w1fZiCPsbmcqdb2wOPfeCa2no7yIF652gofzjNCZkDVaQCnqwX+MgdwkXq/NnLoA+nLHDZ+fZYtX97f0YTn9UsO5zhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006486; c=relaxed/simple;
	bh=/gENOmxMwr2e/wEvRGvLvi8vJZcyz4hFz/OwxmPowBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0pCn3twzI0M3W/CcVhnxQgFcHoVS6qBnQDV0/LQxvjP/jGH+ItigGhoP1aY6Y36qZSpXA3rnpZ/h4Q3T1xPNexqpBd1GKK2rMlDkV6oMiNRI/zWMCGGAkrV7cmOEW+6e1UgcdogOL7qvoDrDuZtIoUF+nfrR+9TKuAI6JVkcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3rgUrl8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3rgUrl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715006484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LX9FQodMEotLA8ljm1FDQuXf3GR3oBpMHpgqWmTcx70=;
	b=X3rgUrl8KvhMBOGC3h+i0Isockk3sX0EbSFNDKqQ3H7MFxuj05OHTfTVv5srpf4XmZ0laj
	dVrL2UJN+wwHMSBCuiqNCTY/ygsFKIbj8BBlp0wZP1bb092dpGdA43Fjy05FCkI5o5HyTi
	Fyb6083rCHBeD8QtngOilHeTRfDJD2g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-D80m_vPrNtG964Y932j7uQ-1; Mon, 06 May 2024 10:41:22 -0400
X-MC-Unique: D80m_vPrNtG964Y932j7uQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a599dffe736so284044666b.1
        for <linux-serial@vger.kernel.org>; Mon, 06 May 2024 07:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006481; x=1715611281;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sn3AsUogQMn6CkvNqT/jPgA+Wq1wgG0ZJ/d0kXQVdZs=;
        b=rezZMQHYWUgWuph2cNlU6+i5ywzSlejCaHB8Qwx5OK2VC1nfsqbivLuSHtjdcmNJRn
         tlJY1QakESyLjaObPRf1tsqeYHh2YhxynYTAAHlfjbRUm3Na2aRGwFs5V0699vecnk1m
         EmBlH7pgNZ/D/T9a3Zv/wJ1sN8nyHTCD7PcLlUoyLYGda94xoCjvG/a4Dr1NzrOjjzbK
         uiqnD9RBtB7BVPKOITyjFDZLBDIeHacaGaEJOAcEHjMtlm5wHjztGKKuIn1XML/jFJwx
         0cx7y+u3EraAo7l7gi6uOfGxwQrP7AezibPs+XjfJJZg5PQy8fErtBCMYnln5UT+jfA+
         j+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPrthfJGoFE3DN5eTj/x7BpoIVC5YBKO+O9Vat07XnohaA2lSPMdgesD8TSuRuvYE0s/DEPTCya3B6eukoEgIB+65HkHoys8BoBfg
X-Gm-Message-State: AOJu0YyGhga0bQ+R4KGTHnVDoKxRmZIrcuEuw7V14AyjIltss0C6i7w3
	TT9rYHWxDFTqEcygdMxN19n7Q/rHeDd960GD1kRIv93W/Bd7YNYwCbpIJC8mj4YBTedEjDXvlJU
	Vy5+/oVcE86vRQe0WcraplfIlnvVR7bazeZf3zAZA1BJuzYuj3E3JzpNPmDewOw==
X-Received: by 2002:a17:906:af91:b0:a59:9eee:b1cb with SMTP id mj17-20020a170906af9100b00a599eeeb1cbmr5738377ejb.35.1715006481079;
        Mon, 06 May 2024 07:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIwgNqo+fQB5yv012L8nqRg3v13YGGbbufhalN/A671ZlBdrn+O8lkRqLdd+/AGoCyrYsmCQ==
X-Received: by 2002:a17:906:af91:b0:a59:9eee:b1cb with SMTP id mj17-20020a170906af9100b00a599eeeb1cbmr5738368ejb.35.1715006480685;
        Mon, 06 May 2024 07:41:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ww1-20020a170907084100b00a59cb8c93f3sm1588733ejb.58.2024.05.06.07.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 07:41:20 -0700 (PDT)
Message-ID: <85ac363b-d129-4525-89aa-d4528b8188a7@redhat.com>
Date: Mon, 6 May 2024 16:41:19 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Defer probing of SAM if serdev device is not ready
To: Weifeng Liu <weifeng.liu.z@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>
References: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------T5dSQ8KyP7OqQv6YtD0DonW6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------T5dSQ8KyP7OqQv6YtD0DonW6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/5/24 3:07 PM, Weifeng Liu wrote:
> v3 changes:
> * better formatting, nothing special
> 
> v2 changes:
> * resolves Andy's comments
> 
> Original letter:
> 
> Greetings,
> 
> This series is intended to remedy a race condition where surface
> aggregator module (SAM) which is a serdev driver could fail to probe if
> the underlying UART port is not ready to open.  In such circumstance,
> invoking serdev_device_open() gets errno -ENXIO, leading to failure in
> probing of SAM.  However, if the probe is retried in a short delay,
> serdev_device_open() would work as expected and everything just goes
> fine.  As a workaround, adding the serial driver (8250_dw) into
> initramfs or building it into the kernel image significantly mitigates
> the likelihood of encountering this race condition, as in this way the
> serial device would be initialized much earlier than probing of SAM.
> 
> However, IMO we should reliably avoid this sort of race condition.  A
> good way is returning -EPROBE_DEFER when serdev_device_open returns
> -ENXIO so that the kernel will be able to retry the probing later.  This
> is what the first patch tries to do.
> 
> Though this solution might be a good enough solution for this specific
> issue, I am wondering why this kind of race condition could ever happen,
> i.e., why a serdes device could be not ready yet at the moment the
> serdev driver gets called and tries to bind it.  And even if this is an
> expected behavior how serdev driver works, I do feel it a little bit
> weird that we need to identify serdev_device_open() returning -ENXIO as
> non-fatal error and thus return -EPROBE_DEFER manually in such case, as
> I don't see this sort of behavior in other serdev driver.  Maximilian
> and Hans suggested discussing the root cause of the race condition here.
> I will be grateful if you could provide some reasoning and insights on
> this.
> 
> Following is the code path when the issue occurs:
> 
> 	ssam_serial_hub_probe()
> 	serdev_device_open()
> 	ctrl->ops->open()	/* this callback being ttyport_open() */
> 	tty->ops->open()	/* this callback being uart_open() */
> 	tty_port_open()
> 	port->ops->activate()	/* this callback being uart_port_activate() */
> 	Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.
> 
> I notice that flag UPF_DEAD would be set in serial_core_register_port()
> during calling serial_core_add_one_port() but don't have much idea
> what's going on under the hood.

Thank you this explanation + Andy's questions about this were quite
useful. I think I have found the root cause of this problem and I have
attached a patch which should fix this.

After dropping your own fix from your local kernel you should be able
to reproduce this 100% of the time by making the surface_aggregator
module builtin (CONFIG_SURFACE_AGGREGATOR=y) while making 8250_dw
a module (CONFIG_SERIAL_8250_DW=m). Although I'm not sure if the uart
will then not simply be initialzed as something generic. You could also
try building both into the kernel and see if the issue reproduces then.

Once you can reproduce this reliably, give the attached patch a try
to fix this please.

Regards,

Hans



> 
> Additionally, add logs to the probe procedure of SAM in the second
> patch, hoping it could help provide context to user when something
> miserable happens.
> 
> Context of this series is available in [1].
> 
> Best regards,
> Weifeng
> 
> Weifeng Liu (2):
>   platform/surface: aggregator: Defer probing when serdev is not ready
>   platform/surface: aggregator: Log critical errors during SAM probing
> 
>  drivers/platform/surface/aggregator/core.c | 53 ++++++++++++++++------
>  1 file changed, 39 insertions(+), 14 deletions(-)
> 
--------------T5dSQ8KyP7OqQv6YtD0DonW6
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-serial-Clear-UPF_DEAD-before-calling-tty_port_regist.patch"
Content-Disposition: attachment;
 filename*0="0001-serial-Clear-UPF_DEAD-before-calling-tty_port_regist.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyNTZlMWI4M2Q0YTIwMTViMTZiMDM2ZjJhYWEwYzNjNmY2YzYzZTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgpE
YXRlOiBNb24sIDYgTWF5IDIwMjQgMTY6MjA6NDUgKzAyMDAKU3ViamVjdDogW1BBVENIXSBzZXJp
YWw6IENsZWFyIFVQRl9ERUFEIGJlZm9yZSBjYWxsaW5nCiB0dHlfcG9ydF9yZWdpc3Rlcl9kZXZp
Y2VfYXR0cl9zZXJkZXYoKQoKSWYgYSBzZXJkZXZfZGV2aWNlX2RyaXZlciBpcyBhbHJlYWR5IGxv
YWRlZCBmb3IgYSBzZXJkZXZfdHR5X3BvcnQgd2hlbiBpdApnZXRzIHJlZ2lzdGVyZWQgYnkgdHR5
X3BvcnRfcmVnaXN0ZXJfZGV2aWNlX2F0dHJfc2VyZGV2KCkgdGhlbiB0aGF0CmRyaXZlcidzIHBy
b2JlKCkgbWV0aG9kIHdpbGwgYmUgY2FsbGVkIGltbWVkaWF0ZWx5LgoKVGhlIHNlcmRldl9kZXZp
Y2VfZHJpdmVyJ3MgcHJvYmUoKSBtZXRob2Qgc2hvdWxkIHRoZW4gYmUgYWJsZSB0byBjYWxsCnNl
cmRldl9kZXZpY2Vfb3BlbigpIHN1Y2Nlc3NmdWxseSwgYnV0IGJlY2F1c2UgVVBGX0RFQUQgaXMg
c3RpbGwgZGVhZApzZXJkZXZfZGV2aWNlX29wZW4oKSB3aWxsIGZhaWwgd2l0aCAtRU5YSU8gaW4g
dGhpcyBzY2VuYXJpbzoKCiAgc2VyZGV2X2RldmljZV9vcGVuKCkKICBjdHJsLT5vcHMtPm9wZW4o
KQkvKiB0aGlzIGNhbGxiYWNrIGJlaW5nIHR0eXBvcnRfb3BlbigpICovCiAgdHR5LT5vcHMtPm9w
ZW4oKQkvKiB0aGlzIGNhbGxiYWNrIGJlaW5nIHVhcnRfb3BlbigpICovCiAgdHR5X3BvcnRfb3Bl
bigpCiAgcG9ydC0+b3BzLT5hY3RpdmF0ZSgpCS8qIHRoaXMgY2FsbGJhY2sgYmVpbmcgdWFydF9w
b3J0X2FjdGl2YXRlKCkgKi8KICBGaW5kIGJpdCBVUEZfREVBRCBpcyBzZXQgaW4gdXBvcnQtPmZs
YWdzIGFuZCBmYWlsIHdpdGggZXJybm8gLUVOWElPLgoKRml4IHRoaXMgYmUgY2xlYXJpbmcgVVBG
X0RFQUQgYmVmb3JlIHR0eV9wb3J0X3JlZ2lzdGVyX2RldmljZV9hdHRyX3NlcmRldigpCm5vdGUg
dGhpcyBvbmx5IG1vdmVzIHVwIHRoZSBVUERfREVBRCBjbGVhcmluZyBhIHNtYWxsIGJpdCwgYmVm
b3JlOgoKICB0dHlfcG9ydF9yZWdpc3Rlcl9kZXZpY2VfYXR0cl9zZXJkZXYoKTsKICBtdXRleF91
bmxvY2soJnR0eV9wb3J0Lm11dGV4KTsKICB1YXJ0X3BvcnQuZmxhZ3MgJj0gflVQRl9ERUFEOwog
IG11dGV4X3VubG9jaygmcG9ydF9tdXRleCk7CgphZnRlcjoKCiAgdWFydF9wb3J0LmZsYWdzICY9
IH5VUEZfREVBRDsKICB0dHlfcG9ydF9yZWdpc3Rlcl9kZXZpY2VfYXR0cl9zZXJkZXYoKTsKICBt
dXRleF91bmxvY2soJnR0eV9wb3J0Lm11dGV4KTsKICBtdXRleF91bmxvY2soJnBvcnRfbXV0ZXgp
OwoKUmVwb3J0ZWQtYnk6IFdlaWZlbmcgTGl1IDx3ZWlmZW5nLmxpdS56QGdtYWlsLmNvbT4KQ2xv
c2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wbGF0Zm9ybS1kcml2ZXIteDg2LzIwMjQwNTA1
MTMwODAwLjI1NDY2NDAtMS13ZWlmZW5nLmxpdS56QGdtYWlsLmNvbS8KQ2M6IE1heGltaWxpYW4g
THV6IDxsdXptYXhpbWlsaWFuQGdtYWlsLmNvbT4KQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRl
IDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29y
ZS5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBmZjg1ZWJkM2EwMDcuLmQ5NDI0
ZmU2NTEzYiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysr
IGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTMxOTYsNiArMzE5Niw5IEBA
IHN0YXRpYyBpbnQgc2VyaWFsX2NvcmVfYWRkX29uZV9wb3J0KHN0cnVjdCB1YXJ0X2RyaXZlciAq
ZHJ2LCBzdHJ1Y3QgdWFydF9wb3J0ICp1CiAJaWYgKHVwb3J0LT5hdHRyX2dyb3VwKQogCQl1cG9y
dC0+dHR5X2dyb3Vwc1sxXSA9IHVwb3J0LT5hdHRyX2dyb3VwOwogCisJLyogRW5zdXJlIHNlcmRl
diBkcml2ZXJzIGNhbiBjYWxsIHNlcmRldl9kZXZpY2Vfb3BlbigpIHJpZ2h0IGF3YXkgKi8KKwl1
cG9ydC0+ZmxhZ3MgJj0gflVQRl9ERUFEOworCiAJLyoKIAkgKiBSZWdpc3RlciB0aGUgcG9ydCB3
aGV0aGVyIGl0J3MgZGV0ZWN0ZWQgb3Igbm90LiAgVGhpcyBhbGxvd3MKIAkgKiBzZXRzZXJpYWwg
dG8gYmUgdXNlZCB0byBhbHRlciB0aGlzIHBvcnQncyBwYXJhbWV0ZXJzLgpAQCAtMzIwNiw2ICsz
MjA5LDcgQEAgc3RhdGljIGludCBzZXJpYWxfY29yZV9hZGRfb25lX3BvcnQoc3RydWN0IHVhcnRf
ZHJpdmVyICpkcnYsIHN0cnVjdCB1YXJ0X3BvcnQgKnUKIAlpZiAoIUlTX0VSUih0dHlfZGV2KSkg
ewogCQlkZXZpY2Vfc2V0X3dha2V1cF9jYXBhYmxlKHR0eV9kZXYsIDEpOwogCX0gZWxzZSB7CisJ
CXVwb3J0LT5mbGFncyB8PSBVUEZfREVBRDsKIAkJZGV2X2Vycih1cG9ydC0+ZGV2LCAiQ2Fubm90
IHJlZ2lzdGVyIHR0eSBkZXZpY2Ugb24gbGluZSAlZFxuIiwKIAkJICAgICAgIHVwb3J0LT5saW5l
KTsKIAl9CkBAIC0zNDExLDggKzM0MTUsNiBAQCBpbnQgc2VyaWFsX2NvcmVfcmVnaXN0ZXJfcG9y
dChzdHJ1Y3QgdWFydF9kcml2ZXIgKmRydiwgc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAlpZiAo
cmV0KQogCQlnb3RvIGVycl91bnJlZ2lzdGVyX3BvcnRfZGV2OwogCi0JcG9ydC0+ZmxhZ3MgJj0g
flVQRl9ERUFEOwotCiAJbXV0ZXhfdW5sb2NrKCZwb3J0X211dGV4KTsKIAogCXJldHVybiAwOwot
LSAKMi40NC4wCgo=
--------------T5dSQ8KyP7OqQv6YtD0DonW6--

