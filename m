Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969632;
	b=pHicn4k8k7GAhDV5ZciGK7VXPsi1N60/+4etlxf5RkfSguI7w7SRjKnrpzSMIMIZxEWW
	 o2/Hl422VP83525zt2dEOcjPiICncUPmhrJVjX1mzUDZod8PA8zJz50C19pR8/pSP0Zkg
	 lHIvDFUK2KpS3/bOBhTxMjQNV88Ch8sQW70fkaHKfN7Amj/IKuwbkeNRWwXMOtJyWKFYh
	 /7ZRsPDaWWIN+MSMw1ztU0PdJPfE+7xUdlV+cnHrcVdLcX22IZzVOZvj/oKqVvszzNsrP
	 1kbtG0KClc9LDAZVNFCsTjh364xKQ/3NPKMRLz8mfTRqrQa4zCkrAj6fRRuXo1DU7bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
	b=JcSBvmS5eIV+hEbwHEz/oexXT+S134IXp7TK87gBzye2htK4FHyf32KJ1yDcJJvkhIfS
	 6AFM/1gcjC/ejltwIUyqtk2Lzq0l64hqD9Bq1cn4i6t5+6TWpvtnAWpVL8CqNpAGU/e+U
	 tUEjMgK7lGKlxvFeRTrtvKtLVIKla/Q5jrDM4Q1/dvuBjFKqbdzTzYYLoxhqHSCVnU/WG
	 phAhqSUKVCqnjdGCnxbKOY15HJouBBofEZcDQe7ZZ1HgjaiqCeMOs636APJUwXtvbONQR
	 H71TwyGDsrnvCbqNwm7Eb8sBAGlA1aTZyBVLL3SLfDy2ES0KX/kaV4m++CDTsp6EaGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66683606A336
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66683606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so4045825e9.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Nov 2026 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969631; x=1794574431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=RTQOMoxix56I3khgiwxSLlG6MqNj4SnKFN0SBhox6cEqvgnl7JGomA1wRtDOmcDzLn
         SMJbxP2clNS4vp9IEQIfNqOTQieTPb/o/DkCapHlrMzsPu6UpPko7DR4mpB3S63dhpsA
         yQIBpXjJ5HgVWdunVyqSVTnmQDD07f5uSMGGmNBys+TeI0//Lgvjg03DukZF8YSSjcXa
         6iBj+12ApuubwP4ZWxCaiBMjqjQQa1joZPEi92XjrxUdybrBwYF7+rkj8D7F62pL697Z
         Dm7VhyarpKwTU6Om6ty0AEYYTNZ8YrIxmj2NZuNBefTI3ypgkCjCScMTGyRuYCr0YEb0
         v0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969631; x=1794574431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=UtWBuSLmDvIUHSXo7B4rB2HND5yRVF5lIRpa6wnAw+hZ0G9eKdFSsSq0urqIoo8Zkt
         9YS+Hi7miE1gnVWgDzKHeS/maMvuv9XOzjA2OaneWsKVHV6wOozY4EegKg/+R/0ILf8l
         9CGONTpntyrQL5RzZMWUenA8avK5tsuRE09pm+AasKX+fGN2/SvBGKCTQCVPsIcCHMBk
         Bp4EP4E6XG1iKI6KjyP0e/oFLQMaYeb/1lS4Sy23cznjK+OENDRAkJg01H7znDFFQlnb
         7TkhJjEamB4/Y928BnuET96wzDhiZQqRs3PQw3MNfa7R/PFbIsLG7WugXVtwA05zXKId
         O6OQ==
X-Forwarded-Encrypted: i=1; AKwUvByPflI3IZ8rUlyESm5jPzMdhhtRWW2w7MPdfwlkpWSEgGV/09EglZkUCDHfnrGFoZ3Wotilr2PsGFFypSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0TK/09JiF7btiATpHZCLgBI/7KgQeh4NNGFilurzBv00QsrV2
	moUi0r1LgIQb1Pj5auzP2Q+PIeRplnQAo/F5o6sLOnA2tNZ16QMt0/MuRC2nvDmJsFs=
X-Gm-Gg: AYBFou3Z23D0vMLpdklbfVSIR5ssXKdTJsbCgjLZ1r0uu1uC8JLxT0Rj/Un/ZR4fDMm
	ziFMsp+F7PMqtXVAbocR4ZO12gAa4af3hXCdHycuMIcnNU1LWX4geHSc9lHRqmaer9hxs0S+EsN
	m9x4QFUQApB7JQTP5dBuysdiTjar00DV96YuwyOOiG9jML8HslbfsGJU/JToTISofRGkCxD/dO/
	16r3rkh1Kmwfai3TdHGyRQKtakLLXH7Tcpv2ElkFOcmBg8bxatjipY48McEd9GXMYd0BDV2muNw
	prhVI6dCYmIs4zjWO7PnHTXboY2av/EWuMQ3zZhCTs/HvwtKKy/4NionG+4olxLCRqLNE179Y6M
	a89avpJH3t19pSSzw9nWg1j3k+cNIabzhAkaE+vq7Z+DdPwIZFHFQMoQfs6Ki4BXpPgyG46zcNM
	KifBETQfmp8CjLbMtyE/IZm/Vxfw/7/+mQBx5EzPjVDjDSWZGiI9hbD6FDIuh6fv5CfTmDfMv7p
	fIWvsTn5tyqyTiybUdJfJboNPoZ+8+N6/12RdhrXhsA7co2U38DKh5T+QWIhcICmf4xyRDOhrdI
	6+KvlkocmflFDdaM7JJ6E7xI6UQy
X-Received: by 2002:a05:600c:1913:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4b6de0ce791mr41196125e9.16.1793969630568;
        Fri, 06 Nov 2026 04:53:50 -0800 (PST)
Received: from m2.. ([37.142.148.124])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d676sm58687815e9.7.2026.11.06.04.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:53:49 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v2 03/15] HID: ft260: add GPIO support
Date: Fri,  6 Nov 2026 14:53:40 +0200
Message-ID: <20261106125340.18483-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
References: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
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

On Tue, Nov 03, 2026 at 01:53:26PM +0100, Bartosz Golaszewski wrote:
> There's a lot of sashiko comments to address but a few additional nits
> below.

Thank you for the review. I am working through the Sashiko findings
for v3. Below is what I plan for each of your points.

>> +	mutex_lock(&dev->lock);
>
> Use lock guards from linux/cleanup.h.

[...]

>> +exit:
>> +	mutex_unlock(&dev->lock);
>
> That way you'll avoid this label. Same elsewhere.

I plan to do this as one new patch at the end of v3, which converts
the whole driver to guard(), and to remove these labels there.

The reason is that I also maintain an out-of-tree version of this
driver for kernels older than 6.5, which do not have linux/cleanup.h.
With the conversion as the last patch, the code before it becomes the
base for that version. It builds on older kernels with small changes,
and I can simply leave the last patch out there.

>> +	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
>> +	if (!dev->gc)
>> +		return -ENOMEM;
>
> Why is this dynamically allocated? Make it part of ft260_device.

Will do in v3.

>> +	if (!label) {
>> +		ret = -ENOMEM;
>> +		goto exit;
>
> Just return here? Why the label?

Right, it will return directly.

>> +	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
>
> devm_kasprintf()?

Yes, v3 uses devm_kasprintf().

>> +	hid_info(hdev, "initialize gpio chip on %s\n", label);
>
> Drop logs like this, they add nothing except useless noise. Same
> elsewhere.

Agreed. In v3 I drop both "initialize gpio chip" messages.

The "enabled GPIOs" message moves from info to debug verbosity. It is
off by default. I would like to keep it there, because my hardware
tests read the GPIO mask from it.

Two messages stay at info level. "registering device /dev/ttyFT%d" is
the only one that tells which tty belongs to which device, like
"converter now attached to ttyUSB%d" in the USB serial core.
"chip code" was in the driver before this series, and it is the only
place that prints the chip version.

Thanks,
Michael
