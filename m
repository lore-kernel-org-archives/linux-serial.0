Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793004664;
	b=yc1nGmQ5uc0LELrykgGJeXXjd+TOoQjsWCB28tIcMzlCi1Qq2/yVO4OYwmWbaXKrTHvy
	 79Cqcpg+yqI5NJuKfnIuBS+1JzwBK9SGXv6UAPbZKZSC0W1O/VM2kbANwfaoeXgNbZSLC
	 IfygEXBsejSTc1UUjJLtPhMNd0uoRVAoa5Gg3sgZ9g+ZTx+IqC+vb5Bznjgo3KuQw6WB/
	 UAjnjr/uJe+/UrlE2cKtFbST7gCRnAIIA5XN/a/ytj9YRY+yeS61FpWZFsYO3dPlb6iPT
	 2bp0HTrgVn4ALY8wV1X5tgHaPFQEvAFsQkbznNjdnWpVROT21izAyv4C72/zRP+zXzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
	b=2nJ6vhNXMYY3tCXD3tPDRiKbHkYIdtHG18voGd5iX7jNvPHyaq+H/HWTOEvHDjBQwbht
	 k196ncHXImpBAe6BSSyYSYKJL3zoB3Idlkh0Kb6Hut8T46Q8yxf+ShU3zU6oA299DCKjb
	 ICH78iqEyt71LrH7GfcJaEuNlE4kDBLnNGwFVSUPpY4bzVOHZAywB41Cvqm4+2LKNziON
	 bzHJp1sgImbqum0q6LT2QEChvS8VnMmMLLAq5FZJWv8HzV0wg8Y30X/mFaSXY/AHwGvA4
	 v/FD5YjFnLFH5Da2LmPpxXLcaNz9e+tziatFLjLrrunr52IMm/iZIuzY6akTapEgRQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oh2lU9lh;
	arc=fail smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEE606A31E
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 08:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FEE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oh2lU9lh
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4589380eec.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 01:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004663; cv=none;
        d=google.com; s=arc-20260327;
        b=fDKCI03KZ8jhUQIzsKu+Ba1unUKtbp2ded5cYpU996Yb6PdeFzXMFT348+gqHb5yyU
         uhRA4VAjjrHFaQYcDhqI+/ZpeUc9ltEC5dkAXiqA5qtSQsgEnRBn7AuZLs5gloF407RS
         KSjoekfrYXAQbO6jRXgdoSj5diRDEp0byk2GwqqK1yc1NusEawu5/rx5Tb+HHtW2McNf
         WX8AUvH0KLdOUeUMbgiyEWVpUShv4o6mLKQw+RCe815lu+SwPeJzC4VFgQljc4cp8dhP
         ZGljuHEzGulskPus9PosMwVsjiu4Hl8vleY+xk+g8HU9fciAQvCvlIwkzkZWBUWlsYVb
         yYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        fh=hDZMLYzWDdMLJVBeMbbckb5x3gguB9myeLat5AGKdO0=;
        b=QBXvexAzMb1o7jJ6WKuGXwcEXFKFm72lJdke3bhkW6GKwySdOcK97Gb9wf4K9Yn9cV
         ER+Em8zoJCT/Uab/cFEBPGWf1UwT0ugdREv06nAnIytm94qKi8MaBl4seQ1ILGTvpfFk
         cTxJ37KjinYAyrFEoUp3yqGXFsRcIt8tE7bsJOwLdhrpvuDzXAUfbG4CGROwew9pi2y4
         Ulo4RoWG5ZLZrztHnlYWi2fZt9xlseLxXz0Bp4HB08oVHWs3io0QSa43vZgbQ33vNq3C
         9pBDUz9+sIRbwY4O9FoVhV3zL8PAfHg2gp8Fhg8hqJFD83rOOcHs/JgGSj5JrY+J4W1R
         j7Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004663; x=1793609463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        b=oh2lU9lh2XW5bOMIoZggPWD/M/w208pLutnXYKtqzP4b2JJ18pW6eKn/KP+fPwj4R3
         mJpwRBZtjw5JnMaXltAZ3+pKOxs/hLeOtkp5pZfFcWLpzypC6IJXH421xJ2LMwnfRlKp
         iU4DLNYUBFycQEAnXJlnNPoJS/84qHhQ0TZfCFg9RlzuSsaiCGLhH94a7bdHammdeDc6
         w0HeWoPpOek8aeQyfPlzrX/2hl8c9V8en0t0VIeqVCoRISPKKz5KQLH55rtOfwuA6nfy
         GVVqgUyBUKDqBbhrnLFbZMZ8sE0jKUvp9DqEXfi/mqUnrtrB2jK4BD/iWysVxfpDWVfD
         1P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004663; x=1793609463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        b=JW4hpj5/KJUk6RfKtB5wzun6Ape0q4AdvGk5FQcj3ScWgiPsFc02nWIOfzOTQzSnG5
         p6grBWxWw5bSdkVwUJ3tVI++HhP6qTr0VlJppWH1Jw9da1itM3M29ALFYikKyKzlm7it
         F/1HoH/wiszyR1ZPQe10QSSZi08Oj1aY7K/33hgsMbhZkqkCCQNLqevyRQv/a0MruOAD
         wgY7qFLD5YHGVEpdyAy/duwtMvnX4vLKEhaQKFrD/C8TlVu7V3lQW/ndZuyqilweqW9p
         GrnzJ8ofEV2ntChSMQOknIldG9jlo0JLwNUObKvADYqUxWfUQHd/QBveO9+76sWAWdsP
         6EOA==
X-Forwarded-Encrypted: i=1; AKwUvBybsjHowayi54MP11HuLpDlKF3+B5sEzbv9xzvhTtAmuXzi5/KvmSSZatQGQQAFc7J7r+/KKzxRLwlI5kE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMgpQUBfVXE5gUF5UwpEeyhQrtPyhmT//bjTlzdD9pb7TOVDWt
	CU4t0JKRqN+pcjfE5Pl6fGOy0mR3nkYLaZ+xbg/XPXpZDuwao7BxqG/v2Cm6w7Vm7S0snii6nOs
	6UoZliozj77ZFqKL/YZZsztpNMq8vt78=
X-Gm-Gg: AYBFou2/HS955pVBMjRly4WbuerJ/gb1WqPs1A1fJf4fau/pSsvbZLnruucBUe1VFg1
	0j2HH8G5T50R7GmzfPbdsaKTBjrOir7lTcRQ4z+uHf2IVB/lIrLNYQJ+QoEJxp/ncJviuOOmxqV
	bjFC9577SXcR8f9UZ+0jYrigqHnf4zjA9+07uABobbDvr1gRm6W3PAArcz391IIEPOD3OM29C1l
	sJ48PLhPg3/vvKLdaIWSdeeJK7AdnMdsQM/sQpfgWX6iGHFnj376oABl8Qztmjz6bZlIVjdoDOI
	IBXmKfxmtreBwur5BsbUO8PemqK4uFVb5f6h/SjOORBOZiypAD9oczavB3ySfN77ikGAX3N1Zgp
	efXmZX3AfvSOUYvaFf1ImmQHHgAJz9AA6iHY2vzcnLfK4H/3ssawh99G5dmlBHyLnsaHa0A==
X-Received: by 2002:a05:7301:db85:b0:369:d486:457f with SMTP id
 5a478bee46e88-369e834e14amr8992878eec.2.1793004662453; Mon, 26 Oct 2026
 01:51:02 -0700 (PDT)
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
 <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Oct 2026 10:50:51 +0200
X-Gm-Features: AclHuK-MLwyI42-tjUetBxMw3Pp3JS4p0iAKrtkhDYxpLMnE-AgEIVtlDEnzRGY
Message-ID: <CAPVz0n0bc8Ox8jLmeGZTHhT9+=xKmw-poX0gM+e2SE55zYf26w@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: tegra: Fix overflow in tegra_check_rate_in_range()
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
> tegra_check_rate_in_range() calculates the deviation of the configured
> from the required clock rate as (configured_rate - required_rate) *
> 10000 in a long, which is only 32 bits wide on 32-bit ARM. This
> overflows as soon as the two rates differ by more than about 214.7 kHz,
> so the check lets through exactly the large deviations it is meant to
> catch.
>
> On the Tegra Note 7 (Tegra114) the Bluetooth UART ran at 45.33 MHz
> instead of 48 MHz at 3 Mbaud (-5.6 %, see the previous patch). The
> check calculated -0.18 % and let it pass, although the limit is 4 %.
>
> Do the multiplication in 64 bits.
>
> Tested on the Tegra Note 7 with a tolerance of -500 for 1 to 4 Mbaud,
> which gives 45.33 MHz at 3 Mbaud: the driver now logs
> "configured baud rate is out of range by -555" and does not apply the
> rate. With the tolerance of 136 (48.00 MHz) it logs nothing.
>
> 64-bit platforms are not affected.
>
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988) and LG =
P895
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
