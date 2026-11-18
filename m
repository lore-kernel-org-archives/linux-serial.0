Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020014;
	b=RUlGMt8n7DlWUaxlG+R8rVgGnq/R/1A70E/7L04JO4sBbHtUVxMss/aqv0zdz3GCbAZh
	 2YyPhcZ/OvsBa79NkI9D4QsDPSfgscM4FvQ2ggX6vlz73k5LD+sqKSKmFlRAp3mMq634G
	 HlQb13Rifdn2dJbyQsFH4yNTbseC8R2urVhVq8FRBEw4cIadE/Me7LzQH3ZqVtwvgVmWc
	 6svdv9e+Mkgk6h6B2XSGmjg1IyQqvUiKX0ODAr+jVrQgkMnNlk6MOrHHELjDYgCPKhXfe
	 Os+jqt7uhS+V9TdlV4c2qMS2bZDeDB91ZeP0tK2zvPcmcs5Py9TEfkSNtXYkqlj6fqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
	b=v2AN9E3zK7mgxPxORJs4z9IRb3YDnrZwjeYEi7E6YDD0ta6kY3bBnPHar6R6T2gzXrjO
	 sughtb6fzd/PGxnpCcwftpSN3NGO0+dAFu2tYGHPHwJsgG+8j1CutWuMoc5F9okuEOkQ1
	 4pTys9dIxeJzOF5vC3oGZBBut5oe1VPjtYsJCCzNgqwNPcoN8cAIsOZ9xxOfSYO+/spZZ
	 K3Gso/B1qO4xdVVf+7xkTt2sMiNVNd67PXGCcAc0AnfvwUefYbRRK3TvmH6OShVjvtADB
	 6TggHYULv76fyT2fX4bcwM0Fgt/ACY0BUkyxEvWuGrBeTxl0NaEf+HIOoYhScZzipzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2F60A2602
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 16:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C2F60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so10174365e9.1
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020012; x=1795624812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=E4U9mTZDlIksJjVDWFzuHLbz7qz+H6X/WuZ+ANBvE5aFdUKR8wGJnCGbI38Iz/2/Am
         DcYffqId9bYDRaceSRCjX0vLa8N2I1YNW8Nj1qZQ3GuZ73h9A9UTkhDsV3iQxJvUqloo
         1qMFUUlT9Uexndc0moK7CkwofIBYGR4tJyD+emRsHapyfy2d+KrUNsMeTIWGDmfsN9A8
         n0Sr1ChhOkJCtqcwuL0MKUD9rqm1bq+5vNOmBkoyrmnodDxhRqx2TCVJVvvt7P3+SNGo
         Wu5SygkvVbJnpy7Ekh/QhM6Qt7MKP3IelqkgrWCVRnNLdHHFr4gSD62k/UvxKTiQFyLW
         u3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020012; x=1795624812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=PBATpVZQPLU102yf0RdPncqvv1h8b5ipI4q1eaaarAHSGcq1TuIzG7Vc84WaMR6Nlu
         zmo9FITde5lv12Ijt2w7+hm4g9YHWT/0T4Q3rzlVbs3oskYPzr5peafBPfOJmiavwgBx
         rHL8siFUryx2HFV8JgpdLzZIV+80WDFSsOukOd9M+QcfaEbXy4/aUEci8rm4vW2iqD5f
         x/s9e7L7HR1qFy2piitW3fAqwOyL8K9bfL1aQ/B65IZ9Em9dGxj3k/hgSBn42/Ib1YdY
         N/dQoPqwnWHrII2T/6f9syTtSK1zZuw57XVocerfgfKw3ml+bE2V7ObNBFL7rCzRKEnE
         Qxfg==
X-Forwarded-Encrypted: i=1; AL+hErHWgxZRIuvb7HbOWXNXybYtP9zK9wUvJ0pjBOcYQn9a3i05DQgQIa0qZVyeHdEebA3w5N2w1HQNUyy8O/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2xrL9B7TjlKhfQf1fKKsfRrTQvpCP0TpI+F176uqddQWef86e
	3BZzSwqFfdw7fssNme35D6OqPKFO9GXtMqqCPlvMGTDhYWBeXaMLoy6r
X-Gm-Gg: AYBFou1qENi7kmkgrQZEmFy3h6im7ynO1vMsi36r9k0JwyNamgnx5MGdJzl1mDVMnJM
	XB1nyHcwYhM1rlnkAOBwub8pwMJzeGnUP4VUiJAKcRBHtdOb1t9jmCahgraQc3kMRtUUsY2RGTu
	drEG9ckBGqUOy3u3R6X7RZ6TRj6KtdSr6/1nH0S49vsSRc06qT7l9GYUE2YtkPeOmEPCPPzJ3y0
	sTq3Vrk780ZmZhuhIVLqSPfiYuoJVo6RUDlkJ7a6LFU04Tb/7QJPA3Gr0zxMsDzPpN7XN7QKdXY
	JPYID41utNC81xaHE+Pz+X9qyWdMP1gGV99gpTMiuRAMyZAvJUlKiljqqiYiTQq2OFpY7qj4/BS
	BLm5mr0tz+/Tnr8bEkISEMZW1tUlUq9H5UQZrA5puI2ZkzMvt6kLV+sD/HVMqQGVWwpuY6dZHbo
	i+cezevqg9Wa4B7XMD6RWQgFjjxscvlu9cSUq6OfC6EMit5DVIQDye2sUoOs3x/262nCHayfzac
	JVJBTZxpvwa1akgoESakYyhNShuzoEVCiTENtwOaM3oBN0+PzSPaFRc8q1TDZi0Ff4+V1AD4tEd
	pJBzgaDTyHeF/lReDRR4MY+YX2lF
X-Received: by 2002:a05:600c:4715:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb7da3d288mr60167565e9.34.1795020012419;
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm137986135e9.13.2026.11.18.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Wed, 18 Nov 2026 18:40:03 +0200
Message-ID: <20261118164004.28739-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
References: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 11:56:36PM +0000, Maarten Brock wrote:
>> +		if (value)
>> +			gpio->vals |= !!value << offset;
>
> Odd choice of asymmetry: !!value == true, then converted to int and shifted up.
>
>> +		else
>> +			gpio->vals &= ~BIT(offset);
>
> And here you choose to use BIT().

Thank you, you are right. Inside "if (value)" the !!value is always
1, so the set is BIT(offset). In v5 both branches use BIT(), here and
for ex_vals.

ft260_gpio_set() from patch 3 has the same two lines. v5 changes them
too, so the driver sets these bits in one way, as ft260_gpio_pin_set()
already does.

Thanks,
Michael
