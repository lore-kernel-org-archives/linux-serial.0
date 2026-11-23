Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436641;
	b=mqs0aOOACat0K9mcz+tkQpGU9dC9R7ZVvqr/5l6xDdFuPMU/0wNZ/3IeuPAd3mFGMa9i
	 LEKZ7XCQdA7LPXXwZk8gmD6+ZTbfbELOCFRhmZatvZwBGYy2+GsvQZxecHTupUNtRoRp/
	 Kq1DRdwOW1mPtgLiMk6e6geOUJQ9txYbtFPC4GckxdnRXTKXVztGXp79BCgDOyj29LH46
	 PG9PezGMwkOm04cvHEW8I8XvFUvaK5/1xtrjK0qd+ohSU10oXKNffyYZOIhve0jTtXzvU
	 WOdbByuCG/V0CQbf99Buj0MwryQ6Q0a/sYD84/i/019WSRtauhQB6cgXAhlCj+kMN4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
	b=KDkSLWON73jJAEtEUzr4O7C5/xWNIXEjYaBMkfKgaj4UwtPUf9tk/qhZQR09jzVSstuq
	 imyf5piOZXpIFGTfnyHkKw1h56pq2/8UkKDYFNkIS9bEYNkHvLsM0r6hXrGmyJik7Y8G4
	 4ZZ5ZqYzYRy9H7fv36UjUdwEcZYkt0U3ZTo67XIY+AUIpQrIxyz2IWS493eKBfihYITZs
	 cH1wGy2OiSCg/s+U289OKBs26Y6qKejOre+WeBlKx/ihlHBiMbV8dy/k3Ld4uayt1uCXV
	 ILyHndHyn2Zsjtrt+m992se4LKUT0RkHE7cn0+k76D8S07Hsne1Cx7Guw6QbquMJi0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtQuSOYg;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E8606A31F
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 12:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849E8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtQuSOYg
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so1335361a12.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436640; x=1796041440; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
        b=FtQuSOYg8sSf4/9V48Ab8qAjujqQz8NpDRWzirALjzHz4bD9ONZbSyTxPwLYNxZbOM
         N+tqz91gdfSCbdcnbNd9ERMipX0rPW1mIPC5bJbEOmBZxkYHpFzJxC0BZCwTaqeov0VH
         NoGITM3lvvDAVK401wBOsWCUrXHF5o+jie2l1moTEcTi9kZlUiphn9ph/y2aLQZDbHzT
         6RoK2LwZgnIKSeQlmwKSQ0cS8oNjqJyxDiTeU1KKTdWBuRlcoqJdi2VLH0zbPeEyZ2+q
         HqC/OaOQ49PpMS8uzsx7hbRKbyErKQiGQ7Y6ESG3KlEtJho+Nj7hI1jjlJU1URXDHxtK
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436640; x=1796041440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
        b=ZYbsZlTiDjUpGLpLjOmjXpv1DBfqrt8z8sI5Ks3h66aS2Id07qNiGqwB5f/k9txkGl
         LtheMT5ZnL2uVGnuIic6eZmvt8ib7rSi60/1h7btgPrUr9C9C4fFlQ765rQo5nmGLUVC
         Ff8YrAUDLxINh34loJg6j3NL5tPpRChyR3EBsjz+Axw3Uy1Mw//SvPQ7hko+0nI5pP0h
         Me4tINA6ysPzw6BmAD2BDLZx7zvOhq86/pVz/1FGwMh/pD5Y+fkQJ0riIIUldLPhCpaC
         A7lZzutZo67KuumuSe1nvc0EZnN8WHJ83u0W0hD9QYFObESuvjL4wwIBUkHoNDvsWqGo
         5sgg==
X-Forwarded-Encrypted: i=1; AL+hErFsPCAUHl+BTop1Nr/A9zrkDC24omsGE+ufAtf8/8TLJGyMND44dHF3Pu9X5nCe5qOec9Evwewea1cE2dM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SyfxwreO0i5uKqBjqq0SzkNj6m4jU4UAnNL0cn6TsnkZ36TNn
	H2H6u/AvQBcnCNVbv2HxsB6Jdwfu4BWXltpeNQOBh4k4WfKzw8VYNtpg
X-Gm-Gg: AZFdTZfffeHb37v9fno3/NDqHncrxFC9RwENRT4So6/DWKZ38tMUVpgGIueNJxh8UuK
	+Fus+Hz8JGR953wX+uxEkvKuKy35UWIzTv8Yue8wzcoXfQYU+y/JKEM2iMMyTBQRvGTasVtCTbk
	jdmEVfooMBZ837PqR0/m/Wdmr4phecg63i00nKyNhEBFGEz0AkYK8Hko1eRgVklEuy0Nnrro2Dp
	XDAt05oPgrMk7zkoEHWcR2/FjX3pnFnENiX+tkuqqSq1t8Zy/OobyTHg4SLQ+4y5sGcPvSq7zki
	zLv/iGTyzGxMgAbZ2WXwbkm/zAt6pFq95Eqa+x3TeGnrcW47kSXn87h0J7zEZpMOCckAZP1Smlm
	M8d5QUDOwVZlrtqgEG03gGfGd83T76dV/4Vz8++aqQtvU2/mUsXTVnEL89Kj+bMV8o3AlFXcHTY
	un/0ihjPTgKt7xu9DzWOo1QsapQLFksJS6+W/82YxaevTsjLwuQVK6DIhCcXA3oswIuR0uJLePh
	N2JTSbLmvkF9ScZRzJkOIOu2VSaRXLL3dtPtEv7XwD5stqNi9F5aUWQTjk8D3YISauoGtGUaGpk
	MrXb2a+irDENdLk9Pyueg7Grh/tNwJJI+LCfSYucQESM7cFL4fIPVbYv
X-Received: by 2002:a17:907:9612:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c513a8845femr1010728466b.30.1795436639952;
        Mon, 23 Nov 2026 04:23:59 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42easm391318966b.60.2026.11.23.04.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:23:59 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 15:23:56 +0300
Message-Id: <DN2L64B7KMAK.11FXWAFFOOFV5@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
 <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: mediatek: Add MT6895 SoC
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-6-95c46597e63d@gmail.com>
 <sashiko-outbox-229131@kernel.org>
In-Reply-To: <sashiko-outbox-229131@kernel.org>

On Mon Nov 23, 2026 at 2:25 PM MSK, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] arm64: dts: mediatek: mt6895: missing EL2 virtual timer
>   interrupt in timer node
> --
>
> commit 52307c1c986494baf205914bdd46826de40efb27
> Author: Alexander Letuchiy <asalde.le1@gmail.com>
>
> arm64: dts: mediatek: Add MT6895 SoC
>
> This commit adds initial devicetree support for the MediaTek MT6895 SoC,
> describing its Cortex-A55 and Cortex-A78 CPUs, caches, GICv3, PMUs, timer=
s,
> pin controller, UARTs, watchdog, and keypad.
>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6895.dtsi b/arch/arm64/boot/=
dts/mediatek/mt6895.dtsi
>> new file mode 100644
>> index 0000000000000..62584cec0f4fc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt6895.dtsi
>
> [ ... ]
>
>> +	timer {
>> +		compatible =3D "arm,armv8-timer";
>> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
>> +	};
>> +};
>
> [Severity: Low]
> Should this timer node also include the fifth PPI (<GIC_PPI 12
> IRQ_TYPE_LEVEL_HIGH 0>) for the EL2 virtual timer?
>
> Cortex-A55 and Cortex-A78 implement FEAT_VHE, so when Linux boots at EL2 =
in
> VHE mode without the fifth interrupt entry, arch_timer_select_ppi() logs =
a
> FW_BUG warning ("VHE-capable CPU without EL2 virtual timer interrupt") an=
d
> falls back to the EL2 physical timer.

Yes, you are right, thanks. The A55/A78 cores implement FEAT_VHE, so the
fifth PPI (EL2 virtual timer) should be there too. I will add it in the
next version, or send a follow-up patch if the initial support is merged
first.
