Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499280;
	b=t6BLPsJ3nilLEA3jlkXSRce0BECOLPosgMOl00bJrmR51+T8Fpde3OcZeg4OhFxHplKz
	 GxjSwZCpYVuqjsO2dh3fm++Ui5jPujdO1iX4qytwegCzWl1NLHxMTreCmI8zoWoyGq8wj
	 S5LSts4vqKFhdWjUwwYuZzYE4P0KSeZgcgQHB0Trf7L2gN/YNsJA+dkPPodMZEUkg6y1P
	 Jm9bjD1P+WQogjgKdauR36nSVKWIwKsfifki39nDD9aYcjjgx/F/GRmHMKSKWNV5dDllc
	 1nNBlfEYNfzknG+8Dz9TfDwe2w7OpQ6HdibRQyq88q05rOXzFUps21ObcAf5jALocug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P0QwVqIkHLHAsRie0NBb7Fm4JU4R0zkfzukQ7suLbX0=;
	b=4NRr0T41z0218UyRg7LtVpmJ4MmqAxQtvcW5bAS7GuY9w7XGdlyRqW7ElncNWOcPVda6
	 GZMmjZIBPokr4vTqgxZcN/UZ7h449Q/JUTdSuEeCcN9NlV2IpuaTpKjzvgyxih7o39SAV
	 j3cCDuIDoaD/ohMgz5y/DSFzABgSsM/v3dIGI+tKRmeN4ckSUZBBCJrINC935sQGMRMti
	 +SbaxjmeCWaj2jrxbhiQFidpqwBK8nXd8/wyAE0jNzx/d6vIm7vRAhIU1imWlTxItUDeP
	 cfhWViSFMQdnmcP4QXPLcpPlPiLeOGRCFvpqbAUcgUS7AtAs+7nMOohlmexkeXjBH/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1nMmDHq;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B14606A321
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 12:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B14606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1nMmDHq
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36661f953e4so770350eec.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499280; x=1793104080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0QwVqIkHLHAsRie0NBb7Fm4JU4R0zkfzukQ7suLbX0=;
        b=q1nMmDHq2C4UkjrZNeo6tN+Zd5a+7kHiLMyrQd5OUTLT06LjSe4LRyhah/BIvNBrJI
         +5nGjTsb1wjU3Q111fpXxDGi0f9Dj9h6Q7hyvudp7ryrlSdatr+UI91fVmiyh0iKRNte
         G4f0cIWPCy2eldzVRkBuNayjxQpkRdhuLa3JDCtao9VHgu+FOcKv21VAkW1ud+VzMmFq
         3z+WCiiOTLq1rLrenEjOA0mHoXqXIBN1sL+hSk6tXejz/HTxuTwnK21K6hJLW5vOQtyu
         vCABdffmvZkOtGiGr7xZYOE2ccHGoE45y2+mIU6Tm6xVpVkJ65hajHFMbiGIYzoACpN0
         O2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499280; x=1793104080;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0QwVqIkHLHAsRie0NBb7Fm4JU4R0zkfzukQ7suLbX0=;
        b=iv9BbHYXkDlBepialZxYL85cuaipfNejPfx6D5BypyMXjfbbs30LAa8Ar3nubZt03x
         u9Bo0mNJDub9V/93126B/cGzcwp9AHz0uGX1atQ5T71cz6G6NqvqabEOHClXkYExPgTm
         u4HpaKIm84m2UmirrlAhKNJVpY/n6vWxVWHLldHun43Jg6Tg/MtOFuudghHqx73hGH9n
         K2h2lshNvC7FEax09i5zNZHvvBfCXZxJ33PDLId+q5wh3+Uq6IBseXW+trY4WO50vBxg
         hRaaOrcYe5Og0hzTjFdOtvQCTggj0jz3+YF5bZ9t53LJE/VOUxayG/6/A3AawYw8WJX2
         4H5g==
X-Forwarded-Encrypted: i=1; AKwUvBz8tFM58GorrUPLe15UDMjTJyYyvW2d8zafiBarj1FgPb/DaKfo7sqFkM4ggv/pha4FSQuX9czlZw6aNGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIriu9Ik9QMrmFrUEj5fr/mHnfa6S8sMxNt3TT0mLVpbhnZnrPy
	r7kBfHOjGb49mMP1WeP3UqE6RkTWWOwHlbxfX8gI5BC7XWUsAS4lAMtS
X-Gm-Gg: AYBFou2M85QD5pYApkU815NX1ATyxbF5ck7ojFM4MzN2mK1eqtNev8rKh72j+FitKqC
	mbcNjhCT+E6Gkb3u7qC2CVoEF3kqXrCe6j+cVtxDaEkmYaPFUbCHhEKVW4Mo7xNDPYyyJ8p4YDA
	2m9/PB9haE1U4erLODonqSGJXGsWEQPy54llBsg47PRBmvVtF0t7BwZd/Rja7D2bNKkWZ6cIxG9
	EG/cG423KotT5YgTCRYATfP7a2ILBBG/JMySD5fUbHXE/ppsEBi/zfzP360emDWHVSDF7IJTkUw
	YFfDfIyW3DI44TdI6xXsi5dhT74JcJEPuABnSsG0rqhw4jfVTyFr9Rzt6BAgzC6NH2cz9deDvVt
	6cUAG0XZ7zkY72jW+fXkAYGVrC7bDSpNvtQTfyD4G4wZNPgCqCq5GLI9ukgzrhRFPWk3yZZwy37
	fnA0VNfUkCr1ATlF/xVf14/S/Dy6D3mKNf530wSfjf3fns63OYhZ/VqWXv21Rypc2A9xolrqPKk
	qKgPv7mYCpdcVq4ebFwjmHzbklGIJOQxlpCbXa5/tBfKxKw1bawbjA8r85aCO9dBxNT0qNrNxAF
	hqzlOw==
X-Received: by 2002:a05:701b:4302:b0:165:1f2c:5c1b with SMTP id a92af1059eb24-1850d37060emr13962847c88.4.1792499279662;
        Tue, 20 Oct 2026 05:27:59 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75ac0fsm36015493c88.15.2026.10.20.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:27:59 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	andre.przywara@arm.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	enzo.adriano.code@gmail.com
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF readback
Date: Tue, 20 Oct 2026 09:27:46 -0300
Message-ID: <20261020122746.41699-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <09812a6a-dd0d-9c47-e1ad-5220f1954648@linux.intel.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <d992e18d-31ab-4937-8780-9c9dc423082a@kernel.org> <atcm2zqDs1P_EDr0@ashevche-desk.local> <09812a6a-dd0d-9c47-e1ad-5220f1954648@linux.intel.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On Tue, 20 Oct 2026, Ilpo Järvinen wrote:

> For is_power_of_2(), 0 is not a power of two. And it also wouldn't make
> sense to have zero bits in the bit field as it's same as no bit field so
> using just is_power_of_2() should be enough.

I think the reg != 0 check still needs to stay here, since the test is
is_power_of_2(reg + 1), rather than is_power_of_2(reg).

For reg == 0, reg + 1 is 1, and is_power_of_2(1) is true. So without
the explicit reg check, a zero readback, meaning no DLF, would be
accepted as a valid DLF.

I'll keep it as:

    reg && is_power_of_2(reg + 1)

in v3.

Thanks,
Vinicius
