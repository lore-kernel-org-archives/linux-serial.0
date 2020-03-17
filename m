Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9CFC10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 08:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED73206EC
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="k5Hee8so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgCQI0y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:26:54 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33928 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQI0x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 04:26:53 -0400
Received: by mail-il1-f194.google.com with SMTP id c8so19312047ilm.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aOuyJoCrMzyvXHSlDSwNMADBZRpY3b4ROkMfslZB48=;
        b=k5Hee8soUFcdVO+I6avboQHDvGJamIlUdtAa9jEGpo/uilBwzwba3lZorbRHrpeJs+
         mzKIQfYEFlUJV0c+PS9u9SAKiPnnQHcx/GKTSsS+/FvQ7KD99ukdr+RAXLPE10oyBPMR
         lKCeNAO5CTAV9TWFxlRb+ob9I6bGndxQbo7FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aOuyJoCrMzyvXHSlDSwNMADBZRpY3b4ROkMfslZB48=;
        b=i70UzlGNsDl/pn4K/UpOx0615U+XrUM9UFdouZMflEgFzVRC9QDZusgFDx39Rj3GwY
         vXwAfeTNruFI/ZXA4NZC8IyquMmvBNzUhTwOVUrC3i031HZ2tJ/g+ZVRJX27k0uh9zJt
         Zft8gPDDVS40fTy++CdkS/wRTI81e50t2HG82K18g75vY7CtZeIz1oyZQRFg+vrXhr/B
         K+YfB93OpxUK3z/B7SJWu07QTnIA2QvvxFPFkxc6vTipYC70JnBfvNNd9zauEa3LlWlw
         +HyBGh9JSp2yk70VLDdiLayGXW5wS8w4pvcaCSIyMBhA7JR5TEBmqhxbqYxHr42dbDsY
         ROvQ==
X-Gm-Message-State: ANhLgQ1qOgOAsrDOiWbNkmt10PYk5Q5oujV3j96dJp1NVZ5cS2uhc88p
        B+B1ps/mZ4xMz/3P1oR+Ii3+qBTRVbp7PO8mTBHM9Q==
X-Google-Smtp-Source: ADFU+vuurAtCAkyqCIHFcLdznh3heTGQ3XHwTYG5aY0816GZbUgWE2P5XFfJ3rW0Pu1UJql5n8z5r8atIwDae7WWeqs=
X-Received: by 2002:a92:778e:: with SMTP id s136mr4076428ilc.256.1584433612716;
 Tue, 17 Mar 2020 01:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-3-mholenko@antmicro.com> <291b0a18-2b50-515e-d6f8-31f766dbe567@infradead.org>
In-Reply-To: <291b0a18-2b50-515e-d6f8-31f766dbe567@infradead.org>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 17 Mar 2020 09:26:41 +0100
Message-ID: <CAPk366T03OT9TxsR27X4cPU5jew2TB32u3URnTy8b9r6MmpTeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 25, 2020 at 5:16 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/25/20 12:46 AM, Mateusz Holenko wrote:
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > new file mode 100644
> > index 000000000000..22c78cda0b83
> > --- /dev/null
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License_Identifier: GPL-2.0
> > +
> > +menu "Enable LiteX SoC Builder specific drivers"
> > +
> > +config LITEX_SOC_CONTROLLER
> > +     tristate "Enable LiteX SoC Controller driver"
> > +     help
> > +     This option enables the SoC Controller Driver which verifies
> > +     LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > +     accessors.
> > +     All drivers that use functions from litex.h must depend on
> > +     LITEX_SOC_CONTROLLER
>
> Hi,
> Please indent the help text with 2 additional spaces, as explained in the
> coding-style.rst file:
>
> 10) Kconfig configuration files
> -------------------------------
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.  Example::
>
>   config AUDIT
>         bool "Auditing support"
>         depends on NET
>         help
>           Enable auditing infrastructure that can be used with another
>           kernel subsystem, such as SELinux (which requires this for
>           logging of avc messages output).  Does not do system-call
>           auditing without CONFIG_AUDITSYSCALL.
>
> > +
> > +endmenu
>
> and then end the last line of the help text with a period ('.').
>
> thanks.
>
> --
> ~Randy
>

Thanks for the comments!

I'll fix the documentation and resubmit the patch after addressing all
other remarks.

-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
