Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7F18C002;
	Tue, 10 Sep 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970914; cv=none; b=Fgiwmg1LpDq2www6NdOGDWsGFBhPrPAUPDXoqo9+RaBxy0KEVgaVgPgUbnKu5J3tmD3qEJNCuHowT5P70LHmcn3xCvKFSqXim4KzrKm3R3GTQ+QlJW0CWwy7HiUMLDyxUUOQ8lLItU1C1ES3UPl6um06T4nvIP6YfOTIfST4Vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970914; c=relaxed/simple;
	bh=aWfFAIjnFqxFCQIzG6XpLXOSvr2sHf9fixe7SOEw2m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6FoGkT/RSSU+uWAVzddQOsvfsvVuMo8GlYE5whGDS7nBs9XAo+Yyv8p6JGEs0los4VSa1cauAS2Lj1HN4hhB0TOXjo4N81tJ/7htsn4giqb4Bo5Jt7zbaxY2PBIfIIK0fgEOliMsj8n/4ujhp4e7stiDzjfHeF33sgjvCFaF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so9948864a12.1;
        Tue, 10 Sep 2024 05:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970910; x=1726575710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtL/PblOPvTiBziYi45g/5MNCyZDNQrsbh2MH421pI8=;
        b=mSev5XNOkZFtOE8PumjMyAvzFR2FGNN1pzYb7miQ/ORB+tHJBFAYfss3h2IFZUt3zl
         HXJiBVfdIhfR3RJr56S1ALiAYR7ms3EUOKYaOK7P2Tz0LQkWxrk2XdOFvjI6pXtbCWFX
         tlTDrQg3gpTYqu0mjC1cVEmPu3OWY5KBAAhTm1AmwvsKN0M9szlPkz+Zk+ZaFeRAHl2+
         VbqiUBXxKBSLw2GH2a4uChcxgit6VrPxr3dIGWsOPOVj2x+N7CMK9DBxWTfLJdg7Uo/O
         Lj/FHQ8BJqwIvKiBmSSdRO0bvDh8Sl/s9tqhaUERnnz7qrSN0awQiPlz9mjzwiOlPDF2
         4YUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY8gUMuznyUKWsbiU64PK+DUUQkCxqGefGuLNnza2P8iTfD8PFQRnLcqSwAuOZ7xXm6hf6i5dEBEbDOCPd/G4Y4t8=@vger.kernel.org, AJvYcCW3vaVcGP7PF9z+90poImNutcmWIM35mZZeQFDTeYQ6BpLGGdpmGq7xbVXzujTdj0Lbq2t83BamRfhg6lL5@vger.kernel.org, AJvYcCWkUO9pUtR4smvN8Fzye1l8xHwKXIi9oOLU7/1d1klim+p6Map/sQHMHmvx93XyLWx+HIAgbMXH9OaIaZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+0h9hM/lTMLV4HN0dIyxtN/9pZtoIPf4nerqLIHCUwW1eIQj
	5ASMlyv8P9QYret8SiXNdocYW1PJDNKEyWWVGJYHt7/VH72oLa96EfOHOor15DMYkg==
X-Google-Smtp-Source: AGHT+IG2KRchwIJb1k65PNrQ1fNQ1P6NkfMRQPHMulrwsY/a+R/7o2D/sfV0vVhVrSfdwU5foT8Zzw==
X-Received: by 2002:a17:907:72d1:b0:a8d:6372:2d38 with SMTP id a640c23a62f3a-a8ffabc1d72mr65833266b.18.1725970910095;
        Tue, 10 Sep 2024 05:21:50 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25950a7fsm478208566b.57.2024.09.10.05.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:21:49 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3d8d3ebbdso1524395a12.0;
        Tue, 10 Sep 2024 05:21:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMeESwmvwUBsMWSRREvwuZWBOsYN8FKW6DBXzmW9Ri1NW7E2+s3AfRMO5O8yASzMBKoBmPMYF9RhBusfg=@vger.kernel.org, AJvYcCX+e+vmcsQ5g2RqDyQjk6IdlCbeBoSqMci3Yq1JGnBwad+mRfl9rlwVo8oB5FczwueDHJX2YGdFbLoOwSBeljB+iVI=@vger.kernel.org, AJvYcCXze1M1aRNRLpqW3Ny2UlDmJ/1NI058taU25F+RghQGAH/lUMRubyByJDUBLsQKHp6EHZUJw/GCSL3/XMhU@vger.kernel.org
X-Received: by 2002:a05:6402:84b:b0:5c3:ce35:d165 with SMTP id
 4fb4d7f45d1cf-5c4015e753dmr3713449a12.12.1725970909356; Tue, 10 Sep 2024
 05:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909084222.3209-1-towinchenmi@gmail.com>
In-Reply-To: <20240909084222.3209-1-towinchenmi@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 10 Sep 2024 14:21:13 +0200
X-Gmail-Original-Message-ID: <CAEg-Je_f5aCyH4+ENb4Tn2XezkPu3YtYP4HRC0LXZHc1TMdhgA@mail.gmail.com>
Message-ID: <CAEg-Je_f5aCyH4+ENb4Tn2XezkPu3YtYP4HRC0LXZHc1TMdhgA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] tty: serial: samsung: Serial fixes for Apple
 A7-A11 SoCs
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:42=E2=80=AFAM Nick Chan <towinchenmi@gmail.com> w=
rote:
>
> Hi,
>
> This series fixes issues with serial on A7-A11 SoCs. The changes do not
> seem to affect existing M1 and up users so they can be applied
> unconditionally.
>
> Firstly, these SoCs require 32-bit writes on the serial port. This only
> manifested in earlycon as reg-io-width in device tree is consulted for
> normal serial writes.
>
> Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
> enable. Accessing these bits in addition to the original RXTO and RXTO
> enable bits will allow serial rx to work correctly on those SoCs.
>
> Changes in v4:
>   - Removed fake Reviewed-by tag added by accident... need to stop
>     making stupid mistakes that wastes everyone's time. The remaining
>     Reviewed-by is real as far as I am aware.
>
> Changes in v3:
>   - v2 did not declare itself as v2 in subject line... resend as v3.
>
> Changes in v2:
>   - Mention A7-A11 in the comment about changing register accesses to
>     MMIO32.
>
>   - Use BIT() macro for new entries, and change the existing APPLE_S5L_*
>     entries for consistency.
>
> v1: https://lore.kernel.org/linux-samsung-soc/20240907111431.2970-1-towin=
chenmi@gmail.com
> v2: https://lore.kernel.org/linux-samsung-soc/20240908075904.12133-1-towi=
nchenmi@gmail.com
> v3: https://lore.kernel.org/linux-samsung-soc/20240908090939.2745-1-towin=
chenmi@gmail.com
>
> Nick Chan
> ---
>
> Nick Chan (3):
>   tty: serial: samsung: Use BIT() macro for APPLE_S5L_*
>   tty: serial: samsung: Fix A7-A11 serial earlycon SError
>   tty: serial: samsung: Fix serial rx on Apple A7-A9
>
>  drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++------
>  include/linux/serial_s3c.h       | 24 ++++++++++++++----------
>  2 files changed, 30 insertions(+), 16 deletions(-)
>
>
> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
> --
> 2.46.0
>
>

Whole series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
