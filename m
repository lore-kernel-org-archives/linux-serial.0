Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBFCDB47E
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 08:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjJTINs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjJTINr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 04:13:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC3119
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 01:13:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso82142266b.1
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697789623; x=1698394423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=it5LId2C4H1U91VsyvnGjoaX7yK9lqJY40QPQhvwsSU=;
        b=V30T3AAcxrUPpj0knMdw+mEtcvDrTimJm5CK4gEL7IJRloZ3CgZCX96bluFA1x72Ib
         FCp9/qNRngUPh1TAzJFRvWDtRxAn+xhf4IEBymXkLkNsyED5yLgTit+6yf+cbhZMAEwE
         lD8UL4CsH2zDla1jY9yNrkAQbLNjjt7Ybwh1DvLE1WOjnI5PC0NDVSIAcMyq+S7M9oEg
         tpHDda19N1zxX5XF6HAD68offFHlaOE9pnUScZg2t+TjNc1KYb3POuYEdHRTft6bqrxg
         kghfnLbhONGYPkgpjUL03ckOo6vrRhoRsJsk446TfSulCdXGiuzBN8BivDJerHCJkxp6
         rRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697789623; x=1698394423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it5LId2C4H1U91VsyvnGjoaX7yK9lqJY40QPQhvwsSU=;
        b=D5zFdc3+c2kN/MONHUk0FOKLh37wtjltUBARrEnCVwzIr+8KdePtKEqJJaIbTXdgIn
         beXpkrG5+t4TIFmBYqsS6Eb0NJkoVT6fizzIpq7FRj7AKdnPk28LLg3ULGqzsz/lXSDa
         MNRfJsRc0rG+1gBOnbecTy6jxpMJEiet2j1HN5hBuPBbPz+OawLyhtdQSJbo+TN1JfLN
         d9CwAwa4UJZxclnL92LGK92sguKe+UPPr0wrPs7Vxvvr4/jC6wqpL7gjnP321DXIQ1V7
         7pczLHkRO6fZ3mFyP2bUc60k7sV7Z0vV7+gYiETmu5txsA1ApC4lMoH4J6Gx4s9FNkND
         XcCw==
X-Gm-Message-State: AOJu0YwiJ3J5ff2Mg90cUGjwQ/58B9z2HDNv1ewhxwe51KszeMgbsKNk
        ZMVvR5RZtN/+tcUVQF9L2iV98g==
X-Google-Smtp-Source: AGHT+IEeFrCSkm3FbczMa45J0DrCEhJJ+FVSEOfJ8fULIE2AW4z8E/7QxxfmoXpEZ0bHuooCq861jg==
X-Received: by 2002:a17:906:ef03:b0:9bd:d961:ddea with SMTP id f3-20020a170906ef0300b009bdd961ddeamr818382ejs.45.1697789623226;
        Fri, 20 Oct 2023 01:13:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b00533dad8a9c5sm980417eds.38.2023.10.20.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:13:42 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:13:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] RISC-V: KVM: Allow some SBI extensions to be
 disabled by default
Message-ID: <20231020-622a7f510c98e8c82135e6fc@orel>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
 <20231020072140.900967-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020072140.900967-4-apatel@ventanamicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 20, 2023 at 12:51:34PM +0530, Anup Patel wrote:
> Currently, all SBI extensions are enabled by default which is
> problematic for SBI extensions (such as DBCN) which are forwarded
> to the KVM user-space because we might have an older KVM user-space
> which is not aware/ready to handle newer SBI extensions. Ideally,
> the SBI extensions forwarded to the KVM user-space must be
> disabled by default.
> 
> To address above, we allow certain SBI extensions to be disabled
> by default so that KVM user-space must explicitly enable such
> SBI extensions to receive forwarded calls from Guest VCPU.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
>  arch/riscv/kvm/vcpu.c                 |  6 +++
>  arch/riscv/kvm/vcpu_sbi.c             | 57 +++++++++++++--------------
>  3 files changed, 38 insertions(+), 29 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
