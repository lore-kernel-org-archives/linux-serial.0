Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC00C1
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 20:05:46 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso4015541b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 20:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701144345; x=1701749145;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OmNmMuC2LHspV3qtZBS9daUrDJWG+4/vESTs9o4TP4=;
        b=C1mzDo60tORrZKQ8LOrVzv+V4dWXHKZLTewDGaB/v1C79wbRtPGWmBB2LtVwFtD3YM
         DeVEj8RWgXmEO7Lh/NL4bMuJb+My8UrCHxcVbCgILgQ68GA8+59a7wzvTGctJu95tB1T
         ZeS8agSeM3IObmFvAuYGhXh0LZaoLufPJwtvUHy3+ALfcV8YBA2clYVVV/hR4g9Gv/pf
         zFeIwTZeNIf4ueoRnez0N/GSRLkM00kChhxoGGncvVy2p4FuuZ9AzLiZ5gEqr8IVVTbM
         LkhX4UxNIpgzgbkzyIH919BxUGuPBAYy+4vM5EdKXFNQ+CbJWYSScfhp6dFV221R3xS1
         vulw==
X-Gm-Message-State: AOJu0Yy9Gn+CTo9U/PvhT/4EKuSmb56CiZBQGbhzpgPiXFk++YGa08Td
	7Yecz7OsR2oxAC8BLPIP4lCLPr7AP8Ho/cuHuA/C0A==
X-Google-Smtp-Source: AGHT+IGQJx+/AoXm295VG+JjvFKKpj/lhKfEcuZUlAPOE886esxRq0lnoBpSbYDU6yK9xq1Po9H9Hw==
X-Received: by 2002:a05:6a00:2d1b:b0:6c6:1648:5ac6 with SMTP id fa27-20020a056a002d1b00b006c616485ac6mr14632469pfb.5.1701144345432;
        Mon, 27 Nov 2023 20:05:45 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005b96b42f7ccsm8284109pgh.82.2023.11.27.20.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 20:05:44 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231124105455.GV5166@atomide.com>
References: <7hfs213u0r.fsf@baylibre.com>
 <20231024045109.GT27774@atomide.com> <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com> <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
 <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
 <20231124105455.GV5166@atomide.com>
Date: Mon, 27 Nov 2023 20:05:44 -0800
Message-ID: <7hfs0qed47.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tony Lindgren <tony@atomide.com> writes:

> * Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> [231124 10:39]:
>> On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
>> Checking the code confirms this behavior. Grep for the macro
>> genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
>> used twice (suspend & resume), both in the same manner:
>>=20
>>    if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
>>=20
>> This means this flag won't have any impact on runtime PM handling of
>> power-domains. By the way, other users of the flag enable it at PD
>> registration & don't touch it afterwards.
>
> Setting GENPD_FLAG_ACTIVE_WAKEUP will block deeper idle states for
> the SoC most likely.

It doesn't affect idle states.  It only affects suspend states.

As Th=C3=A9o pointed out, system-wide suspend will ignores runtime PM
refcounts, so IMO, using this flag is the right approach.

Kevin
