Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2949C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB8561507
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhKPPic (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhKPPic (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 10:38:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32369C061570
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:35:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so89696619edv.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFJrT5zsmWLUN67uHoKU1n898NRoBPqcgc7DPTYa7FQ=;
        b=DAishHXRqIr3nF09KUTjaeVA/13nUyBgfb5sgoiVTUDebCuTboRYDUNaSLGwoNhdSF
         6grbbdwUYxjsxgJ/eTwqHnX+3SyQ9I6OkFJGdautJqm3NkxudNToouP4lupYrusVz8wf
         FdmoLp20MpuSkBnRsEI3MigyqixePZ1TiMC1GDNM7iQpzHMJlAHPdU4CrZ9X8DbyNUlm
         SnxHPHLUvwiWk0473SP51nVZaZRSYfwAf6wNKcnB4QEova6+VH8yTG618dXGrgG3iOV4
         b2FFfCrYvLa/JJjK5zw8UvUR3uUqN7OrEiy2e8cjbMJ7I5TC8IXejgqNtTL/wcQlZbLG
         H6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFJrT5zsmWLUN67uHoKU1n898NRoBPqcgc7DPTYa7FQ=;
        b=efw9A2Ke8UBDVXys2fkePdQiXcac0aV+u794ZAxW1bNDRMcPxrBKm4QuFszIiz2d0t
         2bDX2AvvaR6RmFwU9vDV1P4dWJnZAv1YvmrucG7BSXBLu7CsCRmI/OnqSkKwjQzfvtM/
         DPNbkXX9QpgEbQdfFh53GC3YrgQzYHveg11MrQfH+mtq+1t1xLuMRNLru1r48eGJQnrq
         VroHElv5QaJZICywPEa1GtMfVqFnmFUtsy2ZhapgCi3Cevlji6PfK3eCmu6F7/oktthi
         TRZ18sJu5unTf9vwUaHVTFNorouQLuaj4gMGP2bAMnmGJF1D+E14B8lb6iJqroICqYAu
         SUuQ==
X-Gm-Message-State: AOAM533Obf0uaExqm6uz1hJjB4r7rjOtWmPbO82KSaV9drVfOtSwB20C
        Gw/vOI897avuHAB4YdEx3AUQ4ZmFc1gj5ciCxv/U2q8tfdqhag==
X-Google-Smtp-Source: ABdhPJw+wgH4sMhjvp4D9DWP40Lu83zkyeF4awRez4UjQJUX73ChAVSAjOtrm0GOsvBqamADsRnhF/DMBKH4oy0ECcQ=
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr11334978edz.107.1637076933747;
 Tue, 16 Nov 2021 07:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20211114183908.444923-1-jay.dolan@accesio.com>
In-Reply-To: <20211114183908.444923-1-jay.dolan@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:34:52 +0200
Message-ID: <CAHp75VcLr8MDwQUMgeOWKLP5QwwxGzbso61xJOK7-S=UHfn11w@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 14, 2021 at 8:40 PM Jay Dolan <jay.dolan@accesio.com> wrote:
>
> A series patches to address three issues one customer managed to hit all at once.
>
> 1) Rewrite pericom_do_set_divisor() to always calc divisor and to use the
> uartclk instead of a hard coded value. Always calculate divisor without passing
> control to serial8250_do_set_divisor()
> Tested with 14.7456 and 24 MHz crystals
>
> 2) Re-enable higher baud rates on Pericom chips.
> serial8250_get_baud_rate() added range checking, but Pericom chips have a wider
> range than what is being enforced. Make use of UPF_MAGIC_MULTIPLIER.
> Tested with 14.7456 and 24 MHz crystals
>
> 3) Fourth port not being setup correctly on some Pericom chips.
> Fix entries in pci_serial_quirks array

Can we start from splitting Pericom to its own file, please?

See my initial work here [1]. And I believe you may do a better job
than me since you have access to many variants of the hardware.

[1]: https://gitlab.com/andy-shev/next/-/commit/71fdb8b5d857691031f566daebb1e850b106f46a

(As a side note:
https://gitlab.com/andy-shev/next/-/commit/ac0dc993fa35b5e2fe67e967b6a687b2e47d0edd)

-- 
With Best Regards,
Andy Shevchenko
