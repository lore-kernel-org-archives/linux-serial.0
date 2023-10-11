Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D81FCD98C7
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 06:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjJKGUp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjJKGUm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 02:20:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F21D7D
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 23:19:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so4238994a12.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697005164; x=1697609964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcqMB30naFRgYdHZVjh4rWtjXZPaceEDVeZe+D6ZGQM=;
        b=oYPInmB2+tfsY5VSLQcX+ksIVpEbszEojCThY8Thzo7e/kJT1tjvQmQuGKX6bkfQxc
         YzdllyGRSAA1pX5Xcw5qtIOC/UwlooyuihXTul6XnDIrJlT+HHeSHqyGP66XxK8OH0Ne
         6RKkpFZgnsTX5PVaOBIbEz2LY02fkDWv5omF3P5UUtacxgRAuev/+wb8lQXKA3I3riHz
         3E8wNsopkvnVyH6sxuDkrPbQlGgiJJM1qk2fpyLFWPohvYlFSknl55CJPEGaxWc7Gx2t
         ETUTh3zTDWvJA7ifiCpKdDBenNIMi2RH8cNtCmLn3biDF9xFyd22D3/AisXDNeMwxSj4
         OEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697005164; x=1697609964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcqMB30naFRgYdHZVjh4rWtjXZPaceEDVeZe+D6ZGQM=;
        b=TctiXF1aqg6/tBCAdkOqqXnsHceuPmj+yJUAlK+61lHcuAWItlv9CQdIerj0syMNgG
         cZoo1okMNtPrsRp2u1U0ff4rBEUouCebyN86RQ6waLOWtMgCqE1pwIXVSi1I+HHx+sF9
         GDW2k3o/iv8VlhgdNedFu7BV4n3WUMWmWYUFJZ+KU1VkK+7DJy0PkltUYBjcfGM+4Rmo
         f9IKw2lBEFxvNZ22JrvWt5bJZZG50FnMhCOpK9Q5ytL+c5zwCvY9gH3WjOf9Tvmk1368
         DO8p/HKpAvSAvg9fdZPXVJfw76Kw2l/0x9JKlrNZ+/7NkvwaG7zmiq7eq2aO1hp/gGcs
         U24g==
X-Gm-Message-State: AOJu0YzJsjN1ywDEltJVhphIeHoveKFbSX+S4vHAFz/he+2Ng6xbzAGM
        pl08O6TxOnMd3jKJ7irktdY6ryIbmVpDtqe5JZ8xlQ==
X-Google-Smtp-Source: AGHT+IH0dVQdsDAFTukx58Mm4npJdNbm0bLcgPLvVKj0AVOxI4yYVZT6FxUGUblbjBF7BjO/DvhKeANQ/axsKvXGtw8=
X-Received: by 2002:a05:6a20:4305:b0:15e:2d9f:cae0 with SMTP id
 h5-20020a056a20430500b0015e2d9fcae0mr20933619pzk.10.1697005164547; Tue, 10
 Oct 2023 23:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231010170503.657189-1-apatel@ventanamicro.com>
 <20231010170503.657189-3-apatel@ventanamicro.com> <2023101013-overfeed-online-7f69@gregkh>
In-Reply-To: <2023101013-overfeed-online-7f69@gregkh>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 11 Oct 2023 11:49:14 +0530
Message-ID: <CAK9=C2WbW_WvoU59Ba9VrKf5GbbXmMOhB2jsiAp0a=SJYh3d7w@mail.gmail.com>
Subject: Re: [PATCH 2/6] RISC-V: KVM: Change the SBI specification version to v2.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 10, 2023 at 10:43=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 10, 2023 at 10:34:59PM +0530, Anup Patel wrote:
> > We will be implementing SBI DBCN extension for KVM RISC-V so let
> > us change the KVM RISC-V SBI specification version to v2.0.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include=
/asm/kvm_vcpu_sbi.h
> > index cdcf0ff07be7..8d6d4dce8a5e 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > @@ -11,7 +11,7 @@
> >
> >  #define KVM_SBI_IMPID 3
> >
> > -#define KVM_SBI_VERSION_MAJOR 1
> > +#define KVM_SBI_VERSION_MAJOR 2
>
> What does this number mean?  Who checks it?  Why do you have to keep
> incrementing it?

This number is the SBI specification version implemented by KVM RISC-V
for the Guest kernel.

The original sbi_console_putchar() and sbi_console_getchar() are legacy
functions (aka SBI v0.1) which were introduced a few years back along
with the Linux RISC-V port.

The latest SBI v2.0 specification (which is now frozen) introduces a new
SBI debug console extension which replaces legacy sbi_console_putchar()
and sbi_console_getchar() functions with better alternatives.
(Refer, https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/co=
mmit-fe4562532a9cc57e5743b6466946c5e5c98c73ca/riscv-sbi.pdf)

This series adds SBI debug console implementation in KVM RISC-V
so the SBI specification version advertised by KVM RISC-V must also be
upgraded to v2.0.

Regarding who checks its, the SBI client drivers in the Linux kernel
will check SBI specification version implemented by higher privilege
mode (M-mode firmware or HS-mode hypervisor) before probing
the SBI extension. For example, the HVC SBI driver (PATCH5)
will ensure SBI spec version to be at least v2.0 before probing
SBI debug console extension.

>
> thanks,
>
> greg k-h

Regards,
Anup
