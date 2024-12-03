Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8111FBCAA
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244349; cv=none; b=Z5n88ckN4D+kYNMSqP5CL5veA9A8V71ZQrSlH3UWL4PUenp10vjQhwAsGJo8psTI802ZgTfEKJqeziB+jrlHNcDiAUeGgvcmuS66JKPEuiKqOqhV5Uf08kPUiEHfiBtq7oOnCLXtCS9AVp0uYqu76l9E7hVBCCJ4odzRdPV/X3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244349; c=relaxed/simple;
	bh=HFhimR3f3IJBGPJ8Z6XUIgJiKfqHLCliyUL95uhgTJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqKTajhKsV6mXAdvuyYOo3+lMwXHKleEs3tQ3VIsicAN7DsTSRs73QV3U1GjKTTqFh+z/g9n2GwjYEoOcN8QirASBM4g7lidZYmU8bHvqa6H4O7MRN5jtYgYUTctrXPjvjqNFAC961qfZka9D4ed6TmZ01g8oAaKkHrBAKUh2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jLsMPxXg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jLsMPxXg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso50603835e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Dec 2024 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733244346; x=1733849146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8CkHKyEiZMda1eN794jIca+GC74Y9jUyCzeSzIcNNw=;
        b=jLsMPxXg6a/0SQak+pOsfSShyoIJxgBBf3kqL29Jksu1HRvlBL5BxZtfIv5cAfmoZ3
         qVzLdL/QdQDkkDAaxbarhRDSfVIKJpiYXHZw2HvnwvRaUixqWISaZeX9gDQ9mjELfPDY
         Dx7/LH6H4EAHiLttoh3SePv8sPzXM8JH06BKT+FVGldLGhokb8xzXXfKcsdRnRrU5GdP
         XVj/QAEVy7UwnClJrpLsElPLEFjJAgBpld62FCSrQzLWTCW80mWcKGNHb+Ldi8aKvDD7
         eLwHUNcJ95Hewvp85t9QpaYPTwd4rVqT+UkftWz5+JMTXuwcS9NDvcty2vDGay9jEh+i
         h2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244346; x=1733849146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8CkHKyEiZMda1eN794jIca+GC74Y9jUyCzeSzIcNNw=;
        b=Y0HpiVJbPBC1F43Q7mRhC4OrcTU1CLHiMUYaGpDBbvCkCnqXBt62xTW1x5/UDvKHKG
         qQdmHls9d+6Lb9qExMIijErMaiUtN2e+J+OTBZhCOXPWPMdIzZSqkKY164/b0BC6aCEW
         CqWXfV9A+DEpJDZxKlkaMwwSqrm8VoAtbnH1qfk+Ae/c43Gk/VQGE3JQc7U1PYfIbEWA
         YZhSoUDa/no+K0wIYliA1O9KIfxWJIXFQakdIaOscOq8UTwfguwKSpDGI+iaYj1kbCrJ
         +3bJznyS2JSJ3DG0xoRUxUrqoJT2K3llMZey+dSPy6eYB8CP4Z92aniYxAIAG68SK7Xx
         wxHQ==
X-Gm-Message-State: AOJu0YzHD3t2EtrabEOPYvJuoNmYxL8ZqV1yebxxtwsKQ49bWkvpBbcC
	lzbdlY/Y9sz3RTnMyXbCaygdMpuHfb41gjAUqNBGimo6XiG4zVMaUXsx0mJSbN8=
X-Gm-Gg: ASbGncugawt5OqR72WJZerkDztswOPHC7WrVfkgJdsO8IfMMifV2qtUpRWR3jgL6edx
	ku7/9d8+70qlc6jXtyb/zyf6o59uLm8nvBWPZreWkIH4yc/IIH6EEj/A2tH+wwdY7FwGkHzGBmB
	bBTrsqvP1yi97rx16OD1hNkY0+47J8aJaA2Rj3L0KBQnoOTmz3kTBJm/GEcul7gq07RvqYI38u0
	Jily8haFNiAtuRrWzo6yRRE2FGT3PNXzOayINx74dfexEc7IEuD93fygC0=
X-Google-Smtp-Source: AGHT+IFpdovFyMu7yZWafskTqVsOEzqiVm8QmP60EveHuCZ5asumljo9Ljy+25DKByrk/biF+Y7Nhg==
X-Received: by 2002:a05:6000:698:b0:385:f092:e1a with SMTP id ffacd0b85a97d-385fd3ce99bmr3020873f8f.11.1733244346076;
        Tue, 03 Dec 2024 08:45:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3cbe250sm10449499f8f.94.2024.12.03.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:45:45 -0800 (PST)
Message-ID: <b71bb27e-003f-4b5d-8654-c7639b105e29@tuxon.dev>
Date: Tue, 3 Dec 2024 18:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sh-sci: Use plain struct copy in
 early_console_setup()
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 03.12.2024 18:30, Geert Uytterhoeven wrote:
> Using memcpy() prevents the compiler from doing any checking on the
> types of the passed pointer parameters.  Copy the structure using struct
> assignment instead, to increase type-safety.
> 
> No change in generated code on all relevant architectures
> (arm/arm64/riscv/sh).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Not sure, do you think it should carry a fixes tag?

> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index df523c7444230836..1ed13ce2c2952547 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3542,7 +3542,7 @@ static int __init early_console_setup(struct earlycon_device *device,
>  		return -ENODEV;
>  
>  	device->port.type = type;
> -	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
> +	sci_ports[0].port = device->port;

I'm currently preparing my fixes around this code. I think I should rebase
on top of your patch :)


Thank you,
Claudiu

>  	port_cfg.type = type;
>  	sci_ports[0].cfg = &port_cfg;
>  	sci_ports[0].params = sci_probe_regmap(&port_cfg);
