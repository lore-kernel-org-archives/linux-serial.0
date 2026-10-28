Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151776;
	b=sBxb//ulhxcf5y5XzcwsVcyexUXXg0O8YGQ/sBQuUUnp8SBY2GwcPwjmAft/a6rZIovL
	 J5lFPpbBC3oM8cUVwu6aVD5FU3fqoT2IpVoYMND2eL+0htHtTuHxMrm9/DaD4883oGE7Y
	 /SL7eFnGjJujtqSDGZSMpYfK443ZBnx9gMTV+I6AiNhOod9E0FlBzynjo6eHfdIGeVTwZ
	 AAeNnbo+NDaVbuJqjxdL0w+V6wuZ1m61ShMmeTqMZVbME26Y3k+eGO98NDvwWIbxEGkWf
	 iPcaDzgALg9GfcAaAVLKlgBebBy+3dHvXzK5zKn6CG+T0dBmL6BM4hGYucy90s4P6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=F2b/C//SFL1IpqmZ4dlyGzFHOKnAQfZ+yoE8clPtWLc=;
	b=e5vw+DsTl4ED2GXizi6Cu4I1h9eRE0miWcjGz/Xv+poJ6X/11zCRozwatERYgDh/Ds/a
	 zRZayS6gvBe3lpIb11c5AnBHkQuEpqyHI9ubhG+xtqHZdyr43SvvS7lgyNtjypTr9H8Xe
	 ihmen1akJnuumSM0zQN4fXQu1qOZYhn/R4FtJNVXJo3ElXNkx2LRkgCELeoQyRENN1FxH
	 Y0Wxrx6aqzezswKhQua4I9PQBdFjA2kvCzYqCgu8dh0NIWiULcd3hx8KQjW6RWdECIcPO
	 el+DoX4f5jCS6KBN78xbcHQ9GC2LfD7mIfFic2cKnnPxxklWn1XMiB77VLln3fAlFvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCMyzx2f;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70332606A31D
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 01:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70332606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCMyzx2f
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c43373ae89aso55397266b.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793151774; x=1793756574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2b/C//SFL1IpqmZ4dlyGzFHOKnAQfZ+yoE8clPtWLc=;
        b=MCMyzx2f0O00kIhRhwK1oGv7GzOGM3BLrIKelATcKFUe4QwLqj7MiA8Q/EnhpSe6Vr
         EHS/TnDyRCP8uH71IajLTDSYGUBp/FTsCTQVtV28oysp77bX9vzw10IrhG2nIOfdTQ5K
         8pjhKSSPSrVDS0lS1ipyWioAQ3/BsKkcKIE7VyoZyqeJ+9qZ/wDCP2D3oqpkUTVEuZFg
         0+S3lX4RdVHPnQgZrf8vtTWRvWHMJiVnD+nl3POTGLJohGZDJ2f/CXrqwtAYe0qb0we7
         pqRD4xj8sLpBFdBLnyjUnpHefy+IiU1w9ZTy/vYZOZ2D+srGLO3+h1N2j7eqHdRrimM0
         ngSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793151774; x=1793756574;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2b/C//SFL1IpqmZ4dlyGzFHOKnAQfZ+yoE8clPtWLc=;
        b=RzvOHRIf9u44Uh3SbVddNbkcsH6bX9lu4HQ34Z0IbNNGvD1vRQ2mff/dlH6c3/EYOO
         qYc3p08niPo3br/vPIPfaYcHCgVS2YaTX6pukgdUDdBCHcCIrnM8a2BarYwLVV2TA26h
         yfxaOzsKqY7+BGdQbeIENhNyHZs0Rs2z6UzbsRb453OBBsFAvQWxmcBp4jbQsZVNdohT
         PgeTci+o8KnLT1KyQwj1MdcU0IQOHPwj0USo7TOaQ/Mri0NakP04Q5jL/TGsgv90bhPN
         kJF7G2OnIzZ0U/wCqjzD+7PLTNvYCqDaZoEBWxF8PO/fBWt3Cfy7DATdTnM9MtDD3XIP
         kE2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwo6pad+TMQvgYsP981p1FpK3FmM/2D8q77bIRNtg2Zj/1RdEO/UJt5dD9znVJacau4C3I4YM6tezsYK8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+RfDBDqYtSDWtf82WE2Yn7CXRS4RL8fvvdhhm4OC3qAqGzPuh
	vhzsY2DreWq+ad16MpLQLVbTX0iJh4tQKBaA4yJcJLeGlAR3erPRsYbT
X-Gm-Gg: AYBFou3pfgH+mssvmOL4PQ/HAIqhbvHuEZaXSkiR+NMmWBUimRtd64OwaHPP6QwiOt4
	3uaRpOL4iFciNOAkNHcWOtZN2DXVp5traJOumgylm4d1liDSPnN+hgVNs/u4G4FV2A0eISJeLm+
	mOd+huAuJ4V8fnP30st6M8+VuvY3rHXOdSV3c/EJJUyi8mFKvbZjuUVqeWLhHz0GH5Jsi2MebYq
	+igTa1VF3PHeSo2/B8MH12HgaIgdQKQipXjEYSRG6kPY4U15AXPN2lDWg7r3N8MAeqYbl9MVIn+
	pMTZJc0sePX4txR6nU65hoC7oXQYWkmJxRqiEuVdnBA5Y/XxJYFFQ9fe9mE0w70zKnAiTL6J3w+
	M5uOqC4y/DFGoceXCUf8/m5oJnYZXCLWAH9z3OwL2hjxPxqLk+ap/DXaSEWDaTcXju1T7mbOLWO
	E44WiVKKlJOHJ/JDgnGiT9RX9CrX8y6O+TLV9iy45pZGU83I0SREiI08vswgHcKc7TetDN9lKsa
	z3pCGAvc1GbRWqbh93cPqHD99f1UhynwUl7N/AANR0/wYd2Zq5fYngqbT9HWj+S3a7bi7zj7yx8
	/KVNJiFWTz0TS02xFtS1zdRew/Es8Z05F16v+QDCXRrep6vMnksZ8Uh+KgoGQjDNMArMlwVAsHK
	L6/N2i+dmbt4Bb2yekWkWhD4z9tZlPJiRlbx1AjHXBLe/FbfgZeM/rwcSTgMD1W41nKLhpXFuIE
	iv82ZcyAXfWMKnK/ZjyvMeRJHnHXJbu4+lk2JFV5tL2PPXSHBHEjhyNuYiZ4E/eiJX
X-Received: by 2002:a17:907:2d10:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c49bdf3abbdmr75122166b.23.1793151773813;
        Tue, 27 Oct 2026 18:42:53 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm217876066b.23.2026.10.27.18.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 18:42:53 -0700 (PDT)
Message-ID: <096b2691-238e-4f43-b5b6-e1565b62664f@gmail.com>
Date: Wed, 28 Oct 2026 02:42:52 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: u_serial: pin ports while TTYs are
 installed
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mehmet Fide <mehmet.fide@gmail.com>, Brian Ellis
 <brianellis@gotenna.com>, Johan Hovold <johan@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Ai Chao <aichao@kylinos.cn>,
 Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 syzbot@lists.linux.dev,
 syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com, stable@kernel.org,
 syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com
References: <6941beb7-8cae-4cc5-ba07-e1c8a8753fe1@mail.kernel.org>
 <20261022091359.1187468-1-krystianmkaniewski@gmail.com>
Content-Language: en-US
In-Reply-To: <20261022091359.1187468-1-krystianmkaniewski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch also fixes another syzbot report with the same cause,
"KASAN: slab-use-after-free Write in release_tty":
https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571

It is the close side of the same lifetime bug. gs_close() drops
port->port.count to zero, gserial_free_line() frees the gs_port, and
release_tty() then writes tty->port->itty in the freed memory. The
tty_init_dev() report is the same race on the open side. With this
patch the TTY holds a tty_port reference from gs_install() to
gs_cleanup(), so the port outlives both paths.

Tested in QEMU on the base of this patch (usb-next bdf12cde3083) with
the syzbot configuration and C reproducer of that report. Without the
patch KASAN reported the use-after-free in release_tty() within a
second in each of five boots. With the patch five runs of 300 seconds
each (about 8,600 reproducer iterations) showed no reports.

If the patch is accepted, these tags would close that report as well:

Reported-by: syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571

Thanks,
--
Krystian Kaniewski
