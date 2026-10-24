Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792835499;
	b=CoVtUg1Q0aZD7Z1BjipFs4RKH2ECwNwNA+EuS7Bu7aYPY5kCCw6FvUxzpwbqg3Nii1Ua
	 X9zz27hGFyi755CLc9tMKlkYbXjOn1MFQMfMnEft/QgW63qWsyrCt052uIeE5dTzzWYEX
	 6R1pWBkIL/KA2j9Ny2nmZbwu1fo8mPqjkUtO8jOKJ7PNnjVFIIdlppqGI1Q7k3hjf2ECL
	 Wom3kM/3ScBoWAzGFEAj6wLdq3h42O7oTtR8HLLb5vqEPwG56sPnvP7EQAGdnHRZHx+xs
	 coKsWhtBMKhFqbhzhRu4qEBkFpu5sfFihWZXKKaHW9oFtwOp/Ya7mdhhfWzBgQ/rykw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=vjxoIJzlpzcgf9BPcIKsojKmntjoGNgJq7tusKjlXR4=;
	b=jBOOtg0uTSIQUaO/iotWWBYUphmm8Armbk8HWdjbbttGvLTiVYR1wXThTP2m/8607bEn
	 CzOIrWcmNYtoPH7G/041jOwDnkJjLEbIilIXuEhEyhzyjPukGuV0rYoVrkJcQU9L73uu5
	 qDE8QwoQKKnQqIiBoMiZtKV6lMgQGKxSZ+epD9iGTxx7P86NtrBRDiXOZ5hhJQ2OS+tZH
	 23+WEg2jr4hYae9VPyNyniHiSVhDPLcVSiu1qgCRB8340h97Zc0SvtEtMYMs7kdDgMHAA
	 t5/tokZF1Y7ORYiJPxcY1b8THSjRE3okia+/X1BI5oEeoJRKkyzmM03wzepyTK3NZIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UvzDO78A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA66606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 09:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UvzDO78A
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36681e85e87so188256eec.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792835498; cv=none;
        d=google.com; s=arc-20260327;
        b=K2LHgKwdSeORCNht1dqqix39PsCEQyuK5W3ZryAQ5I00HIA3srnXxnTJz3b0tQjXwj
         L3p6ejlz+KoK+1XO9+YuYm15k/CztL4dg8zaRbMRcMmhQTDSdGwuDpUKgexIKWGGCM++
         Awht9WIxZbn7pYcYcNmANhU27z/MtpVStXK2a7vrOiJcIx7sWNOVfxxDOp3Y3gzEN14V
         ehz25cNc7culYSayo7AMETnfZQ2ychIAgrMn45r2tTK+dIwoZ48qp9TN88MeIAT2izRH
         jjy1sAQxyrzBD/B9p4LtvXRxIs8ddzRlHcxt366xiT6/mtwD1gQby1MQUoxNZoaJrFzh
         0KiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vjxoIJzlpzcgf9BPcIKsojKmntjoGNgJq7tusKjlXR4=;
        fh=3xwkVqf7pOGEVxIfFiioFsp8V5pHuGMuOEVeglcpJ3A=;
        b=J8wgrjzLcZG+UsqBGcO8CwfGk5C52oXgyvTHbxxki0ZDhCUbBMFo2ttZc8z7vfKW+t
         Zwv5AyQ0pvXXHSU63WskxNgEp9Chs9QF+XONTbtudNzFNJbg2P/xxtQ0FVLMdLvYZinc
         4ZnnJ9NANwGDicDLOQZyADgyOf6OeKO1rFf4LQHXOJ7Jp59ieg7gujv3uVgbRH0HjlWG
         WPlWZDQu5QBsBGMbO4CcOd61qXvzITJyMQDl7Pvj1JGYxXQ6gRXWHnEa+pngErBqqFfb
         ks/bH+Jo7rWIIcwfpjI2u9F8lJL65JE0dA51/eymjO8sFsRye13JrsLpr5fI2uPs/zpv
         b/XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792835498; x=1793440298; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vjxoIJzlpzcgf9BPcIKsojKmntjoGNgJq7tusKjlXR4=;
        b=UvzDO78Ai7JHXSkiTJGRXae+A4QyEFi2H2uvSzAgk3+zJIb9Z3QDCC7eAml83VMYT0
         0sRm+r4J22rvuBr6dIWNTnoSpSfFkaeVLs+6hEbMTDCeFxWSM+4EHS0ladzL+5xmhL4P
         qeD4jS0JwWNDivjeh0ghL072fK5guEk2sfKGU6EBs5puzDuB/Z9bpMVhriWzNLJqw7we
         B9BKyU0omAazxbFzu8gqx+cYMDZMtvyzZWmhE5RSrvCKET0n3yhrxqF8z1F2qa807Nbk
         RU1ay/53zQ3lbyt6S2rVG1EufXQjpNw4hh+bbfrGHCPU5Zar/t/4mLKH8MaHsSXwjE49
         ENiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835498; x=1793440298;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjxoIJzlpzcgf9BPcIKsojKmntjoGNgJq7tusKjlXR4=;
        b=GJO5tk6TOBsWqRbfijcIH/6mXzhKdYooE2HJjKjNz07TM7wErgemnRAoRKFKEPDgnX
         uSKTvtYOvi3dMbNI89L1uUVrc84TC2w1A2nt5RqITTnxKrlsXx9Se/L4toKwEmZjc3Gq
         DRC4YYaQDD0ZxDh+FLMfsS2jQkYxZ4K3TOkYpAX1qLXpDRjndvAQleNVQ8Qd12FDqOjt
         HQHnbWXE81W3Fb8NcIFpFUNRGiKH6bw1P8liwc048EP50g6iTbO8mDvICT/4aYe7toJb
         vsiZlXUbiYbj+avVIgk4NoF3ABOGOnUzWwin3fzWfYG9UCyMXIOgXB0xG1BHWHtuQUzE
         /thA==
X-Gm-Message-State: AFq9FYLZSM/r66FjNc49Lczazr9VUtqfYkHm+qOD4zAhnssQ+LjjGEPB
	Scg0zMwWAmedJs8M6cBWlUOdrfFeb8Rgges2SdQO4ZfxaIKmAV+CXZg3qBkry5UyE52Wj75PGsL
	Bb3fZxXJvhoG/SrDQciv8FFXtB1Pd/zuYRzuI
X-Gm-Gg: AYBFou2GRPqmJAY2Iwvf5SN5aFqdWWiJLrbkFvAKTSVxqc03qeqIa+Sf5KNE8wFkWTr
	EAUTNKP8smviAFhKidEOV1JVo3h8eVxEOLi3ea+9Lox6kL27TLrevu101ryWA2pMcyLCvSIv3Aj
	yt49uKlPnIaqeI2Q+H5gnnnWhjdhFFbNStVB6qgXQ4I3Jgh6Hpa2g/YQXcZ0TD+mhhyJgGpV7Sk
	DWxzEQVKvLzZR5360Bwva2jL3kV3IuEE9SLs0I4pvMLxwYBWQq00i31mMdyFfcuyI4k27U5MjY0
	MANdCaN8DHVieUymx/m/K/PZXsx3fTpzHCuQ8wNcpneZpxlRi+XeM+oahq+g+WuTghNrY5vGicn
	qC/ymTTEH9JHdZX+y0WqEoD8fGkVYKar8JBeOJq9Obc/SAAdUBIhhGXtpU3Te87pJUw==
X-Received: by 2002:a05:7301:4394:b0:353:8122:27b4 with SMTP id
 5a478bee46e88-369e845c87emr2587293eec.18.1792835498429; Sat, 24 Oct 2026
 02:51:38 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Vivek yadav <linux.ninja23@gmail.com>
Date: Sat, 24 Oct 2026 15:21:27 +0530
X-Gm-Features: AclHuK8DTI2ZJCEbvN8MElAUlRdRfPs17ZsSGClMvqpYMHPqNrFGcKFC9bXvojQ
Message-ID: <CAO6a-9_b5qEu7WqZ_Db0fwKRo29zhsYV+UbQFPvHJa+O=HES-Q@mail.gmail.com>
Subject: Questions on UART FIFO Depth, Watermark, and RFR Values
To: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

**File:** `drivers/tty/serial/qcom_geni_serial.c`

The functions `qcom_geni_serial_port_setup(...)` and
`qcom_geni_serial_earlycon_setup(...)` both call `geni_se_init(...)`,
but with different parameter values.

I noticed that the RX watermark is set to 2 (`UART_RX_WM`) in the
former case and 8 (`DEF_FIFO_DEPTH_WORDS / 2`) in the latter.

I have two questions:

1. **FIFO depth assumption:** Why do we assume a default FIFO depth of
16 words? Since the FIFO depth may vary across hardware
implementations, shouldn't we detect it at runtime or obtain the value
from the device tree?
2. **Watermark and RFR values:** What is the rationale behind choosing
these specific watermark and Ready-to-Receive (RFR) values? How do
these values affect UART operation and performance?

Thanks,
Vivek Yadav
