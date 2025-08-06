Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3417736;
	Wed,  6 Aug 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517060; cv=none; b=KlzeaJy4zpjK/5LeChZXDrAQfgpsNpGeQ4A7aRDWciqGNWiJ9hNtsD6Cf4L/uJVi5v5g0Lo8r9N63qagPyyCayOwZdtfcskdszlIJdTt9oXTXNEsI0FXb40SbI6KYjKQvjYnLuRwUnpqqAO/H8snJnaJeu3r0XVrq9KcgH+AAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517060; c=relaxed/simple;
	bh=tIoV3u3oSEKl5MJGhmiBKE+O6vBjRoLixbmVMt9YUiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lccAdaKVRH0wVm2v2S4iIp3fg/PUmNIPirX1NLKY8pGIlVseCLnSy7FHzFYiL00M3IUC8Fj3iLzYvjBbFM4TE6DGPhFv02k6BAHALqWMF6XSjuxEAN2WNkTSsTu9oquNPzNl0fWIl2UFo5+LUxEjHw+AwN5F9O5He6s3UEdfAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/mLYc/n; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/mLYc/n"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7698e914cd2so576926b3a.3;
        Wed, 06 Aug 2025 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754517058; x=1755121858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax1OWJKtq61vhFbiZgJU2e4yFQjUlA2kSS1lJZHbeQg=;
        b=k/mLYc/nY6PS22Rbz8Fxl9Ngt3bYBTlPuGJ2t3+ZOX1qkUJzOvX3o6D0zf6nfVr1Eu
         mimDJR1W1KbnVAyQRfSdhF+Yb2CYPKMoygWnsI/upZLaTO3fCDMgutd/e1JECGVsYp29
         8yKxlntSxiUrxwXoatsvobIYKb6cKm9+0fcEW76kqhk9MK26mvVdjvZGDSRKUWCinh3J
         AtsfWkpr0B54ZPuX4KN/wXghhSTtIwMKFMZiT+EjOEkTXn95lhF3bgZ+OjwJi66BJR2C
         kZdH4JSUMAepOotNZXa5DpgHqylF/9e8zQ9iUkoXU8/7gcV/HjIZr2RGTRjAZNZnEy/R
         h+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517058; x=1755121858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax1OWJKtq61vhFbiZgJU2e4yFQjUlA2kSS1lJZHbeQg=;
        b=WgdfkHSyB8vlxt4xqpQIsbJm1sRfQBivEcQSFYMMAhRqWniSW+xrjvi8FAZANR69jG
         5CPHvrBZuGJXoMJy1qRE5jx66dE2KvAa8qKVsTwdf05brREzt43kIcPro/dbECumc6CM
         eHk0MrOA8zBY8daabsW3OzoRwpaC6pdXUOBOVWCijCXe8DZKbVWyI9Cml3BPxWD7w6vx
         Agg+3rfqTP0PWT7c0q49kja6SKRtEE/IWmmw6GoUrnHgM4T+m9dd4ZKeAECseApapq2c
         vvMnAb7yvsXWLpZD5JS4twFLUH17LZIB6b84OrV2r2kMIBEpH77NsZ/+H9AH53OnL/Hh
         km4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSIp463/jZJvtQm0zDlnZk7pO6FG97VwLilp5xi/rs1oddA/HQ4StT+x8jNn1Eb12gS4qicrHgle/PU58=@vger.kernel.org, AJvYcCXe/lcnh/U0IgdihmPbv5XYDXvIa6BWXeB/t6+BwMQU/UchlRYEN3RtGG2difCNU5dt82diPt2JkgHdHWa6@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCc89KQo91GFsZRMp1XHRXKQb40VU1cEgeHrPBNSoge0IDnL1
	75XClzG6KSLuxonlY6VFxL48m1bDuHqSKKvuG9JhV5qYJfA6RG0JlX4Q
X-Gm-Gg: ASbGncvkQ3tB9CEO5EkfGcQr5nCevOmbm9FCSISGYzhwmRh8FoMbtR+zPq8DjecY3PE
	3/fNNfIX3xVqE1P6nYsFob6GtF/droSXIRuudZovnC8E743uO0dXmQiPbGtvJnCzXy6DJ6Q/1fT
	hgaqoa4aV5l/fYeHgl6zSrtr+oK/v9+oyPtr63SwZBOOt8t7HOGZbf3PIOyXukqqa+MZ04vK51e
	5BCupF7QfpDQ5Bpiq8gMnGkIY2rQMHD3pQLVLMf7t5Vz+c0y/6C4pP8/nX2YuMR0dh5HiO2pp9t
	ZgegsOm6YT+U7Bm/1TWreoTTEXTu+SAyzjYdCU9KBYoFnbxM8u37GmF1YZsrpuS3HrBHjfzFEd0
	3R6B1RSbIQZpHdZAiKUNVk86Mkr4Iury/
X-Google-Smtp-Source: AGHT+IFkhQV1UBg/HGgQPjZmwpL6oJFcsdE9rfvijwAwk3sJ9O1FSEt3UsYnLut54YRvgLMgin34KQ==
X-Received: by 2002:a05:6a00:2d0d:b0:76b:ef8f:c277 with SMTP id d2e1a72fcca58-76c2a5166dcmr5622578b3a.11.1754517058417;
        Wed, 06 Aug 2025 14:50:58 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm16252258b3a.36.2025.08.06.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:50:57 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: abinashsinghlalotra@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v3 0/2] serial: 8250_platform: Reduce stack usage in probe functions
Date: Thu,  7 Aug 2025 03:21:32 +0530
Message-ID: <20250806215134.4921-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aJO9fnbydWqu1RpJ@smile.fi.intel.com>
References: <aJO9fnbydWqu1RpJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 23:39 Andy Shevchenko wrote:
> Have you had a chance to see Arnd's comments?
>
Yeah ,I have made comments on that.
Please check that and provide feedback.

Hi,
Apologies for not reviewing the patch carefully before submitting it.
It's 3 A.M. here, and I’m still up, so I missed it


Changes in v3:
- fix missing __free(kfree)
- mixed defination with code for cleanup attribute

And I will remember the rule of thumb to mix the code and defination
in such cases.

Thank you very much !

Best regards,
Abinash

Abinash Singh (2):
  serial: 8250_platform: Reduce stack usage in serial8250_probe_acpi()
  serial: 8250_platform: Reduce stack usage in
    serial8250_probe_platform()

 drivers/tty/serial/8250/8250_platform.c | 87 +++++++++++++------------
 1 file changed, 46 insertions(+), 41 deletions(-)

-- 
2.50.1

