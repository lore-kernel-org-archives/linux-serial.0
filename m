Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A7C10F27
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193AC222C3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583777363;
	bh=q/wjPXk98Iav4DIzjZvnbTdu8x7vxATKPEjPDGTAstU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tNhOjGZnfflJCGyp8Mzh1Xi3+Am9dU+N92DaJEsYCekyuuZK8A3/lVzGIMrZ81n9D
	 V0/jNzRV5lkZlX1GkyW3Feosa1VTTzeGfrn4Eulm9LG4Jwk3WlBM2UlEcytuWxFj8T
	 KkrgQz9ZCNpFJEx5bIK3jAK8JQ1S1e84xLaCRJP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgCISJW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCISJW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 14:09:22 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E7221D56;
        Mon,  9 Mar 2020 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583777362;
        bh=q/wjPXk98Iav4DIzjZvnbTdu8x7vxATKPEjPDGTAstU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O0byU8BWB9cTxwxKIR/DT94PYb319NA2pgXCuq7JymyjeUEqpeHPxcZhvkFj03d0T
         AlYoQ2UZVYhSRJulzdi9jqLP1etTJ/Gc1UgjK5YNvGJpXW8Xnj8cL87r7jrIQFYQ7U
         19cissDSZ1NcIQqSLSi3q5IU6gchoZ3YEl6GKsfM=
Received: by mail-lj1-f171.google.com with SMTP id 19so8166256ljj.7;
        Mon, 09 Mar 2020 11:09:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3nPY0bgPBwhMoY2n3wr7G+hMLDaWNTWnKOjzF3XmQUPNL70RKd
        O8RuWbLAqGJJASJkgRBf+p/xgGsFJMzhTaWKaWI=
X-Google-Smtp-Source: ADFU+vvJrwQAU7B4C8WmaH5AG9yytmZyVjiXSOkfnxp+sxppR9FpJ79hvOp43uNlfDtqH3N8AKoOz0WSuAzAqXGka5Q=
X-Received: by 2002:a2e:9356:: with SMTP id m22mr9698465ljh.201.1583777359739;
 Mon, 09 Mar 2020 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200306102301.16870-1-geert+renesas@glider.be>
In-Reply-To: <20200306102301.16870-1-geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 9 Mar 2020 19:09:07 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeknZDrA7cXbznvrcCoV4hFfaUAtd6mzHO+dbepkzueQw@mail.gmail.com>
Message-ID: <CAJKOXPeknZDrA7cXbznvrcCoV4hFfaUAtd6mzHO+dbepkzueQw@mail.gmail.com>
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any platform"
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org, --cc@rox.of.borg,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

.On Fri, 6 Mar 2020 at 11:23, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
>
> When the user configures a kernel without support for Samsung SoCs, it
> makes no sense to ask the user about enabling "Samsung SoC serial
> support", as Samsung serial ports can only be found on Samsung SoCs.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Discussion about removal and then re-adding of PLAT_SAMSUNG and
ARCH_EXYNOS dependencies remind me [1]: "[RFC] Input: tm2-touchkey -
add hardware dependency".

In both cases the driver is clearly only for Samsung SoC or even for
particular device, although one could argue that touchscreen could be
reused while re-usage of serial IP of SoC is highly unlikely. My
understanding, maybe not correct, of "depends on" syntax is a kernel
source code, building or running dependency. I do not see it as a
hardware dependency. Although Samsung S3C/Exynos serial driver will
not exist outside of Samsung SoC, there is no kernel dependency.
Unless I missed something...

I understand and agree with concerns mentioned in [1] and in the
thread here, that removal of this "depends on" makes life of
distributions and generic users more difficult. To solve this problem
I was thinking about adding weaker type of dependency. A hint about
hardware dependency. Something like the "imply" is for "select". This
did not happen, therefore I still stand on my understanding of
"depends on" thus I gave positive feedback to Greg's patch.

It is a pity though that Greg's patch was applied so fast while
discussion was still on going...

[1] https://patchwork.kernel.org/patch/9695769/

Best regards,
Krzysztof
