Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035441;
	b=x/U4iUOmvourPnu000BSuHFh3s+Npy0U6BcT59xfaQKdR65+L/a1C+EtwgdA479tW94g
	 zKZxGqehwbe6swT5v0asnAyh7QAcQ6wIOGrZdE9bd+rvY3FsygwUVWDxs1oxpiyoDV3Pl
	 kVZKt90DvGHuMlZt7qZqFRC26wfrg4lSuNQfqCpOlc7+78esmUTtBMrXfnlqEReFra8Hd
	 rZL1JDq/eVxhwv7Jwv6UtwtMObt8/viwRGZO90r3k0ZERGavZ8pVi/zHP0hGw8LRU+lYE
	 0d5+SjfYNOzySVkAqhghYjljnlKbXA6h45Iv5dqnxnso6cPhbCTNZY3La3fnygg+Pqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
	b=CWdiNA0XGY8vDZ+n26CDP/wJ4bQ9N1/7L7It0qkR+jsN+yEoH9o5AWs4TS6npgY293CF
	 0YUKvSKU/yvjL8K0qS3ssAh6vMxcGd00NhbEhceU7nwc6RUQs7RusklUuvh11r7B2z1dR
	 mlp/wsGcpKaCccfUmI56f8E0uBF0cX+2y81bOYFRmBz0w5QqKz9bhfTr9/wsHQIWjerB1
	 RnEzUsHAZDZaN3uioIVPhy/nlgQ5DrC2Ho1jEgpakXTCUTN+ovod8RVwekDaqk2gdBWe6
	 a0ZaSfMjeURXWKnv/zqI4QTxkFWCWAPGsbKsBSewfRGYIlC9hFCu0FsIvDei8IqfgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ3U6pM4;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7C606A31C
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 20:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ3U6pM4
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a5506f09f5so969422f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035440; x=1795640240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
        b=eZ3U6pM4uWJAg0soB/+ulwruWIsechmVHctntlrGfFAqhTYhXgCJHlROKnJ6NWnq1M
         laW+G5ENbDVDab3NiCysSPmTXaeHdNeJFajmjVOasM0gJcbZ+MfTwYBW3zm54ce1kICJ
         hY+WWaTNVK+KTLU6RflsZwY34xeYZ7hw5ASyRvArs/CPArbC6OKothn8Zv5+huSb5kaE
         HMEfQgptHblJF8aAtmqIsAFas2RViUEo0KFttKWUHsgsuh00kGjh+0scqN7PPKwt1fUb
         RXzhJt1sLYeZXh/FkEEwZDNWpqns2B3YzK6/7TazCF08CXfnRCan/NaG/2KidQ1vyWfV
         rp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035440; x=1795640240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
        b=iqnhGJG1gtxssyTvU/FzTAy5vk0qCwHrdoY0uCnKTsx9CB0wezjgWjf5SSnMrJqjF4
         7Q2bs6jvmsJPlilVG90Xgo4K5mRNZRFJg/TO7PePT5wxTqIOjfgOJ0TpOZrqFBKB8LA1
         LKmk93Ndp1gInwEmDtnEYPCtjjce9awLMVbKzIbpgULdjnOsQlXUt2SIYXsuiKgIy6Nm
         jshBNcRz59PHniUFTGBSDqyOWwzF9zT6YXmA5viWDiKJtqMo9PHPOdc2U+ky/cRxqUJf
         1lIvYOFy6tJ5AJa0IPLI6oxUcMeb1A9aQLo+bVWpEQjnUNA3Howq7fkrKqvZmEf1bgMX
         FcYw==
X-Forwarded-Encrypted: i=1; AL+hErFH5N8pAjStVynRo8LXeDqKC4cWHFpuzlTSyVqkMHvfQYxpH8HBttLsmCkpL7pt8p1cMOdfJznBQOO9ryQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sg/Rp/3Hnq9a85y2UTkYduWLd+uBtimILRghM0WGj5biozD3V
	jO066ZBurfmACL13F2bUgT2Zrr0Qqa+HYQj5om35zBGZIsNb3C2OjLbB+tVYoLhy
X-Gm-Gg: AZFdTZdSiFFqDcxC5F4KRfyxC7Ix05S8gk/8UDoKqsfip6FFd63xTjSBmEGGYvk/YBn
	nB8rENiPgIqjiM9CFuyuL60QV3ytgdH2P1QbwKRbrdQeW3y4pd/388e8T3/WBWFN8ae0QNYDu6B
	XxPD2XlFqyiQyOCx6DR4kBvOr8DccHm81/UINevvi4leTTMWM/VTwbyq2WAm33yzEpQKQTsUMWm
	Hp/Z892Dme/WceQM/ReZkU+d8uhxRDQDeSfggNVFhKQrLzx/UMOOwHghpCVK00joSdU0lLNHvmQ
	GF0KEr/jmY/5G0x8yqq4VXgVND+bYXFbBprgVG/5kmOWUH9UyrHCdeurWfr6cNMmLsfI+aRSsYz
	tq42aH1G0dzLAptarzW1fUGeMUTKM/h57rfkoVEmHO1yK/Xr+hnR1hFIqGx5q6JT/za4bGh5GWn
	ZB+PWXEC7gPvkp5/fMhNoYR0x9U2cgOxieChbDhmzEczJ83U31wsRFpsam6URVRzRGN/6JD+rBM
	LjUqblh51morNz3AQ4CZDdwWnVoGEyRxuZ0l67uyg97uOXDC6Yu1FLhavZYsT79hIS5+Ik22dcC
	UdHiHc3KV2LBhmEOcMWjhLA7JYKn
X-Received: by 2002:a05:6000:2f81:b0:4a9:4dfa:c151 with SMTP id ffacd0b85a97d-4a94dfac238mr347385f8f.26.1795035439821;
        Wed, 18 Nov 2026 12:57:19 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a65560bd46sm6675311f8f.31.2026.11.18.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:57:18 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 11/16] HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration
Date: Wed, 18 Nov 2026 22:57:10 +0200
Message-ID: <20261118205712.49261-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219658@kernel.org>
References: <sashiko-outbox-219658@kernel.org>
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

On Tue, Nov 17, 2026 at 08:50:51PM +0000, sashiko-bot@kernel.org wrote:
> Can ft260_reset_and_rebind() race with an active ft260_probe() when the
> driver is bound outside USB enumeration?

Thanks, this race is real. I reproduced the order on an FT260 board
with test-only delays in the probe and in the reset work: the probe of
interface 1 passes both TN_189 checks during the unbind. On this
kernel it then fails at its first HID raw request with -ENODEV from
hid-bpf, and no subdevice is registered. Without CONFIG_HID_BPF,
hid-bpf does not stop the request. v5 fixes the race in the driver.
