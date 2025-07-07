Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AF21ADC6;
	Mon,  7 Jul 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923019; cv=none; b=UWp2Ixu8fn2+9oH2Fo4ZN4ySYBwoxvk5xyUnXZeEoI/uylCvU50wTsZexzMLsstMk6Nn10tcPaM5cm5vxrJiYdUsTXGgUdxAAwCQJzmvzzYmLMLDAvTYuW6N7IbV7Do9Gq3WO3GsqKFVtOp4/YDDAvgSNqCsk53rWCXjtvd6rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923019; c=relaxed/simple;
	bh=bfJx2la5wj14J+QYANpPCqmfZniPGr69Qwx9FPXgQoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6KtNa+JuIeT2TlBpWNosISh9WwRtOVvvuDlGg5qFZoPUt2Lex/LenT36zfuH5NjelCuM40NsQPYP+y+mWRgeqyXyktPd6oF5xsDSigAXVJaHfqTF4Hwi1NucKbB6PurKypuemZt36ntNPBHW0UhjzV5vHZktsfFaGs/G1Azneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWLdfM1T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWLdfM1T"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so543632f8f.0;
        Mon, 07 Jul 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751923016; x=1752527816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOV+bbWh/YRPO0L3zwomLxzMcoxclWz9hO/1NtSl7MY=;
        b=bWLdfM1TYUnfMmeCa2XGlALxDLWqebvCF+4yvsS+4sylGFniMpDTdju9e1r2DcAU/q
         AQs6PglwNaN85ATMhDQMBBaUy2Bh4HVklrUD3eEMwwpZsCgIWeHrzxZtAYla6InIOqw/
         wMTwlFMD4qk5GCc0TNJ8mNTm8Puux3z6SnYQET1+2lf35idM3sWmjre4nNq/GTQfe/Gs
         yLsFyJEsEPp+txzHemUF+8JyIkMt4NCXKq0m/HZukH7daQTlnXUZa8LgRgKA7wSwm9DD
         qy0S/q0L54F0C1XVaoiUL7s2IZpr28AZsIdvkKqLEAtgGXZJD5z7hhob5FUuJUnZaEI3
         D6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751923016; x=1752527816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOV+bbWh/YRPO0L3zwomLxzMcoxclWz9hO/1NtSl7MY=;
        b=k1UFjjr3HwsJ+d0vmo0SOxFKaQhnO9qcidXykwazLUHctdcFg5JRjFMRolQp+ALngL
         ImxU2TSTT+LWbwiiFB/BXeTPXP8S3tGjNjSGoATsDjvc5xfIVCGEhUSFtex+lnPUnlJG
         nClfkwQj5NOL9UXQzGIu+yDpLiZFiz3DJJ135R6tz+Nzgq5LUO0Bqxop0XVflawreYcH
         bw3nbKtfy3YbG1ZKy9XHvfN7ZHCSeJEUhOvhR19q7Vz5Hd3zyOfmBTxblbZs/+e7yrC8
         w5DeEbQ3UcPEu3lJDBXhIor/J+/CRkkVPmQ2g0I+ock3mmDJ5c2Y8mBzsEo6lqUHoPkL
         uR6w==
X-Forwarded-Encrypted: i=1; AJvYcCUuFaabEusWi+ZXVFj7SYeEBGNffOTzdK0HXVIqNJfA29hJyZazRZ5yPODX1GxAYm+4V1fjj8cRhWSC2VIx@vger.kernel.org, AJvYcCXr3l/cIoFGzg0eurwuPR53t+dJWGaCXZknXMGCKJvQWo+iq2MALL4FlYBVmTn7AzfsCFkddOizEKBO0N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mzs6DU/Sydm4zjnnH0ThbpovvlhjhYbEODIIDgfXatpa+2Y5
	fiCHumGHFO332HNICcDTMWit2Pm5lfsUATxVd+2bYHhh2u97IXzY73EL
X-Gm-Gg: ASbGncsvFdD8Xb2+D2PenVI8R0ShrovySeWC9/WiMgakKsu2Qd0+9xajwbKD93QUUa/
	FqiJ8/gSRB46J2fDmSyQkD1rt3cEM1lZ+PZK/IMJ9QCbpeSXibLpB3d1t6mN+qaezNDzbaJB6nC
	6i9O2asPqNxQC6hmVX3yQX1y+nF82eTMyP2MkwsFzxAg39CXqBXhyfiORi3kDKtsQpCn4ARwiuk
	kTcKGBx5jz4YNitbXLHw6QB8BuAHEODv5OW9fnucfqlPfgeMjMwqKBoCUk69RV1JhvUPOsuvz0p
	HiMonn9kM0FxnNuY45CamzpN0zT7p4JQtECamgOUmo3v7PJriSrdymyOczI3kTZ0lCpsvHBcdIp
	4PQyIpahc
X-Google-Smtp-Source: AGHT+IF+P3C9CXNVJJ3oENkV2frWmpNQxL4fV2zoRp40CwiaLutapyZDpBsZhu3fANLKxpPg+K/bVQ==
X-Received: by 2002:a05:6000:2c01:b0:3a5:2ee8:ee1d with SMTP id ffacd0b85a97d-3b496625deemr3482921f8f.16.1751923015774;
        Mon, 07 Jul 2025 14:16:55 -0700 (PDT)
Received: from DESKTOP-LCRLR8G.localdomain ([196.150.57.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd38f092sm3202965e9.1.2025.07.07.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:16:54 -0700 (PDT)
From: Marwan Seliem <marwanmhks@gmail.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	marwanmhks@gmail.com
Subject: Re: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
Date: Tue,  8 Jul 2025 00:16:50 +0300
Message-Id: <20250707211650.12051-1-marwanmhks@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025061938-making-igloo-3326@gregkh>
References: <2025061938-making-igloo-3326@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let me clarify the security rationale and address your concerns.

> "security" involves crashing the system, so I fail to understand why one
> is more "secure" than the other.

You're absolutely right that crash access itself requires careful consideration. 
The security distinction we're making is between:

1. Controlled Crash Access (our patch):
   - Single, auditable code path (only sysrq-c)
   - No runtime configuration possible
   - No ancillary debug features that could leak information

2. Full SysRq Access:
   - ~60 command vectors to maintain/audit
   - Runtime configuration complexity
   - Features like memory/register dumps

> I don't understand your graphs here, what are you trying to say?
> Somehow still allowing someone to crash the system still is "secure"?

Apologies for the unclear visualization. The key points are:

1. Current reality forces a binary choice:
   - CONFIG_MAGIC_SYSRQ=n: No debug capability
   - CONFIG_MAGIC_SYSRQ=y: Full command set

2. Our proposal adds:
   CONFIG_MAGIC_SYSRQ_CRASH_ONLY=y:
   - Only sysrq-c enabled
   - All other commands compile-time disabled
   - No runtime reconfiguration possible

The security value comes from:
- Reducing attack surface from ~60 commands to 1
- Eliminating information leaks (register/memory dumps)
- Preventing privilege escalation vectors (like filesystem control)
- Meeting compliance requirements that mandate crash access
  while prohibiting other debug features

> confused,

This isn't about claiming crashes are "secure", it's about providing the minimal 
debug capability required by certain industries while eliminating all other 
sysrq-related risks.


Marwan Seliem
