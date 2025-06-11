Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375CA21B19D;
	Wed, 11 Jun 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623633; cv=none; b=L4ot+KloroqEc0IXgEd/XRYMtvcc5MN8jtVupeoacxHMMFcSp2O1hYlbg6JyR561cZm05tDYD5zH2b9uFlhytdV11CQsZOi9IHm4bhHCRaN4Xioimz0qy+Wu2fLqLvtlHeUo6+bNJzyDMQRtm8hczRY/O6EoAZYa6OgZ9n2OeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623633; c=relaxed/simple;
	bh=Mh3IBAJJLPsihFnUd8lzghlKsY+ledSbMenVLAl8F7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRMXc4qhnulW4xk71ZPDNl5IGeZHHZ+dufNPasjggpGuwmwSqXvOf7rbmc9i31V666u+7kvWYoeFX7+CUs0N0BW4PLiXokNpykZ4qgpl7rhRi79yiLt553VSZM3ItPY6+rFPwGz7VKlUaj8mseFW/FhLibqc7d4eTaWK3vi9fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoHhrVry; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoHhrVry"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f7865b22so26283f8f.0;
        Tue, 10 Jun 2025 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749623630; x=1750228430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi53fMKD3cKJk5G9CvrhErtFN8YzIqzdTSF68BonW+Q=;
        b=CoHhrVryH+2OkpVXuk0orGcliGcNQOJiMXp9G5QCwtaF4z3MOTAAUL7ncijbzDk70o
         spZAa5CLVPPhUm2NQHB5XTnmd0cMvYnAs35UwZxx5YKLczRYmzX2+xEs4HeA3Yr9inXY
         XrDy17n75s3VZ+1b3MPyRRbGwNzZwI3jtJ0u7mtdhTnUjuUYA1okBGiQcao0Yc/QQ3LJ
         GTFelb1yN9pVWfEHYjjrsxXi2hMCPPz/Cf47jy522UwcOqpe0+YCLaNRcE4ooZEeqgIN
         gY4O3xqqpEJ1RTAyHY/P9t4n4NCLmmuq/abnhM8DvsMRBCKG9Gcwr9ioT+bLGAOG85Hj
         DQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749623630; x=1750228430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi53fMKD3cKJk5G9CvrhErtFN8YzIqzdTSF68BonW+Q=;
        b=H2cF5RtKWoRP+cfveezahMJTlVwTjZXcpFOBdg9jXGR/ybIkX30TkVbTnbS4PU2prv
         xG8pPzw9aAO+sVAvos+rP5RlQiaNCrB6EbPdtA/0yt0hPd/SRITPvjSrlQseUHb4Rp61
         9xLr/7Gx1gwdW6zeMRhk8OzThoyXrL1ubTIKh5emnZnty/MNDWc1HrY7OmV31FDc2YQ+
         4s62GWy49g7VueRnuaAS/DQ2JRRmhsCTsZggb9v5cJy9PjWw03XENv7aNkSaQJoaShri
         K7uh1mGBRFrWj/KuSdgawzxQRyv/jxDHyoUDqGHMQxisU0DnZkvmGRfWT7LtyG/Yst0N
         NHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR2ZmYy4LVJXhIKgMCoXg5AgvT8FAD0GB6yGF0bWtiZYJ04vjtI2zXTjK6/Ap+dL/YRJTwbe3J/2GbA1k=@vger.kernel.org, AJvYcCXBYP3quec7Y3tU8HtHDHACo5w87Z1+mAIMAyaXaFWP7ymgg6wQr3UWiMBvulZF5obaqDTdi3rMZHaDurIg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzffa3vC3FXhCcHAty34YpIt/DEQ9iFQUlHYx0dbBNhtZCtiXiv
	Knp6fuADtFAqUhmUCy7XzbawU5+SWxyEOosiwNl4QHtmVTvweul+vc/1
X-Gm-Gg: ASbGncsqck1fYpsqgG2ZFz03DeL0x7DZg0fumG+ciARwA1vBoMyeq/uGZJtifnLmHw5
	e86aecyDqWBOKNp1rlb13nPvwmgQ8axFjrD4W/sEWZlY5Of1fMc/ewzTrToxIS2RRIOYh4mKKy8
	+7vJ0/Ae/MnItF4C47EvysMz/cJVxd9bjzC7y5M40XIzFc/XMiMp+QOspJ3sDesXJuzLL2u6ilM
	PCYnh5ggQJrXFJD48S6ZWX2NEUZSkqh2uZprlcoShU5AM4I5jvIDkM0l7CTGdMHwyM+5T50XRhl
	S3tH5qtUSovqJs8NRZrLzG2HSCcmq+jwhV1adeXrhmXI5PvVa5Bg8qZWHuveOOqhWaFltA4iSfS
	ijNO2g9M=
X-Google-Smtp-Source: AGHT+IHqzA22qfVooFHgPHYXbsp7freFm89h/OzXJ7nibh5EChOXLAXLUwkTVzWLKe8uuREBQYZA1Q==
X-Received: by 2002:a05:6000:208a:b0:3a4:f7ae:77cd with SMTP id ffacd0b85a97d-3a5586bd8e1mr443311f8f.1.1749623630296;
        Tue, 10 Jun 2025 23:33:50 -0700 (PDT)
Received: from DESKTOP-LCRLR8G.localdomain ([102.186.42.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b653dsm14364226f8f.39.2025.06.10.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:33:49 -0700 (PDT)
From: Marwan Seliem <marwanmhks@gmail.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
Date: Wed, 11 Jun 2025 09:33:49 +0300
Message-Id: <20250611063349.25187-1-marwanmhks@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607151957.222347-1-marwanmhks@gmail.com>
References: <20250607151957.222347-1-marwanmhks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Jiri,

Thank you for your review and feedback. Let me address your comments and provide more context about the use case for this change.

> I must admit I don't much understand the purpose of this. It can be
> spelled as: you can crash the system only by sysrq-c from now on. Don't
> use sysrq-r or others. Who did ask for this?

This change was created with embedded systems that have external subsystems in mind (like modems/co-processors) where we need:
    - The ability to trigger a full system crash (via sysrq-c) to collect subsystem crash dumps
    - While explicitly disabling all other sysrq functionality for security reasons

In these environments:
    - Crash dumps are essential for debugging
	- Other sysrq commands pose unnecessary security risks

> These inline #ifdefs are horrid.

Agreed. I will restructure this.

> This can be invoked from userspace. So you can nicely DoS the machine by
> the added warn, right? Hint: use ratelimiting.

Good point. I'll add ratelimiting to the pr_warn() calls or we can consider reducing these to pr_debug()?

> No need for this return ^^.

You're right, the second return is redundant. I'll clean this up.

> Is it for real?

From a pure security viewpoint, expert advice is to remove this Magic Sysrq functionality, 
either with kernel.sysrq=0 in sysctl config file, or with a full kernel rebuild 
with n value for CONFIG_MAGIC_SYSRQ parameter.
This patch provides a middle ground that:
    1) Resolves the Core Security Conflict
		The CRASH_ONLY mode provides the minimal debug capability while eliminating:
            - Register dumps (disables 'p' command)
            - Filesystem operations (disables 'u'/sync commands)
            - All other privileged operations
    2) Security Architecture Benefits
	
		Traditional: All-or-nothing  
		│─────────────┬─────────────│  
			Full disable			Full enable  

		Our Approach: Principle of Least Privilege  
		│─────┬───────┬─────────────│  
			Off	Crash-only		Full enable  

For v2 of the patch, I'll make these improvements:
    1) Restructure to minimize #ifdef fiasco
	2) Add proper rate limiting on pr_warn/change it to pr_debug
	3) Clean up redundant return

Thank you again for your valuable feedback. I appreciate you taking the time to review this.

Warmest regards,
Marwan Seliem
