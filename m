Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF626FD91;
	Tue, 15 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613224; cv=none; b=uIHjTgKhiDu4RDpRUVrfLJ2aPMWidJAbzpCYzNT59AFWXVwBCBwHzCUcjpzVPeBDIK8TbJSZubwUVAfnZfwaqwWjAzQvNglk7pFH75CXYRD0BxPcgLlsOXHddS6N3QI3WJ8M3M9i5ieC5MgT4c6iPlD2VS1NI2J+7tS4SpIXLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613224; c=relaxed/simple;
	bh=NdQnNA3fF02ohjHshOAcpzNoezt4dBDZURm8yQYNoFE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lPDJhtuPCol6aTJ2tf1Dzud5zz2dmqH+Toj+2AlPrFhG2YMQAPSRsNIpLTswCZKGmeIYphhGtWAWQBMjDsBfG0HUSMVW9z2IL0zZIktLfj1+b5e4z3W+5Y5W9Nn3HeL5dDxwt23e80w21trwrRo8cpCp1gW3mt1T9GHrM8MgOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Ekin6gO+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ekin6gO+"
Received: from [IPV6:2601:646:8081:9482:6556:8629:7dba:d48c] ([IPv6:2601:646:8081:9482:6556:8629:7dba:d48c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56FL0F0w1148310
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Jul 2025 14:00:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56FL0F0w1148310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752613215;
	bh=nFH2JFEH395RyzNce7lxw11nURFzbDl8EM5cGZUF/V0=;
	h=Date:To:Cc:From:Subject:From;
	b=Ekin6gO+YziYS5cDuQvphQsNWdfBy3QrYYhZzKvZW6oHYxRbtVXGmm19Q5TqGl1mQ
	 MhGgcWT8H7WlPSJJCVTnkCFEz91vIs7DxrlIrTA5vIH+vRDql4VPmj59LI29qmD9GR
	 b/MJiRmmqRoy3iZfzzCXJkbovIru2HMJlp5wcUFBkjBds/KOUknARB70c+E4wcfVRs
	 iwtV5W2qpaIx8/be/XzWNmtWcu2xeWpg0vFWWr+FMl3xs8E4bTlLX745s4gWgbtWm/
	 rlmZLQMEPTrCygHUh9HcUYtz8J1cgX1kXAhr4+Lh2choq2VOEWUqH4oKRnjL/MnXMN
	 qbeWaz4mm9vqg==
Message-ID: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
Date: Tue, 15 Jul 2025 14:00:10 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: USB cdc-acm driver: break and command
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed looking at the CDC-ACM driver that it uses the assert/local 
delay/deassert method of sending BREAK.  Given that the CDC model has a 
delay specifier in the command packet, is there any reason not to set 
TTY_DRIVER_HARDWARE_BREAK and sending only one packet?

I'm also wondering if it would make sense to support the 
SEND_ENCAPSULATED_COMMAND and GET_ENCAPSULATED_RESPONSE commands, 
presumably via an ioctl().  I'm not 100% sure because I'm not sure there 
aren't potential security issues.

I'm guessing both of these could be of some use to embedded devices that 
emulate a ttyACM serial port.

	-hpa

