Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC01AD
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 20:52:09 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cfc985c92dso16515065ad.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 20:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701147128; x=1701751928;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg1r+RZ9FIUdipnR46oZwbf8A9z7QRpvYkPUW+SGcxw=;
        b=hfPsLKKCMhdzWamMH/Kz17pOr+8IFnG+NdQ2fLJg4SkSLsTG/3p/ktL+YyWyGKopzc
         08lPpU9Lmtn9lAPq1WvxJLJOkrBwf14VzYOQ9xcmSngOiHf5gVhatED2p4jM5QvoipIv
         d3B3c2RAOUZmwxTZdhcDrHxcPxu0bdwhjteY3E2WZUlJtG3sHzroCMVIoGEGLESQG9n9
         YkpAD/ZzMnrcBFQ3oGTw8EIktvLi+phnPl8BHHvymGS1fNvUjWwThSBhn0EhJWpmvhmn
         4g//0sa/T1empfoilywF7jBiSBusIK+syOT+M2LifQ7fmYQGVp5GcEafLSDbGSklZBpJ
         D+Eg==
X-Gm-Message-State: AOJu0Yzv1EvfO6VofXs/WzaOZCYpOME9F4VLvGcd6W9saalZIioOgLQZ
	YaTIvPaTKazyK+ALiFu8IrZAezYhKsgXMJ3s+8q7yw==
X-Google-Smtp-Source: AGHT+IEk+Q//bjeaG4FF/edJ5277pbWRCSEYNZSey2js0ANdKAVFKOrMILdO1XS8TkVNd+6p3MM6HA==
X-Received: by 2002:a17:90b:3e86:b0:285:93f0:b2a7 with SMTP id rj6-20020a17090b3e8600b0028593f0b2a7mr10259064pjb.22.1701147128399;
        Mon, 27 Nov 2023 20:52:08 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id ie24-20020a17090b401800b002609cadc56esm8203805pjb.11.2023.11.27.20.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 20:52:08 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, Thomas Richard
 <thomas.richard@bootlin.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231128041134.GI5166@atomide.com>
References: <7hjzrbj29t.fsf@baylibre.com>
 <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com> <7h34xqitl0.fsf@baylibre.com>
 <CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-01>
 <20231124053727.GU5166@atomide.com>
 <CX6Z7BRRRECO.3I32FB3Y8Z21G@tleb-bootlin-xps13-01>
 <20231124105455.GV5166@atomide.com> <7hfs0qed47.fsf@baylibre.com>
 <20231128041134.GI5166@atomide.com>
Date: Mon, 27 Nov 2023 20:52:07 -0800
Message-ID: <7hbkbeeayw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@kernel.org> [231128 04:05]:
>> Tony Lindgren <tony@atomide.com> writes:
>>=20
>> > * Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> [231124 10:39]:
>> >> On Fri Nov 24, 2023 at 6:37 AM CET, Tony Lindgren wrote:
>> >> Checking the code confirms this behavior. Grep for the macro
>> >> genpd_is_active_wakeup rather than GENPD_FLAG_ACTIVE_WAKEUP. It gets
>> >> used twice (suspend & resume), both in the same manner:
>> >>=20
>> >>    if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
>> >>=20
>> >> This means this flag won't have any impact on runtime PM handling of
>> >> power-domains. By the way, other users of the flag enable it at PD
>> >> registration & don't touch it afterwards.
>> >
>> > Setting GENPD_FLAG_ACTIVE_WAKEUP will block deeper idle states for
>> > the SoC most likely.
>>=20
>> It doesn't affect idle states.  It only affects suspend states.
>>=20
>> As Th=C3=A9o pointed out, system-wide suspend will ignores runtime PM
>> refcounts, so IMO, using this flag is the right approach.
>
> But it still blocks the deeper SoC suspend states if set, right?
>
> If so, it should be dynamically toggled depending on the console_suspend
> flag.

Agreed, and that's what I think Th=C3=A9o proposed earlier in this thread[1=
].

Since the deeper suspend states are prevented only when this flag is
present *and* the wakeup path is set, Th=C3=A9o's example just toggles the
wakeup path set based on console_suspend_enabled.

Kevin

[1] https://lore.kernel.org/r/CX5F88JLWFUW.Z36KQB2PX554@tleb-bootlin-xps13-=
01
