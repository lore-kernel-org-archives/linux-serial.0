Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842952;
	b=WOwm5+KihF3dUFx/Umq5sBEIbAJiTbbq/A6U+oQ/QNgDdLgJK4jZISxgts6Tvmw8w5AM
	 ebLcOj9QMmL0OCgX1M9TRAS7x1OFvEQqSu86UT07GDfmDIGVFVPm4EkeUkaMNQY6Qh2Td
	 ps3wfndEkiM7s6CSq3v3VxbnoxQhg/bZZPRGqlYU39ZnQXI6mNuv2UCfuRuMCq5SV0nFZ
	 77okqet8njb2XSFaDAb2VGCioBqQhYnD3KjB66d/PyVDAMYdE2/1iVvu5M5mTmNpouYpJ
	 mT0i/Vz4mQ7tBC254RvtBfJi0nEOIbL8VtXzxmSLKjXVt3ZUDavisYAS2TcCkQx2l8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842952;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z9y+op9MwcAYKiVxV6x1Polc0TJVtfhV5fChD4LyxGU=;
	b=AGQOwD5D/fZ49uGx2bIJBEHDgYO65zStbdCcBYUYQ3XWXZ9vCbWNSxQ3FwcSRHEU4/SO
	 9oljtESCicldZp0GeR5ioloKS9QGGN7GLBy5+0wriZuyziM/gLSTQj70ZZ6zFx/Pqbj1V
	 +GFIRSnwhuvWHLy63VWnNdVeWXMmoJ7rEJK5V+Q72sIecotEKm5rCAYa9U1WjMLf162fo
	 xCFACxjWKAGIboq2RaIuB7GoEfPF9CG2AeTcM7avYvKQBq4vwAvb5Rwi5NBzqLKgBByoS
	 sNkCZlJ6n83Mzhzd1qW6YchY9NPWt0m7Y8JUiFH0AvPdFkk9kPDxut7CpmcTkS6OwRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=RzVtavYk;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DD606A32C
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 01:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E4DD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=RzVtavYk
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90BB33FCD8
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793842948;
	bh=z9y+op9MwcAYKiVxV6x1Polc0TJVtfhV5fChD4LyxGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=RzVtavYkE/LBMxpLKB6QGcQKcna+jHZBHZlBmThLYzqMGoIRU3ImDyxu0guCqITMo
	 1eTiTck2Q1vsq8KW7GRcZCEOtnHGWaCZi4rk4cFEoMMc69lT6Yh691ZABf7DsakKqz
	 iyIB0ekVqFgCJlXYlHWYMa2mpnlQbZpKa4e1pK76R0MtJBN0J9RFHLHX3tVGFzzOnP
	 xBANUb2YsSym8zl8ao97CXb1wvT7eNVhiBPw36eW1PvLwFTUrpxgnePVbPXbo53B8i
	 4isztSi/ujZGsKjwC7zZ9jrm8Qgs3kUcXMwAjZwUaJQ5gNUv6UaSIZ61FT/VasXGcO
	 Rs6UaqOiE9Nx+x2Lr/k5oW1f08JL1YNEjDQK+fnfkcrxXy25dGIpaYLOfw3/cLjUn0
	 6JUIYm1SSAV0lAE3yVIwdGgc9mO0QTb8jjEVR0FUjMCCZWaqP1O1euNBFq3DoNvSTd
	 vLHzbUh/SiNzgaBnTkE5fDvUd9oDV0ctvrRmK4PF6FzaSDWWULYKdcfSgi9A44mrIO
	 DU5HtQX7fJ5keKbmbq3LA6sWemlfErQwfVn1dAFMNTrOvXIcBCxI5SwUzR8GNj5OHg
	 WEV35Uyc2fPyKEWqofJC+HMYp7pwKHsI9El4JLf2lTVuGHrjkcf9RQfcUydXl6Kkbn
	 wqw9dLFexkl5BN1HI96ZQ3CE=
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c58d35c0aso166512eec.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 17:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793842946; x=1794447746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9y+op9MwcAYKiVxV6x1Polc0TJVtfhV5fChD4LyxGU=;
        b=XFsYDphwF/AUDZE/V18QDvbNas+5v9xidoMyCEIwVSUIwU8tETOM5AeUWSlvuPUQpC
         yANJYX7VQgqAdafle3o08a7qtw/hVoRIkXjBGv2IffbVW4p9sQoLiS8AHV3216Z+IZbg
         jgOnC9ywunkYfFA8wI5m++gOgaUaw96DXmnIfjcWX9GjpCkW+KXVDVm9s94LlcWdgQY4
         tEl7GsGDoVRIp9YMsR5SeT33WwxfkXexQaiBO1Y/29hFH7jfw6Ho60wZRpPObSw5JAgD
         634WuGVNGEuqBu4d+ihWDCvmKLi3SAmboo0onytGKZPY6O5eBIW56Zlxa9wyBu4rHsVr
         8Iaw==
X-Gm-Message-State: APuU4Z9FNpNxuFyfvNc52XfxjNO6WvBHpiDAbHLanjYwAF5vJwEQIxg1
	F6BPhveGPVVxbD3G3qi1G8FShk6ozhcII7IZB5Ec7PNezknm3HEbpi2IlmFIe64tveEniZbJx+X
	tn75YeoWu+S4PKFmpyJoofOyXFEI2isQNNJs2iotCUCXlrTytUSFkw9xkiGmmC7txz5E+4I9ADQ
	BPqeVAFw==
X-Gm-Gg: AYBFou3k2il0J7OJcvEnbyhSn7GE1+C0wnnVO6DiQd3rJlnV2hK3ACcnt/TG97V5Ow2
	1FsWNS18ww0tM6x5xexZvHkYJhygUxlMPlprquWuIqgvjHf6/DMXjrmfT3BFYDWtAguk61A0YCU
	6zWUV4i9gIuEE9R/QD/BNbY+5Q8DlwnHESE4yIUrMM5qnUJY1beCS9sPfzCVBtlOeHZ2jIV3Way
	F0YDRdqUuYmVMS0AnSs8LM7e5IjObMf14Ju9ylBkimgj/+NzTEicFcDPdE0mU3iMu57dYWLefxQ
	iPJVEjSeJrwA5/6l3kdLwkYcHc1uXzv6OQ/FeLtHmCz+5S3VfysBh1wQ83hDA49+hcKImFqw5MX
	4yUiVhiO0fWtJSx3Y+JvITfKG+onk5gzZbBUfWphrTEOgNefE/I0BcRgu8REKhIgNTzLqJMbTB2
	rhRxrKVczrPMcuialBbtcMrS/4dfQyKFTcjZK7p/6/8vfqp1rZ277dWbs7cl6j5MV6049KBcQSx
	JHo+Py2qfG/0ckHDq+kKwAYwDBXZnnlvzz+PCGEpSpW/OK0LQUSlq9hwlNnXzd5N0JpkO49KVA=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id a92af1059eb24-1ac5b7dcb2bmr43089062c88.2.1793842946388;
        Wed, 04 Nov 2026 17:42:26 -0800 (PST)
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id a92af1059eb24-1ac5b7dcb2bmr43088986c88.2.1793842945775;
        Wed, 04 Nov 2026 17:42:25 -0800 (PST)
Received: from localhost (2001-b011-2008-445c-f38f-16e4-9788-cb61.dynamic-ip6.hinet.net. [2001:b011:2008:445c:f38f:16e4:9788:cb61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm11629150c88.7.2026.11.04.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:42:25 -0800 (PST)
Date: Thu, 5 Nov 2026 09:42:23 +0800
From: ChunAn Wu <an.wu@canonical.com>
To: Markus Probst <markus.probst@posteo.de>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, cocci@inria.fr
Cc: linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v6 1/3] serdev: handle devices without an ACPI or device
 tree node
Message-ID: <auve/wI4t7A+2G5W@an-XPS-15-9520>
References: <cover.1792856688.git.an.wu@canonical.com>
 <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com>
 <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
 <20261027214742.3624605-1-an.wu@canonical.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027214742.3624605-1-an.wu@canonical.com>

On Wed, Oct 28, 2026 at 05:47:42AM +0800, ChunAn Wu wrote:
> On Mon, 2026-10-26 at 13:59 +0000, Markus Probst wrote:
> > Reviewed-by: Markus Probst <markus.probst@posteo.de>
> >
> > You should add the maintainers for the modpost scripts to To/Cc.
> >
> > $ ./scripts/get_maintainer.pl scripts/coccinelle/misc/of_table.cocci
> > scripts/mod/file2alias.c scripts/mod/devicetable-offsets.c
> > include/linux/mod_devicetable.h
> 
> Hi Markus,
> 
> Thank you for the reminder. Adding the Coccinelle and modpost
> maintainers to Cc now.
> 
> BR
>     An
gentle ping
