Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84B9CD6E5A
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 10:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjJKKyo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjJKKyn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 06:54:43 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520798
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 03:54:40 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ae19da7b79so2655058241.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697021680; x=1697626480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4nF6PEutWJBQPD4LIT1skkD09xa4qGsBtRI6mZk9kM=;
        b=LO+VbWoGycURW0lZWdLoS/PCw4dvNGHkODJzJRAUvngwyubXTbZmkcxI1LxdnqXjQ0
         tzC3qwSQaqLZW1rIcbypgWPF43TKDA1x2hNTPaSmfshPGmGHGIfnUUu3Mh2xCeMC0x8Y
         gSlfAMdlmU81u4S4uWARRLJ+Hj/7G+XQkP+vak0jx2ATtR2AuxNGOufYOpgEyXnHcPOx
         DKFIJAgnbyG63kE2E1j5vdX7aYuwc/0e5+hbcU+4SvPbdzOVjnZmyNHcxgAgSWn5LSwU
         XPCNgora0K24vvGw5oZHx7cUs3moAhmK07q24JM6Bh8Y1ffUD/nlUQizpL1IxDytNttD
         GOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021680; x=1697626480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4nF6PEutWJBQPD4LIT1skkD09xa4qGsBtRI6mZk9kM=;
        b=UOjBxY58AKiZ/+8UkJ5ntbWpxOVBnrmhCd10rFx8Wnw5olDok9cAxWf69sjUIvICI6
         2TKOTgAL9vPdO6uq/tEoBETMDXMBfgj7QL6XVmk4zFRqrcDJTwWpFWehXQgUXaY44PQV
         D49Ozh+be2/MVp13X9/5t7+YhrQAU+e4cOkU8cZ7JJkPZUz2cdICSovwMQRwn1P4Rqc3
         gGj7y/rorGS8dDajurivCKX7kv64rfsoigxqZLvwKX4yQbmyUUBiO9LatqtqCqlPQ+pg
         JP2hAlUvoFk8+3P/iVcyGIDKIKD251c4a0J/JEfWbu9O9fo3i+KkqhVlvg4YVJATMfiC
         DC2w==
X-Gm-Message-State: AOJu0Yxd49GpXXFhJ2ABgBfdcZA3vvUyOgYAviUCF4+GPCu56epzqHGb
        0VMvs3msz+Fe/77mwsj3BJaTKjq8BOwXyTq2BeGR4w==
X-Google-Smtp-Source: AGHT+IFDs94V/aDo55pKyEF+KYMg17r2BTEWfhXQjYPz6s8btDK4mBkRCwVsJWRGGrp60X5u0qqqHYxCDBabIc6c5JU=
X-Received: by 2002:a67:cd11:0:b0:450:8e58:2de4 with SMTP id
 u17-20020a67cd11000000b004508e582de4mr18396034vsl.7.1697021679643; Wed, 11
 Oct 2023 03:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231010170503.657189-1-apatel@ventanamicro.com>
 <20231010170503.657189-4-apatel@ventanamicro.com> <2023101048-attach-drift-d77b@gregkh>
 <CAK9=C2UEcQpHg8WZM3XxLa5yCEZ6wtWJj=8g5_m_0_RkiNMkTA@mail.gmail.com> <2023101105-oink-aerospace-989e@gregkh>
In-Reply-To: <2023101105-oink-aerospace-989e@gregkh>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 11 Oct 2023 16:24:28 +0530
Message-ID: <CAK9=C2V3VzCgaJ_dWExvS3mf3QRgeV5tU9t3LsMaHv7xO3wwzA@mail.gmail.com>
Subject: Re: [PATCH 3/6] RISC-V: KVM: Forward SBI DBCN extension to user-space
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

On Wed, Oct 11, 2023 at 12:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 11, 2023 at 12:02:30PM +0530, Anup Patel wrote:
> > On Tue, Oct 10, 2023 at 10:45=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 10:35:00PM +0530, Anup Patel wrote:
> > > > The SBI DBCN extension needs to be emulated in user-space
> > >
> > > Why?
> >
> > The SBI debug console is similar to a console port available to
> > KVM Guest so the KVM user space tool (i.e. QEMU-KVM or
> > KVMTOOL) can redirect the input/output of SBI debug console
> > wherever it wants (e.g.  telnet, file, stdio, etc).
> >
> > We forward SBI DBCN calls to KVM user space so that the
> > in-kernel KVM does not need to be aware of the guest
> > console devices.
>
> Hint, my "Why" was attempting to get you to write a better changelog
> description, which would include the above information.  Please read the
> kernel documentation for hints on how to do this so that we know what
> why changes are being made.

Okay, I will improve the commit description and cover-letter.

>
> > > > so let
> > > > us forward console_puts() call to user-space.
> > >
> > > What could go wrong!
> > >
> > > Why does userspace have to get involved in a console message?  Why is
> > > this needed at all?  The kernel can not handle userspace consoles as
> > > obviously they have to be re-entrant and irq safe.
> >
> > As mentioned above, these are KVM guest console messages which
> > the VMM (i.e. KVM user-space) can choose to manage on its own.
>
> If it chooses not to, what happens?

If KVM user-space chooses not to handle SBI DBCN calls then it can
disable SBI DBCN extension for Guest VCPUs using the ONE_REG
ioctl() interface.

>
> > This is more about providing flexibility to KVM user-space which
> > allows it to manage guest console devices.
>
> Why not use the normal virtio console device interface instead of making
> a riscv-custom one?

The SBI DBCN (or debug console) is only an early console used for
early prints and bootloaders.

Once the proper console (like virtio console) is detected by the Guest
kernel, it will switch the debug console to proper console.

>
> Where is the userspace side of this interface at?  Where are the patches
> to handle this new api you added?

As mentioned in the cover letter, I have implemented it in KVMTOOL first.

The patches can be found in riscv_sbi_dbcn_v1 branch at:
https://github.com/avpatel/kvmtool.git

More precisely, this commit:
https://github.com/avpatel/kvmtool/commit/06a373ee8991f882ef79de3845a4c8d63=
cb189a6

>
> >
> > >
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/include/asm/kvm_vcpu_sbi.h |  1 +
> > > >  arch/riscv/include/uapi/asm/kvm.h     |  1 +
> > > >  arch/riscv/kvm/vcpu_sbi.c             |  4 ++++
> > > >  arch/riscv/kvm/vcpu_sbi_replace.c     | 31 +++++++++++++++++++++++=
++++
> > > >  4 files changed, 37 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/inc=
lude/asm/kvm_vcpu_sbi.h
> > > > index 8d6d4dce8a5e..a85f95eb6e85 100644
> > > > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > > > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > > > @@ -69,6 +69,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_s=
bi_ext_ipi;
> > > >  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
> > > >  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
> > > >  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
> > > > +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
> > > >  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experiment=
al;
> > > >  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
> > > >
> > > > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include=
/uapi/asm/kvm.h
> > > > index 917d8cc2489e..60d3b21dead7 100644
> > > > --- a/arch/riscv/include/uapi/asm/kvm.h
> > > > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > > > @@ -156,6 +156,7 @@ enum KVM_RISCV_SBI_EXT_ID {
> > > >       KVM_RISCV_SBI_EXT_PMU,
> > > >       KVM_RISCV_SBI_EXT_EXPERIMENTAL,
> > > >       KVM_RISCV_SBI_EXT_VENDOR,
> > > > +     KVM_RISCV_SBI_EXT_DBCN,
> > > >       KVM_RISCV_SBI_EXT_MAX,
> > >
> > > You just broke a user/kernel ABI here, why?
> >
> > The KVM_RISCV_SBI_EXT_MAX only represents the number
> > of entries in "enum KVM_RISCV_SBI_EXT_ID" so we are not
> > breaking "enum KVM_RISCV_SBI_EXT_ID" rather appending
> > new ID to existing enum.
>
> So you are sure that userspace never actually tests or sends that _MAX
> value anywhere?  If not, why is it even needed?
>
> thanks,
>
> greg k-h

Regards,
Anup
