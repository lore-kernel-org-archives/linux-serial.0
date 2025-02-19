Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008F1DE3C2
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977493; cv=none; b=VGcpiw9reVrZJp4T39Z+KGhrG563ALizsnX9nmteprldDVXkBJbjNFB+m6+4xwNAaX3FB/iDPtDJ43L1Q/hGECaAkxeISO5fbESnUSYHsAIkFkTA2eveKjuNs8++5oheMOq78JgZkyersOguN82674vYu1ArnOyuFihmcQVcSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977493; c=relaxed/simple;
	bh=7UoeG7sQosLXeI//h7JdA+3n2Sob6MRh1xFZZflejho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENtwPlesUoW6qDF4BiITKh9kmtXRhEVQ2uAbP5+5uS1a/DPP5NPtH702mlCivk/bcAOPHzoIZ/hZDSbRFJAQz5ZLYUXbXXtQfx458FZdvAADuANLZuBuzThGHUgRtXipIoqYcPfRQzxEKtQsGseDqD5/TTOyKooJjOk+eB6TMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Dgl4nPGp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Dgl4nPGp"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb90f68f8cso688519666b.3
        for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2025 07:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739977488; x=1740582288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+Xyg2rx7Tazyz6RJ+FZigjB6taoqrNoJ/dCh8rwj6Q=;
        b=Dgl4nPGpSY3WIl1M3hJCs1n2pKIeRorFWx7Xm/yWkXAorUU8BkYuf2v+g9fTvcDdEB
         PCo3wvPkFITV937X8CLgZMEJu8y+6rB3br5NOo31Hw608snLlCY8QW7dci5ID2D4j6J6
         wJZyTfsO3LUsHG61I3/qlVNAVZq0TFXZZHmZ/iLBLdmLuc4DhChL/2rVqZL1ykXRF678
         7ThOkjUSko5ncyWwGg6oLFyu2q0Rk6aBsktrFS3dXFQ6jJuDzTj9t/0LnL2j9BtbIcWE
         V/0cGbaNnh2LAPUUQdUl1aWbo4HlrA3YVjty+evzza8VaTcrXvjTVC1GspN0qI4lEKrS
         PnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977488; x=1740582288;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Xyg2rx7Tazyz6RJ+FZigjB6taoqrNoJ/dCh8rwj6Q=;
        b=aNLw0Xv5piaQujCZRwGj4+X4FN5I9BKT3Z5u5Skqr186V6qiTsryELKi+uoo2n8arg
         C4kQcregjn52m9stkTUfbNbGN0mWrzitaEHuGwh8WgcMUgwnXuRHCZouJafyirdVbAwx
         kiB4kyHdU8ffnXim/y0fNXHOoTLHClVJ112gvcigr2kP0Wj0Ptl+1YU2v4zmujx2FDQs
         4dM9s6XS3IXkcxfT1poxL+YWoQHC+6dWETfhBapsp8KicWJOA3HxN6TtSdtiBr3tYxNO
         6zHmsS78UGFZtl48o8OvKCPMswlgWMqWqJEsMZcG7sUKiDS+bOVfNvftRABQ9BJUa59d
         bqtw==
X-Gm-Message-State: AOJu0YwBy7Gr4t5K3lseplT2Bp6C1aq/rMeols6eeX08/FhtNfr+ZoUg
	7EbWx7miRctqYTG/WZfXyQSM8CkRPwuq6nNkHUW9kQTy5jJ8WxJj3ZPK3wTRNHg=
X-Gm-Gg: ASbGncuosy9a3Mdu6/UI8bdsUu3xdC5xsJMVW74yKWBVCmydL8XILenP/4bEFD2dDTp
	Y0i/twUFiMQl9eAYPJ4esMbtwSofBshpljpm2ibKjGtBw0FyRT96AEh8jBCEhEvsoD1YqS+TTTW
	7Um3lAABwliL5CkS0WBC/ubEIjo3ryKz88QgxcHLBhWCGZH0ao+hmCm3pdge3doamTocQZSXMOH
	/h84KZyvLF6ZVTBh0n9RJaeiuR1jSCazC8hcIJho3sVPhokDfJvqSzce6qp3dZEOKrP04fj5+c6
	y8ZXtCi0dqcaPb5ZqxcN4Gs=
X-Google-Smtp-Source: AGHT+IE+EUxXj/MaS7xu14WHiywJ2YA+1PB0N9Csii7zF+MBOdg/1Z4jzE2+V+lT99mNIsTi85wemg==
X-Received: by 2002:a17:906:4794:b0:ab7:e899:2de7 with SMTP id a640c23a62f3a-abb70b1eaccmr1817533966b.14.1739977486885;
        Wed, 19 Feb 2025 07:04:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533998e2sm1292855066b.134.2025.02.19.07.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:04:46 -0800 (PST)
Message-ID: <289b6cba-b305-4de9-86a7-24520af16298@tuxon.dev>
Date: Wed, 19 Feb 2025 17:04:45 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sh-sci: Save and restore SCDL and SCCKS
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250219142454.2761556-1-geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250219142454.2761556-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 19.02.2025 16:24, Geert Uytterhoeven wrote:
> On (H)SCIF with a Baud Rate Generator for External Clock (BRG), there
> are multiple ways to configure the requested serial speed.  If firmware
> uses a different method than Linux, and if any debug info is printed
> after the Bit Rate Register (SCBRR) is restored, but before termios is
> reconfigured (which configures the alternative method), the system may
> lock-up during resume.
> 
> Fix this by saving and restoring the contents of the Frequency Division
> (DL) and Clock Select (CKS) registers as well.

Keeping the thinks RZ/G3S focused (as proposed in the first versions of
this support), I missed there might be other registers on other IP variants.

Reviewing the full list of registers from [1], maybe the HSSRR and
SCPCR should be saved/restored as well?

Thank you,
Claudiu


[1]
https://elixir.bootlin.com/linux/v6.13.3/source/drivers/tty/serial/sh-sci.h#L14

> 
> Fixes: 22a6984c5b5df8ea ("serial: sh-sci: Update the suspend/resume support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

For this patch:
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
> This can be reproduced on e.g. Salvator-X(S) by enabling the debug
> print in sci_brg_calc(), and using s2ram with no_console_suspend.
> ---
>  drivers/tty/serial/sh-sci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index df6512c9c0ff28db..70f34b8a93888eb9 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -109,6 +109,8 @@ struct sci_suspend_regs {
>  	u16 scscr;
>  	u16 scfcr;
>  	u16 scsptr;
> +	u16 scdl;
> +	u16 sccks;
>  	u8 scbrr;
>  	u8 semr;
>  };
> @@ -3571,6 +3573,10 @@ static void sci_console_save(struct sci_port *s)
>  		regs->scfcr = sci_serial_in(port, SCFCR);
>  	if (sci_getreg(port, SCSPTR)->size)
>  		regs->scsptr = sci_serial_in(port, SCSPTR);
> +	if (sci_getreg(port, SCDL)->size)
> +		regs->scdl = sci_serial_in(port, SCDL);
> +	if (sci_getreg(port, SCCKS)->size)
> +		regs->sccks = sci_serial_in(port, SCCKS);
>  	if (sci_getreg(port, SCBRR)->size)
>  		regs->scbrr = sci_serial_in(port, SCBRR);
>  	if (sci_getreg(port, SEMR)->size)
> @@ -3590,6 +3596,10 @@ static void sci_console_restore(struct sci_port *s)
>  		sci_serial_out(port, SCFCR, regs->scfcr);
>  	if (sci_getreg(port, SCSPTR)->size)
>  		sci_serial_out(port, SCSPTR, regs->scsptr);
> +	if (sci_getreg(port, SCDL)->size)
> +		sci_serial_out(port, SCDL, regs->scdl);
> +	if (sci_getreg(port, SCCKS)->size)
> +		sci_serial_out(port, SCCKS, regs->sccks);
>  	if (sci_getreg(port, SCBRR)->size)
>  		sci_serial_out(port, SCBRR, regs->scbrr);
>  	if (sci_getreg(port, SEMR)->size)

