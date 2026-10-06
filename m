Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF1463B8A
	for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315074; cv=none; b=bm9yOR5HorzpTW1uPTW1bTEtBSyLvJvIrPTCiTbSXLz4qLoyvAfh+vck2mvR8WetnlGwzY/4UuOu8JLgELuRcXVY5j2JsuEr0GilRLUOB06OmNtXfHOa2a89KlZIVBeJr2t55SmrFOYoDm90yITvoHAxTb37fo+1WrdGasA6eWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315074; c=relaxed/simple;
	bh=ObcFZUo9XljskIGbuLmwpSTyteIwyyt3iWGxb6XgNn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqE/FoUBuPLAzGp5G4Dl24gUKWlsT4qMJxGBI4SToDEf47RsZrSOvyWneSwfpsVU6Rj4wTpVrTxRVMRWyOg6NRvJhZUTRHI39nKeViTGoZSgVyMqPKxt3Qeui5UnCsHrvjRPguu4F5sjeJqNyOfq6kRWsJXA0WDrbNzSbusWC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXC2E8ow; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXC2E8ow"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-34ceab2900eso1613144eec.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2026 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791315072; x=1791919872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObcFZUo9XljskIGbuLmwpSTyteIwyyt3iWGxb6XgNn0=;
        b=WXC2E8owFukNNC5JXO52ZlUeWBcP2xuvuoC7xXh/Ku5AN39VuJGB/64KkkcEKxO4tu
         q5Iu9V8s9e/ydPAkouDPSrwEazX10rIf/5oh2h3J1x0ZowUhpJBsNjifFOfAEfkX+41O
         422t5Z8cT7vUhyhyvxHerVVieooqmVh7MghYlmARqBGAEOY5jjw6uELOS+ufNHfWrdo+
         tlykLeuiYPxi9DjnfYUhypEtdyg0jFhhewcXHsuUqLkfOzdQZNcbEUIbgie17WSbRPzP
         7ZQWgiXpT4j8sm3nnAqX6qavdGabwn7sUJZE6ONEWafKF2vLTvTgEGc1IVzXWv4MlnM7
         EQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791315072; x=1791919872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObcFZUo9XljskIGbuLmwpSTyteIwyyt3iWGxb6XgNn0=;
        b=FPZzxB0UcTlS9oenf88+7VSl2eqx6dGGxYBCoc6lgoK0+IEYR3+0lNMf4/KhJaIJXM
         oIup9t1+Yc9BxsiCmcGkG91e9KoBizmbRVDTkNhL5s7tKrxyxYoKEVnzL5D7z89Cm93e
         tjYyRre6JRMK53IvwdqOLsaexux0VALtulwzQDz08xyP+1klv3/lRrIHwqSgx+IPR4HK
         89x2Xji7jBRwP5bOLQ0bn0jNv4PEQthQKZTt3KoB5XIt0ts6XYpNv3holF1fThC0eUHB
         WBFiE/81Ksyq132zeIeeSq2AUgdToO5QS/SzQDM2OaDGQe0pbOXi7snw8mDG5zdhCsWN
         CXqg==
X-Forwarded-Encrypted: i=1; AKwUvBzBOIOP8iof0qjbB8iINkmR8qnNwiPWcJ2eKus0qZVAFSCyniJOPaclzYgCtFAZmxtxUB9Pqq3x0yRAcT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiY/nhHaevABNIwMn5E7LChi/qwFU8iRsbtlGp7DaUxACwu25E
	BGxV6xMRB2jo7QG5IFgzAu1ECg+I5gBK5wk2BaiPrzCy7sDMa5oW75oj
X-Gm-Gg: AYBFou3lPxwNOeiShtiW3lP1hhq5Vhh5pm4XAx+QRVefeS5nSGigZjLJeu+TTuEa+BA
	AfrllbAhXtsWq/FC6NfDNtBtRO54iVvWecJBluJwmt6Yhu1B7b41hTMkWxjMP8UZqwWU8hkfEng
	Sypx7zNdgLlJK03KSAtagxhbQY0MKODzPmWKEWhh0CJjZYE7TyMdJSj7EdGmM1OLpx3LejSF4ST
	sV1/uPxcl3Yd51XLDO7ScKfThfMmRbXZGHro5fatfsv4SxKk3shuBOXQxvXVOOG/TLNQoJLg6SY
	txjycMQZIBgOOd0nvuZMcuvds0sNTip7xQkC1JhGHhVVRV27cTNF/S1ehTXPMvQxOS2dMzq8KNS
	5ahSav0QNfKt0vx17qxxgTAneVbHwsG6CiAcCyiuhqQmrQL3klYy2Pgu/7g3By2D2ezqGdbhviI
	ap7kGs8QqN5ui6HWq5rd5frkPcmCzWytqql/TYc/gYYOd0E5ENaZIBtrIkQuiWeYvdeVBt7IXC4
	cvMdqp9X455LbTkT4KH0x/yRch4ZRtMKrGiBmKVl7xtuAyzqcXwWngc18EeMDf4RNTy7Qj4Dsrn
	h0mn3q0=
X-Received: by 2002:a05:7301:fc0b:b0:351:5665:e451 with SMTP id 5a478bee46e88-3515665e804mr975434eec.38.1791315072116;
        Tue, 06 Oct 2026 12:31:12 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af170c5sm717764eec.11.2026.10.06.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 12:31:11 -0700 (PDT)
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
Date: Tue,  6 Oct 2026 16:30:46 -0300
Message-ID: <20261006193046.540252-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <603b4f40-2a60-4bc5-8b98-ada7a52fead9@arm.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-4-vinicius.eduardo.pedrosa@gmail.com> <603b4f40-2a60-4bc5-8b98-ada7a52fead9@arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andre,

On 10/6/26 14:16, Andre Przywara wrote:
> So isn't that a bug somewhere else then? Why would it gate the clock to
> set the rate?

I think the bug is in dw8250_set_termios(). The gate comes from
4e26b134bd17 (2014, replacing the Baytrail hook) and runs on every
termios change that reaches the driver, with nothing draining the port
first. On LPSS the UART's clock ends in a gate on bit 31, the divider
update bit, so I'd guess the disable/enable pair is how a new rate gets
latched there. On the A733 the DT hands over only the bus gate, so that
is what gets pulsed.

> And what is your use case here, exactly? Do you reconfigure the baud
> rate while characters are incoming?

No baud change. I toggled only CLOCAL with TCSANOW, 300 times while the
console printed 3000 lines. With the gate alone every run lost 12 to 18
lines (3 runs). With round_rate and set_rate but no gate, all 3 were
clean. A CSTOPB toggle splits the same way over 6 runs each.

> So can you just expose CLK_APB1 as the baud rate clock in the DT?

On the A733 the UARTs aren't on APB1. They sit on APB_UART (0x538),
shared by the seven UARTs. I tried it as baudclk with the bus gate as
apb_pclk and the console was garbage. The driver asks for 16 x baud and
the CCU rounds down, so 115200 gets RC16M/9 = 1777778 and divisor 1
gives 111111 baud. 24M/13 is just above the target, so it isn't picked.
ccu-sun6i-rtc lists RC16M at 30% accuracy anyway.

It's also shared: 01569a29af76 removed the clock notifier in 7.2, so a
port that re-rates APB_UART would leave the other six with stale
divisors.

For v2 I'd drop SKIP_SET_RATE for the A733 and only gate and set the
rate when clk_round_rate() differs from clk_get_rate(). By my reading
the branch is never taken here, and that kernel was clean in all 13
runs. H6, H616 and A523 pass only a bus gate too, so they likely see the
same thing, but I can't test them.

Would you rather drop the gate altogether? I kept it because I can't
test LPSS.

Thanks,
Vinicius
