Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16426199FAC
	for <linux-serial@vger.kernel.org>; Sat, 18 Oct 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760785480; cv=none; b=tJTCFd41TFWCyuhPzgfI65XTL6n735HUM6c/prUScXKtJInezmn2XKC4YggQ0O9wbiFccllzatp4LTlTZ04N7GP2ttRcpQNv8kYj4OMw89ztfVtvWnFk6oSmAdvvx3+OgCFx+CAL4il6OA9ZC0CcxYEdiRIARflTbJtdsduUsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760785480; c=relaxed/simple;
	bh=7c6NUalPWOEIvEIjiWEwBssfaoajm0E9hgeHMSdNUhg=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=YTn3YMEanbnv6FUOlKtcIjnrlAAVHScfjq5pvjbq0oo3gj94jRiyOBN5tLD5OdVFBcIBmrCSpIRulHK9IhJjl31ARH+GFwoWsc56PHgIL5Fl/TqHcRdOih4FkHPX+yKGhjLAOJmJ7TBbmLwUO7Z1Drk2ovTsC++T2eaAqyg3xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Dco/M6OO; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Dco/M6OO"
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 59IAFFv5865149
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sat, 18 Oct 2025 18:15:17 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1760782517; bh=ZLea4U2yjT7xgzjOa735GQR+jNc=;
	h=From:To:Subject:Date;
	b=Dco/M6OOwD+TmHJoHVegKpuXOk9bZEl+fDkYwVylHcI0R/XsM1J4bSCAkLQRSskQR
	 fS6t/CGCD6Xa4NR4XGG/KJBbhpp1oiPJFvsITTFYUtvw2b+rJOCjYU3VItNMdq6rNW
	 /fC3B5TqVv0Ku5SKqcmGrD0+3NOnCw9Bkwqf5AKE=
Received: from [127.0.0.1] (118-168-45-227.dynamic-ip.hinet.net [118.168.45.227])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 59IAAeSH206796
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sat, 18 Oct 2025 18:13:42 +0800
From: "Sales - iGTI 395" <Linux-serial@ms29.hinet.net>
To: linux-serial@vger.kernel.org
Reply-To: "Sales - iGTI." <sales@igti.space>
Subject: =?UTF-8?B?Rmlyc3QgT3JkZXIgQ29uZmlybWF0aW9uICYgTmV4dCBTdGVwcw==?=
Message-ID: <58532159-8cdb-bafc-5de0-ac0627790204@ms29.hinet.net>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Oct 2025 10:13:41 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=cYdxrWDM c=0 sm=1 tr=0 ts=68f36857
	p=ggywIp0tIZrEgnU2bSAA:9 a=avzCmnXzaMFgKpOopv6J1Q==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-serial,

I hope this message finds you well.

We are a diversified general trading company with multiple business streams=
 and affiliated sister companies. While our operations span various sectors=
, we currently have a strong focus on the resale of general machandise and =
services on several products to our partners and associates in the UAE and =
UK.

Having reviewed your website and product offerings, we are pleased to move =
forward with our first order. To proceed, we would like to align on the =
following key details:

-Minimum Order Quantity (MOQ)
-Delivery timelines
-Payment terms
-Potential for a long-term partnership

To facilitate this discussion and finalize next steps, we will be sharing a=
 Zoom meeting invitation shortly.

We look forward to your confirmation and the opportunity to build a =
mutually beneficial relationship.

Best regards,
Leo Viera
Purchasing Director
sales@igti.space
iGeneral Trading Co Ltd
igt.ae - igti.space
