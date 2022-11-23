Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22635C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiKWPbj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiKWPbV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 10:31:21 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDE30F42
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 07:30:53 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id c26so6406740uak.5
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUoChsKBNuN03wcrTOc2UNOEbfXAl69AwMtwVs41RuY=;
        b=ZaE0WiDUcb45M/OW9G0pRdeWarrm4usTJd9OHJFG/VJmQoRKanZiP50SvmARkyXtAD
         cxvdznzDyyRYvYiYAdUHvYTE0/sHXROUILeQXt+lc4C7a4foAEUY2NGV9XPdmoRixymk
         lh7dc2tuaEoiSKZjmY6mqKTspZl+IJNFhNW1cZfalfP9smklKlktsG/kmcvL54SlyUtQ
         VlZWYyVvUVNCAR74PXRwxcx2AtfqiLC/2qy8iJV3seAuVU32Qht7KEXmL3bzI8tgBKZb
         Xgr5EGDsdfpURfXUPfsvapuHFDqt0+UANfAnYnCN+P/9yPso56hALMYTfSzwOdSwVivv
         6KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUoChsKBNuN03wcrTOc2UNOEbfXAl69AwMtwVs41RuY=;
        b=5FH7q5flTtkBDbgrnLT1B+4Kjs7s8G66DUQWPtWiOV1BWdaDanC2bvfjGx/zxbrAvh
         POW5IiTI4ekd6nXYRF4LC+cEAtKP1XqOm0z80HbwNBObCcrF8O2KuGwiLneuMtKdOP6T
         SaFJT7z7DU27XyKwSN+h8K+S6hmwJyqekytIIXONncQJjyZY9+hXK1QmNE31WfKy0c5f
         bKnxM/uyZkEXx+iED6ANQLjPyiPmiOW2g9xvUVQUjIPDZFetZpxMvDsRs8dSz7+UJmWw
         9gL63SSOED3emJXtkzgklvEunvuuG7psgCwxp7z/9CDPhTHaaiW8RxGJb7wFOTzC3ck8
         LF2w==
X-Gm-Message-State: ANoB5pkVYmHGVsOwBe55sd8dnRVGkRyyuZo+9ThCs4sxjWK9aLpMAjDW
        IaZLFP+/JfzViP4CizH7mt87imWCXinta8Ewv8ePaw==
X-Google-Smtp-Source: AA0mqf5DsMXES+K/CJiQVAcKNGFEyictIOB89in/o2CuupV7FzwhFkMHiT/XsitTAWFmDVvO/um9RMphviJgCYyT7EE=
X-Received: by 2002:ab0:6015:0:b0:418:c2fa:f8a6 with SMTP id
 j21-20020ab06015000000b00418c2faf8a6mr8323130ual.119.1669217452532; Wed, 23
 Nov 2022 07:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221122102125.142075-1-brgl@bgdev.pl> <20221122102125.142075-13-brgl@bgdev.pl>
 <Y3z/sqRZ3A/j8TIv@kroah.com>
In-Reply-To: <Y3z/sqRZ3A/j8TIv@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 23 Nov 2022 16:30:41 +0100
Message-ID: <CAMRc=MfEa_GwCGLS6c_wET_6BSPSh_rp_hhvCC6M7FFPwdMf5g@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] tty: serial: provide devm_uart_add_one_port()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 22, 2022 at 5:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 22, 2022 at 11:21:22AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Provide a devres variant of uart_add_one_port() that removes the managed
> > port at device detach.
>
> Ick, no, please let's keep devm away from the serial layer like this.
>
> I would need a LOT of justification for why this is needed, not just one
> driver that wants to use it, sorry.
>
> Please do not make this part of the series for this driver, but do it
> separately, later, if you still want it.
>

Hey Greg,

I sent out a v3 without devres changes.

It's not just one driver that would use it, rather: it would be the
first user and others could be converted later.

I was wondering if your reaction ("Ick, no") comes from the general
aversion to devres certain developers express? I'm asking because as a
matter of fact, I've been just recently going through the various
discussions about the supposed harm in using devres helpers and also
watched Laurent's presentation[1] from this year's Linux Plumbers.
While the issues described are real and easy to reproduce, I struggle
to understand how they're caused by devres and not by the driver model
in general. Specifically: the question that keeps popping up in my
head is: how are the use-after-free issues fixed by ditching devres in
favor of manually freeing resources in .remove()?

I'm not the only one to be asking that, for instance in this[2]
discussion Matti Vaittinen asked the same question and I can't find a
convincing answer in this thread. Instead there are some incorrect
statements, like claims that the order in which managed resources are
released is not guaranteed - it is: resources are released in reverse
(as they should).

It's true that devres_release_all() is called after the remove()
callback returns AND driver_sysfs_remove() is called so when replacing
kmalloc() with devm_kmalloc(), there is some functional change but
let's imagine the following patch:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3dda62503102..0046062828a3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -527,7 +527,6 @@ static DEVICE_ATTR_RO(state_synced);

 static void device_unbind_cleanup(struct device *dev)
 {
-    devres_release_all(dev);
     arch_teardown_dma_ops(dev);
     kfree(dev->dma_range_map);
     dev->dma_range_map = NULL;
@@ -548,6 +547,8 @@ static void device_remove(struct device *dev)
         dev->bus->remove(dev);
     else if (dev->driver->remove)
         dev->driver->remove(dev);
+
+    devres_release_all(dev);
 }

 static int call_driver_probe(struct device *dev, struct device_driver *drv)

This seems to work just fine when tested (and I would argue it would
be slightly more correct so I may send it as a separate patch). Now
the devres resources are freed in reverse order IMMEDIATELY after
.remove(). How would moving anything into .remove() fix the
use-after-free problem described?

We have the same use-after-free issue with the GPIO character device
and while we keep the struct device associated with it alive until the
last reference is dropped, the user-space can crash the kernel by
calling any of the GPIO ioctl()s once the device has been unbound. I'm
looking into subsystem-level solutions to that but devres has nothing
to do with that (I tested that with gpio-sim just to make sure).

Anyway, it's most likely a subject for a separate discussion. Just let
me know what kind of justification for devres other than "it lessens
the burden on developers to keep track of resources and simplifies
error paths" you'd like to see.

Best Regards,
Bartosz

[1] https://www.youtube.com/watch?v=kW8LHWlJPTU
[2] https://lore.kernel.org/lkml/cover.1660292316.git.mazziesaccount@gmail.com/T/
