Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CE2C324C;
	Tue,  3 Jun 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941402; cv=none; b=CMrChL1HxLtJvTsrdF+00Z6d6fUjdY/4iaL1/NXev7FBYFnxR44OIiUCeSj6ch1F2J1VfvNSMYycjT6GFuKXM3e3ubWD8my2EuxwTG3kBRl1k7siXpfXFglAL4o5CvCRkaDkcWV/I1p4qy8jv9agoUTTffG1lYfhteIljkkKpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941402; c=relaxed/simple;
	bh=RvvoSdvh1GbK3SJcyABBxGFsts23oRvc+PjJ09eCaHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=so8NjCrvQ+6+BwWvGoKRdbSVKfPBvpMHwMzbeLFiCZHf/p+AgBUxV0bHgsyWo7HfSzVobDkMTJ93Qx5OFq0VU4Ezo4ElfYI/gC1cZTyfXGBWqyiui7ssWanfKRrx7NWg9vLTZIZ65/wYkY/7uV43lluxiTEq6I00FCogGghQAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfByWO/S; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfByWO/S"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fc77ba9eso471293b3a.0;
        Tue, 03 Jun 2025 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748941400; x=1749546200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edqc53WVwam8+kme4BDmyEiA4jyp5xhT2nRH1AvpxAY=;
        b=dfByWO/S5D9J1hiqO4Fo08zXYhjAwaV7RHFLXDfk6vR/du39MjqsaABvuUiAfg0K8G
         tTauJHMWFAmVdYf11X4O44c+w7+u2ZAhvyx+TlbAzvsBOMHPNbuMv/nYOD9AfqdyTM5+
         lxEUWWYysHR4tvMLYljDkuiJgAWhwjvcJdoJdaYpKP3HVsAT9PCip9U/HSrXouWmH48c
         lI5JVuWnSzhjbPy1xY4DuoWowvurMWn3lqzjBjGJAKjikt5tUY3LdmfMG8R9L+VNYzsG
         qU3IvtV26x6JZb9J9Mahb+XvgbvXwqPWas9hRbdS74BMFLoSOJaDAod6YhnnrtZeaJaI
         hlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748941400; x=1749546200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edqc53WVwam8+kme4BDmyEiA4jyp5xhT2nRH1AvpxAY=;
        b=saEdSSyNZKJbNrBBHePzGlj4YDu4pnSLheBhuU8YDMmPvMdR5UJXn248GrSYntCT1g
         2iONS4CQ0NiP82yJ5Bu0olHEE0HNMBEsXlQApm8boPKQk9VxflUXr5Jow3stB7fNFMon
         GJ8R7AwQL11ETNTjTEhksNkpWZMtTc/ebP1PQwhmeSdbVizCB0PAnWKKi2PRZvsD7WkE
         RkZT2ctcXPJ3EhHKqoIoL8yfE7Eza8gn91Zf9viEJQaoOuAQZydhl0hd0Z1VlSsr8ryj
         VLG7jh+GiOAKsnnHSYxKzrGKPahBZbtxzxjsxy0LF/YTocU08day7gFCFbxakMxFnJs3
         R/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUanLl49stzt1Xf8VXe8IWLFQhJNn36J5WCywpLDh6Kf619qFdoCCT+1UMd37omOkyhOKoWoBgLbfrqr6w=@vger.kernel.org, AJvYcCXKzzh0MjeO+ZETX+g7hB5sgCCA/Qbn0iK/qWb+RlY/uVMhg9aY6QKPJZn2+7mufhFU4rEUn/vjN1pxmie/@vger.kernel.org
X-Gm-Message-State: AOJu0YzrR1gXXn6NJBn/SdJTj5yHT1krvoZdVAGN41KgFNA+12kQlLBU
	UfEiSwNfmRlpyZurJqW6ek4teAHgWd5PkB40yl+sJtK6x0vEyjeRyCtX
X-Gm-Gg: ASbGncsv3rpbU9uHkdJYElxGvUbkC70vvkc7+SEAwPY0Jur7YKujndBx222jJATCIw1
	L0GKBTmTExCNuP5Cyqh21OR2/meTnjSM7SvB8ylfSQmFniVp/olWzEnNPwFnuSNL7HscIgXXP+H
	3wr4I9SSg03IffZKvbR3M5Z144CUmHuQqr+42X2zH+1xwvv4LumgS/OB12k+v1vAlaweIluk61C
	ckS2LEsnm//lLblWHZHy1k9qlSOokS3aoZWA35Br8FrNEqQHvAiTK7o3Y3wHjnfZrRVeqOzSBLa
	IAnvN+UGYXxPy+fJYSV66ZOmi1CklVhj4usl2UWLFd2POE2MYefuA3cmI3lPF1w15y29HrcObSI
	8M87imFyI5E0gF8mKF4Bmy55MaDz8uPk8
X-Google-Smtp-Source: AGHT+IFA1Q2lNH+gmspD70SzLf3+pSWEj4qJ8Zsz7JMouVmhAnXVdN1MwMEGMK80uGskc8co5Y4iUw==
X-Received: by 2002:a05:6a20:93a1:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-21ad92b8f6dmr24111773637.0.1748941400229;
        Tue, 03 Jun 2025 02:03:20 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm8963618b3a.77.2025.06.03.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:03:19 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: mhklinux@outlook.com
Cc: fj6611ie@aa.jp.fujitsu.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	pmladek@suse.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux@armlinux.org.uk
Subject: Re: Problem with nbcon console and amba-pl011 serial port
Date: Tue,  3 Jun 2025 18:03:13 +0900
Message-Id: <20250603090313.126850-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

On Tue, 3 Jun 2025 03:18:23 +0000, Michael Kelley wrote:
>The problem is timing dependent.  In some cases, the "pr/ttyAMA0"
>thread is evidently able to get the message out before panic() calls
>pr_emerg(). In my case running as a guest on Hyper-V, the pl011 device
>in the guest VM is emulated by Hyper-V. Each pl011 register access
>traps to the hypervisor, which slows things down and probably makes
>the problem more likely. But from what I can see, the underlying
>race condition exists regardless.

I believe the issue is not amba-pl011 specific, so maybe John and Petr
better be Cced as well.

Sincerely,
Ryo Takakura
