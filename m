Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436282;
	b=w3GRzn/me5cCanK2OiDfAmhdOane2uHjLYttrYMuWXX/OxDXq3+oUCAHbM0EgqRfcpOO
	 YjrPu1kKhtnbX4ROS9iSn1Ov/f/HbBCmNbl56R5onhBr/r7BBchdRQqXsx/8aabKTo8R3
	 7KN9/2uMLenxtX0HTiLR1XVtjXuTDdWaY3d47Ri0T+83jtw9UVKDhehK0r5tXupqipBii
	 1rNmEaG1XjciQtQC2EMXYV5C8/MvMZKPuf8hf+nE06hyJLXeL86LuWd1oRK6hKCaHzpAS
	 6r8TA0p16cdeJ032mmaCE1WSSL17A3LMjG+MZ+n4xfr+HzOd0GLrHDLL4e4Bn/pbPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
	b=TwGp4+GzSIstFWJROR6Abhxth/amgLW0Bn6Sh7/PbTSrT1zLSgmaOTVTD4pezdl0sEFO
	 1UkpLJwcGk1ZiwH8LAmuV8OW22jkdYmWHH6TQJmxxkqOEYvWRwP6a1qN+EkrJyYkIsUjm
	 rRp9n/roeIZHWgx1BoAgp3IXjr27vDAvF4hCyV5cqO3HKEb8VvG3+kbkl3dVe9gdoQwjY
	 xvcqXTRPw8wxBoLZFjCHYY3/M4yKqTV+TfEgrNKwGq37P/1+s4c/ajnXTyRBmxHvo4giB
	 Nrk2F2MsqUMR1mnalsg6AujToi80FVdbYv0CtR3Im4q6bKATOVmtkby+8HA3+NFYFRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6YfVoas;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0969606A31F
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 12:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0969606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6YfVoas
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso7884879a12.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436280; x=1796041080; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
        b=d6YfVoaswLbKwgD3P19bFRJ7ZURGLAM6cgUFg1Az7CArc+wqW7p9oN5XEDfz/OWZM7
         BNhsP3uqnO00vH5pTASrYPmILCkbDfnqyXbzN1aOLyXO8gKYRq0+8PPp6XSsqmClS/8y
         QKiU2lH2JXFvZ/cONB9A/We4EBus2jE8TIhb0YJYYCNbsds4KUlnma5I/AYVFUNggDM7
         VwxyJX7CVMT991m7EQNBh0qTSsWXSpLL8PQg+qDdReUbN6U2+9KdXOVGrc0vAuPLIv2T
         56SIttjVScC5XssqtGrOHAGAyglgIEmqbhLOnpJbhijs2+qCpmOi+mgWNmrU6hfO5c0h
         qjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436280; x=1796041080;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
        b=PYV+4lw2iun7qaDW0xXoQxjNQ90N4LlQbncFDFvJioZpRQd1wufy0DtMphfCiLxSCP
         xGH3RUfEoNRe0nQTwmnY+roqWUbWBzdAt6P+QWi2kxwj5SPgXsg5pas4CKxm37b2wgiJ
         F83sczsZbqY9L1P5xzqVWq9oqd9aONZAoYcfcBpMea0F8+eEewGxbv1JunD/5QYrqbZ9
         Ka1CRvrl1AfolfMVlzs2lL8zB5PCKgfraXuvTOupPYQ2pk3Q40zy1omY+gy/aZW9dyUA
         8sC9AWkjGnS2XJlWQSpIxkyLciVCNxU7RqpAKkHm2NQx6LqcwFPNzFlZ73ghLYPFhmbb
         qkfQ==
X-Forwarded-Encrypted: i=1; AL+hErFmySCmQsHxXVkOUv93/yAYQKgErDMIYiYnuoqiBmOolxNeNR+tPATDT1xlz//RaavDDtIxFM8R33mOtbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+beS8KZvaV2B5OnOvHPtTeMd4m/SmKbQfdOQiePXWOpzMcdKkH
	oxm4kchQ4VdRnhyFhCXwBilmYVkQxXWXcqmwrxZc+rzRl3RqLEIqkUU5
X-Gm-Gg: AZFdTZfbUIJO8hK78siemgTfWqOyuEe2LnpWElJpz56QXyoCfYOfMdO+3vhlKrBQxa2
	AsGsxpGssdkLCBETZ8q/E1vxZ4eRQQCnYtbdcCOKVNXo1VQngVZGVhGnGTRe71BWgkg7YDX9lrl
	m+TsGoBXlhTSuyn45l4O7SXd/VDjjTPo7olAGY+sJIvv/GdRxYQ78a/HO71aC0Kl2NuDY6BG0pH
	q18zplV5G4NKtgi33rEfwPaTeg67QgTwaLpUEr7ATj2QsiOwgA2QVnzh4xhNCF4KrLA8qDEv8I/
	ygKY1fohv2YcCL2gPJmaexuo0skXu/E7g6jhJNjNKxWm/1JkG/wS7rDSUB0fGcMwtinc7HOZTPR
	Ev1cc9dnVOB8K8aZ1A2AbL9u47M20z7HmxGmPoHdHQokFYFCr/FhG2TYTDy8HIaSEdIcZd41YtL
	tFY3zKy1hS1Tz1wgEP2Na9TKDaxrcJ/EDoBTWwoY3/tvWXHKZinTGkH+9jBmKNS1TQVuETi5Fk2
	0U5r9zp2tISI1WJkY8ZqXoNnLWY0c2b/KgyEGPd9FNIW4xrLZ6VZeOy8Ndq4dpUT8ujlFg1+F6n
	Keckt1spLI/EGicQE7WSL9VlYcKV4cAmYUE/rKWlZk/jRgLn2mitbdB2
X-Received: by 2002:a17:907:6d26:b0:c51:50c9:741c with SMTP id a640c23a62f3a-c5150c98208mr692273566b.10.1795436279974;
        Mon, 23 Nov 2026 04:17:59 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec5115sm397263266b.51.2026.11.23.04.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:17:59 -0800 (PST)
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
Date: Mon, 23 Nov 2026 15:17:55 +0300
Message-Id: <DN2L1II131YK.3M3CEKXTOAUDX@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sean Wang"
 <sean.wang@mediatek.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Kees Cook" <kees@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <phone-devel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi
 Poco X4 GT support
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: "Roman Vivchar" <rva333@protonmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com> <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com> <OZecqgdcxZrbwT7Ps6SDq9u1Q2EeF9jng68KHoWs8vTEetcTU8GAfC5LYcKzDGEZlr5Rlzh4rgzVh36JelFK1zHk3Dgh3TVGqj_a5Y3hv6Y=@protonmail.com>
In-Reply-To: <OZecqgdcxZrbwT7Ps6SDq9u1Q2EeF9jng68KHoWs8vTEetcTU8GAfC5LYcKzDGEZlr5Rlzh4rgzVh36JelFK1zHk3Dgh3TVGqj_a5Y3hv6Y=@protonmail.com>

On Mon Nov 23, 2026 at 3:04 PM MSK, Roman Vivchar wrote:
> On Monday, November 23rd, 2026 at 1:59 PM, Alexander Letuchiy <asalde.le1=
@gmail.com> wrote:
>
>> Hi Roman,
>>=20
>> On Mon Nov 23, 2026 at 2:41 PM MSK, Roman Vivchar wrote:
>> > > Bootloader dependency
>> > > ---------------------
>> > > This was tested with a modified LK bootloader that is not public.
>> >
>> > How are other xaga users supposed to boot the kernel? You might want t=
o
>> > port uniLoader instead, or if you're on an old enough security patch y=
ou
>> > can even replace stock LK with U-Boot. U-Boot chainloading is also
>> > possible.
>>=20
>> Right now I am replacing the stock LK with a modified one that knows
>> how to handle mainline DTs without expecting downstream Android nodes.
>
> LK is known to mess up GPIO and clock state. The earlier you replace LK
> the better.
>
>>=20
>> In an ideal world, I would like to replace LK directly with U-Boot as
>> you suggested, though U-Boot chainloading or uniLoader are also valid
>> options. Luckily, the security patch level isn't really a concern here =
=E2=80=94
>> xaga is already EOL and hasn't received official firmware updates for a
>> while, so LK replacement works across the final stock builds. I
>> definitely plan to look into a proper open bootloader setup for other
>> users in the future.
>
> You can take a look at mt6768. It's not upstream, but we replace U-Boot
> and TF-A with custom forks, as well as provide tooling to prepend
> meditek-specific headers for the latter.
>
> Best regards,
> Roman

Thanks for the pointers and the mt6768 reference, I'll check it out.

Best regards,
Alexander
