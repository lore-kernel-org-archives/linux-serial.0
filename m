Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA13E49F3
	for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286405; cv=none; b=X4CbkCGpiQ0RG/ixhWH49khKTr4wIzv4aFMC7+06pE5tydCThiBKs0ANwNfGOKSh3fK0OhAeSVi9j9aFdw5Z3OQidnruK0QzKryxoMm+hSCypHOSAB1uoAHCqVUQcJEgjgdQfXCwisIgNPDDTCvi2qBeO73adDvHTH5lvk8UX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286405; c=relaxed/simple;
	bh=K+paxjzoi7IzgH+mfHtxQm46Je8LqMNkCno24z5At/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rduf/Bu+6BFwmBYvp9Ogn6OvUli7HxAuBHKoCSlYNn4mQDZXR6K2ynOJsCRxsBIci3hE0TIJXlYRT4Nk+coDKtRJqT8B0LchhEtRWhulXZxCL19Wq+ToYyVyTYgvCPu61xnbanKI0h6ePXry2JAUf1Bs0TM9HzxQ4Yw6sAL0TVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgaHlvkD; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgaHlvkD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1419d3416ceso4545878c88.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2026 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286402; x=1791891202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+paxjzoi7IzgH+mfHtxQm46Je8LqMNkCno24z5At/s=;
        b=NgaHlvkDNAkww7NGIAOc+OIqWnvDBKwZRrMILo3SuDyqe/P6pWzo+t/bevBC3FOIOp
         r04ToZrjLpOiHlPKEDIqGyem785r3fr/hVD1KF4hFIrjC7pyY9vjd5N6GX6+MGgK+yyD
         TglHiLSgbkv+29sNFrS/qG+KmO3LWlmmPs2neDzAu3AuGajFM7GJiWVTIOXdlxzMQt8I
         pMtWlSbuXwdoD8jZPM/yhnMJs4uqLRcbuISbDGUfcMeIqv4hSZbixuYKu93X+PYEZ7gj
         DxACO3WuXe8C/Imo58DZrpn/d5GQ9R5ArXvu6Al+SMgOtZJLnOrKr0pMA618DmYtmcdO
         JeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286402; x=1791891202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+paxjzoi7IzgH+mfHtxQm46Je8LqMNkCno24z5At/s=;
        b=BMonP36hpfoKL3Qg6xn4bYW3Qi6RkvSJX8OinRbo0JAsyu3YU15e2n3hO9n7LbwbYn
         NrH24yi2cX+vXeqXvyTlq/MWI+KnHCm96zSRs+aBA6NktLf95Tyvit8v9ktgXydiucai
         bjWdd6FTOyr0zNC3w+SA07mgXCjl8v6coIqgfRJ0KmbeeBjowP83oHN7L1WWj1XFE9hf
         PXIe7lmi/lamaBvUfoMPttGsRnBvSfu7RjJdXXaDrXvZ7aL1dMbdhUkwdvEXu8SDI662
         PLCKErD3h0rZ/N5/JMM1fllB6jqNDSEzk/Ek7P8c0MShiyyKHWnwZJxBHqqi1Cr0hN7f
         8wIA==
X-Forwarded-Encrypted: i=1; AKwUvByOI2QT4At8YjWX5VUkOmfGZir2uw+HxIdLojwHOxX7Vb9B2RCR1rG81sm6Idx2viQhn3LKH9YPLy2Za90=@vger.kernel.org
X-Gm-Message-State: AFuF++kDfEjV1XoHr4l/byAsbEpHDT5V4zkA60BYXAAyt17675ViXYoc
	DJEZZ14cL0NUbspqcPCCfh8dq++lRtGbLGdb4LkjTTwAZVm6+Y1XsA8N
X-Gm-Gg: AYBFou15KE+O2AsU7lyQHHbBvtyE13pBcSyAJ2ZXKeBq393/ctCRlLOepL+NNuBf9Xn
	g92/L9kLwupl0X40R2Jm9teB5RJhwPVeaSUPkaBejkaMpszcbqt7JgkBtKN+bHaexMDneOsNy+F
	6e1zUoZwCCRXEzmY9bleIyPOjiWnTUknYGjqoq/Bj/clPIaPcX35+1m6VGowdm5r7/czwx3NgQY
	nqqT98hGuqAKyetXRFKTFQ29nAHNXWPRqfpCsFripzxw+KZpNXHTASpqeoFcJUwas+ozEpTb1+8
	qSapEHGqsZCdQJJk4EmAGKwhsrn/EHK3ujf5CyGzJGUOTzOyckmE7nnhj8kCn9K948NufBMkU34
	nGBeuABfeHrvq+GWO2X+uLLS/mtCDqxS+xg2v0vFCwVkViCNVwZM7hcXX2E176y0klCfbk8t9l3
	SZvzTTB6T4zrsFztr/YOcUmk897s6m9FZvRcBsSu2TuiX12qRWzNQSUaSUR0lGoRTwi/XFOTKXC
	StQiszX46dolj9BHCEcWuT0e0Xm0vrUyVyQdA/7pALJhH0swbjXSzky25xzkK6a+CMUeZ7cu6bU
	LJQyCg==
X-Received: by 2002:a05:701b:458c:b0:148:bbae:ad2b with SMTP id a92af1059eb24-151c2b16e87mr13424090c88.11.1791286401479;
        Tue, 06 Oct 2026 04:33:21 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d7234c2a2sm10735006c88.0.2026.10.06.04.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:33:20 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250_dw: Add Allwinner A733 UART
Date: Tue,  6 Oct 2026 08:33:06 -0300
Message-ID: <20261006113307.86417-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <db561de8-cef7-4945-93ee-b0d434eb806b@arm.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com> <db561de8-cef7-4945-93ee-b0d434eb806b@arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andre,

On 10/6/26 11:46, Andre Przywara wrote:
> So I was wondering if we should refine the DLF detection instead? Only
> when the readback from 0xc0 returns some 2^n-1 value we assume DLF is
> implemented?

Thanks, that's better than a per-SoC quirk. On the A7Z, writing all ones
to 0xc0 reads back 0x19f, so the same family as your 0x9f with bit 8 on
top. A 2^n - 1 check rejects it.

With the check on the board, dlf_size is 0 and 0xc0 is still 0 after the
termios stress loop. Without it, 0xc0 reads 0xb after boot. I don't have
a UART with a real DLF to try.

v2 puts the check in its own patch and keeps the fallback, with the A733
compatible only selecting SKIP_SET_RATE. On the fallback alone the same
loop leaves 28 garbage bytes in 3000 lines.

The probe itself still writes all ones to 0xc0 before restoring it. Would
you rather skip that with a DT property, or leave it?

Thanks,
Vinicius
