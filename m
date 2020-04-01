Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD9C43331
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4CB20714
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 12:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LwmS95WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgDAMWn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:22:43 -0400
Received: from ozlabs.org ([203.11.71.1]:50333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgDAMWn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 08:22:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48slhJ058Dz9sSM;
        Wed,  1 Apr 2020 23:22:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585743760;
        bh=C2bThPqw3VWzR5WgmrlUX730CfrtDYdrXujURU2m0n4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LwmS95WSCrsWDudiX7CVG/u/OJu8Q1uGGKglglo0+ApYIqMrsYVdDQWwNE71xe4rf
         vEKAISM6Mhlcms+SUBjjFrCHgToh1ua3ambtH9VzL41fRZCu/CTWQxJKsCNr2cHc6M
         CKsQcfV7HTwfIMHZoABfvk6wSXpFWFpZRbL7/VcfdgmBtK21kP+F46t5zsNa68HDhr
         sp7mcIsZhCOfKnvZAAIzPc/Modb516+EgNLGm7uriuLKeYNJyttYhv8LmsLgQlTUWo
         nBZbbaGA8XtTxJKVczUiy/koKXLWwqSfu/vQvdjihP93AddKXzSqoTNSGY5n9lSCrD
         BKdLODrxVoAPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] sysctl/sysrq: Remove __sysrq_enabled copy
In-Reply-To: <20200302175135.269397-2-dima@arista.com>
References: <20200302175135.269397-1-dima@arista.com> <20200302175135.269397-2-dima@arista.com>
Date:   Wed, 01 Apr 2020 23:22:46 +1100
Message-ID: <87tv23tmy1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.
>
> Currently, sysrq can be either completely disabled for serial console
> or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
> commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")
>
> At Arista, we have such boards that can generate BREAK and random
> garbage. While disabling sysrq for serial console would solve
> the problem with spurious false sysrq triggers, it's also desirable
> to have a way to enable sysrq back.
>
> Having the way to enable sysrq was beneficial to debug lockups with
> a manual investigation in field and on the other side preventing false
> sysrq detections.
>
> As a preparation to add sysrq_toggle_support() call into uart,
> remove a private copy of sysrq_enabled from sysctl - it should reflect
> the actual status of sysrq.
>
> Furthermore, the private copy isn't correct already in case
> sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
> getter-helper sysrq_mask() to check sysrq_key_op enabled status.
>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/sysrq.c   | 12 ++++++++++++
>  include/linux/sysrq.h |  7 +++++++
>  kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
>  3 files changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f724962a5906..5e0d0813da55 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -63,6 +63,18 @@ static bool sysrq_on(void)
>  	return sysrq_enabled || sysrq_always_enabled;
>  }
>  
> +/**
> + * sysrq_mask - Getter for sysrq_enabled mask.
> + *
> + * Return: 1 if sysrq is always enabled, enabled sysrq_key_op mask otherwise.
> + */
> +int sysrq_mask(void)
> +{
> +	if (sysrq_always_enabled)
> +		return 1;
> +	return sysrq_enabled;
> +}

This seems to have broken several configs, when serial_core is modular, with:

  ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!

See:

  http://kisskb.ellerman.id.au/kisskb/buildresult/14169386/

It's also being reported by the kernelci bot:

  https://lore.kernel.org/linux-next/5e677bd0.1c69fb81.c43fe.7f7d@mx.google.com/


cheers
