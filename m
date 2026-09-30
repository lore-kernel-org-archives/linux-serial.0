Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96825B099;
	Wed, 30 Sep 2026 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769962; cv=none; b=QLweBNgieeZVq21ghhdSgJheK3UEPt/hDrUAOsSg9XBrirey6FbXFU2BMMON28sMamSfRfWaF4znWe93NCqNyNCWaJ+b3S+qhg/kKe3zUQKwOz8p/2AIFrkrGDHujfu++79Y7zqjRBxFdWDm9nl/CoVF1JrDWYCBXfgOuRRf/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769962; c=relaxed/simple;
	bh=gz97G2/VndZrp/R6v0jEjGAooNiUY9rtpVTmX5cld0k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UcKNtq6PsEi3qhAr80bTLG5vL+TOA+psjUrOqn610z8fYA2X/lHw3c6KHH88H2ILG6bsnBVbvXTBvRoizHbtTuYpqhFqviEjZpgKcBEJdJBVdRH3rk4ypAwpGAWgFPhTB3uvCDPn47OG6FlZurzKo8O0yv9Fsz25u3WnvyxtkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=USxB9Tk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7m/4Fin; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="USxB9Tk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7m/4Fin"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CF1F14001FD;
	Wed, 30 Sep 2026 08:05:58 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 30 Sep 2026 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790769957;
	 x=1790856357; bh=xqxep6GiVLDWPq1CLLWzDYroRTT63dZ5HsotDLVOpmg=; b=
	USxB9Tk9cR6GQT0+rKubXXVkloXK1fOTrGP0S/wBRsvrQAIDteaj6uDNPHAEz1OD
	SkBxHDxgQsiLj/HMibFbsezGbevR4UL5drOOljnhBa93gxfiKV4y1Um6ufWpshsa
	45gsjD0rkw5TQore01MIliSyJoV51GsOaAcTpmzqJ/fjFPHkv+7EjXKl3BaaA/Q3
	IdO1fVnzXiODZp1DkomAwdN6IUacEJDslJP/6yn8WlGpY2L0XfGa/B+dgk66y83s
	+gvF5yONZ+XT9VneApIxyJmjExPP3c86ZRKlISLI0eBYpVG5FhpXsZ+DoqHQbfdD
	YDW9nwl4X/+fj5eX4ES3Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790769957; x=
	1790856357; bh=xqxep6GiVLDWPq1CLLWzDYroRTT63dZ5HsotDLVOpmg=; b=N
	7m/4FinXgpayGXYcyxLKGjstS8mg08NIicqGdoO3BvH0RwSObEG6Db6vcpkZ59EC
	/Tu2Vy/D1dLL6wDtcaUJyzTe/+xJebuCPuCblreTQGajC2XnWS2N8N5owFiMWZeG
	pAOP5Q1U2VRiw5lRt7X80+VntsbRpCCAHTSKnsCM03snG7o5Nx2pxOjdMT16esvP
	qsajj38/aRZeSscjoCsJWHnZKL2w/IixgGswVquVMH45NwGsiL/swnUZvaopeWek
	DpNy2gekLHgSaohSEyyCMe8nzaDq8tDEwc8ujgpJ9AdtwTWONLLRjWTOfRgGVHXv
	D/lxDeZVLHA9mfS0IvdTA==
X-ME-Sender: <xms:Ifu8aoQ2uJrb2llCEAwAZiZm8eF18WigQcqDln29S6c08-QEnXz4Aw>
    <xme:Ifu8agmiqPbva4_rfP73yrJ-8zTc6yr2gAdk1TwTiJadPT8DOOkuMt3SIu3HXI3T0
    WoxJ49duB9gQp5cC1UKbM5-aP82UP_7ns1fORu0Azv3zzVXRn8MhyY>
X-ME-Proxy-Cause: dmFkZTELJ1wCFX7WFVpQk3imcnAa+TxAckaOriG6Ug6bxw1z7o1tOcu7rbEhcFIc0tbI2A
    PLepz8lcuJFN9pwXkLefg27Lm4nIoURdsMl09sL3CZEJ9XmJhsxBZD6qitLh99+70RwWcp
    2N+EII2nD/ZmIjd2o3KhpjnqnuYxaR9/7I3D59/sxIZMNVkODMMhUafZhe2o4a7COvekP6
    0HagR5EX1WfwemJu0QmApt1smf0RXm5ZzYP4DKZxVoQs5mdyU9YnQKRuCqasoXaHnlg0Gj
    rJj6CtSE4BHw0NWgEATUY9w4hRlPg4jdP6M8v95GZqTdErp7VtKZzXZ6QftFUrE/L1quPI
    megOIY+VQmheEEiutS3mFMiwHvksm65tCxXV/nwylXlLQY+0WqXXcPrJ/MoLSTpUDKlBsU
    cpS/uNETjdKLx0cfWXMFRc1vSwIE1Q4eeytP6yJDYTLudZcSFVsV6GLfv6aZAfPDakICur
    e40JgV4oIc40YWXrg86z9BuEu6x61XZu/qWgatkS4ufXgHVph52RT2odRiPsZwahxSFmUN
    tedG+89Na6Eg+ZKsB0yVsA6ai0G6YkdOjc44seV+Gp+ssFpK9OO2/L7linhjD4GWroXIcA
    lKF7QT5+1sm2U1sESEUs2J4bCuGCsxnNUfiJlt/HEDzWiVawZf5rJc2NAv0Q
X-ME-Proxy: <xmx:I_u8ajoIzuuX4TQXGIzBYYxwLPvLJtBS_fzqjwEuRSyFp3llqRO9uA>
    <xmx:I_u8aoV1O4YCNSVDusxuu7DWZavgt4-zbqQtK2L8jKIIbzV3-2qYIg>
    <xmx:I_u8am06Qkx7G8ghx0oUQKBKyE7wIsf8__2aNmj7xS0vzGPHqKXXzQ>
    <xmx:I_u8ah1qVfjMcaRsNnGRUGjZNW-aUHKsl1YN9uXdW5N8iApB-bwQJw>
    <xmx:Jfu8atqH_LiHKUtwEcJP9Ko_7j38Mn8mlntqsLvAYkQzEUrAuwx7V6lT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7FF3B32A008A; Wed, 30 Sep 2026 08:05:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxcX56erMFXV
Date: Wed, 30 Sep 2026 14:05:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: "Linus Walleij" <linusw@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Russell King" <linux@armlinux.org.uk>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Drew Fustini" <fustini@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 "Jason Li" <jason.li@cortina-access.com>
Message-Id: <9ad7be0e-6a60-4e7a-b94b-fd79ad0fc91c@app.fastmail.com>
In-Reply-To: <179076749140.3134070.3869742286743401078@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com>
Subject: Re: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2026, at 13:24, Fil Dunsky wrote:
> On Wed, Sep 30, 2026 at 01:08:07PM +0200, Arnd Bergmann wrote:
>> On Wed, Sep 30, 2026, at 12:57, Linus Walleij wrote:
>>> Look at this in your Linux tree:
>>> git log -p b61c8bf4694b5115766849378dcb8787ff54e65e
>>>
>>> This is essentially a resurrection of that driver.
>>
>> Jason actually came back this summer to try again, see
>> https://lore.kernel.org/linux-arm-kernel/20260610112821.3030099-1-jason.li@cortina-access.com/
>
> Thanks, I was not aware of either. Comparing the two, it is the same
> IP: the offsets of CFG, RX_SAMPLE, TX_DAT, RX_DAT, INFO, IE and INT
> and the bit layout of CFG, INFO and the interrupt registers are
> identical. The Cortina Access version additionally has a flow control
> register at 0x04, RT_TUNE at 0x0c, STATUS at 0x2c and three more
> interrupt causes (break, RX underrun, TX overrun).

Ok, thanks for checking.

>>> Anyways, clearly this driver is not just for CS75xx so name it
>>> cortina-uart.c simply, and update symbols accordingly. Kconfig
>>> should be SERIAL_CORTINA etc.
>>
>> I think we clearly want a driver that works for both the Cortina
>> Systems CS75xx and the Cortina Access CA82xx, hopefully that
>> would also support the ones inbetween (CS80xx, CA81xx).
>
> Agreed. For v2 I will rename it to drivers/tty/serial/cortina-uart.c
> with SERIAL_CORTINA and SERIAL_CORTINA_CONSOLE, and name the binding
> so that it can take the other parts. I would keep SoC specific
> compatibles ("cortina,cs7542-uart", later e.g.
> "cortina-access,ca8289-uart"), so that the flow control and the extra
> interrupt causes can be enabled per compatible.

Sounds good. The important bit here is to ensure the structure can
work with both variants.

    Arnd
