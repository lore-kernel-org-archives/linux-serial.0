Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA349A3AB
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161751; cv=none; b=CwNky8QQDHQdavv4Ht+BITxd0gGFY+CTlVH4EVIGnWoPtK/UiAxSE5LTUMNPOfjNF7ppz3LgKz9BD68QXU9hZ0KHe8soa4RxJuX4kuQFJAIBPpBHaFOwDlfbmQQOv8OBTgae2pMoNdoGWBdbWpmiTt8Ss+gukNasOk0Z7OihDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161751; c=relaxed/simple;
	bh=+nc4F9eQckj7R90Z9Q2QAGsijSxI7+KgudcWTIBAlmg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nq6ubMSkF75bK5+WG2FqYiBrdQaotqimXYkuE1mjlcGdyP626mP1sV//MN+wXWomnb1cU5XYy9be+BcSVCQey6kO0lBgkJDp8UMyoDcW2M0JqnE/k9NVxRydP8ioei/yxRgMStQ2QJ9WxnZ/aqEKU38R3obaUZbrW2fS+ZKD0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V8PPXjMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9Zs3sm4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V8PPXjMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9Zs3sm4"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id A62BEEC00E7
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 10:42:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 16 Oct 2026 10:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792161744;
	 x=1792248144; bh=aKpnb7yXuWN79+CT5JC4DKumb3SvQ4AMvlQXBzXMP+M=; b=
	V8PPXjMs0B4JLEonkN+/l4V+KmdgVisapme+D4QH/aGw2aL3CKGOL8e0fPYGutdq
	wnSTTsR0DzK/y1Z6hAHJrE7z8e8yilGlTKCYsYl3iw8Id85p27nsE1854z5ZKd3l
	UoGPdjeF9uHeMvGWG4JSrjmht5J6u/4PNsziIeCZDpQ4s0s/uvpMAs8fDgdaj7xl
	oHCaFeJsuc640hOvysj/4+wPWRqMawEDbMwGv2dNfS9tbHDsOfb53aUkmC2QsyQD
	DKi5TFNzDqLYGj6yh0CIDLjxKK2j13tSBsTG/lTH6nKq3OQKYsmR1xPxS9MAGyWj
	ySxVnI8WVrs+vYQJWJSGxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792161744; x=
	1792248144; bh=aKpnb7yXuWN79+CT5JC4DKumb3SvQ4AMvlQXBzXMP+M=; b=a
	9Zs3sm4I76Vaj5D6gQON7Vx6K4rcAflIUWoxzAZpFk7qPRtBn1fJgfVJ5NqwMh1w
	bT/j5grxJRoDMItroh9/WZZwTe9vwhdUpsoDPEpfVynaD0NMY39hLTms5w1GD5tI
	Y5mV0xNGmtN+aBHZH9Bn3NeONPRwl/LLc7EEhH8sh8nLfKVp3SgAXoMmTV7Qpt9r
	hCI+Vs1/B1WKKy9I0fxBuqzAbV5o20XEA4FLhvMtRkWLyBGMNjpUGzWMjU6jnFMQ
	3bP/YcP72IPuZUaP76bXdaYn22oyqllcPMZoL1/6Z3BBEt9oMFOQQp+rDBSkrIWP
	PRWjTNIsTUwLed6INZaWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792161744; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:O9HbgP21clzetkPp6v3v/uDmRgr/B6ZPT5jgRAPJSA9ilbH
	7HNTZR9OsHJleOlnN1zP+TD9AfU3AonpY/y92WzPWYhH6Oi1/t4SeJGBJC3cNBmc
	+DOfX9+kXrHtPIq81NwWJFQRoyEOtYScmd2ffDmu8oci0D4UxQbiTih5BQrAW8s0
	iciPmORfV9mbGwu4iyJR9RrDs34V6vO2LLHujLkOnv8cuZvfWMXUaIbWQjkKF0r0
	msL4t+GJz/Mqo0bX5SD4mremlXMruALb0wAyUsrm0OcXItxRIr2rMx+prYjVMnS/
	Xq7HF9QhzhnPNv0VH6t1qwhJD4nR0jv+DjpNYTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:517RQdKwcZ2E9HUT6oL098gqiwhapSKZVShqyWaxe/s=:+nc4F9eQckj7R90Z9Q2QAGsijSxI7+KgudcWTIBAlmg=;
X-ME-Sender: <xms:yzfSavWKk1CWdiXw8r5FzOYTFtgxgqNYCIKultGgH9-tltZJS8QZ7Q>
    <xme:yzfSaiYcFUmqFhP3QgSplPucIvjUaZznOayAqtrHDxZ5tqdQJdzAn2nHLVvsfyKfz
    fDN4q3F_BkwHyrIRYKtn0FjUYinJU0azr8k1pRN8Pk8a76CQ0X2QA8T2Q>
X-ME-Proxy-Cause: dmFkZTF+3rfSvQkPH5vX+1X2huUFhfjyJS4C9bKeG9uGBVPWuaVR0D3ZOB7E78/lg6lBuU
    yeBeDN3khuVjziy4hSwH9Df2QVhA0Xv5BaQrEJmvPDOP3bk2IIb77+jIifD9y5gHsoM6uH
    0BpA3/U3YMURqaIU3ydySEv5DU07I/Jq0t5sA7PZhzNG/2Y0PDb+t3LFZAmaAD5CebEXhF
    aKhfQfmsQWHms8hnZM06bYRxMF0H3s5kZnDarIoMXepYLKKjDvRkeZdTj7d/WZ1kjLRsWj
    khDmaG7O5INuZPg/R2wbe6iKf7de5mIwuPeBJAn5JcJO+0tSKulsLV5NSZBtSIfdJjTTk5
    olmJOdht7R5yTejFZHBHUB9g6WzTtvOi/zkP63dRWIc6dsUGD7WGwk1Q3JfA7Axsayc8L9
    gIFNTGForC1WFBhK8RxKPPSVFfP/K9wZZ7lVIbRhUtVXiYlyNgtb89JNlKSeaUhqyMsrns
    WNirtWw2o5aLwlNXNu7Bijbt1wX/2zTPZUDpBw6G2Co4QALkUsn0f+w0pdT8wZv5kGMpji
    cyEnkjEHMalCTDmSMX9n+izdpCFFIzZXCElzfy5sWo4vJm2buslxecJgKRv7R9TbcQTwW/
    1qEgRPGeFhuCW5t414ga+l5N7kd9eF5PU8pBlfqTAQwjXVZhP8eOlCDNs5hg
X-ME-Proxy: <xmx:zTfSam7umEVih8a4--NQmF-q0lwAH6Fr1UyW46AQFqENdv7HVBbRiA>
    <xmx:zTfSarwroTDoX6Lc1tXnVi4_ZYKYGPziuDSlyLyfPNBv3mZmjQCyTw>
    <xmx:zTfSaieiBasoGJWfcs8R-MyABsbCqWo_hUa-NNOLOUbebiIUEvPfZw>
    <xmx:zTfSaoB_OuzJ4sZYoFis-zvJp8bGgMDz0LmIdb9Ji7OJn3-_025LVw>
    <xmx:0DfSaiI0VNjCYk10DjPyPdQ372pfkfhUVI0srhoHy_PJQoP8GzEpKklL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A5F3C32A008E; Fri, 16 Oct 2026 10:42:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4WN0AQLOakc
Date: Fri, 16 Oct 2026 16:41:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
Message-Id: <912aecf9-b135-48fb-b539-52ba3a1704a1@app.fastmail.com>
In-Reply-To: <atImm4Ixv_PwUqLb@ashevche-desk.local>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <atImm4Ixv_PwUqLb@ashevche-desk.local>
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 15:28, Andy Shevchenko wrote:
> On Fri, Oct 16, 2026 at 02:59:47PM +0200, Arnd Bergmann wrote:
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> But there are some minor issues to fix, see below.
>
> ...
>
>>  {
>>  	unsigned long old_iobase, old_mapbase;
>> -	unsigned int old_type, old_iotype, old_hub6, old_shift;
>> +	unsigned int old_type, old_iotype, old_shift;
>
> Move it line up, so we will have reversed xmas tree order.
>
> ...
>
>> +	/* hub6 is no longer support */
>> +        if (new_info->hub6 != 0)
>> +                return -EINVAL;
>
> Please, fix the indentation, should use tabs.

Fixed both, and the typo in the comment here, thanks
for the review!

    Arnd 
