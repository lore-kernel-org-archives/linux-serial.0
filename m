Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78C46EC72
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548381; cv=none; b=eno9tq28TgsVpoiQ5oWNqtYb7sjvwX7uIY8cyVCnymxrEteHugRGW+Jmmm8IiQx051s5aIAxDGZECUGwziX6hWEP3nVSHzeURCAwZt8JqE9zsVEgZcH1R9eofP9XxgAvBYcdu45bJr3Qw8KFFljkux1NcjI7DWAjCnYtJ4lKUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548381; c=relaxed/simple;
	bh=Wtk0NDE/nQLO0Kq/zxEWskh8edpJnJdJeeeQfs8GFgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OL+wDRKiLyiRapx0iNN14FNomtgA4GyEJ4VhI6Y3EJdVh9n8WGQrvKPDiV3KVuQQLCaQeWs35wLXLwCVmf32PLQqP0NSdy7tpAF2TICLsiQIG0m1KgEx2ennF3fdUDh/WWZ7IsYmH8J8+T2+1L2yi4FQXcgIkio11llQL1UD490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BO4rX17i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BO4rX17i"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954dff6536so8594205e9.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786548366; x=1787153166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaP8njrWqNK9u1k6UNh7CmbA/RsS8a+eLHotr32/f0c=;
        b=BO4rX17i41nOdw8CbZHhpSpqE1CZy10/olhBrew2hVw6fnqThOmZQtPsRVGRdag0EL
         tnMJStBIOWInsHKNxRq+OJs5EM5BX9FcDxuJoFF4KZmWsHspgmxIT7k/a+PAUcAwqFhq
         LiRJri0yRVndwb+kYfV+YlfDCdvPt/LlnVMYG+m62gS6++YCkltfbY9mjwEId4itOnJf
         3Ax9U7Q+Q4Xr/+p4r9Ciu/8DbG6bHKySX53QAyQwcC2hEG3dHZvSSSmNpcO16U/ABceT
         y9u5/RvZSA17bHFWNDDLXGWEc0mAKirHEpjWkxa/+kCmesIk23Uur2Rkv632uavVmAcm
         csQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548366; x=1787153166;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaP8njrWqNK9u1k6UNh7CmbA/RsS8a+eLHotr32/f0c=;
        b=mHOYFFlA9pL6+Zx2jmj/yW9olKOnAnLRi83CU4AVcNcVtaer9UJp6mXSVWx/odLVos
         0UdCJrqcYtNE7W3EbchuH16BXpi2QU3+p7FYopATsQQkwOBHeSLuuSA4d56v16hNMpE3
         HJIlZ4F1M927jdBlhpKV/HqyjOEmDppqPSITsPxwuJDg5Jnqk9xkwAk1KprzEeQQ81Ia
         DTF94FsVMNTlzPh4DOE/Aqvgt+HgSPbrbnKGreRVJmZhsytupyTLmbDgWV8SLyxkDwez
         QcM2DBUWVBjkldTRsJSYtZZ5hyqyfewEOymYVvZWE20E/l8B9MpMlCK4n7OjhXXjvSdH
         U5Ew==
X-Forwarded-Encrypted: i=1; AHgh+RrHL0SOQ7rNVN1OBfbDfLJTZ0NLh7qJKVLbq5NiYrJIKa2SaUSCL8JVM/aO0Z9PaMJnQ+AxDjRjTI91Nso=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUyg+V+vo/W6OomU7tIczm8hDAe1YSnEB0YXw6jv9jdFMm0tQ
	vQH5Vz8S48u2DDJmy21ZTvkKAlYyjLK1RS2L08qc6rXIJNbD32wZHYaIKJirhz21s+S4NofLXT2
	W1n9sCWg=
X-Gm-Gg: AR+sD123D8LIPgsf/mm4L7S+QteN76JMjutACGrJn1j54YyFbA1cqbgvqRaJLhbrxau
	WFfMJmnaFuGhbzELR7kc80HGxdOsSgjUlzArLRgMzqMlGuAYO9i1VVAtr2wV0Cc0AsDxdcSAyM0
	sFI7iHUL0lfz2GBQ4iOh2ilEh3gDqyDyELE8i/cJ9ssF+F5SO9kYXSuKEMOLTMWa/dsB28xAHAX
	5g3bPGXtVRvoFp2StgrqDwtSt60+DPddtOcJUknlFyCLLHk/b4oJ+lvUHsh+l12BIaJQQrMfvN7
	a1VNyq/Yhcsoio1LH3AUNkefWhP07FzVmp14kbauyXDP4mCMtui6hyyeDPgojStp8jU5ZYebSn9
	yGzyKXTBj4H1C9DZHKMb582BlF/4v/ZOiOOpvTc5gT8U0FTfNrMhTbllNRwJI9+D8NG4wv2hlSF
	8KzfzWy5MeG4xeiNPMXHrK4REP+VEIHrgNSzdLgobqlslba7G6oScSC6/b6eThTZXt37G0Jry4b
	L3d5XZiPo/Z7kle0yifrWniwxOeLR39W6JPo6RhKaISI+eYZZk=
X-Received: by 2002:a7b:ce0e:0:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-4997c149ba3mr57045705e9.14.1786548366309;
        Wed, 12 Aug 2026 08:26:06 -0700 (PDT)
Received: from localhost (p200300f65f017104d1b8d865063c5703.dip0.t-ipconnect.de. [2003:f6:5f01:7104:d1b8:d865:63c:5703])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4997c9944ecsm57398145e9.14.2026.08.12.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:26:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/3] mailbox: Provide devm variants for mbox_request_channel{,_byname}()
Date: Wed, 12 Aug 2026 17:25:51 +0200
Message-ID: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Wtk0NDE/nQLO0Kq/zxEWskh8edpJnJdJeeeQfs8GFgQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqfJB/7yySQbqx1G83rWBLo8uBfFZuEr2QxFCo6 dYxinU28aeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanyQfwAKCRCPgPtYfRL+ Tm4tB/sGKfeGvf851ZrjzdYH/y7CQMrZDskN2gFqCxqs3CbEMJPwFlqOF0Lrkz3bWQVbkwxpeyp bUKA4WZpW2Vs+ZtwzAiWnOuLdIbJIV1wkR67tXEeztaGD/84goXxqUF2luTVqGoGNRBY8RVoIwL QPHFE5xHMqSF0ugLnqyu//aOHfIg/vHFqNZ0g32Y9wWpne3GkJD+krr+1OJ0IdATnbF68Ni9PHU RWeSGrU9nmdhMvSo9FZrfpmFZF3TFdo1fIOgcU7SPGeZ0zv3FrhkFMtR35eE7wRjt6NWyhGgx4I TdNrpe8YutRjkO+FnYIpq9mZyOzwqje9sDRR78nYRq5z5qeg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the first patch introduces devm variants of mbox request functions.
The second patch is just a minor cleanup preparing the third patch.
The third patch demos how the simplification looks like for a driver
using mbox channels.

This series is mostly about the first patch, I'll resend the serial
patches separately once the first patch is in. (If the serial
maintainers are enthusiastic about the 2nd patch: There is no dependency
on the first and it can go in already now; the third patch has to wait
however.)

Best regards
Uwe

Uwe Kleine-König (3):
  mailbox: Provide devm variants for mbox_request_channel{,_byname}()
  serial: tegra-tcu: Make use of dev_err_probe() in .probe()
  serial: tegra-tcu: Make use of devm_mbox_request_channel_byname()

 drivers/mailbox/mailbox.c      | 44 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/tegra-tcu.c | 32 ++++++++++---------------
 include/linux/mailbox_client.h |  5 ++++
 3 files changed, 62 insertions(+), 19 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.47.3

