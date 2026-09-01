Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D2386C20
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270533; cv=none; b=Uf7pKw/T+FDWZ2lLzceGZ8I3JSxIB+8iZ5DMs5KbN22oQDQ/3xYElRdpa1QB/Y0LYQlacNMISGIlE04v8GQflPpgMARRsz6XiLvR1rTxpj2ge5g7/AWBLk50mmhbaBWyjt794wct+a03SD1WxhUjST4YlZW0y2hysM9G/lOvqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270533; c=relaxed/simple;
	bh=FhGox9gXqmh4I7C5JglwAnrOhoH6H+CLn2mkAQ+mXqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/cTu5VDuwn2xio9MArozHu2pbSH5+rx1fRzhxCi+7bpgQ4uK+aKvss/4l31FFke6tG0rnlB9s26OXgTwuXjcRzGEOn3Tf51OSrx0hd+9HQ0HalwUFhrkZKr/n2MLSUUU/X1yBXmxzUp/L+YKAaKY4tmN76yn0bKE322TK1Xj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRwRh/z7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRwRh/z7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441fa5c37so732345f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270530; x=1788875330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTQx2GsPa85XjvX9iVGk5mcgWwxcHbSTKInQpmNkpgQ=;
        b=pRwRh/z7/Owf/eTBs5AAF7tg3JvZzLsXaYx30TPMVj2/cc0vOdd4KzMs1cTiuIpgrh
         7fO8ZScGwGw2vzFvXiRga6sPAnRiDQP0GfcnjgluYzQ1uuY0LXUqMpnJq0uVycECql2Z
         +QgLWvNqT7bGFFRp87aNuB4JphLK0h2+brfqEFbQWmGLBD4Bu1WQv/9tGkBRHa8Es+0U
         xrYYqSuAB7LJ66DAS3omSCfk8lBczdLPSxNsdQ3EAN16HgpdKA+X6hHMhrPMXy82nAJ5
         7Jkc57FvutklxQ4kbq19B0JBmTHxvqkECIJZ8JOOzM51SNQfx7oKF7s1SkDTgmebcIBT
         hZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270530; x=1788875330;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yTQx2GsPa85XjvX9iVGk5mcgWwxcHbSTKInQpmNkpgQ=;
        b=BJwK2zPquykyvMAIeM4GqQdbdhrAmtnAYWHddWUxxii6oWQ6POzTVHibS/IulPBS/s
         yrQc9dJMU7B47HKXsF+hEKq75Vlqwi7NHgmIj3MUVyqYoezNyR4UJSo6LbAOnA4MGJPI
         SXykrkNnu2YMgtGFN1EOVSZnlsTtnih7G7/99EucHZrBev2udUcNP69e/HMDF50/1MRK
         V/FAKiRndkldEodnKAdWwCyGQbEFLkAm2dXiXN99hG0qyJHEZiozldtVjQgLrsCfyhL3
         ACbmc7cNKPmH3fZHafRf6TtSXTiGoloT0vMLWjRKgJ2cDD5uKdYNxu6HLEbRXHVaKoAT
         s2tQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8l6fxhGzY28+RF0+32ENO9ZbmGNQx4MXx3Xhu9JU1su1h2r6uGZGsYtweVnheZ+k1F2bwGFsn7u5132E=@vger.kernel.org
X-Gm-Message-State: AFuF++kbzuwOH/6rkQSZX7i4B8GMFn9lL/N3ewampN1hWphocwn8aEV8
	lUHghm1pfXfGnSovJOdrWPise4LoSAs0bxAhU/9Vj1N4kU4FOMwvm86S
X-Gm-Gg: AYBFou26gAmx/O9CKdm59dxQB8KEuRIhzjcrcvXbWNBL9HLnC8gPtsVBclDwksRT13g
	aC2Gj1lmKjJCu95U7FhMRu1uclJH+7PdMD9AgKzdu7GKcNSsKbDCoS4Cs3tHFaPxCDMdaT6oRdj
	cgr2/We3TDbHaqcWdGQGt7gJ5bMc+XoPjpihMseMG7x3vykg9uguqqbslXHMfQtFhCVagHYe9Dm
	yMBzI8dRHPuCchvvVvSXAQAi+fH09ClqJIhUVtkMNsV+BK3fwOZ/0zMllCM+nDugyBc3+o1QYh9
	fZlRQ6e/axoTkbn0k5NdZ8mUfMwAryUpywr6aIyRpdNoJZifjsPh0N0eZJ+5ruqnnd/UWwg93wc
	zGeuA/kpUSacfgdE0kog5V2OYHDOu+s2EjFk6RKMlQc4GhwD8scusQUW94iJrXBrznvVFISkofD
	/0j9Oi3KMXKe6Ql8XKNLCvo+ysNRoFZRyBNpqBhe5iaP3fnMcfaeAks/tGuBEdx1C+D8dKTj0lo
	Ai+1BT5rO9ZLmlGOQqs2un0SBVOFlY7Fg52QugFGu5UIisG6eNRORZM
X-Received: by 2002:a05:6000:4010:b0:482:f528:be4 with SMTP id ffacd0b85a97d-482f79bab3cmr50727081f8f.16.1788270529641;
        Tue, 01 Sep 2026 06:48:49 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3b4f1sm4512147f8f.9.2026.09.01.06.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:48:49 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <0c445767-a4fa-4c44-b81a-64863be3de2d@gmail.com>
Date: Tue, 1 Sep 2026 14:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: fix extra output from savedefconfig on
 out-of-range defaults
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: nathan@kernel.org, nsc@kernel.org, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 hongbohbli@tencent.com, guochunhai@vivo.com, michael.bommarito@gmail.com,
 kees@kernel.org, vegard.nossum@oracle.com, sam@ravnborg.org,
 u.kleine-koenig@pengutronix.de, mmarek@suse.cz,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, mpe@ellerman.id.au
References: <20260830221129.2668354-1-julianbraha@gmail.com>
 <CAMuHMdWkPtJinDa10S_r7Pj2DTgcKpwgxt7U3tqm7fnSwGxm-Q@mail.gmail.com>
 <CAMuHMdUywobKkt5Zozh3GdOW57nF_XhydJh7PaqTBoGB-2XvTQ@mail.gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <CAMuHMdUywobKkt5Zozh3GdOW57nF_XhydJh7PaqTBoGB-2XvTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CC: Arnd, Christophe

On 9/1/26 11:17, Geert Uytterhoeven wrote:

> FTR, this will impact all defconfigs that restrict SERIAL_8250_NR_UARTS
> to a value lower than 4:
> 
>     config SERIAL_8250_NR_UARTS
>             int "Maximum number of 8250/16550 serial ports"
>             depends on SERIAL_8250
>             default "4"
> 
>     config SERIAL_8250_RUNTIME_UARTS
>             int "Number of 8250/16550 serial ports to register at runtime"
>             depends on SERIAL_8250
>             range 0 SERIAL_8250_NR_UARTS
>             default "4"

I suspected that there could be some cases where these out-of-range
defaults were actually accidents and causing bugs, so I added a check
with my SMT solver [1], which also detected these two (powerpc-only):


  config DATA_SHIFT
    int "Data shift" if DATA_SHIFT_BOOL
    default 24 if STRICT_KERNEL_RWX && PPC64
    range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) &&
PPC_BOOK3S_32
    range 14 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) &&
PPC_8xx
    range 20 24 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) &&
PPC_85xx
    default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
    default 18 if (DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
    default 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) &&
PPC_8xx && \
      (PIN_TLB_DATA || PIN_TLB_TEXT)
    default 19 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) &&
PPC_8xx
    default 24 if STRICT_KERNEL_RWX && PPC_85xx
    default PAGE_SHIFT

  config MODULES_SIZE
    int "Size of modules/execmem area (In Mbytes)" if MODULES_SIZE_BOOL
    range 1 256 if EXECMEM
    default 64 if EXECMEM && PPC_BOOK3S_32
    default 32 if EXECMEM && PPC_8xx
    default 0


The DATA_SHIFT case may be bug, where it should be 12, but incorrectly
adjusts to 20 when:
  PPC_85xx=y

  DEBUG_PAGEALLOC=y

  STRICT_KERNEL_RWX=n

  PAGE_SHIFT=12

The MODULES_SIZE case seems harmless since the only systems using that
option are PPC_BOOK3S_32 and PPC_8xx.

Anyway, this change to savedefconfig would also affect those 2.

[1] https://github.com/julianbraha/kconfirm/tree/smt

- Julian Braha


