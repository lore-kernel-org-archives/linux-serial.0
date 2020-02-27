Return-Path: <SRS0=sDBB=4P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E681EC3F2C6
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC3824650
	for <linux-serial@archiver.kernel.org>; Thu, 27 Feb 2020 22:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582842886;
	bh=YaGh6D1HzZ7fNKCmGcqwfIeREmWsHw1fRwfnKYtFmzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cI4O330jyVOA3JGjMhdaSN15twyjzXCfeoiRnnQpDyUlnwdcpwWEQkdk3NGp51wxV
	 hVhesNemT6yIEQVP/Zj6qZ8v8opobE34+b+fvyKyMqSO/ExGlDlMbI8ysTv4mSdQcd
	 50oNU6k8Cm+iQ4INjPheP4xfALKmlmL0m5gMJVWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgB0Weq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbgB0Weq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Feb 2020 17:34:46 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD4F246AC;
        Thu, 27 Feb 2020 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582842885;
        bh=YaGh6D1HzZ7fNKCmGcqwfIeREmWsHw1fRwfnKYtFmzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vtupj6DZECBmVkSIhKs//W0XwsQmOxTt4UepDYJwQEuOg4vEvKHMYW6U5MI3XG6rF
         ECX0OqVBvXgDCczjDg9okCAU/kyqNMdfNI7pwFpFCaT7/sxNNRbX5mhW9rSHId5kS8
         HrdfBSFLZoIotsMniP2g4di6KEv10U2Gl95hVKVo=
Received: by mail-qk1-f181.google.com with SMTP id 145so1189173qkl.2;
        Thu, 27 Feb 2020 14:34:45 -0800 (PST)
X-Gm-Message-State: APjAAAW3FMK72SVt5oKr0aY8cGkl1ZXbrDb70sFgWJT6Gk9kJCisMSi1
        ydGGePFVxtIy1LtKgcTlVo0K8NJkSLUFZZSfqA==
X-Google-Smtp-Source: APXvYqyeC5qhzNELpJaQTWJ0dR3EvH/Ikp7mcj1v76BER8UPpw9OHDgX/94cm+5BGXHVmQc+0agiMxuvdmrlGH8RZmI=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr1905154qkg.152.1582842884742;
 Thu, 27 Feb 2020 14:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221174754.5295-1-michael@walle.cc> <20200221174754.5295-4-michael@walle.cc>
In-Reply-To: <20200221174754.5295-4-michael@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Feb 2020 16:34:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
Message-ID: <CAL_JsqL8QGKARtRAfjCMyk4Pp7EWhFMV8JQpveHoJ2OyH5kBPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 21, 2020 at 11:48 AM Michael Walle <michael@walle.cc> wrote:
>
> The DMA channel might not be available at the first probe time. This is
> esp. the case if the DMA controller has an IOMMU mapping.
>
> Use the new dma_request_chan() API and handle EPROBE_DEFER errors. Also
> reorder the code a bit, so that we don't prepare the whole UART just to
> determine that the DMA channel is not ready yet and we have to undo all
> the stuff. Try to map the DMA channels earlier.

Changing this means you never probe successfully if you boot a kernel
with the DMA driver disabled (or it's IOMMU disabled). Some other
drivers request DMA in open() and can work either way.

Rob
