Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8243C8C5D
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633568; cv=none; b=u7p2pP8L4WYFbkjLa8dy0St2WikcEyHv8DUUQSo38kjF/Um3B175ZiOkqkrtuMTirj0ReRVVRn3kOQZbSM1PvSADJZv3+Jvi34NgP0m2lkvhW2qiKLBuTNU3IWOwzEPZIRZNrHHHMCB09A4Rgtn6Ae0zzl/POga/1bX6UT119XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633568; c=relaxed/simple;
	bh=MXG6F+XOaJjTHz4SHrXau2henaRyFb9pRMsdcqxvSUQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlYumlB+QYUxqxquJdB3I/3f4NEebhtlcLFvfcgBpCsgcZGd+t9LWOAAabyV+nVIgbDa0OSsbOf6TMXxnSeFK52ZKyuCugndy0rE58KMRcupbWiX2Q3Yz1MDToU6SYgqYUq5QabskXnj+8SlcSrU39n2gJ4woTA7WF1eM+mV1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMPFIP5V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMPFIP5V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so231193f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633566; x=1784238366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VkbACm5M+XrCUV3Z7NNaW5IbCVSb/enbC9nT9Rpc0jM=;
        b=VMPFIP5VmYlPsYdxH/RzSJ6YIXQzfqwwW4TxGyWMyNeZJmO8ZBRMeZAfUmud4k3ZUU
         cmrDSyB5V1N8jey9jGLTwytFgVx0mzGCAuxjMfbsTjC5XITv0HadgKAdwgr1fGNtXE+f
         dABxE6ik17BUHEPzQTfon56MxZsKBWFr9NXRZP310hRtR9kwsF6vZR+YSwdAK37qcp1t
         7SnqFISUE5EAfyIET7Xb9vDHYBwETw9iHVil+492YuKakTW5Cg7qA3KGbpe/Qjfme1+a
         GgZN1BracjpPpnZJwiimk/gkL03jSUxdHwZLnHLD3qqL/U8jccLENEbyEHeBFLFeltmP
         IUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633566; x=1784238366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkbACm5M+XrCUV3Z7NNaW5IbCVSb/enbC9nT9Rpc0jM=;
        b=gjOC/6KNsW//emyXn8IAwi8Awt6YDQ1xIh3LysdJbBK//1omHoDmdsroOariijuvZf
         R9mNXsuDvI8xmTWm1SBUKZSHvHIZ26V6CORJ+whG9oRWJUs1RTgPbubQjRDyYHRgUcP3
         NgdxkpfaKCQ+c430I1mY1bU2gTjmkz18BzlzcQrciI/ZAYUhk5EhLfpbGWGcls8nTHVi
         PSytx+S4xNgABHlqRRKRbTb4CKP/kGmZZ8Nx5+KWqP4dwEhAhEcB1SseCJjzafhUL2R0
         SqvIpQWy0CSTQiK67L+4mmccw5zB48iIkHPobaxGPBA7vWzlwjKB9GngHiVcrEouNquz
         jrFg==
X-Forwarded-Encrypted: i=1; AHgh+RrOeVex0m4BiIzhijVXcNqcNvPfvoWzfd82BXIZnGq9WNPSt/a2gr/mVN/sFkaE+8nI4YpkvSjQTOqXXd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ66E0NoDf52vPRj6IPZR1PzNXkJoLCL60JZB/FRVzNu87qvUy
	FWNIVS8CdrfWC50+Tp9xZl3RwLfpuRQ8f0k5k87HowXJ1PqkSWMW8s9X
X-Gm-Gg: AfdE7ck1L1vXjIYbFVnNDYATC/jMilxboZDMVvbZ1hmPSjtilZOVjz2gBO6qcftCO9o
	TxQX1e3szYsvzae1Aro1Lm410HERlYVwQ+FXc/XNK9Q1fmJJzCVj/WwP9/Zd7u9LDBCXZR2knje
	DCVXq2GTdCE78AEg0k0omys0apI/lFbpHktB08ycWAw90RBjOfCa0eHeiRqY4H52vmw6Umjmm8b
	FKIeMztODRlEn/I2CustM1TTbkO+6JoBXLTzX+2ZcHZIrjZBdkdfH5RlfU+942ZWWn/xIAV4XmS
	7x/NWo4HYI0vnlCwssIXzd8MJJuTbiI2ALUN80oas2lE9yLhRkBX8zehi67xlsnI7jsDp5z0osO
	LjrDZPb2GXkexWDU6bs1mC/yyeJblF77jJK6QHtZsd0Iy1ANXJx90xNIuzj465esAKbdb7qbcQl
	C+I9jIRz1EHHKAMOuWdrEgxYsefZ2Hi8IOZAZ54uTC0H1+7q0oEg097/TARmJIVAywDqIXTpfGJ
	g==
X-Received: by 2002:a05:6000:2385:b0:475:f0f0:9ef0 with SMTP id ffacd0b85a97d-47df0782dfcmr9126719f8f.53.1783633565738;
        Thu, 09 Jul 2026 14:46:05 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm55980888f8f.0.2026.07.09.14.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:46:05 -0700 (PDT)
Message-ID: <6a50169d.41a38e5f.1bb169.a6d5@mx.google.com>
X-Google-Original-Message-ID: <alAWmmBXI7S1QUG_@Ansuel-XPS.>
Date: Thu, 9 Jul 2026 23:46:02 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] serial: 8250: map UAPI port type to internal enum
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-4-ansuelsmth@gmail.com>
 <alAUrANx15gyOgdZ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alAUrANx15gyOgdZ@ashevche-desk.local>

On Fri, Jul 10, 2026 at 12:37:48AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 10:56:51PM +0200, Christian Marangi wrote:
> > There is currently some confusion when a new 8250 UART device needs to be
> > defined with the related index for uart_config[] to be directly defined in
> > UAPI header.
> > 
> > There isn't any specific reason to define the index directly in UAPI header
> > unless it's also needed to be defined for userspace usage.
> > 
> > To try to address this confusion and making it clear how these specific
> > index should be defined and where, create a dedicated enum in 8250.h
> > with all the current defined values in UAPI header and document how these
> > id should be defined.
> > 
> > Rename the define in 8250_port.c with the new UART_ prefix.
> 
> This will bring a wide field for the all possible conflicts and doesn't really
> solve the issue. Why not simply kill the UAPI part of the definitions for good?
> (Move the all, except the first 13) to be internal to the kernel.
> 

I mean... With correct review from maintainers, conflict won't happen. I don't
feel it's that easy to kill UAPI header... userspace stuff and we don't
kill userspace.

The previous suggested solution was to stop declaring stuff in UAPI header
and start declaring in the internal header making the situation even worse
and error prone with id conflict. This can really be prevent only by
correct review of the change. (or keep using UAPI)

Maybe other have better ideas on this. On net we have a similar problem and
the implementation is mostly similar with duplicated reference and some
BUILD_BUG magic.

-- 
	Ansuel
