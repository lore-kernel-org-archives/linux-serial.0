Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0338364E92
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978882; cv=none; b=HFKWjmc7Us8Pm5s69x2VRcPh3bgB4v6Ihx0UiKBbhH3YmKM4DHFbXbmSfd2GWClc8Q4JDGmyObID2kuKx6mCYdS/MuCKN9xRs2nGmVOsdlisKyUhfFN1tMHBrO5nx1TkD/bO4fzm2AkOmL44jY2/l9+O30vvOoOk1pOi+7e9mDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978882; c=relaxed/simple;
	bh=F7zcGk8nCH165bG+Lq3YX1vuc4Qm0989LRhZOuxR4Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lq2OpxqT3Isjoa7fN1DNZIl/Bj60PApp1O9mX6+jxIhJ4l9bF1iBN38rgRO9lXuOA7UM4P70TcyB8s/qMr04SpK3tpdxjMkYvHzQCDrx0OI9KqCIHWdqDCVKbMxs+GmWI5FULggVYpJOSgn580gBCaz48WUVDRyiZSwvECV6BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwcdQIEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwcdQIEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767978880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSDwbxYjO8+HiZzQaZwthav/1dzwRPtawpHAGU+oOsQ=;
	b=dwcdQIEgLZjsyxB7929jqU6zWOZHNnyKRvoHVZ5oS/AOk2Ev4+Fsfa2gNy15Vf6kmWy8Ym
	7N2TEN/XC2VXXCmkMRSZDfGuwqhKVyW8lOmfJlNDrSYx4oufL2Fd3q2XJmVqn1V+ZV4Mnv
	9MNSLdNdE+Ak6Qm2KM850SZ28L1/6nc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-DV4FsymBMICsZlVgup65-g-1; Fri, 09 Jan 2026 12:14:37 -0500
X-MC-Unique: DV4FsymBMICsZlVgup65-g-1
X-Mimecast-MFC-AGG-ID: DV4FsymBMICsZlVgup65-g_1767978876
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b22d590227so552089785a.1
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 09:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978876; x=1768583676;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSDwbxYjO8+HiZzQaZwthav/1dzwRPtawpHAGU+oOsQ=;
        b=G5IqRn1y8t68UcnAVssZ3eN81sbColoK5kWKgr4pfxYmiWid9bfxLkMNSb8RSqHHYY
         n4YV7kBBMqmgQuxJvsNklfchb093k9tD/S2kSyNY9NDw/lSUfXcZMMzh/gRH5Fcrp4h0
         2EZRSiKKB/FeutLou9jZZyTyxVv7BgwbbOAKWvnGCxLLaxu/J1RIgxWo2HiHnQdvryaV
         +eVC8F0N6W/JiogJaXMljozA/3X49uYNmk+rykDClgjnDLyRUnfbW9Hqz8CBb1yak6xM
         lSmLyZ4xJiSTZAiY/mbme8iYGVXabs3AVvI6rS9TH88DeYRfWBVocMP6p+9Dmo+Zx/4u
         lwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM9sKqFLQpgoP+mgRrv05wX56RWXdmZIQCh5IJZXJece1HWuh7pfBv31QFfzs+V50Gpa6uP9RF8gMN92U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+IAMXDCt9WgzRnzOu17rgJs1LZ43Bcrwce5wGHxZimxPg7Vr
	+0Oa9Ca+Z0Szt/2hI/3xPKGe6TReqTE/JNkcvlwhey2eteo49zKkWXM44n/nX+ZwoeexnmLC0XU
	0jPYlV3f64oj0aKjj6PAXm7ypstWtU2pGhneEC1JWNHI1v1cP/R/uflQqJcTjyDHQDA==
X-Gm-Gg: AY/fxX5dPptg8qBfRgXkaKy4rhapZwP70V+xyFjkKsO0lZEhlVP7+CxilgkFyZpe3TV
	T9AiYvaeVoi2iwlLvEhnsLfgMT6PaVIs4Ab5fnLUVg44dwloP2uLALQhUXeUCLhlgE0Ce7rtvcI
	b5c7bIT3WzbF0KVJyfSzasITLQz4hy064ldeHoXfZSBDbXZRTziHAZhiex3w2O4B4RpbqIUQJlX
	KBK/Mz9zgpflV64EKnJWcVZUwSSfj8PIXTDrRZg1SR/K6w7koaLYbJxRJHosgniWJQmg4o9yzsj
	dVSNJzp+gUeenMbbv3otbqo0xViLAhMgO5ooi05uvFaJsCaDIkoz4iAjmHfFzoDFFl/SreDhPoV
	CdkHnpZSv6+eoOydRXcuzBcf2L3Z6G76EHmfkN2A04ZdD
X-Received: by 2002:a05:620a:4109:b0:8bb:a675:aa61 with SMTP id af79cd13be357-8c3893fbb30mr1217151285a.79.1767978876340;
        Fri, 09 Jan 2026 09:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHotayWWfWtWeRCvw1eejr8Fm0argOz9TlIuQkrGTqEF91Uo7p3dq/qiwtr88DHNoO1lgXL4w==
X-Received: by 2002:a05:620a:4109:b0:8bb:a675:aa61 with SMTP id af79cd13be357-8c3893fbb30mr1217146085a.79.1767978875890;
        Fri, 09 Jan 2026 09:14:35 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726041fsm82384206d6.45.2026.01.09.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:14:35 -0800 (PST)
Date: Fri, 9 Jan 2026 12:14:33 -0500
From: Brian Masney <bmasney@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/13] MIPS: move pic32.h header file from asm to
 platform_data
Message-ID: <aWE3eWL_8U33TcsT@redhat.com>
References: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7gUiOR-B-0Ul599H6fqU6uLFhd0vKK6-1KpgwXzzI2M_1767978876
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 11:41:13AM -0500, Brian Masney wrote:
> There are currently some pic32 MIPS drivers that are in tree, and are
> only configured to be compiled on the MIPS pic32 platform. There's a
> risk of breaking some of these drivers when migrating drivers away from
> legacy APIs. It happened to me with a pic32 clk driver.
> 
> Let's go ahead and move the pic32.h from the asm to the platform_data
> include directory in the tree. This will make it easier, and cleaner to
> enable COMPILE_TEST for some of these pic32 drivers.
> 
> I included a patch at the end that shows enabling COMPILE_TEST for a
> pic32 clk driver.

I didn't CC everyone on patch 1 to this series that copes pic32.h from
the MIPS ASM directory to linux/platform_data/pic32.h. It's available at
the following location if you want to see it:

https://lore.kernel.org/linux-mips/20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com/T/#m1e0e50adfe2ea4bf430025660fada7b1468d0fbf

Patch 12 of this series is where I remove the asm variant of pic32.h.

Brian

