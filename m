Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FB1C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BAD615A7
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbhI3Pd2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbhI3Pd2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 11:33:28 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E2C06176C
        for <linux-serial@vger.kernel.org>; Thu, 30 Sep 2021 08:31:45 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id f73so3050044vkf.6
        for <linux-serial@vger.kernel.org>; Thu, 30 Sep 2021 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMQZgqn6m+291rbD6FB65yGqtk2LWYklc58PG7BawH4=;
        b=WeP91qmSgIXo1a/NFgp0fBJwwk/RQsIG6P3TGJEJBiYShkWapc/jobvYucjLJrBsuA
         h2EV+zHcjy+Soh6Mfth9AW7mPPHQ+dx6X/FIFhiwhByHduZCcwZlwRyHztCr0gRmYYCR
         Jn6XleEH08+3mv3q5L/ISO8/LIcjqsd6NXmpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMQZgqn6m+291rbD6FB65yGqtk2LWYklc58PG7BawH4=;
        b=vmWEDD3pvysOY55dz+qic8RirRiYqSs/D5aZp1EsUGT/RwBSbnYO0BB6IxT4C3qSuT
         aQKYq4eTTzzw1NdJ1x0mrCVZ2yd4BJiXJlrP2Kde57873D73JFw5p2GHd4QU7Rueh3+m
         QdQp1EPtZVVUYx+igaaAM/Ts/bmpf5y4A9ZWqaKBKJd0dKwXo02968j87orRI7HetWvi
         rgaKhSNfdS6N/kxVFhhd6fkHJ3fdaQ/XVOyFVa5RoH0+aS+ia4leVQ2LjTbb9H33Qr9W
         6NqLOz3jzpQOAWU/x2dzrldBq9ToaigxyEOBpHGZvdPa59L8BpmlO4cNguvDgxKT/of+
         u2Kw==
X-Gm-Message-State: AOAM530Cvtv2dHC0KF26IK5g92gOn1nEgO0ED+bgiWkzt4xlc/pCP4Pq
        tm7pDCeYX2MZiz/UZIeRHYFJveZrPVjzpOTPNAis1w==
X-Google-Smtp-Source: ABdhPJz5wnisH1ZAkrMyUoL5nwJGU72PDXvYsb979G+ivugO/mU+8liTpY1eHMQRJC1nHk6kOkqZL8h0N58DRETHcBY=
X-Received: by 2002:a1f:f203:: with SMTP id q3mr3893652vkh.1.1633015904635;
 Thu, 30 Sep 2021 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930124950.3069638-1-daniel@0x0f.com> <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
In-Reply-To: <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 1 Oct 2021 00:31:34 +0900
Message-ID: <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

On Fri, 1 Oct 2021 at 00:24, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> And incorrect fix. See my patches regarding to the topic
> (`git log --grep ACPI_PTR`) and do accordingly, i.e. drop
> ACPI_PTR() for good.

Something like 349bff48ae0f5f8aa2075d0bdc2091a30bd634f6?

Doesn't this mean the ACPI table ends up in kernels that will never use ACPI?

Cheers,

Daniel
