Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC5C2D0F8
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 23:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56F320740
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 23:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="eqwTzxzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELXA1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgELXA0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 19:00:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3139C061A0E
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2020 16:00:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f23so6202967pgj.4
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2020 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ANYA6Uqt8JmQsCZkIHeMhChyGR2ABYbN7ab10n0Cyr8=;
        b=eqwTzxzfiHOX9idt3KO/0v/oXs46V6+ltH8+ODxDgE0xTtbWLhrQqjj/I4MLeTo7qx
         XH01gBCpb1wq6pkrBgTdUvNaHUet6KIGOrw+El7Q0VATiiu5Hm3ud0zB9mQ6vWmG+TXj
         lPrFz2yeuuqPPDExkB4Ui+7wK2wO1wcIk1DCnfKN+v7JH7HpAkPwVg2eg1udvimBywzs
         HMWSz5VlN5LaHs9s+FDqffjRlIrM1FDVkvPKUQxik3z9ZLS3LnM/OzYDTa+1rOwxB58H
         aJ7Nm9BiiVb+HxaLiOGxmNB5rkCNad2b2Bn7VaGNst1546ZG/wZIGmwNZ7PYKNZh5IhU
         pxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ANYA6Uqt8JmQsCZkIHeMhChyGR2ABYbN7ab10n0Cyr8=;
        b=EO5Y4aM9SqyFBSGumpgMpe04BzoaDkSh64tsXLlBLgdOu4Rvcq676nbkh8QhvmjdNT
         ZXQXJHq/faftQFIuzYYLIxy0Yr0J3tO+xfksQs4oYq93wr2X+yHELL/0QjMc+Ihz01mj
         iAHLBX0/PcEmF66sC7hbDSN6/+VCwHGUFRgrUfpzqWoxJ16Mdiz5DaW07uZEZ5sUU3QL
         hV0XA4sM3T5VrB8Y/D5ZFsjXv0WaDxwomGQLpY2GDWindYX0aVycMum1mqS4AyMi9Jn9
         h3G38sDK9JRD+xBv8zjniftOQt28ouuQJoRCf4pKaZdciw9LWc3TPcS+wioQRjo3M3WK
         4/FA==
X-Gm-Message-State: AGi0PubizTdGCEXW3pTfhJy6+n6USCtVXewr5Q1p0Kjh5Grsz+AfsBj8
        j8bUHWwVlLajdXXjL3huE9+bmoMADtQ=
X-Google-Smtp-Source: APiQypKpItiCTq+LL3cwMHlGAk6EceSJc41DnTPbVWgGyBzY+wmrmmIeI/2RQL5jF31HJQFyTVmDkA==
X-Received: by 2002:a63:d742:: with SMTP id w2mr21237526pgi.180.1589324425601;
        Tue, 12 May 2020 16:00:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b9sm12707480pfp.12.2020.05.12.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:00:23 -0700 (PDT)
Date:   Tue, 12 May 2020 16:00:23 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 14:10:27 PDT (-0700)
Subject:     Re: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for SiFive serial console
In-Reply-To: <1589019852-21505-2-git-send-email-sagar.kadam@sifive.com>
CC:     linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, sagar.kadam@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sagar.kadam@sifive.com, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-b2e9c16c-ee06-4c78-800d-a7725d6c74a3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 09 May 2020 03:24:12 PDT (-0700), sagar.kadam@sifive.com wrote:
> An uninitialised spin lock for sifive serial console raises a bad
> magic spin_lock error as reported and discussed here [1].
> Initialising the spin lock resolves the issue.
>
> The fix is tested on HiFive Unleashed A00 board with Linux 5.7-rc4
> and OpenSBI v0.7
>
> [1] https://lore.kernel.org/linux-riscv/b9fe49483a903f404e7acc15a6efbef756db28ae.camel@wdc.com
>
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Reported-by: Atish Patra <Atish.Patra@wdc.com>
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/tty/serial/sifive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 13eadcb..0b5110d 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -883,6 +883,7 @@ console_initcall(sifive_console_init);
>
>  static void __ssp_add_console_port(struct sifive_serial_port *ssp)
>  {
> +	spin_lock_init(&ssp->port.lock);
>  	sifive_serial_console_ports[ssp->port.line] = ssp;
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming it's going in through Greg's tree.

Thanks!
