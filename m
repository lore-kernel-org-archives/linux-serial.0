Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C17E0E4
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677415; cv=none; b=IpD+hLvx7sVE/dRD8Xh9WQCPpO4tRGNwg3lXvdFPPFZOSexYE5BEam2PXnBhiyzS4XPCz95imtXvHE5rlXeKuf/kOv5+l9aYTzHAIJ6u4LEZU3Axb5sVi9dqmVZBHffnknMfZS/+g/gRFALiRGzwAZFalwLhtuCqTWGwxDPiZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677415; c=relaxed/simple;
	bh=3bLDDmxM9+7bEMwptKzPe5tuqwYOb9te2j7zoPqB9bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiD12vMS+olhNAOQBddX0mM9zVK/y5kH+a/M9hJwJ8cZ8QYYl/8sfPpEKRFemAOpHUMH4CdEPs2wNuRtErrsCV9GJZf6KQy444bjS19tDjraQWT43jznAqYc0yaLf+xLuRzvhlKtV8I6Lk0bylxB1kmDYch8PPl+NIDNpfNZMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T13vT2Hm; arc=none smtp.client-ip=74.125.230.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T13vT2Hm"
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-934956d1044so61860485a.0
        for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791677412; x=1792282212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BP1bz2pHwtNQXRUrZx5Fh8v5zRyVZJ76VNiARN43ayQ=;
        b=T13vT2HmzeACAmqRS9dvSj0jsE/RJgswQ3APVLhPcQ0l8dcglJaJux7m7fcR6NtA0j
         f/iKT/0+tz2aMef8WM8n0UFX9N//sbhxsBtZPaIUgp95FDjC7Qz29x8QhCi8ZziAepWb
         ReXpmGTM1D3iTiJCTM+RT/S2yODZyFWFbOMkEZCEKv78cpWkAiep2PuktaotLopBf1eT
         hqtFW+WR1dWpPu+SJoQ++0g0N1vu/Sqjk1SzzqU+iEZqvUy0sr/5biRY+auCbDqXbdif
         2JNglB6+y069X/9q/hgJ2BMALlvw5gOFt/1hDrPdalDcxttXzeZEwbbBU1Z+yduyxEEg
         WlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791677412; x=1792282212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BP1bz2pHwtNQXRUrZx5Fh8v5zRyVZJ76VNiARN43ayQ=;
        b=WMgqEM3nsOA2kcQFiX/axAHNhZz2Lp15fuaipmXNm4iQyPr6/4+wJ9lGjpL9XirnTD
         X/KEclRj3gwHhzPWg2SxMDE+bTkvbB2+JQStOlNcozWUXyfxZL6epoIZyxdc49qeGT03
         gsQz5HWVfAHTJ3U+7aQ4wTHhWSEf3MF9vs/cEjK8svv1HlSN3HtJwAs47Ifz0d72+kET
         usbCKeMk0rytyvYlCYDzNc8zgVb/AjabH9hJ/mwLTRpDPCiZ7/emfLLc1AHF5vsJFfes
         H++BpE8boKL5OgKmpVsW3QzIIljZ0GFGBR2ZTd82KRilsqjnJ3LXIl+9ylkt++WOD1oR
         9yKA==
X-Forwarded-Encrypted: i=1; AKwUvBw32ejVceyGa8tllKmW1KwzPt0LLzn8iAL4De89bxZVSIplGxzrG1fGAwmVfr3mzdwNPrvYKcDRZe9i2mA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSPrIntyoPIpDZzwIuDYj0fgYfky0g0PRK5skOr1tPJ/NbfLba
	cdbgQX92tSTxzCJv9f/CVaJl1IqESuUAvgFd29675ad71N4Z9JP+KrNQ
X-Gm-Gg: AYBFou03vGJshpo10233ixkthi5y2a8daXAnJNuCji4jFTFypHrOae/IbDuccCz3IKA
	NJGBsnTmyazMMJSngwgqMwmXG7EfnYKzsDtFtT/9U/x+ISbV0U4oj9b3N2NqK7EPORvtyYaoMT2
	xDLiOtxM2O/Vod+04TeCga9FXTU9p9EXZwu5QWg1VpxWacWLYiSxclHB0J4B8kp9W0s3bRZ1Y5y
	HFPvJyFwHDaScJw1axGuZ+TiV+s8Kq3KZCd5F+ruhLsl1uzcqbf+i6javUXz/fcx9oyF61SmTwD
	ArQeUyak4fHEQQa4xhG9tha9+Ebqtd9/Oi+EwHwYArpGERgcOW1kgHmvDBysWWy/YziQaq5b3Kf
	1s/Wo6p7+8Y7MX0UgN7OGZB1VudW4TwQPgUQ/tD3FXxaI7FofwjvDQXu183/kUMGFkKpbUdRKu8
	YikN5mBdYWzjrptber8amCNpfoNUru6TkKCjPi49dJPBnyeS+EJc5NQ3+3zB0ujlfC7vA=
X-Received: by 2002:a05:620a:4692:b0:93e:95ce:539c with SMTP id af79cd13be357-93ebd0e4018mr1010764985a.2.1791677411682;
        Sat, 10 Oct 2026 17:10:11 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98ff9d8sm523933585a.44.2026.10.10.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 17:10:11 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: dts: mediatek: add Genio 720-EVK board
Date: Sat, 10 Oct 2026 20:09:22 -0400
Message-ID: <20261011000922.1089313-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Louis-Alexis,

A note from using this series' mt8189.dtsi as the base for an MT8189
Chromebook (Lenovo IdeaPad Slim 3 Chromebook, board "quigon" of the
skywalker family) on next-20261008.

The dtsi has only the cpu_off_l/cpu_off_b idle states (PSCI
CPU_SUSPEND 0x00010000). This firmware has no PSCI SYSTEM_SUSPEND, so
suspend is s2idle, and with those states the SoC never really sleeps:
the EC doesn't see the sleep signal and the RTC alarm doesn't wake it.
ChromeOS's mt8189.dtsi adds a system-level state that only s2idle uses
(infinite min-residency); when the last CPU enters it, TF-A and the SPM
put the SoC to sleep:

	cpu_s2idle: cpu-s2idle {
		compatible = "arm,idle-state";
		arm,psci-suspend-param = <0x020180ff>;
		local-timer-stop;
		entry-latency-us = <10000>;
		exit-latency-us = <10000>;
		min-residency-us = <0xffffffff>;
	};

with every CPU listing it after its cpu_off state
(cpu-idle-states = <&cpu_off_l &cpu_s2idle>, <&cpu_off_b &cpu_s2idle>
on the big cores). With that, suspend is real SPM sleep on this board:
the EC sees S0->S3->S0, RTC, lid and keyboard wake work, it passes
repeated suspend/resume cycles (20/20, then 10/10 twice), and a
10-minute sleep used about 20 mWh of battery.

I can only speak for the Chromebook firmware, so I don't know whether
the Genio EVKs' TF-A implements this power level, but it may be worth
adding to the SoC dtsi if it does.

The board files are at
https://github.com/zoan37/lenovo-slim3-chromebook-omarchy
(port/quigon/mainline/mt8189-quigon-suspend.dtsi).

This was found and tested with help from an AI assistant (Claude).

Thanks,
zoan37
