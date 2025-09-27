Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB81E3DF2
	for <linux-serial@vger.kernel.org>; Sat, 27 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981566; cv=none; b=mdB3mNiseBoplQdeOruVB0wCZ0m/lSZ7H2barmnnWykzM80jFTM3xxYusXQ2KVlQnikQG3vGSq2ZIvUNsVn29XSV5Bsu2Q/Dgwx2AlDWJ+xcmcwgXvG3qGyh29RvVNfw6mggkFNrWBNsvW/ZDN19i9sTU7AEIBMOtZZl9oUhJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981566; c=relaxed/simple;
	bh=fcHiWyXrlFKXvBYGJ+K3ybehrxbtVs47y8UOfxcApoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fG0nFMxqShdr8yZtdETgrScSaq/GfS/+vWwrC5tPCvaix8Xcq22fxr9K64FMLc5KZKZgENNMmm9h7HNilypPcTtGokTr9cepbYFC6qc87MboxBp+Ra7iqYqTf+f9eK6gA3g75Lsg5wKRefR+/Y4yimMLWZj1nSnA+EKGWgk0r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH10xkyc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH10xkyc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27edcbcd158so28900455ad.3
        for <linux-serial@vger.kernel.org>; Sat, 27 Sep 2025 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981564; x=1759586364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ2zurBZlXyqU6xN/6EaGXAHpVHgluSazTPc6JBBq6Y=;
        b=nH10xkyc9cde1tERg2coU9NQpiXEEfU2/xui9bdVZYz8Vr/B1PDFeYxMwkO52MJRPj
         9blcA1NKKi6o0CaAWsP0DJKelAGW/4osgS5A5kKXVKGRIF9fvHziQ8Fck9cSGr90Njda
         lCT3Qsq3/Is9L5Q2jsGEHb8koSU2akPc5xiwTjhMpUEadqxcG6l9w7Ia5iF9lFcKQMte
         hd8B1xQLTgOFpYDqv4iS/bpgN0srNSvca0XkIvc632WrXrszQysFWS8Dgp7v4sc+GPxx
         CiWVtOP3zzqsCSWLg4eskp46DRmgW3w8OsRHRJzHml8XUNrOEurmnPdKEdvBeBnAXk4q
         g+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981564; x=1759586364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ2zurBZlXyqU6xN/6EaGXAHpVHgluSazTPc6JBBq6Y=;
        b=r4O/n4MH0RzvA9eqgzI98X/DkiN++LPsxPBF8Vh/H1Ea1yB4rRURcoAOh+kjCJ11TY
         YN77BPc12rbu/GfiH13EDq5nZs452KU+T/xlYlPq16bECZTreB5C+3fbPoeWybIvJ8nE
         /OC7vSzyZbav6BdRDyRVToKuzOWKe/UjRltN0FrnjvrTlpmIT/Q8DWUFVYAX9OVE2VQQ
         R4gaChzN+LK6iC8DW4KZICtO6UwLQ0jPAVXaVC/ac8QAqbwj0sWfPJPHuaNSewyvoMC7
         tfBHx8scyNwKn8Oli8I9hQD1+Ypw3utE5HGairo/ojex6TmjxwtoVEXyyLIy1xkw7RzY
         8HQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFY3ZEZp564lxtAp1O00bOo3a6xQMEzc73TRd9wv7QRhJ+7AsslQu886Wve2RM8gzbgqyQuB6pxAoNPuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExrU22/F1AU7maAWwdkbIrydWunFuxd6H+HCcfkXhzB6XeY9d
	e10msfgM2qqPSUxmJrI7uVzuEQeIeJ1Qncja397jDa9hzYAMa15xVQvx
X-Gm-Gg: ASbGncsdGTdtA0qmQdk2vJRF9ww+wSEVG4OC02/O4yMt/vfSS8TIf93bV44qfX5/A+X
	oz9DRbQrPjgj2q3+t1sdxLmCcSExAffk0gUprigfeWrcALhHLbVAxlf9pcbKXrhruXqlRXC+ZQn
	3xRiwhuT1hCejRNiKW3hoWWtnJxzr8BkQ6MdUAkRYJ5dRDNhRLmZCC6Dh8+1cykNoswyz2jwS/V
	1EeBw3av/WIdB/s8hxD7Cfco1FruN4nyGgPUfN7Y5bs3iLycBVLVMI6hd5Z5KvzJzpWeV0oNap6
	eDttb4dMhkIe/jS1pQk8M7NSJKLEvsFv86Vk/SXrPoGmfzphyIL27wYMVEIaXjtYxsRoZaSVqNk
	XA/5XKaNuMOcFcUwkDRm/wVfT
X-Google-Smtp-Source: AGHT+IEf78Oq9CDF3Gdqzh+zztJ/1K0sMtW4DnsPMDn/dIyyhBV9SYuiQfoD+F6FHky70q2kK7m2SA==
X-Received: by 2002:a17:903:2f8c:b0:27e:c27f:b834 with SMTP id d9443c01a7336-27ed4a6dc52mr119233195ad.56.1758981564487;
        Sat, 27 Sep 2025 06:59:24 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:1f0b:281e::3ff:4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm82444095ad.28.2025.09.27.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:59:24 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: timer: Add Anlogic DR1V90 CLINT
Date: Sat, 27 Sep 2025 21:59:12 +0800
Message-Id: <20250927135912.3327-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech> <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Junhui,
On Mon, 22 Sep 2025 20:46:34 +0800, Junhui Liu <junhui.liu@pigmoral.tech> wrote:
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -29,6 +29,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - anlogic,dr1v90-clint    # Anlogic DR1V90

UX900 uses the ACLINT with SSWI. Please use the new ACLINT binding.

Link: https://www.nucleisys.com/upload/files/doc/Nuclei_RISC-V_ISA_Spec.pdf

>                - canaan,k210-clint       # Canaan Kendryte K210
>                - eswin,eic7700-clint     # ESWIN EIC7700
>                - sifive,fu540-c000-clint # SiFive FU540
> 
> -- 
> 2.51.0

Regards,
Qingfang
