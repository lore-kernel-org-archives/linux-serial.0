Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7BC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Dec 2021 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhLUJgm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhLUJgm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Dec 2021 04:36:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853BC061574
        for <linux-serial@vger.kernel.org>; Tue, 21 Dec 2021 01:36:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so25565120wrg.11
        for <linux-serial@vger.kernel.org>; Tue, 21 Dec 2021 01:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=spNJUIR9YPNYKPYbPhK/paUxoC/pCowUYQ5J2t8AB/k=;
        b=bPa+E9HQzyTgq3K23IkhZvEIm9wF35yvLOiaXwXX7jliASNgJaeBLr8ew3MeK2J7aN
         r4EQplqYygw/5zS9l7MGYrkFI90xJflpumpes5OSypcfHwFXhaqwEpVdL3z2YeUx3Uvh
         oMTaz2+sPbqQU6WI8TnRE9Eik5/MiA5ftcr+2bv4AVbji/o2fZHv93QMKEOLLqGOz+QC
         91MeemCc28RaFdnHHfXCQin8I3vc7JOgIcEtSl3/meLX9yrO0cSBjGDUsqt7Afqb/XEz
         EkRcJVID0nRi0jmwtFiYOE7noBrJn4SPXVCzEDS+lOoEz0eI5qbV3n8Z+oAGjVgELntz
         2iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=spNJUIR9YPNYKPYbPhK/paUxoC/pCowUYQ5J2t8AB/k=;
        b=s2AJQc6PTgwvKXhtJI08D8Ed3fo4DppWz0MBKT0PG+Wbvkf9qNGpWvIAQOC6jTasB/
         ImB8gbOQBgU5FPO6OnIkIm/8Qx54e43lV7Ja35hdse8DbHZPZhHkg0f5iMErHEFWHudU
         IYi1UdBnhdB1JY9o2eoN2O/1/QywQTEpQwIOB3CWGM+Q57ioBQ/NETNtY8wdqglHJa94
         GQdslBm8jG3arXSrPcTECbgxIpeuBrInUpa/Lv16L38BTyVWbHNhW1F0Ende8Ey6X0zQ
         VA8bwGRZ4ZssfcAYsC8A7kDcjVCBUmt1aXc5e6YgIioVVTG1VLq4HGMowj1GZtEqt/Uw
         aS6A==
X-Gm-Message-State: AOAM532b6JcFoIKKfrQNSPAwCCOw+cn8rMUVEXVJpgkxGBe5wrOFTpmy
        0e97HZFO6c3uHdmCRPSnDgM=
X-Google-Smtp-Source: ABdhPJx+fdQjz9fCCbawVkfcWhnVCm0Ii4edQO/LUt4UiqqB1KRewln7dqlc5fL/QST5te9AQAT3Rg==
X-Received: by 2002:adf:d0c7:: with SMTP id z7mr1888207wrh.236.1640079400701;
        Tue, 21 Dec 2021 01:36:40 -0800 (PST)
Received: from UbuntuVM (arouen-652-1-413-72.w92-132.abo.wanadoo.fr. [92.132.102.72])
        by smtp.gmail.com with ESMTPSA id n3sm1856276wms.46.2021.12.21.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:36:40 -0800 (PST)
Message-ID: <9d5477e0046927fe95badb63e53af7251c5667a5.camel@gmail.com>
Subject: Re: [PATCH] Allow PPS on CTS pin and non-RS232 UARTs
From:   Mathieu Peyrega <mathieu.peyrega@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        giometti@linux.it
Date:   Tue, 21 Dec 2021 10:36:39 +0100
In-Reply-To: <YcCkk8ck91Nt4F0R@kroah.com>
References: <bc2d427e30e24978be5800c41f921b9d782570e7.camel@gmail.com>
         <YaoXfxwSeVVWUWUJ@kroah.com>
         <14a35918ecc95199066ea78c7814cf71bcd9e52e.camel@gmail.com>
         <YcCkk8ck91Nt4F0R@kroah.com>
Organization: mathieu.peyrega@gmail.com
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le lundi 20 décembre 2021 à 16:43 +0100, Greg KH a écrit :
> On Sat, Dec 04, 2021 at 04:57:56PM +0100, Mathieu Peyrega wrote:
> > Le vendredi 03 décembre 2021 à 14:11 +0100, Greg KH a écrit :
> > > On Thu, Dec 02, 2021 at 11:56:10AM +0100, Mathieu Peyrega wrote:
> > > > 
> I don't fully understand the point. Isn't the existing pps_ldisc
> > module
> > already affecting the whole system ? (with it's builtin fixed
> > "options"). How different tunable options such as the proposal make
> > things fundamentally different ? Still I agree that per device
> > settings
> > would be better.
> 
> Per device settings are required, this would prevent multiple devices
> working in the same system, one using the existing line discipline
> functionality, and one with your new changes.

Is this per device settings requierement valid also for a new line
discipline module or is it acceptable if a new "module level settable"
linee discipline module has also a global behaviour (as current one)
?If per tty device setting is requiered pointers/doc on possible
exemples/mecanismes to achieve this are welcome.

> > I can retry on this track. However I believe , it will also need
> > support from userland utility (especially ldattach). I don't know
> > if
> > this kind of consequences is in the scope of the discussion here.
> 
> Why would userspace need to be modified?

You're right, I initialy thought that ldattach support would be
requiered
(
https://github.com/util-linux/util-linux/blob/master/sys-utils/ldattach.c
as for the drivers list) but after first tests on a separate module,
it's still possible to use ldattach as is with the new line discipine
index. Only support for using the module name as argument is
requierement which is not blocking.


> 
> Try this as a new line discipline, should be much easier and simpler
> overall for everyone.

I have been working a little on this already, was waiting for list
comments/answers to proceed further.
Is there a prefered name as the module is mostly a clone of the pps-
ldisc current one one with first patch changes ? I went for ppsex-ldisc 
for now.
Is it Ok to share & modify the C structures of pps-ldisc (especially
tty_ldisc_ops as per initially proposed patch) or should a full new set
also be added ?

Regards,
Mathieu Peyrega

