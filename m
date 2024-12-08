Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE37158535
	for <linux-serial@vger.kernel.org>; Sun,  8 Dec 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675665; cv=none; b=qQ27FKRJbv2Ke7sPc0KK3FkVqHDP0gi0GzpBLXkn4SnJIYWXDBr42O0KeItANhYa5XPPikW0zW/VclROGVfAeNJ2XP4fhiUyMvljaJ2x4kauqbiA0FISQ8uxPMaP4OuggzrHV/Lbm9D6YaOTskfKZ2pVWdP3cO/ra5l7A36q/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675665; c=relaxed/simple;
	bh=sfwHUbpW8XDdoQtwvphDU/WFW5sPN+tjwHvMRp8wfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGjJqsgNpUKdwSmDHh/CsHoxPhB3FumHWgLTPYi5qEU7cl8LrtASygucC1RY2NQUxeH6MAbtKVvmFAOufYMrUHd840Y6MmRqctToSaHjgoHhfENaS7fgvke2KXYg0ixQvK7a5Taib4CXaAM1wno9i3rOJ8tKV8SQC2gx6fRqX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qp1/DbZZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qp1/DbZZ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso568830a12.0
        for <linux-serial@vger.kernel.org>; Sun, 08 Dec 2024 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675662; x=1734280462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iT4NSRVpd0erHt+8HYNhpTfhW4lFJNhq1fa73nwHoQ=;
        b=Qp1/DbZZx2NGqg7d8a+PsUD+4gr75eDQYBm/GAQqKy3W44kbIF5ZRsXDdpQwfWmapi
         J0j62l4c/cEZijGgoxTW1jXxIoxpBn1NKr1TSH9KAb1ynmMB1pU7j+U0kalioAX1lFA/
         xngEgTOiSVlQ/yByDnSqrEbZTmCNYyLilDculHjIVpDcPpaoOUTt7iGnUgknRI9jtyR+
         R0gqqBTY3927/kyVyRY1+H5lD2tMWJGVxsvtegnjeCWoQEQIsdEImYlKRF02seft2PcQ
         tM7US9+v1TPP/arR/+lxFpV7qxttnolxheb3JOpXPEQgNAT1Rtb+4Ut7l+2MCYCPJOWx
         qyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675662; x=1734280462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iT4NSRVpd0erHt+8HYNhpTfhW4lFJNhq1fa73nwHoQ=;
        b=BOXPwMEN0bbews2Bn6kVFeSAxE7sUIWnKAJp+pePmuq7qFHvPMrTIAiFkSALEVdFHX
         XDWEv/TWoUJWURa3fIVfX7+aBHTXszB54j1CGPlyOyp3Are+vxEgGEOXw3PCnz5I1kqI
         /FSimkCDD4kIzuejsvZV3WyMl7FoNYI6hCEJmr2McKzBDh/LyIyCxItBNqEk4StGYehx
         vtJZ3qN1m3eA++QCufakhicXTmc6CrNZDY6Ze1a4OJKTKEE8Oi1XfbIY2DTm9riu9Wmp
         WBpkr2M/qUSJfJNZMp+qKMAAjWjC3wpe6+5t1JBx3cCHC7w49/peON1zKTMmL0wrOjuf
         oIEg==
X-Forwarded-Encrypted: i=1; AJvYcCV8joWvnicp82ZA75UhrmdDflgl4v9AxYZVaYrDMWnDM2BzafCmJWGtDO9x58iFSPhSv1/Jphw7T2Dgujo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwrk1urvLlDjPZ7HyxJiekbMGplB74nTuZuKjoO2avrcP6KdL
	D1N4XWKA6t0eRn5YOoInAHtf7nHY5e1AMnVKwYT2JWc/91HuDW45LMIk/KTkYTs=
X-Gm-Gg: ASbGncsegfwO0l8bWbTixDF0ldAYlZDG9bXH0+p1whDPsiCOMC+q4M1XCrsQjhjM298
	oh2eYKY7cO/VvpPOn0IiGh99ZBJqSg9K+LXiXJg7OWlmWjEaSJVQqkQ1GqAEFpDV6l1h/jSC+ib
	ipXEtYmi4vOaMFYBCMF2tGtLy4TzGtavt14BS4bWyZKa7qYxs5yQkLA8SE2nRnZtMj4PFfPyJaY
	pk0nRuM9VBpivVnrirbDZPyo+BR5nTAtjkHb2JTGrB+fcSzpBKgd72VVWA=
X-Google-Smtp-Source: AGHT+IHiWExZ8bPK4wGroZLlYPeAABfeeYHqCY2Pc7mcSXStanDyIam/ppcbW7eqPB4JrD4ws75z6g==
X-Received: by 2002:a17:906:314e:b0:aa6:57aa:1fe9 with SMTP id a640c23a62f3a-aa657aa2b65mr521603366b.51.1733675662072;
        Sun, 08 Dec 2024 08:34:22 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67a4f8dc2sm113804466b.179.2024.12.08.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:34:21 -0800 (PST)
Message-ID: <30d2d8af-836c-440a-8b39-4131e8c85540@tuxon.dev>
Date: Sun, 8 Dec 2024 18:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] ARM: at91: add new SoC sama7d65
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <465960c9240553753e96a7f4ff3f48879ade7558.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <465960c9240553753e96a7f4ff3f48879ade7558.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add new SoC from at91 family: sama7d65
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 344f5305f69a..2c7179b1baa0 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -58,6 +58,15 @@ config SOC_SAMA5D4
>  	help
>  	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
>  
> +config SOC_SAMA7D65
> +        bool "SAMA7D65 family"
> +        depends on ARCH_MULTI_V7
> +        select HAVE_AT91_GENERATED_CLK
> +        select HAVE_AT91_SAM9X60_PLL
> +        select SOC_SAMA7
> +        help
> +         Select this if you are using one of Microchip's SAMA7D65 family SoC.
> +

Spaces ^

Other than this:
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


>  config SOC_SAMA7G5
>  	bool "SAMA7G5 family"
>  	depends on ARCH_MULTI_V7
