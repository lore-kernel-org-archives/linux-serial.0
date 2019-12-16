Return-Path: <SRS0=ZD/M=2G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F34BC2D0D0
	for <linux-serial@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EA220725
	for <linux-serial@archiver.kernel.org>; Mon, 16 Dec 2019 06:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJM0am0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLPG3z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:29:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbfLPG3y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Dec 2019 01:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576477793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ubOp4aTqnj6ZbGuFbvUqKZ36Xlj3G+DpTScuo3T0AU=;
        b=iJM0am0VqXAnZk4+ICT0bhtzF2/lvnm1H3SdUGNuQJiyKdxDLFxlYIoC4Higihj6xQ8ZzN
        nu5yi9t1tIWtkT23COTYtUJaY2kf2JzRrivFEEBxgF/jc0R8jvKCkGpytG8MJ/PQB0hd6g
        Lg0xZJewN/aChgRaD8ziF1G9M4HGN5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-gPYcP29eN_i_6B_YoxB-Ug-1; Mon, 16 Dec 2019 01:29:50 -0500
Received: by mail-wm1-f69.google.com with SMTP id z2so678343wmf.5
        for <linux-serial@vger.kernel.org>; Sun, 15 Dec 2019 22:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ubOp4aTqnj6ZbGuFbvUqKZ36Xlj3G+DpTScuo3T0AU=;
        b=KP4x0ugb1r2Op0KM9oTCPsdXYRGxiVf4y1HJcu4BNH/pBdVVCACmJ+0pOepNnF5uPx
         O/e85sfHZ4dlF8loKMa/1BnUATrj2cLrCQojizadJ1ydfwx2XrWYxcnaN/bluOhHtyN1
         jh48DINF+qf1GLBSKXixgzxlKn9L2/bXdMOwfQIjslplmnEkqHki63XW+Lh3IAvKAswT
         8P2WJo4oh6tJcMCxiwc0GdhkkWfA0kvgpoYM4Zho13x1Ri3uT7dozeM76cb7QVMDyfjN
         SFG6zKkG15Yvs4w7i9bdI9qeaoT2oNHm+QCXm4uuGtIcdrA/nEh7EDULdmyhR9qjUHOX
         rT0g==
X-Gm-Message-State: APjAAAUV9lgWVdSYCBwoOfEYLjf84d9sLPmz1y7xnNFNj8bKnlklP1Tw
        LSBdt6JVuTH/9AvbG3sCqVmctV9YzwPMp2Z7iHLeNFXjYrRiicIYoBXdqYRIib1oKYobOGbIsj/
        OHhILhiM83y7792aUosy1+PyK
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr28957264wrx.341.1576477789070;
        Sun, 15 Dec 2019 22:29:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5v7XSpxm+l0b1T0k9utZR94Uy7YosafjTNXNGPHxOytdatpSqvDrmEJH9IFcj7ox38kO7Ig==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr28957247wrx.341.1576477788836;
        Sun, 15 Dec 2019 22:29:48 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id a9sm10614812wmm.15.2019.12.15.22.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 22:29:48 -0800 (PST)
Subject: Re: [RFC 0/1] serdes: Add whitelist to bring back missing serial port
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-serial@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        robh@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org
References: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1ce4dff-7239-640a-fcc3-4ff935fdb3a7@redhat.com>
Date:   Mon, 16 Dec 2019 07:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
Content-Language: en-US
X-MC-Unique: gPYcP29eN_i_6B_YoxB-Ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

HI,

On 16-12-2019 05:08, Punit Agrawal wrote:
> 
> Hi,
> 
> While booting v5.5-rc1 on Apollo Lake based UP2[0], I ran into an
> issue with the primary serial port. The kernel is able to output to
> ttyS0 but systemd isn't able to raise a login prompt. On further
> investigation, it turns out that no serial device (/dev/ttyS0) is
> being created as the device is claimed by serdev sub-system.
> 
> The issue has been reported in a few different places[0][1]. A patch
> was proposed to solve the issue but there doesn't seem to be any
> further progress[2]. Feedback on the thread suggested implementing a
> whitelist based approach - which is what this RFC does.
> 
> With this patch, systemd is able to create a login prompt. The
> whitelist has intentionally been left blank as it's not clear which
> devices go in there.

As I already mentioned when discussing this upstream:

https://marc.info/?l=linux-serial&m=152460460418058&w=2

I am afraid that a whitelist is not going to fly, that means
duplicating all the device-ids in all the relevant drivers and that
everytime we add a device-id we need to do so in 2 places. Just take
a look at drivers/bluetooth/hci_bcm.c at the device-id list starting
at line 1187 and that is just 1 driver.

I also mention a hack for RTL8723BS devices there, but those have
gotten a proper in kernel driver in the mean time.

Looking at the ACPI device id list in the proposed upstream fix
with a "hsuart serdev driver":
https://www.spinics.net/lists/linux-serial/msg30035.html

+static const struct acpi_device_id hsuart_acpi_match[] = {
+	{"INT3511", 0},
+	{"INT3512", 0},
+	{ },
+};

Then blacklist with just these 2 ids would clearly be a much better
approach, as we are talking 2 ids vs 50+ ids here for whitelist vs
blacklist.

The whitepaper on this:
https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf
Also mentions these 2 as "the default Hardware IDs (INT3511 and INT3512) used here are Intel HS-UART COM
port peripheral device IDs." as the hardware ids to use if the port has no
specific function, in other words to use these 2 ids when under Linux the
serial-port should just show up as a /dev/ttyS* device.

So I believe that the fix here is using a blacklist with just these 2
ids in there.

Regards,

Hans

