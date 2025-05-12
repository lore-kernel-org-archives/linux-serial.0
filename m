Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32D1DED5C;
	Mon, 12 May 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058239; cv=none; b=EE1J82KRWJDbTvcfJn9qkgpzWUDx0A87wVJkd/FtIMFhRHQ4LTBtwxS99kB0zbSlNaKa8Uj/M+zXo6UJqQ00kREvVmINjFUkLiJL0oSY2PohIl9T8QEj74k7dBMMvPnUeXnQM0zONa2wB5Z2iSVmfEzIaqb3cQJUpxFKaVXeD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058239; c=relaxed/simple;
	bh=05H8JpjKY35SdPO8KI6iVeXLxFQWAJS1wj4NnitynvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4E7D2asep+LykUmpPX1FcxNwvTgfN+V4VYyyDv13qJXGDaze/aZBZ1WcXjod2gXC/6BeQupsp0JnHgbGvInrTWL0KOY5P+6rRuqIfrFlr3MET4JXXOyizYcAbkLh/2LA4M+Jw1dd806T3gJ+cvLcoTCcwqOTsLauC2eCLdJCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjHw1tWd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjHw1tWd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33e4fdb8so37315635ad.2;
        Mon, 12 May 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058236; x=1747663036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN5gSHLw3iiOyOm7rZHDOXQuNi2nQ5wWFGqnZaf6CLM=;
        b=jjHw1tWd8TfVPcSJxovY9k5pJzq/GhkOx4IOlwreSKiFsaFhWlm0Wx1vuPOQAdkAyb
         4HyKlNnb7SgSMcguduQ0ozkmYPUWJ2J7XCQvwFiBMJadqVe9PYIKgSAIS7SKaBfOHQkM
         jUUWWw11M7iINZVcigpxDi0sb1pmG0sFKp/qUaFlRc2G9y/sv75c3MlYpSuoIAksNAf7
         b8DbPa/NMikS4S4keMnY0AcPVG7HYKETU9zt2Xq4GbYbGxwZoLHpoPixUAXDbkpeHK4T
         S29c+qfD3UJTS1R0z798k9meuVqbVVmbmUs98GsdyOJi3zTOOyPhxqNFu+62vgdWDDh4
         jMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058236; x=1747663036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN5gSHLw3iiOyOm7rZHDOXQuNi2nQ5wWFGqnZaf6CLM=;
        b=FKkE6XzuQEgSiQXrW44x2bz891pu/jY69KCDaN/TgQNMsNd3dEcS1i5Fb6imoe6tjv
         NdBJAt8lEDj/ao5455WEFQzh74wwbW03Q/LB8U80XCPbeImQCrWxSVTz5LFWl1CATVlf
         CFdXhxV0zYs7fsssyfZDPh6seeOfV3If9TAd9ynnGhzn0sdUAcFXOfsAWpvpH5tBGSO9
         DUCUx5T5N+r0s3VhNpSSLz45QLlaISc4sOmC0A38/6H1ou2Z+lTActezdqCJz+JgseTN
         jJG+4Ub9reG7O4W6eFhbb1LUIRgZC8vCTganufnVgTZO9OBbIvvFZcQZBEZSh84wEFie
         b/jg==
X-Forwarded-Encrypted: i=1; AJvYcCV2F1jGkGyXVJyNMsgg+rum+FL63NG5OnwoCW3aoG8C/4o5q6cuxb8bkdKW6swQgTfhirmnT0mZk79Mvss=@vger.kernel.org, AJvYcCVeFCDUBhIdVjQ4zHXgkeQI6jeDJZWR0A5MQRL8aoXqFkrGv4RpNbsFjXvgzs4FLkV+UA/Z+ei7EVN2P9ZY@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRRNkKan59iDgFz93KfxNJjrTKB9tlYFpKr4TsmWigwbemfTU
	UZGR4bhNzRUbZ5Orw+Lg/iNVxK/fraonwSEbOOX8cRZiCZsDG7vu
X-Gm-Gg: ASbGnct+xLwJMMeWjbq5wAXRKqZENGjJIvfY7vr9FWyk2NaTGAo03oI5yk/LmJe74jK
	WzPDPIEuiRbu8j5h2A/xc15B4pcq+r8QXS5OofsYgIBaXojxBe69QKUNCkEu+EygORkjvKDCMLJ
	t6O9JSRQYj2Bt1aAqpL5pQlJpmTFeeWHo1xShXI/ZBvyqBkVUEMtYOOVtCOGnL7vh3iZE9+1tRG
	UnnMIFZxBLXQ/bcHiaT9H+wUtvCu8QHHDnb14Si6GREEvy2PmyauW4laXxgOl0RHsdqTZWMyDtq
	XTMK4JgmOAN18yFXzi7OFyYCqE7ochMrg1ODMiNTvFklHIis4nrQKoXPHtWLU6mP7+c4mDIx6JK
	o+ZEqR+qOp5KGMcfoz/NdBp9J7WSADmtmD5IFtNqjm9lZYdHln+I2eOBu6mc=
X-Google-Smtp-Source: AGHT+IFywl13Dph106GWlo1h3hEoMGAJaBIrJd19Hxw1kXTgrE5Xd4uuO/U4r97s3z0wwStvtpT8fw==
X-Received: by 2002:a17:903:166b:b0:224:c47:b6c3 with SMTP id d9443c01a7336-22fc8b0fa27mr156037045ad.6.1747058235694;
        Mon, 12 May 2025 06:57:15 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a38ccsm62985465ad.235.2025.05.12.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:57:15 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: Re: [PATCH] rslib: Add scheduling points during the test
Date: Mon, 12 May 2025 22:57:11 +0900
Message-Id: <20250512135711.5307-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aCHfvBOY0vQ58uaC@pathway.suse.cz>
References: <aCHfvBOY0vQ58uaC@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 13:47:08 +0200, Petr Mladek wrote:
>On Sat 2025-05-10 10:35:15, Ryo Takakura wrote:
>> The test has been prone to softlockup but stayed unnoticed because
>> of the printk calls during the test resets the soflockup watchdog by
>> calling touch_nmi_watchdog(). With the commit b63e6f60eab4 ("serial:
>> 8250: Switch to nbcon console"), the printk calls no longer suppress
>> the softlockup and warnings can be observed more evidently that shows
>> the test needs more scheduling points.
>> 
>> Provide scheduling points by adding cond_resched() for each test
>> iteration on their up to/beyond error correction capacity.
>> 
>
>We should add here:
>
>Reported-by: kernel test robot <oliver.sang@intel.com>
>Closes: https://lore.kernel.org/oe-lkp/202501221029.fb0d574d-lkp@intel.com
>
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>
>Otherwise, it looks good to me:
>
>Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>Thanks a lot for nailing it down.

I totally forgot the Reported-by and Closes, thanks!
I'll add them along with your Reviewed-by.

Sincerely,
Ryo Takakura

>Best Regards,
>Petr
