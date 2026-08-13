Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A8439015
	for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631030; cv=none; b=RQ3q1ZpCIz1Eov8ByVGg9p+7XZ/K47ZqyOo8seIBX1NgVLt9k/crwgxjk/Arrskss+0hWk4Qm4/FVkl2mChmKWmfqqhl+7ztXA5qnshNdI+4sQ0ORSULWbY2HZVw8svYvJRtLEZ8fQlNE2qO7gz1Qqsu8EE9qc/exVpiT1xCRZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631030; c=relaxed/simple;
	bh=xzA6z/ScLQYJHgyemPeQLuBov2qwLz98o4xTEP7Bomw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKvu7B4BaHT/FBQzxcQnzP2XePCxislJlZYNYrhVTsgM44wTGvR5AIAQoYx5zDlSymaaVLb64jWTWb01ZjYRMoxfrYabEDaQGKemwgAGRtl2sKf8PySILgOxM0QLQjL4CeOzplRRhb9s1qzNB5bggg+OdvmGaFv+zN6TOhC3f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Ny6tl/Ko; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Ny6tl/Ko"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47db714766aso619059f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2026 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786631026; x=1787235826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zAK75b8ZUtjKJXv+z/knfiDKVadFa2L6rKVWPT2qQc=;
        b=Ny6tl/KodaHSIrpr3YhGQ9SMgRJ14naUzlZee0rVY32T0OhFFNYRC9dfocN1Bwkkvf
         0LV79OYDsCIlbak351iadjewtHq3qDK7l2v1an12NHiNE/eF5j2Q0M9k5RGz7PpOz2d6
         w4uW5XhAOVwYf9Si+HjeaQiw5Pcphtgg0QV2vmB5ptugcn3D8tRMmdsXcBlN3KFupnk5
         HFHphB2TD7nOjHEh54loe0mYKqXmKrmBLwc8Co2K+gnEMAvbSI79na9/D4Kgiof4QU8g
         EC1VDn4gUQspz1ZjzWJp1Aqa58rnLaDH70/rqFuDID9+imESMdYXrRx8te9itn5wG99d
         Vy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786631026; x=1787235826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zAK75b8ZUtjKJXv+z/knfiDKVadFa2L6rKVWPT2qQc=;
        b=m1qjREqfosJKYGfnf6v4ULs5J0GZ1rv9n37utcXYiQFdTR5wYeviVtU44sB7mYMxCv
         Vy7mU4p7Yy1fijfyCISTWI9ZHnmmEudgY0qybJtZeCAxUgG17z+ZHoqeTlb/amzE+JKS
         FuyaaG8jMQurxtdp12/hPfDNKZLIkRXskm5xgSx1x6P7aXtn/9WhGEIQDL2e+Noe/zze
         V3y4aYiO4bMavzLhHwqQBikfooGlp6l3f7NkrNYhabp98cIZPaLLX+XaobGRuQrH3xRH
         Cx06sb1vlbLYBF8UvppJDHR4+f/PnDmamSfzYJPMoqZNgCD/VcXhvsYnRkWyjjfp9CMA
         gBhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzG8RWROGhUiLC6hBYVRM/Kucq0Cq/9tlDnSf7sRGCUAOc+p4KpiSXyIMKcoUoTL/wUQ2nDFU64hUeSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpw9CM79zXwVHasPwTUvSGXMzc2aSX3k0myQ1/FS+rygyluyEt
	bVNRt2Ms6y1YT0sNYpZ3DND6iEBZ7Zej2H74VAoLii8cLXBtgxoTBbNpjVwrEPtJaxs=
X-Gm-Gg: AR+sD11PFV4XOJhIAwZNPu0ZH0BPnla2uX6C66QlB41el6EdUk3MXvGFqTr3hBu6obS
	YoTxbjAnknibrzMyxDPNjW04deaZ65oDXGjrH9x/oFw3kp1h2g45OzXsk/pT5r324LENwBj4qzF
	gaO7Vgjl3eMiCKilq4N9SKDJfFF07H3BJK8GiEeNrcPNks9Pc4VPQGKcw2IiPuyJeO/j+wja43f
	OnTPPRU3fL4HIKE9Xi7vdNJGCURnKF07Wk50p0vS+MK8mB2BywIzP9b/hqyjoY0nWD/nm3tqnmO
	me6JbR04l7Tz7Wjba8f9QWI2M/ZSNNEQEdsm5Lkpb9yoixBNb7X8/wTHDV2h5qZo4cFWhaf8hsu
	W3m4aIGARScvN+e9rNwhJfMY9t9J8hWMrs6SXDqL9rnAvi/f3eJEVycK+VzGJiGfHrNcn6starW
	St02gmaQOfOwMwz7IZVjs+K1/LN3WIiN0pLkNhq7Y7joVgSJDDH4+k2231kEdiY48aSFhPVB2wI
	zvzFdhtHL2OriXcNW4ENwAQ+ASBK28ideQKRGMBgDAY/3o3JQ/c
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr29737445e9.5.1786631026583;
        Thu, 13 Aug 2026 07:23:46 -0700 (PDT)
Received: from ?IPV6:2a01:599:447:e518:cc7c:e59e:1489:db94? ([2a01:599:447:e518:cc7c:e59e:1489:db94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e2e266sm51262395e9.2.2026.08.13.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 07:23:46 -0700 (PDT)
Message-ID: <15d1ced4-2400-477b-800d-fdcca80559bc@9elements.com>
Date: Thu, 13 Aug 2026 16:23:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] soc: mfd: add ASPEED AST2600 PCIe BMC device
 driver
To: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lee@kernel.org, =?UTF-8?Q?Gr=C3=A9goire_Layet?=
 <git@gregoirelayet.com>, andrew@lunn.ch, jacky_chou@aspeedtech.com,
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com,
 linux-serial@vger.kernel.org, mfd@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <51db5e5bb5bf44dd5ab893b8d547291f04e1d3c7.1785932211.git.gregoire.layet@9elements.com>
 <178609182923.193353.7287772568467157519.b4-review@b4>
 <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <CAFi2wKZdJ3LxJVDqC2K79T0JhoOOWSj=ZmL9pB+Lka_aXDXatQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/26 12:36 PM, Grégoire Layet wrote:
>> But you're adding the UART devices here which now means that the core driver is
>> doing more than MSI interrupt init.
> 
> I might have misunderstood but this is creating the UART device by
> using the 'serial8250' driver.

You're right :face_palm: I haven't had enough coffee when I reviewed it.

Sorry for the confusion!

Tan


