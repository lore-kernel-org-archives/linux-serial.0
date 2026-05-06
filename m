Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1B3E3158
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056208; cv=none; b=UBGhAWTp+S4ZVqKCrj9qQfboQKr3c8599ysbND+b4nh9gLunzGECRFp9eqSi3nNVgSHIh2j1O/TsPZUf9KzeWZyHuAsHQkT4hkrBYnngYv5f5rWZodvOsXJBEGQxkDoNq7N9l3C1C2eWHCShaRJiIpnR1louZ/8R0sRYRmQ3TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056208; c=relaxed/simple;
	bh=9jsCfJ77aRZ+EQUR5mk8tkC1C2blxzYZk6FFbWtFFN4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyA3UQLtEPHbyCw3MYO/1KYVHHsNGVQy71a5oTfPadaLSGOmeKmIIk65u8dGNoCFcHaUquT7ebqSafG550w6DBpNSOhZ5OrPTO55Ziljd4rpc/dHngtr7KvERjdsOhm9KesuHk6htYq6xRI11JFoNhWQhFCJ40iHIfyTMsxPBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg4KUl6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg4KUl6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E7C4AF09
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778056208;
	bh=9jsCfJ77aRZ+EQUR5mk8tkC1C2blxzYZk6FFbWtFFN4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Fg4KUl6UPGygVcAGAEON8467PR7zMdd30ytZEGGvC2OE7ESv6SJ0PPk8DUorJ/AyJ
	 3BotXOrB06ohe68bo3ruAcdm5d3y1UU9Ika4vvxDX8UAHGeiFxYPZG5qOTsNp9POw7
	 PytzCQUUyrSkVCKJRu2FRcEUqrOvNNuNEf07tpiWQ+RGvfCEy+g2A9AgVA/hFqLS48
	 tUpVwbQvicdG3DINjzyp9TXuDyvzYoAdD5mTzUjetpqHfNHgIXI4iTpQTuh8eZj6ss
	 MbqI4q2lh2duD9Id4ik1W9JE44SDuHgWyI6qROTQ7fUqAsPHCNQsBdrIKNOo+fQMA5
	 IsyUTk5U/owSA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso6781471fa.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 01:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/0wQQ66BT7v04XSFyg2Vc7cftFhHt/H7YXfj6d4DdDXkFXdKpiDpV5PyzPcwrHWqjh1TrTMq+RGNIkvxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+1XppamKzvmpV+QhHxpFrZqovb2bD5fPKaPDS4rKre2+Mii/
	bc6kirI+gnyweVfhQ+/cz2ztPrGjcF9ZKT7HyG0DU7IauQ1ym3z9A/gO5T1N1IA5UVh8vPCr3G0
	PEjU7dPeYyAL3SPm7cOC2MXfs8DgfmxnUnp/q5PRnLg==
X-Received: by 2002:a2e:ad13:0:b0:391:1570:b6a6 with SMTP id
 38308e7fff4ca-393c515dc32mr8708051fa.12.1778056207163; Wed, 06 May 2026
 01:30:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 May 2026 01:30:05 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 May 2026 01:30:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260506-serial-dma-stale-tx-buf-v1-1-e3ccb360d719@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-serial-dma-stale-tx-buf-v1-1-e3ccb360d719@oss.qualcomm.com>
Date: Wed, 6 May 2026 01:30:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfYowRSM3Ng4nPUwwcnPJJO_b5Bnff1bQ0+=nTymjSU5Q@mail.gmail.com>
X-Gm-Features: AVHnY4IxiCU56DY3SHuvlTt4PbWJmBIT3psLIm54c1U5-W8OVA5Eo5IvT83J1Nk
Message-ID: <CAMRc=MfYowRSM3Ng4nPUwwcnPJJO_b5Bnff1bQ0+=nTymjSU5Q@mail.gmail.com>
Subject: Re: [PATCH v1] serial: qcom_geni: fix kfifo underflow when flush
 precedes DMA completion IRQ
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 06:45:21 +0200, Viken Dadhaniya
<viken.dadhaniya@oss.qualcomm.com> said:
> When uart_flush_buffer() runs before the DMA completion IRQ is delivered,
> the following race can occur (all steps serialized by uart_port_lock):
>
>   1. DMA starts: tx_remaining = N, kfifo contains N bytes
>   2. DMA completes in hardware; IRQ is pending but not yet delivered
>   3. uart_flush_buffer() acquires the port lock and calls kfifo_reset(),
>      making kfifo_len() = 0 while tx_remaining remains N
>   4. uart_flush_buffer() releases the port lock
>   5. DMA IRQ fires; handle_tx_dma() acquires the port lock and calls
>      uart_xmit_advance(uport, tx_remaining) on an empty kfifo
>
> uart_xmit_advance() increments kfifo->out by tx_remaining. Since
> kfifo_reset() already set both in and out to 0, out wraps past in,
> causing kfifo_len() to return UART_XMIT_SIZE - tx_remaining. The next
> start_tx_dma() call then submits a DMA transfer of stale buffer data.
>
> Fix this by snapshotting kfifo_len() at the start of handle_tx_dma()
> and skipping uart_xmit_advance() when fifo_len < tx_remaining, which
> indicates the kfifo was reset by a preceding flush.
>
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Make sense, thanks.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
