Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793089292;
	b=LPlSAZbk6/9L7K560sz1LDfBv5VjK8QZnEjzyVS+/irJfW3C6gAF3zkDPnNkwLM++UNx
	 3Cq/QCmhjwscx/wUXp97FVM/FfBnG6eOpkj3mYPWdJ1+kpfprG/wba+sUrNWXKxfvxW+d
	 8hBnNmulvnl8+THL9S10FoS9qBExAnDMVHyBAXSlVD5/QkPKYR4Yo7+fnvfhlncPkNPJW
	 iYoaEIqIf3HLnArEOdYjXekJCmwr5n7C0HevCI6CVDlgvZ9GNbroL4EqWM5HoKPrXCOjE
	 REcqs0ub7qiwcmx5E2XcTj2Cr9j5iY3I+udc1mWZI6cjqEwJq4eZM3c16ODbId7L0Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9mn94YuDHCKNZzi8cPTFAQu9swr+S5PrYRBsfhBVEmA=;
	b=rgOofjoN99bKQkA/40i5ljw4hchTNOdm5ZZveqLj2VKMX85/7yJetjMppVNWtr5aFcsM
	 BCDA/zv0lxB+HbLiZMFq0CYkwwxe2nuZCEKP9NFozDlNcjfBDz2RSf6AsQYcix/wKiW+J
	 zBnM/pijX2DFFDdg9FOyvTmo4z5Nkl0V7ms1jjt/E6wrd8ZFBqWuqxhfplIPi252wS5c/
	 0qrgXk30Bg+tV+TMknEk5vtCcR7HjZEHdYg3MRwFnaZarh33CDL1J+wmqTrCzeeU1oP47
	 G3axpSJlnu6rOTkkaglC5IjfR6w0rr99bhldSirk03X23vZfjvwUUX3wqOx6QCh8v/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrJzxOmC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDB606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 08:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrJzxOmC
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4f742fc5d09so1087781b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 01:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793089291; cv=none;
        d=google.com; s=arc-20260327;
        b=bJaIZpiZ83tMhXjzPW2d6UE565mjslBlEzz8nus2tBm9a6UQTEX+bB6M0Fq6YLRkqU
         FpmpvLF8cYZnCtiBiPaTzF8+Ij18GEG6zle48mv49d9kTjDYmHdmcZFJqYjJTNlOniMN
         FWwIBYu7jylXIiP5WGk70UnuX+mYUPREUShCs6sycUGGQKPK8TRTONZ6vpOXnOnCwF7m
         3El0VoW9b3e2XDaeTkcJ6zeiJipzL/W9Jex3ngNTKoR/lW3C31Jiey2l1tV84JOkloi+
         KIUd+cgijTQYftLBb9T7GEttLoyEZdzoJReb0FaEmneGXNwKsLq+wukcQ2T4tZ4cGlfL
         08Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9mn94YuDHCKNZzi8cPTFAQu9swr+S5PrYRBsfhBVEmA=;
        fh=wnuZu36DwD6BPiYJmd4uMI588x5y3vF7ufwIJaP8AQI=;
        b=qIU9ccCbXvHn9dFSS4no47pG1wRqLQePgu7OAVp72IWILTIjV8zJYsDYgrZwN6jc5F
         aFXRVSHXIUd8zk+yswI8gw5tNFSmnEFWlxmNMtrGMUbgpb1dibLmdE9wiM9jwNuiHxJa
         HKWEqls8/nTP8RUFM63A8MyfM/cfoaIGMF5qzbxaYlsnY9SkkkGyGhi+Xz+wi8wtVBiA
         fmZ/vyVH6/vyQDmUpGcxztSDIw3sdYS4FNYVN+YQ6Co9OAKLmKq7Cd/9Y7RcV0dhC8vE
         hoK9vgsY84H/EHbbZGV7qfgRW64744/avuvwMTYSHiUWoWnDYsLVFX6ex/h1muaZBMwf
         3Dzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089291; x=1793694091; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mn94YuDHCKNZzi8cPTFAQu9swr+S5PrYRBsfhBVEmA=;
        b=JrJzxOmCl/3md7/9Fi86tAUmHB4RjLyVlcTp7r1WUV1Es7K6QmrtvV+LVRO/jRwUKU
         Du5QtEPYCrYPasuy58hmeSEBeVHBq4+N3JxHfmAC/Ba7MtDeveZmmmyESrELyXeF+51g
         /LyjaXbvOpzBqoaiHABQwUCSmwQA/GcEiCc/PnBxy7xeSTDy3CJUkHewdZjOubSQP3Dd
         M3Vo3r78VYIrYMZJicXHVHqZDbcOJWehlyjhjtgAdi2Q1ZuLfp4GNwzcQQz4tpGAMSzO
         73AodoElXKdQ76NkpHuJYzmdN3y5YQ5abefMX9Wlo5DKQuiXCIcL7P636/qs0DDBpARG
         OPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089291; x=1793694091;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9mn94YuDHCKNZzi8cPTFAQu9swr+S5PrYRBsfhBVEmA=;
        b=fafKakMt0fH06MpmFZTB8e6tbenKYZv6NEA86MhbtHjYBSOl3+kWLonKH8qRn1n6uG
         5UKns8JEIHzlrguHQLhFLwxoUhv6yg/7Oqbg3MFk8bBTWIBD57Qdw5PLYuokBhYqo2fb
         6v26pApksHta6CF41CdW9cI+X6wV/Z93GmLDvsiZYSVy05+SCxl9rHjkBEgakAsv/B2E
         Got8UhqBGuKXkfYqREC7n9rH6teVy9l5BWBh04zS5jv6h0jQSUfLnrlbGeHZXW9qVn+c
         9wLe13q5Iy3ht3kvr0upsAJe6l4nVjzFDn2A1MpcrAk5rmraBQP5Fijm5Pw1Rw9Z7pD6
         oegg==
X-Forwarded-Encrypted: i=1; AKwUvBz1bgTQ+VWVyvlac8fT9lTgmvAjH0tYuGNAYd6U4vJQQwn7Nu2kxOwZF4c7wkJbokSIHhbr6BrGp2l9I3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb0zLcvFqrmWMwdVxaaJTI/cuIjP4dhcDg74LqLyHvFOTiPYBM
	HDJ/S5nn+UfqbseE/YXZBVEyNp3F88g9ZB/KrA+OHQ1bGb256iRMPo/QD7kmdQLsfqpi9EnRQWg
	7Yj7/F2FMrP28VFSyvTTl6t7x/sIekg9bm1HRiogDYA==
X-Gm-Gg: AYBFou2rB5egjKtArAZKp0YT33BfDU+ntuECFG6M6lqWQxrPSPxYvrwy5tuhi6Xue2m
	GtFIs4eXOJ5FidM8GkDnHMkCEQrVsiwhbP+pAB3vATt532zlWCpyncoFEGc52WS5G3owzsuDwqF
	ROYN8nQt6AToPiZ272dlfs4Xzb4wTz/6rOR6wcqF98DNnJ+xz35J5fxLUGZ2Nnk8t41aQMxJ1h7
	QRZZYWiuBtptX9a2W3viZSmuZynxw1+fb10fi63dL/fdDpFSLO/KhhhkvWI+vh9iR/Ff5W00aWc
	b/LYFP/Xts/rYiLYbVySd5mMAZpTFa24TkpyrR5lDEpD4nFX3DhLmzhbFSByq7nYQkR8Sp81Ia1
	XNwvMukrbbjtSZXUaB8rBxbiu+6J3CvgSE4d2G/timABkXEaDQL5A8XS/+5fc5IzDf7lfdhozb4
	bnIDBusZDlCWNG1Ff/
X-Received: by 2002:a05:6808:198d:b0:4f3:68d6:f0dd with SMTP id
 5614622812f47-55c002f88b2mr7047283b6e.38.1793089291107; Tue, 27 Oct 2026
 01:21:31 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027054304.35543-1-dennylin0707@gmail.com> <2026102711-venture-amicably-24c7@gregkh>
In-Reply-To: <2026102711-venture-amicably-24c7@gregkh>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 27 Oct 2026 01:21:20 -0700
X-Gm-Features: AclHuK8mKEFqNZ6r-25CgQcNCoeN3KIl4Rlv2fmwKxPrps12_lcpFHKvKnkhJ5Y
Message-ID: <CAGEkeHePGOKXsHg-bqkJH4Dpn=OSxTQx8z5vbjW18uSWHqrpWA@mail.gmail.com>
Subject: Re: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What commit id does this fix?  How was this tested?

The missing flip-buffer flush is already present in 1da177e4c3f4
(initial Git import). I could not identify its original introducing
commit.

Tested on ARM64 QEMU: an 8192-byte PTY write leaves 4097 stale bytes after
TCSAFLUSH before the fix, and none afterwards. Built the ARM64 Image and
32-bit x86 tty_ioctl.o with GCC 13.3.0, W=1.

I'll send v2 addressing the unthrottle issue.

Thanks,
Hungyu
