Received: from relay01b.gzo.com (relay01b.gzo.com [96.31.72.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781E20322;
	Mon, 17 Mar 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.31.72.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220781; cv=none; b=uEUJcigci0p7Wm98wberDPAERMJKNu2KzEzEKW+cq1t2xkzrk65mReY9cYVsJY4AEW5A3kRz5a6q2Jy8yBlRfqj5jkSz3uZPPsf6MG1a1SeMDytFVFFz7XiiNkHF3/STH4Ai+HzBCZhj2Bi1rpkBmt4CXW9ueLk2ZG41lwvk7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220781; c=relaxed/simple;
	bh=jTB5znB+ogEWEhTkaupi8dMN+yvFZhhh7iKqXffpBfE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fpk0Sc/ZUjxuvxDTsreOpa3OYKOEL1tiVr3vftmW7FrTwdyCixiNJbx/YC8wZYleoZ8LdJoCN1cDpLTSqs44W8Nfcmexyvdyw3Zq+MK6E4NVyVVmq/naAmcnt9zOzl99GVu0c/a0H04QKk6ekLQ2l45zmooBGjEpo/ILXqp5YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurup.com; spf=pass smtp.mailfrom=shurup.com; dkim=pass (2048-bit key) header.d=shurup.com header.i=@shurup.com header.b=itgmWAFW; arc=none smtp.client-ip=96.31.72.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shurup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shurup.com header.i=@shurup.com header.b="itgmWAFW"
Received: from cpanel84.gzo.com ([96.31.72.74]:38344)
	by relay02.gzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <yury@shurup.com>)
	id 1tuAfX-00000005jnH-3R2z;
	Mon, 17 Mar 2025 08:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shurup.com;
	s=default; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=jTB5znB+ogEWEhTkaupi8dMN+yvFZhhh7iKqXffpBfE=; b=itgmWAFW/cuIeL45f9rRrm8AD8
	oSRYuomvAQ3i3hhhxAuh5G8Z7MEgw6gBc5f1AmFkGfSjypoRJuGZfm0ebwvwEWKJ1UGin889Jy845
	n/hmIXlvqjpmzUzWROwNEqBw3Mv12wGamJPMXc9PPFyfwDXYyGRdSCjdR5qgK7pKGfFwoaD5beAzL
	4WImmvX1yUAAM81Rqhsj12WQI4QxuCD7PMImbsbPOIPqCCrgE26vu6RCCfH0n5CHkk97SE5no1Cn8
	m7shpDRb/eOeXS+dlZ+p8TmXeG2uBTJ+T7tgaVwi/GECFztUuvHR5nw6tB7w3IPOfOy2a2drVH6tb
	Cn6pydIg==;
Received: from [178.202.191.195] (port=13529 helo=smtpclient.apple)
	by cpanel84.gzo.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <yury@shurup.com>)
	id 1tuAfY-0000000Ei07-0uS3;
	Mon, 17 Mar 2025 08:38:14 -0500
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RESEND] tty: vt: make defkeymap for shifted F-keys
 consistent with kbd
From: "Yury V. Zaytsev" <yury@shurup.com>
In-Reply-To: <202503061554.ZQPrGM8H-lkp@intel.com>
Date: Mon, 17 Mar 2025 14:37:43 +0100
Cc: gregkh@linuxfoundation.org,
 jirislaby@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD85D5D1-4D09-41AC-BFD8-C53E986C629F@shurup.com>
References: <20250301132108.62761-1-yury@shurup.com>
 <202503061554.ZQPrGM8H-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel84.gzo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - shurup.com
X-Get-Message-Sender-Via: cpanel84.gzo.com: authenticated_id: yury+shurup.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel84.gzo.com: yury@shurup.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-GZO-MailScanner-Information: Please contact the ISP for more information
X-GZO-MailScanner-ID: 1tuAfX-00000005jnH-3R2z
X-GZO-MailScanner: Found to be clean
X-GZO-MailScanner-SpamCheck: not spam, SpamAssassin (cached, score=-2.099,
	required 6, autolearn=not spam, BAYES_00 -1.90, DKIM_SIGNED 0.10,
	DKIM_VALID -0.10, DKIM_VALID_AU -0.10, DKIM_VALID_EF -0.10,
	RCVD_IN_VALIDITY_CERTIFIED_BLOCKED 0.00,
	RCVD_IN_VALIDITY_RPBL_BLOCKED 0.00, SPF_HELO_PASS -0.00,
	SPF_PASS -0.00, URIBL_BLOCKED 0.00)
X-GZO-MailScanner-From: yury@shurup.com

Hi,

> On 6. Mar 2025, at 08:20, kernel test robot <lkp@intel.com> wrote:
>=20
> kernel test robot noticed the following build warnings:

Just to make sure I understand the expectations, are you waiting for me =
to provide a fix and resubmit?

I ask because this is generated code. I can replace zeros with NULLs no =
problem. Not sure about the symbols, but I guess making them static =
wouldn't hurt.

Thank you very much!

All the best,
Yury

