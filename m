Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA01C6FD1C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 10:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCNKVr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCNKVY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 06:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF514E8B
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678789215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5SIYAuIJ8eJfBqmvXOS8vA1Ut6e+nZSJEM2KQfNYfsc=;
        b=YaUwELWQr6QUov03EpymR7Nvs9fNhLOs+ISs+XWDxzZFewy+1osECfd3qfz75fEYaZN7xB
        bFEGlNhS2KJm42WibcNbo1ma3QOrssMo3sCtju0b1ruWo/pNOmWkkinIcdWY7HAxdc2glb
        wFcnx+1209DuvdWqdmEwlwAIN0cz3k4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-EwRVXIghO0uC6cT5wsQgnw-1; Tue, 14 Mar 2023 06:20:14 -0400
X-MC-Unique: EwRVXIghO0uC6cT5wsQgnw-1
Received: by mail-ed1-f72.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so12178924edb.10
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 03:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789213;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5SIYAuIJ8eJfBqmvXOS8vA1Ut6e+nZSJEM2KQfNYfsc=;
        b=HFOkGadc6B6ZWXxmxX9dwJisWdmZIkV97Q0nK2TgUyfPlAfCwRTKESQ60X6ZlBxtPN
         KD2Qx2RWrPfsgX3IpEkMWf8p1Q8jZnjI2rS1a632lwsUsk8gc0yzM+X7o+OiurF0yklR
         yzrUCwZTaag3ie9jw/t12rgeeL5aP+BA32lT19qD2F5ftMtZ7rxZ35RbZdTN7LEbDmCD
         mS2Bb5yMUMhBUke46H8inP0l/T7bCzPqOVpWG+2qxlkEmc9+J4SmTvq7CQ40jfJL3BFm
         vhcgjD5WNJVS+QGM3ortmCWXBW5sEy69lI0GmSmrw1Imnb3bV7fo2MH1t5Vim2iJ1inM
         6gnA==
X-Gm-Message-State: AO0yUKVeucdFatZ+tujgQAEdhpLyf+9+SvTZhQvdTHCe37ld3Xzqu4OU
        zOx111wtS40HK5urCV40k4JTnfekQWZaBVc9XTSQf/BskeTa8CTqlutpMLRAJDcs8I+4cxf9d+d
        I23ePWwVg3TYVd3ZvPO0955aY
X-Received: by 2002:a17:907:8c0f:b0:92d:3b95:4660 with SMTP id ta15-20020a1709078c0f00b0092d3b954660mr1018569ejc.21.1678789213603;
        Tue, 14 Mar 2023 03:20:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set84LejG6O8ADs8ya4z39SJuqI/FGuRMV8KIZXAahA844tpe7NFQMIkj3i9cqeY88kW45q2vIA==
X-Received: by 2002:a17:907:8c0f:b0:92d:3b95:4660 with SMTP id ta15-20020a1709078c0f00b0092d3b954660mr1018549ejc.21.1678789213307;
        Tue, 14 Mar 2023 03:20:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x62-20020a50bac4000000b004fbd365fb33sm794721ede.38.2023.03.14.03.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:20:12 -0700 (PDT)
Message-ID: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
Date:   Tue, 14 Mar 2023 11:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Ilpo,

I have spend the last couple of days debugging a problem with Bluetooth
adapters (HCIs) connected over an UART connection on Intel Bay Trail
and Cherry Trail devices.

After much debugging I found out that sometimes the first byte of
a received packet (data[0]) would be overwritten with a 0 byte.

E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:

04 0e 0a 01 79 fc 00 54 fe ff ff 00 00

would sometimes turn into:

00 0e 0a 01 79 fc 00 54 fe ff ff 00 00

Further investigation revealed that this goes away if I stop
the dw_dmac module from loading, leading to:
"dw-apb-uart 80860F0A:00: failed to request DMA"
and the UART working without DMA support.

Testing various kernels showed that this problem was introduced
in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:

e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")

And reverting that on top of v6.3-rc2 indeed solves the problem.

So it seems that that commit somehow interferes with DMA based
data receiving, causing the first byte of a received data transfer
to get replaced by 0.

The issue has been seen on and the revert has been tested on
the following HW:

Asus T100TA
SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3

Lenovo Yoga Tablet 2 1051L
SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3

Lenovo Yoga Book X91F
Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2

I have more hw which I believe is affected but these are the models
where I have done detailed testing.

I would be happy to test any patches, or run a kernel with some extra
debugging added, just let me know what you need to help fixing this.

Regards,

Hans


p.s.

I believe that these changes were made to improve the timing of
disabling the transmitter on tx completion when the UART is used
for a RS485 bus. So one option to workaround this might be to only
enable the new behavior when RS485 mode is used ?


