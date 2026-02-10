Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9601E5B70
	for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727354; cv=none; b=eIsfoa2eLBzT8waLXEPrWL2kKED9N8D/xgtSLMPfzajIfAuUgKyA8vtQtD1+4hUEUu1GRsMtbUr9OxM6YIh6UlNfW8roGsPW/G+n0OcZRnQ0b+eoObmqvh3AS1VOm2bJgl2wxWRB6xOTvCxCsEiz0W3r9L5tOBfNtw44ejmQUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727354; c=relaxed/simple;
	bh=GlKpwAqt8FXcLxnYzpl9cDfIBN0bnkDbFsP/hLk3P+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JIRgCtHa07mL0IRbaqcC9/qTTIWxdwv5y5cXVtHvqwDwxgC6YWIVYF2qYPNGupmk+8x29KcX4ntjxD8ghOT+pD9ALMgBqtINBhJux9WEydqpj4gMab3mcEBOa1o4hYulkJ1TleHsYk9wKucvmAz3WJc7RB1n5rdy77FU36MJdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avqFO5YW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avqFO5YW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770727352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WIPR0mr/henT5bqfT/DKonkyulUdL16MgQRnA6kCJNo=;
	b=avqFO5YWRXcJwQRlfEeF/a68vHabKfraYlG1Q7XQwTwtF6uFLj2EL8xl2jh07yUkfXu+uA
	KSleiPYhhlfbZWYia/5QrtWEBY7vGGq9+he5b2uFuDq4+vwSdaAxcxUeK0n5Ck6IsXIrW4
	JKsdzH+Amh2i7ClFfj74Jw7pwiJJUgA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZtePo0cJP5aLbygNkjTvCw-1; Tue, 10 Feb 2026 07:42:29 -0500
X-MC-Unique: ZtePo0cJP5aLbygNkjTvCw-1
X-Mimecast-MFC-AGG-ID: ZtePo0cJP5aLbygNkjTvCw_1770727349
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8947d47793fso257694996d6.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 04:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727349; x=1771332149;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIPR0mr/henT5bqfT/DKonkyulUdL16MgQRnA6kCJNo=;
        b=rp640MvgQR/lsphoRruWKNNkjmk2B4VRSHfGxO79mUU15c1otBnqFhtC2meTSFO2YL
         Lbpfq/nWss3MaOOR3BKcT8Dvboe2S6rSIxFsOcj3tf8cfhAv6LViH6IWqhVavabRzYPl
         /K+7+bvT3dqW8uY/bynxlRySTjuzyxCeI6BOtLCpy3qvFsw1kgv8mQr9RqZB6nx8Vovk
         DG+j9tq8n1FlKH3Juon/zFwYRsbbkRBqmOFzCaoydA90GY9ieJNeDljB8QHRccLkPMvD
         PGuY8Nh1rkZXSPe/Oj/tYG0m72vNW8/ko+xjM3Z430RThdn8eHejgY2yU0WBK3btm0xS
         ML8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfwWjmcEC6vAZfa0rvTM40wYo0tST39qEXu39iSjbnEWsJcUvCTULPKVlr+LWTOV5lCnl5Uk7liDfMtlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHZxzBZasRFlMmQA+MJr3TgyZVpp+5c3mqNjDARvtuHPmHzYe
	1WE+xt6mBCpSkHnyez1aH3U2NNuOVNUAxzMwry6/xuZm7ZioD+3TVftt3YxPlQ7+wXHRntsmopk
	Zv+mwoi424RblbvthC00Vo8FfrGuGY8ewNUGJe5lOq4nVj3DT7X7Hd8BmiWXVRv7/rA==
X-Gm-Gg: AZuq6aKoPUjsDKjf4JJZtQ9ur756Sj+/HDvaBBp3g1eglP1Lm03JJBghptu4Co4viB7
	SdzmBu+cIRI44sYLsPzipZceryVohfpWolpJ880aWZ2AzrWyw7HZWL8IyANR9zCtX3WOI+tkusq
	sZ6g8QHz9TE3+M/EBf3T0AUOUfHb0kmYHc6Pv2U517yOgNe5F7ioD0UQrcxeuo8lP4lB7sBLxaW
	bThxNfNdATqw3IbUwuYDYcHy5NmCz7fYDo0cJV1OSP/EATexECP0tBqEQWg9mjh3zeCF54uEhvc
	2aJgrSPeZbBUuLFUCXOREj7V3f+2RSnFeDvLubEwe/ERawgxWwGZJVnqvRZS5kKIrwfk1XA8FC6
	eWjEaCMgmMHOWDjj/3CS1fxMhF5G63ErQmrN9YLt5nZtEWCFnM1kLE8VN
X-Received: by 2002:a0c:f952:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8954cc28dc4mr97314086d6.48.1770727348937;
        Tue, 10 Feb 2026 04:42:28 -0800 (PST)
X-Received: by 2002:a0c:f952:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8954cc28dc4mr97313856d6.48.1770727348578;
        Tue, 10 Feb 2026 04:42:28 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c0599b4sm99582176d6.41.2026.02.10.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:42:27 -0800 (PST)
Date: Tue, 10 Feb 2026 07:42:25 -0500
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
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH v2 00/16] MIPS: move pic32.h header file from asm to
 platform_data
Message-ID: <aYsnsecPa8bWMbaA@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9NqlLJyBo4cwo64wdn0t9om6gZbEKHPDWsnvw2u59Fw_1770727349
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

On Mon, Jan 12, 2026 at 05:47:54PM -0500, Brian Masney wrote:
> There are currently some pic32 MIPS drivers that are in tree, and are
> only configured to be compiled on the MIPS pic32 platform. There's a
> risk of breaking some of these drivers when migrating drivers away from
> legacy APIs. It happened to me with a pic32 clk driver.
> 
> Let's go ahead and move the pic32.h from the asm to the platform_data
> include directory in the tree. This will make it easier, and cleaner to
> enable COMPILE_TEST for some of these pic32 drivers. To do this requires
> updating some includes, which I do at the beginning of this series.
> 
> This series was compile tested on a centos-stream-10 arm64 host in two
> different configurations:
> 
> - native arm64 build with COMPILE_TEST (via make allmodconfig)
> - MIPS cross compile on arm64 with:
>       ARCH=mips CROSS_COMPILE=mips64-linux-gnu- make pic32mzda_defconfig
> 
> Note that there is a separate MIPS compile error in linux-next, and I
> reported it at https://lore.kernel.org/all/aWVs2gVB418WiMVa@redhat.com/
> 
> I included a patch at the end that shows enabling COMPILE_TEST for a
> pic32 clk driver.
> 
> Merge Strategy
> ==============
> - Patches 1-15 can go through the MIPS tree.
> - Patch 16 I can repost to Claudiu after patches 1-15 are in Linus's
>   tree after the next merge window. There is a separate patch set that
>   fixes a compiler error I unintentionally introduced via the clk tree.
>   https://lore.kernel.org/linux-clk/CABx5tq+eOocJ41X-GSgkGy6S+s+Am1yCS099wqP695NtwALTmg@mail.gmail.com/T/

Sorry about the duplicate message. I just wanted to reply to the series
with MIPS in the header so this message isn't lost.

Can you back out these two patches from your tree in linux-next, and not
send these to Linus?

clk: microchip: core: allow driver to be compiled with COMPILE_TEST
https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=026d70dcfe5de1543bb8edb8e50d22dc16863e6b

clk: microchip: fix typo in reference to a config option
https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=a6ab150deb4b740334721d18e02ad400a9d888f5

See
https://lore.kernel.org/oe-kbuild-all/202602100954.BAVYq6aC-lkp@intel.com/

All of the other patches with the include changes are good. I have
patches queued to send out in two weeks to other subsystems once the
include changes land in Linus's tree.

Thanks,

Brian

