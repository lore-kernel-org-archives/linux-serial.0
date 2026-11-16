Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794839578;
	b=lD3D0bWT2XRCw9t5mQLvdkdxUSLnVUQHJ9sHRHbFqR8u6F9u3qruOOpHVaCKizI2IAOZ
	 yD7c8lEXDZuW4jf40ugjHutfM0UCEqP9IxO87Om+Gb/roE2qa2PC4vBhNmbEyZ4WG/94Y
	 TMvAXw8jEYlSAfPvZ33TKzVzWWSImH4Iht+c27Nvg6KTjRpv7Lfyr7Q89/9dUtU3xRx0X
	 aVJqhwenLncwZhUp0TuYlYXyyUWccr/2/Qcrwg9fcvz5oTFvZy/GvqQrGMkuobsqeCD5C
	 zf/NPQQ+MINyXYgGqxWOR+ouL9GB0y5LjJqpsA0zGufMCp9QE3R3TCHMIs6fHGIkyEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=C9B94QbPDjaKKQtAC6TsJzJpuRtomQi1ExQZgwuOqbU=;
	b=eFfdqn7d9RzoiHUpG/VT+HMzB72wjMLXEGvjPU6oKONrKX+sN9m4Q5Wvlb1wn1k4vqAm
	 yHVAPyj6o0dwVndES104dzzPwhDXweMVZ88qtu5qwg3i8cDzoRo2wNFJjCOXu66A9ojFM
	 nAmaChc5HXTfEt+ues5Fw1R7YoBKfhRYqfgKhIGNRL+xeB8vadM+JUZamhs/je0+Kq2tX
	 IVY7yrcB8TaXiefVnrjP2P3sEj5lCIO/AzcH2olj0JHA94R1C3Y2FQeo6hOzDlwymYFYL
	 byGx8KBMTQ+rTiREL3Djo//OKxPNhrreMxxNYhCDMRUG2d94nW0URLNpchGNznuUoFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8Z4CRwH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A71606A32A
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 14:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A71606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8Z4CRwH
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so4988786e87.1
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 06:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794839576; cv=none;
        d=google.com; s=arc-20260327;
        b=eDd/6UBVF6N81D8VYKtEOBVD/4Rr0ZL76K9shegVNLH7GcOFAOvT0Mm3UsacdToh6f
         mf2oGfa+UfYcvpzLq0FmSLDtU+V8lK3iMuzy5tdm3TQvxBuXbtRo9ZgRWGwPAGGuowMZ
         2d8XcTpYNDVvfO9ezIFDvqtZrMjid0Q/Pq1U+VTOqSGRB9e0DESZNa9YbYQ4WcltspZG
         eeshTYttIl/2njOvOISrGufRUvWMo/+snRh1Rn+baXemk8ex+HfXStxeajkfnbL0GmaH
         dGTjBll0hfYXBnDR8pll9mR5Ru43b1VwPT+TTLNSBg4jcfeYZFageagU+EBNmVPxGlrZ
         Q5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C9B94QbPDjaKKQtAC6TsJzJpuRtomQi1ExQZgwuOqbU=;
        fh=gWUvC6p+fUcQPWpKfkmagh/4h4fCUP+GxXthBRs6WL0=;
        b=cLlFbmAs8e2gmNY4OhnRGL1cOE6kd3hnty954puGtyGOqXOzP1G8mY20Se2s+ExZsg
         G2Bmv7kmOydO/3oGkCcBE91zDiuLfwauu/QMcNqPh3ncVj7zxVGXY1NLSKkVVioyqfSj
         /X5R2/KA9WT+/OegGIG1aWtQ+W9TRhW+/RRabfIfedVtsE5AaISQZIAq7JUiIciud/KO
         ueV7u5D/7h38Ya90A6yecDOy2hwqVoV9XgcnlkzLwcAX7J8imTfPYKth0UmFxNPXwJER
         qxiPw4tOvTx2Ej9BZeelO+HWNzcsNKNFg2Em5/6R7KSTTSy0brrKe+K/pGzmhLYDWE2a
         6HDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794839576; x=1795444376; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9B94QbPDjaKKQtAC6TsJzJpuRtomQi1ExQZgwuOqbU=;
        b=q8Z4CRwH0sjPZ2AFdplxBv97CtRNwTaq3BYuIkZ83p5Ma+7EkjEQAsofQcWZZ/ONR0
         Mzzk1Zdcy3XcKbyWGAiR1EGtmjjSgUifkCzpqIgae92YbtXl7T3GdDzlmuTK2f77Cusl
         wOkR1szXPoYEDsFY5iwXnhgxf5G38lV0jVXUIfMMFpznFKrTOp5Joy5TObwS1FrXAkRr
         +w8TBHmMyAoARdljtxljlgw0IQRsHvDk21+iXGBdv6iD6+IfHZP283dJ2PXdmoIw/PVB
         ivWiAOtIlgJkxlN7xJlMjdKMDLo9u5kfKWBtfKWczRbMeggQ5AFVuGDoASkVYvHYlGH7
         +iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794839576; x=1795444376;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C9B94QbPDjaKKQtAC6TsJzJpuRtomQi1ExQZgwuOqbU=;
        b=T+g6ncgFB+G3Xy/oICroUEW5RSJMl8tr/dywgvGyx6KLe5HuAFqF9rBr43Tu3ySQEq
         iiOA6psKo1Dt9cG4zT7r3ATfg24CjXEra83wINtYIZpEjEnLFvOaP/pDn3i7+5GEJf3K
         OkS1VlURlErUqAXfeCClT240j+Zock1hMIJfHOq7yWWVOgawOtRhrm7meu9PWtJmNzwo
         /VBSbaLJABplZYSi3T9am34kV9kE8tBPrNJwlQh2SKn63aVrrpNGKMU0V3E+LNa/Wted
         ytfffSaLOYZv6w//KkB00dq9tl1ZhDO+fl/4zOLKKKhrvJgRRyl1KqxvePp1n9nzTP9d
         pGeg==
X-Forwarded-Encrypted: i=1; AL+hErFyFWWlS1sPCXJOe/FUQMgFk4bzbo2jsb8mdYJEgiunKsR2YgulkMMDukRgpgumSExEmtePdOs91lAKmhg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vvBnhwxWCQ7otESh9vp1hxzL2GwFJAFL61dxk5zvj19f7PNVr
	xaqk3OJZJAo/uaEQNLCI2fIdKZe1smqtzctXWf5wmJBsBb2JcTe7KDr/YQZGIvzLTe/hdzGnakR
	nzPu468Xw3UjANFOdAc+r/jGNn9/szdQ=
X-Gm-Gg: AYBFou3YVb2+cNqjtxmv8WOyZOK0X6+JoT9CxeK1OXTEwRvpzFTem1f+emP1m2Owr7L
	xvRqmrHmjM9FY209hKo3UkJV44NZ9QwNCH1YjbWYAyl5DJgyczTmmpzUt3bSSeGhIMVazlPVo/q
	tAYxijJGVRWdxF3uMdsNSReg9f3+GO3ybGTnWr4Ki2JJwXCZotxY37+U6cNHpx99rwo9AtcPWYu
	VWiRYbp+fNkdUVESagUqb7LX+cottMgcWSqj1UykXsmNn2d19QTOcqsK9Shj2BeHpgSrUOmOots
	Fqi2VxPZ0F7INElOQwghLGg/EsCwPW+mFoKeR9h6N/on3MeSEH0OHTVMbHAxFYXoOIs0zxx8u2u
	4kNTik/WDzg2oH2C1kVADjg5APPt497OzZ2giKg+g0dCCKf7YfbkFz8w66uv3UT850HgKGravFF
	Gn30xDcIis07n/TdnJ1Y7+ldXHPwNGcVa3j1uSU1MqkbACh1Cht/1upHJzinCPgtKT5hj6rJmxW
	fxpaiA+S/bkXTeDirJVq1wUWC/AxVWKO6eTk5JLJtzNRkYmOfQkayGbUjiXt4zOEyHtg2bQqhca
	lTauvr+B/sdR7mtvxi6/QahKhLv/NGE=
X-Received: by 2002:a05:6512:31d2:b0:5c1:4c0a:49d9 with SMTP id
 2adb3069b0e04-5c1709aed3emr4514975e87.16.1794839576049; Mon, 16 Nov 2026
 06:32:56 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 16 Nov 2026 15:32:45 +0100
X-Gm-Features: AclHuK_LmPF6GdpEB1OKtm5HFOhuVUEo0FmsAXlPZr3XF_GhyxB157Z16Flkh34
Message-ID: <CALoEA-x+TpMdsE-e7M9+9K0wu0kgbwDdP02QsMZ49nnnahxxnw@mail.gmail.com>
Subject: Re: [PATCH 0/5] tty: serial: remove redundant pm_runtime_dont_use_autosuspend()
 calls
To: Joshua Crofts <crofts@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Oct 2026 at 18:10, Joshua Crofts <crofts@kernel.org> wrote:
>
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>
> Remove the redundant function calls.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
> Joshua Crofts (5):
>       serial: 8250_omap: remove redunant pm_runtime_dont_use_autosuspend() calls
>       serial: fsl_lpuart: remove redundant pm_runtime_dont_use_autosuspend() calls
>       serial: xilinx_uartps: remove redundant pm_runtime_dont_use_autosuspend() calls
>       serial: port: remove redundant pm_runtime_dont_use_autosuspend() calls
>       serial: uartlite: remove redundant pm_runtime_dont_use_autosuspend() calls
>
>  drivers/tty/serial/8250/8250_omap.c | 2 --
>  drivers/tty/serial/fsl_lpuart.c     | 2 --
>  drivers/tty/serial/serial_port.c    | 1 -
>  drivers/tty/serial/uartlite.c       | 1 -
>  drivers/tty/serial/xilinx_uartps.c  | 2 --
>  5 files changed, 8 deletions(-)

Hi, gentle ping on this series, thanks!

--
Kind regards,
Joshua Crofts
