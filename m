Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB3C004C0
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 08:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjJTIPN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjJTIPM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 04:15:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559318F
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 01:15:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so668925a12.3
        for <linux-serial@vger.kernel.org>; Fri, 20 Oct 2023 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697789708; x=1698394508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9mLk3QRlIYO5dYhhdXhtQWG8pCu0/EaP/qTEbU6WOs=;
        b=or4kQJYHBDCG6v6ilXxgAtz/QWahpgm8w3WD6dliDwJT6rl7XyPisP+SdbR6HOXOO6
         QCJ6OkaA/d4SvjkcBibK1R39AzHOVEL+gZMEvCZikXGVBnBBiPh8K+t7zju1UbwFgkA2
         W1Y/S4LiGQmtprW7ecf/LGKykJAUa9tJRLXLNBFxr2LYnJwbVcc6OMzReC0+oIaH/Zug
         UmnDjQyvdAHFU9QW2Dr2xiw4amF08b8S167KzAr0dgc7Yky8SwwMz6pWhV5UAXtHk87K
         m3Bk4DoZGbQZn9VMRt0vsF7INoLyIAJh9yrlBGsVP4RtwwrOah2qiUsamlIA2R6NkYEE
         DXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697789708; x=1698394508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9mLk3QRlIYO5dYhhdXhtQWG8pCu0/EaP/qTEbU6WOs=;
        b=ocy1T3a45m+Uod0XeMJq0ez/12U6WqcS0W8HIHZIBTA91oND3FeMpcmd4tTDJ4n6Wh
         jgOkiu7csSbVaRWu8ybwDjWg4JVhb2XtU9IOdPfBaPwAgGG6ONWju3ZxjbDH7du9+qZA
         OJM6JqSokcG7+WiqYOrhHzSsSsoUJYFUOmEY8QbXgKCm8HqN6G3dGq6J1+FsqVH75kGs
         9SPxvyaLYH3horHmtu+fjUasbvxGVgPPrsRIi0YQrciOeU+gFrbA832sAmG7TwPVe0K2
         MivU413mhB48ZEAqFoUTVfbVQJtnNrpgvNcGjFb3LjzFqyR7+AgMGKj26FJ5XHziOv/G
         hx5A==
X-Gm-Message-State: AOJu0YxfnzI9JhmvrPbjAH/dNQje67Wj8RkCCfeDpRVRosOIgEeQxG6u
        V6C56R0IIl6eoflPUAS7FmhaBg==
X-Google-Smtp-Source: AGHT+IFxDBdUK0jjgrdu/5lSvIddhM3Qd3L9VVDVSECPo1+jfo3eLrczA0b0wVyjpO8bPpxHApIM6Q==
X-Received: by 2002:a17:906:ef0e:b0:9b2:bb02:a543 with SMTP id f14-20020a170906ef0e00b009b2bb02a543mr922414ejs.74.1697789707967;
        Fri, 20 Oct 2023 01:15:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906261900b0099cc36c4681sm994192ejc.157.2023.10.20.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:15:07 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:15:06 +0200
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
Subject: Re: [PATCH v3 5/9] KVM: riscv: selftests: Add SBI DBCN extension to
 get-reg-list test
Message-ID: <20231020-825e5e2e7d355330a93f1194@orel>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
 <20231020072140.900967-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020072140.900967-6-apatel@ventanamicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 20, 2023 at 12:51:36PM +0530, Anup Patel wrote:
> We have a new SBI debug console (DBCN) extension supported by in-kernel
> KVM so let us add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 234006d035c9..6bedaea95395 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -394,6 +394,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_PMU),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
> +		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
>  	};
>  
>  	if (reg_off >= ARRAY_SIZE(kvm_sbi_ext_reg_name))
> @@ -567,6 +568,7 @@ static __u64 base_regs[] = {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_DBCN,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_MULTI_EN | 0,
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_MULTI_DIS | 0,
>  };
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
