Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F506CDB482
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 07:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjJSHpI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbjJSHpG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 03:45:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F451182
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 00:45:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40839652b97so15600025e9.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697701501; x=1698306301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pmXZfNDgHWU97eVG0ao9ZDPxa8/NusQS8x4RuYWhWk=;
        b=iZWOzNajhWf3yU3oCewYpD2OUdH0ARGWLZ4rj91MZvBr6MGURqHWgXt53Y/CbaD/H1
         3En+jtm90Q6JThv8z87H1h6VnnICzay2rrVWCIL+TfEKFMxDv0DR0XxxhZncnE66OEnJ
         oHxwLI5irsn44RwZjOXLsPVqkr9jNXYRpkCBvozGyI1+tCh2F6c2wOSxPRWr9NKiFRYV
         DAFBA89sVAtvQwvzsH+5pwhNJVDW8krDzFjc4vOI1ya+ylqt3ep04naCqDfirKBJqxka
         yW3bM2N+iG8EGM6zU6FL1K61xlHa1SXRQhBmhc64AV4sr0nFg6b+KuO8iCFqyodkdOtL
         5hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701501; x=1698306301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pmXZfNDgHWU97eVG0ao9ZDPxa8/NusQS8x4RuYWhWk=;
        b=U1I+/ycsEBy50HltL8l8eLXqakOI17Zzl619o7Afv/P1JWRBVH/24fCIAHwxpN0z7y
         NgkB8f6INYZUlpZTs5LfPrfuy+BAQx4X+MFDvE7uRaXRjnX+uFeS6B2NCMAqTrvGpEMX
         Y3ib0UaldgUSzW6Ask/stXrqNcjQh7vJ+fPedIffrCkCeEFxkjgSpDemTS7U0JHxlLQt
         3m3KMB3HZ0PpeZsB3Wq6xg9j1eGPsebkbjkLyNo3n9GCibZow3uGzDMK1cATrzaFvPFp
         5lIWESjiNcHmlMMOggks3sQuVL0v0ttpo9YMNF4faJ8fHVKHKe9sguED5GSzlnOY9LK+
         BrSA==
X-Gm-Message-State: AOJu0YxpExJ0evWIXTJ9oaohnTc9tKG5Zi2R/hGU1zlS0RHQIgTpCuxI
        4BKchfLm3up9kvDauKxS0w6vRQ==
X-Google-Smtp-Source: AGHT+IF7BQxJkgtIKhJz33b7TksgaeCJ/FKlTDLOVy2fY0p9glVw/wOjAaJE92kUJE4r9I59EYQnCA==
X-Received: by 2002:a05:600c:3b95:b0:408:37aa:4766 with SMTP id n21-20020a05600c3b9500b0040837aa4766mr1021340wms.5.1697701501064;
        Thu, 19 Oct 2023 00:45:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm3630164wmk.6.2023.10.19.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:45:00 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:44:59 +0200
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
Subject: Re: [PATCH v2 1/8] RISC-V: Add defines for SBI debug console
 extension
Message-ID: <20231019-5e24c756f19e98cd9d3f89bb@orel>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
 <20231012051509.738750-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012051509.738750-2-apatel@ventanamicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 12, 2023 at 10:45:02AM +0530, Anup Patel wrote:
> We add SBI debug console extension related defines/enum to the
> asm/sbi.h header.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..12dfda6bb924 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -30,6 +30,7 @@ enum sbi_ext_id {
>  	SBI_EXT_HSM = 0x48534D,
>  	SBI_EXT_SRST = 0x53525354,
>  	SBI_EXT_PMU = 0x504D55,
> +	SBI_EXT_DBCN = 0x4442434E,
>  
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -236,6 +237,12 @@ enum sbi_pmu_ctr_type {
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>  
> +enum sbi_ext_dbcn_fid {
> +	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> +	SBI_EXT_DBCN_CONSOLE_READ = 1,
> +	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
