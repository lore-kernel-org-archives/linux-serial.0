Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039731BCAE
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399951; cv=none; b=oPWOQH4BCHoFXHsn6ILOv+Tuhn69ED+FUF+6l2+DxJrPArvgCIpGE4UE4rH4Us+oLrvNuCuq0EHHuC/bSg/oXxTwdTcOFpcZ41C1qITJD7K1/wXS6cxVmIhLtl2Ml1Tp/gXrR7idxGpeqcUsZ5akyrXjkFItjVHy5iVg4WFPk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399951; c=relaxed/simple;
	bh=nEANZGCZ9guMXFCy+MYGNEwKQAPuCeBUOf9W0nQu4uI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RMC53lERbXe/iLUyAVEk2hLfznBu8Jp3ajTHLSQhEKEur46LYK2L7iE+FUfZtQIcENmmsy3KBwilHfF4bNYa3lsRm+hUwR+lD+HvRfe8H2HfLEPQzJnZpui+dauhFpT2VGOvwEP7fmRbcytEEaLNuvU6Nt4+mcNosXnYdu5FL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Bb51uD+z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaGV4Lyb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Bb51uD+z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaGV4Lyb"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id A63D11D00093
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 04:52:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 19 Oct 2026 04:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792399943;
	 x=1792486343; bh=cRAdLuUMQVLrTUQtW3xqfK+uVlZ53vZnJeL6TLJsmWc=; b=
	Bb51uD+zvzxGM6E0mUk8Giz3BKrGMrrYJX4x76rDnG4XXQZ4bkc+QQYo/lCgJKnw
	/YtlnW8l5Mg7zNTrkuv8QIx8Hjdp5VGbsPy9sKYWCD0qTGCufyK8sWmERvilRBC1
	suD/h/ro15Dqr3eqcbBnvQ8xJutlBScOOobxIsg/ut5JyYblIKSu9wDnH8zvsxlP
	KXQF7e6m8fTjtwEWl5yUWto9N9CbV8i0YTjeKgQzTjz4vvcVkEYVyKlAIlPOMFA8
	bugTzawWB8mC/sORP9m1z3JbxThwVxV/6MEbhhikhts6qbm8ZMASgYX6+okqfCiJ
	kJ3kS4Opy0c+UjM1O3osRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792399943; x=
	1792486343; bh=cRAdLuUMQVLrTUQtW3xqfK+uVlZ53vZnJeL6TLJsmWc=; b=j
	aGV4LybY53Wtm+1by7eCtJn0dPTnEINAUicpLQXHxV5Dpv8CaqMBPyu/aGrhq70E
	+D0eOt+0cLSqy+Ne7G9g5DCqpDVyRGo5IoCPPALX6k48HUC9TcT72rNvXv97v9ra
	WNcYVRUjWaaoyvyKdjpvs5BaIfl4NXjd76HoNFeeTC3m1zgEnjZ6bKyJMcKpQPNd
	SurClGB81XgpUnfWbXe1rrYOi3n1+rT2e/xyJjOLwRBmzNlVeZ4LtMkrKfx6nQDg
	nvtEFB68+rgvgrGIhmfwh9TDI+TsOqpBIqiiXJhmNDJ9u/+P1qyf3WSdOz1U3GDY
	ntnZ7VFRlLkcAZYCcPGxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792399943; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PoKrthyuNa7qziB6sJZ4a/t+Z1WZ8wsEBDkNfEU8HtnOipB
	JNDEC3xLeMBWuZAjm2GgMUh9kNyFOFQF/qX+XNeJKODBt0zGLKXFz9IhVzraX7MU
	Txpu1eZVitcwLldBFO8h7JFZPWO33lyc0ldRx8+easAJTzeXBnd3dSaOP5OaMuok
	y8eQdIjRdGC941N91AIZjqwQ6SAWVrOpVN5e0t0DdBtwYJjsaRtqTO9+D439RM01
	nbCuP4EDnn+jiRugmC1/TCG7HNoxMZVtIR3OiJmyaYiQ30H9hVERnGGV/ZTAGrzi
	9CBrh3tHqduIkK6d2wVAIrK3SZudXVXyYVMurcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Gs2Wjku2DTGryiiEUBBCDXcmzXgVadBUGqvHkD4nUM0=:nEANZGCZ9guMXFCy+MYGNEwKQAPuCeBUOf9W0nQu4uI=;
X-ME-Sender: <xms:Q9rVav6D3Dcxo8Dp7JWJFqt_8J5wut7N8gdYQvJz9SaLqGGLFo9Cew>
    <xme:Q9rVavs6MbXGshW82x0ZHhMokskmEBlDr_L3WY3pDTonLkGORsRJb8Lg1tZyNDm9y
    4Q8gOCHerODpEO5pp2eFtqjku720t1IBHn0U391crtu2AZA6CGjMaqu>
X-ME-Proxy-Cause: dmFkZTE/dT272iY9im8e2pKUcyzfMQ8Oyk1kzzEI1f+HUy/s7LMoDoLCYPzG0mJfeS5zgO
    f0lswCnXyxAz+3erxCsMP4+vKJeE3RV3bgTCuEtU6lTcmjMBsmyugSw1uttzfjVDVBiti2
    oKBnrV4PrIs5JBpQqCsGNeblrRF+OSCnjJBycE5D6i35XNLxqa7W3RkNG6bn1Kp7rxg5Ip
    fEQBkYJ23L3N/yWyUzwJ3QLpqiA/HEtisyzb4pkcIX+IMo0Aeou+u1tGFtqCfhGevzHMZd
    oZ8vtgdi2VkY/na0up9+kUmxThyhDdk2ZOQfeZePrCRPPZSfhi7o/0QYKt05lzKu/bxIgV
    AReHGFOFOKtO2spw5zIUjzV2Mt6Vy/rb2JeooMviE+ckKOrO3+JXUWT6a431qQDP6wsZ1B
    JUCNzNfI1KtbtxDKQthKy3ro/ga2f8vCIrc12mHcukL43PJ7Sb0yoVf6WnE7lsuUcx+w58
    Kf2sKWLGCas3MfVGNk2MBnJSX/QoRwdm3EUscO/dz2rjVB+OurtIIpzt62qEaLAhGVEkKE
    c9pcKjxpuWjO+sq0+R9/Rtdq9kVa02g/2kcT7+I+UfX0l6V7CWezsZrG7j6LdTN310060G
    8XMeBKA3hQEDNFFWhRjGxTGMA3jzqme/BM0MinigfjVujLnUyW1g5aT6cz3w
X-ME-Proxy: <xmx:RdrVapdw0q3pcIo4FDKP9CjLcJ9aFpMgJEYH3YsC-_qpVAdGtBgjkQ>
    <xmx:RdrVajFt2sfTAI3F-k7Ca0awfyHj4AVnCfEo7BCBIdNnQt__wutuFQ>
    <xmx:RdrVavieEU2XyCgZuUhkL4gJ2IwJYpDzzOHFKoqLaAcpK4oqiCu9Cg>
    <xmx:RdrVan3qJP-Cv7JpPw1hwcS8aRNhqb7x5fl54a5BJ8qgeLW8JXE8-Q>
    <xmx:R9rVan-aKXJyknrQZ5T92z3Wf4yKBw289HESbAn057kGTwA5ZK8ivWH5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0244532A008F; Mon, 19 Oct 2026 04:52:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4WN0AQLOakc
Date: Mon, 19 Oct 2026 10:51:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
Message-Id: <d0d4182e-342f-4038-ad9f-e6b580c9f2e5@app.fastmail.com>
In-Reply-To: <atXLd6SdHNr0UcjI@monoceros>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <atXLd6SdHNr0UcjI@monoceros>
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026, at 09:51, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Oct 16, 2026 at 02:59:47PM +0200, Arnd Bergmann wrote:
>> Link: https://mirrors.nycbug.org/pub/The_Unix_Archive/Unix_Usenet/com=
p.unix.sysv386/1990-December/007174.html
>> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
>> Fixes: c526404a4a92 ("serial: 8250: Fix corner case for port matching=
")
>> Fixes: 7ab80d1e7243 ("serial: 8250: fix compile error with hub6_match=
_port() when compiled as a module")
>> Fixes: da7b5fd4e17f ("serial: 8250_hub6: add missing include for hub6=
_match_port()")
>> Fixes: 3d406299d882 ("serial: 8250_hub6: add hub6_match_port()")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Fine for me. I wonder about the amount of Fixes: lines, but don't care
> enough to check.

My first thought on this was that the hub6 support should just be a
loadable module and that it would only require inlining hub6_match_port
into its caller, but then I saw that doing this would be exactly a
revert of those five patches that each individually make sense.=20

> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Thanks,

      Arnd
