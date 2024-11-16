Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F113CFAD
	for <linux-serial@vger.kernel.org>; Sat, 16 Nov 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771649; cv=none; b=WExxfzflmVviGc1OUE4yPPjD/Em0dlYXM1DZ+vh/I9mZxTUrbAHhuCn1yOGgwwWd3E4ebFVlD/VVlybNoh+30mcQzOzDQVqJbTFtq25c/skiVOKk1SY42vsrV5kjx//x8SWVrbou7XuUErFFoS7WJswy76NkFv4nDls0UC1fU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771649; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=Ll1tNl5UqLwqmKJ0UO5jxXEYgd0bxouO72F4vT/+CqZBt+53HIowSiIi0cl199GgExZnTI7UeKGe5KH1rtEzFOG0zoy2vleV2M2YKNPH3GPaWcxd2vRcMwtRwVrUWZ/9JpXQ4hJ1AxqHKrdzpBArBbZYf9GRNtrc6n2tJB7s3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIUiGcAS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIUiGcAS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72061bfec2dso485581b3a.2
        for <linux-serial@vger.kernel.org>; Sat, 16 Nov 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771647; x=1732376447; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=OIUiGcASv0Y+bYCetIpbnmmvb9LxCknrssj9jnNOKFqbkAWVOJXk22w7MSJxrng++U
         zuK5YRU4gQyhfaWmicZ2XQatWfjPXoTsNRXinzEZVNRRC9bY3c40p/QYeO+3Mo738BR2
         jiN1kmVLz6sV/xZs5+wGdT1VPUVXmj6JOjUos3sRXg9GtsBXd5dF/D0gGJJlcAOQn862
         uPLGTLvorj8J8U/eEr+FSrRicdBCzdKNvDsGx1cA1kj8M7XQ6jW9z6O3iYgTQRC200Tj
         QLlBnU88GFlVWae/4R2QnwuIg7BWxZLin/Vk2tMK+QRUeeU9OSRMwRwEmfXAFir16M1Z
         +AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771647; x=1732376447;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=aEQfJ6OzIHVFhNxLB/TZ70iIj0x/B/bT/qSqgflyLSNpiuEsN+WdjCWTJwydaEOgwJ
         WcaG/s12M6qaWXmHb8pgwl2fZnttAXYZWy6E/RCURxa4NpzoZHOuGCNONv1L6KfL/aA8
         DkTQKYmJEBV8T+AKXuvh4AlGYE3Cd0kw8qaJYPj9vU4LDNgvaaBajwctFnYQZRdo4EXe
         Y63vU1XOYI961QwW9ISmRJaB36X18KHgsewYiIdFWBbkxZMFq///3TE6mtfG/vxy09K4
         HIOv9wn7enBS6LUPcuqCTEWodSMAzJi/sg8HvSdFiFqsa8NzVgKewAmvkLs9LE4u7yyX
         Q+1w==
X-Gm-Message-State: AOJu0YyhsL3QKxcui1xxAAeiqG0LbrBV2Qz40eBMRu7WRIG44SnQr1hL
	lfWqrCppiL6OMNxBAI3GqSOETSAxvLWGOycYPixPd3tBNMmtiqARKONcjg==
X-Google-Smtp-Source: AGHT+IGYd2+aSljsor9TGJib9sSjgBV8lU+Ei7ASb6HGfR++G9mRRpXPmFXMQDgXT0rr6+t+zh+4GQ==
X-Received: by 2002:a05:6a00:1488:b0:71e:104d:6316 with SMTP id d2e1a72fcca58-7247709d4c1mr8051929b3a.21.1731771646931;
        Sat, 16 Nov 2024 07:40:46 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477203a26sm3173703b3a.200.2024.11.16.07.40.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:46 -0800 (PST)
From: "Van. HR" <marywangecimaina@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <9d47eedb4397c10c284425a1e0f11ebba5c33c1bd4ccca12f274ec7d2fd4d589@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-serial@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

