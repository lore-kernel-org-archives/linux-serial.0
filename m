Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="LIwdbBCV"
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692E123;
	Sat,  2 Dec 2023 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1701512962;
	bh=k7wQyfXjBWCfgfOP7iiTpi3ek+GXI8y10Nph3yJx0EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIwdbBCV3Ews72MJCQrg6JO3vGiq+olmtvV84gXu3T+sUTimhNAF/yszB0n6X+mcU
	 1ORPYXr1EQ0vSXz3jyN5UlPRW1ykNM7mgHIynvJgwxUxTWCnWQkjQESoM6rbYrx0W+
	 TyMb2KJlJWukHaHffQXAtIZ87YA6I9ufYOzAaGZCFM5HK2sAID+zq9m+AfYKmYkgIK
	 bLRn++uZLi0yW7r0gt8edTG3z2oGb6CVasP0I+ClMD9ofmwD9+jxHia18xjeecSkYn
	 Yi0WQkfdSRuDRqNMFkXPMPDM4gGWKNtGEk1HOwPVIkKyr9zwWBwBVbDh/KNdc4q5nT
	 HJFwvcDCwu/KA==
Received: from localhost (unknown [IPv6:2a07:b241:1002:701:7aa5:598:fd89:7240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id 198171180072;
	Sat,  2 Dec 2023 11:29:18 +0100 (CET)
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
 <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data =?iso-8859-1?Q?corruption?=
Date: Sat, 02 Dec 2023 11:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <430727d2-7e88-4de2-97ab-e841656d7915@cesnet.cz>
In-Reply-To: <CAHp75Vc4tB_CuT-e+gofanWK=mss-k_A-mqPo-8+Rv-aQ8tu_w@mail.gmail.com>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <f66cf0a3-4d63-4548-8648-e93a1ef995e2@sirena.org.uk>
 <CAHp75Vc4tB_CuT-e+gofanWK=mss-k_A-mqPo-8+Rv-aQ8tu_w@mail.gmail.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.10; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On p=C3=A1tek 1. prosince 2023 18:02:32 CET, Andy Shevchenko wrote:
> On Fri, Dec 1, 2023 at 6:21=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>> On Fri, Dec 01, 2023 at 03:51:51PM +0100, Jan Kundr=C3=A1t wrote:
>>=20
>>> The TL;DR summary is that the regmap_noinc_write spills over the data
>>> that are correctly written to the HW also to the following registers in
>>> the regcache. As a result, regcache then contains user-controlled
>>> garbage which will be used later for bit updates on unrelated registers.
>>=20
>>> I was investigating a regression that happened somewhere between 5.12.4
>>> (plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our
>>=20
>> Can you reproduce this with current kernels?  That's not even an up to
>> date v6.5 - we're up to v6.5.13 now from the looks of things including
>> one upstream fix that looks potentially relevant.
>
> Indeed, the 984a4afdc87a ("regmap: prevent noinc writes from
> clobbering cache") seems quite relevant.

Thank you, Andy, this is indeed the real fix.

Sorry that I missed it, Mark. I spent many days on this one over a longer=20
period of time, so I haven't noticed that a fix was merged in the=20
meanwhile. I was just very happy that I debugged something which looked=20
like a real puzzle at the beginning :).

Cheers,
Jan
