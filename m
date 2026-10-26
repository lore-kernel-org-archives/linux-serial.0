Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004634;
	b=nBGY9QPC0bu0ftAyiZPtNdqeo/111lZI9I+qZdQQhheeqb0apyap+gNszIryLmQu5T/o
	 pNJ2IpNPKLo2O7j3RfQiHDdh6v+/qj0/y3yy3kETHI7WNaw8YnTUW1t0r3IYVQJnwnPrJ
	 ys0HhCs3I1os5zA8d7B3fIwyt44EIs6TC/VE6vRyVkU5d9T5M39ccrjaM4jTjSHYvWrP4
	 FvKcQ5GBpXccP2TXfO96MjThhyZrX+VJWPqtmumG1IsXfYGlQ0J68WbV7murfMjRggSgt
	 c3MnOR0e9wNajYo0+yXL33CkmB1LBOEE2lLeNKfv9Qdv5Fh3O/JH6YgCNicVWa9grsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
	b=X5F9hpYOiJbl4iruiaAuNdnG9KYRiwoMxkBIIULfuOS5zVIAJYRt7PwvSbiPPALDlUV6
	 8G+W1M0yjH3lxOYeCfhuiSGmuczhci7BdxLjZECJxBnNATmz16hphZUkxSALZB0gFJWRx
	 XOJcctOg7DgGHrskW3QkjJp+YgpLEi+23nGm7xMRQVqLeVXeQAxcLgmSZsGVbI2wCqf1w
	 IYeqHBl4psN1VImykssQbGIQkft71dnYJ6f6wDJc32zTIeRnSfE3xJEW9icKKvsmw6JtG
	 OeF95OhO4ytPgulVVhCbAGg5wk3GhJGOpEXQ54Hpc1+RcO/60vISOcm1HJq9ACR4gSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nn0nVMTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D35606A32E
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 08:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D35606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nn0nVMTW
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso4458220eec.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 01:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004633; cv=none;
        d=google.com; s=arc-20260327;
        b=Fn1MW2NUZV8hOwltHQJ01Ld9DI6ytn3e0qeZ+ottjMsGUA9varxmu4V8EhoEvWuHVK
         V1oB++ECfwO6ccEeASSPRddtdVDMAf/BmRIEy50PAJbMVj7kvOqUhSyrS8sq5AB+NI9i
         UQzGJzq04NgX6n2idm+myNw6bsW8xDfkYfDXRQ2gWM1hfV4DgB4lDdjxKi/UGqJIP+wY
         gYiXQlsRLr0v4TeFHPUXVw5XEVCZEWCvVLi0BXfO7Z7/w9LNSG2C0ZWCmhv/O1tcRG+N
         J0YIEAWLOXc5YN4wSJtXEl4UXLBuI7Tov5JAqfcP2HjL1m92q//F7AmOEdQldfPm2kLI
         fQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        fh=9ROL8wAJ6zt1G/dwYV/crsuOujCDj2G0lkNItRHsKso=;
        b=DfwDRg14ntbjXet/1YDSbPqUX2fuDWjOB4Xk5qcXcybkHN5tebdQTG5o0ZXlTEUw0X
         I4GzWbPaYRsozyMlx55sW7SVeWcGQ1FKsUggClEOzZG5koTomJNFUCIdqKeE5ZMXwbSp
         10mPAV0uFJ899fD6PnwBpLUnXDFsPVn+UBK2QNIm8Nb86Lka5ZYStCzD90I/MCZKBT2l
         hL9/KlC0tPlTyfCirSDmUTNQGTaxjLnPOqFAWE0YdXG6o5uAvL+FK+jDK5BU6w6V0VM6
         4aNbv+LueLwFfPkBqVKR8B8AsKb7v0QUl5ABpsrj+0QiRv9Jq/NkXaocWekLp2jrc/EO
         SGTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004633; x=1793609433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        b=nn0nVMTWa/ugZXPz401T/3tm2krdJPTQqU9DomZfF4YDxk/9Q9Uh6xz5nhH6qQ8P1E
         AeYL5P0ze3rc/tKbby7ir9sx5t0zkHCxvV2s/Z1mk1NnH9mt47jESv9zkkwMSVZbO7kN
         a6q3ybnwzDOLcS5B4C0qvq41i/h1wkclm4EbNTzFxQY95U9tpUabB500RG/Nx53/SglF
         Yaj/7W8im9IIiHbhzpwoGIqJWCpWQ/mk3MJ0BJocjD1/BYp+QawbLJpfI0kBLJxo/Azx
         baDB3XQzzCf9lfyV+uio/X8ICKiL89jsF8lex617pD3TS3z6DwNwC6bvmQXehcSeWAo7
         3J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004633; x=1793609433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        b=dvR6kVTuG7HiKt2O1SdxarLs4m20ks3St7I5BPku+1pTugcwPW6Gl0wJejQxTYvh4Y
         UwIMxa5D9KE75Y0YWSkF2LlorcUD7KsO2cNjfiBPkZfp1y0PdkinSbReZule7gs48tjU
         k6A3byGR8e8df0JF0qn261/IobceACA7ZSGXpzs1aUU2WuCp0lxCG+dEYgIVz5v8CCQA
         COoirHbSO27vF/ihDhbIj643UxNtzPtLpBlKD/PnvIanaQqCvcCwNuY4XDg7hg6p629c
         uqm9Lp9/iX1C0nXhtHBBZDfRtCWO4k8vX9ns6WUcIAxFvHBLI5CiIVNggcsH6VdGYJie
         mtbw==
X-Forwarded-Encrypted: i=1; AKwUvBw4Yg8L1tDklQIJv3CHE3fVCm1X3pJQ1I9urX6KszTmDY4Cy40Q6Umo+e2zV0oqrfFLgxNrFv52aaEgMNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFDqCYwRyJnE1CAtpCH84u7RFKhzaEd9HS2ymNzg01vuk12CQl
	pRJTEf4fTAoSOMHaHUNvHdMjnoifaMVgZEB1PvPcd3JYz2hAzbdmJhLdvNjSwk2fu7WLPos/nOb
	NNjBNAF9fCzhMCu/q566v8X9voDSw13o=
X-Gm-Gg: AYBFou3gruQhZNWNI5xYfBq1gxZbXvt1HTBBXhf47PfpJcvrBOzXolGjHdx3V9mT1Eg
	nG4QQQPPzLiggyVQl9rGM/BfEpcyAAoA4ZPYASBCm5iEXuKhvYys/2UOjwrSdPRpwAl2YMU9fyL
	WHq2Y/QUHY6A2RXBlA+c7PsdKzMRRl1sbPoVirROn1ObRvw6C+14WzQYU7G0mzf5utuOz6DQ0RH
	qKLL4V9Rgki/qvUjdbch+8Ohd9htQnPyl8QNbTgNjtq0DbTqn362CHC94CJ2m/FigOVDcxg9yf5
	UMCNKMp0UNis5KiuLXOcrlfuDDfi2OJKM2MEOuon2LKtKxZvIwL55TZf+wR7jZFGOzVZDHiAutb
	3+SR2PfTVOlLK/FOpiyD6HRzfw3QBPURUHsNblH7AZTzijlAHoROjA9VJx5fKfhgOimPVFQ==
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-369e84bc5bemr9492113eec.17.1793004632970; Mon, 26 Oct 2026
 01:50:32 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Oct 2026 10:50:21 +0200
X-Gm-Features: AclHuK9eFB2IINUeequ9JiBD2-5Y_QxsonBBC6Q_QH-dQtxOvUA1C2K4ZB60Feg
Message-ID: <CAPVz0n1X3K_vtCNUg5k6oStVCfwZEpXJSSGJdk1OK24au1R-UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: tegra: Fix overflow in tegra_get_tolerance_rate()
To: admin@tsv-stahl-riesa.de
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Shardar Shariff Md <smohammed@nvidia.com>, 
	Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 26 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 00:5=
0 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> tegra_get_tolerance_rate() raises or lowers the UART clock rate by the
> tolerance from "nvidia,adjust-baud-rates", given in units of 0.01 %. It
> calculates rate * tolerance in a long, which is only 32 bits wide on
> 32-bit ARM. With a tolerance of 136 this overflows from a clock rate of
> about 15.8 MHz, i.e. from about 1 Mbaud, and the rate ends up adjusted
> in the wrong direction.
>
> The Tegra Note 7 (Tegra114) uses a tolerance of 136 for 1 to 4 Mbaud on
> its Bluetooth UART, as in the downstream device tree. For 3 Mbaud the
> driver asks for 47.79 MHz instead of 48.65 MHz, the clock rounds that
> down to 408 MHz / 9 =3D 45.33 MHz (-5.6 %), and the WL1801 controller
> stops answering after the switch to 3 Mbaud (HCI commands time out
> with -110). The same overflow gives 23.31 MHz instead of 24 MHz at
> 1.5 Mbaud; both rates were confirmed on the device.
>
> Do the multiplication in 64 bits. With that the driver asks for
> 48.65 MHz at 3 Mbaud and gets 48.00 MHz.
>
> Tested on the Tegra Note 7 with the tolerance of 136: Bluetooth comes
> up at 3 Mbaud, scans and connects to a paired device, and the HCI
> counters show no errors.
>
> 64-bit platforms are not affected.
>
> Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988) and LG =
P895
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
